getgenv().zeehood = {
    enabled = true,
    shotdelay = 0.05,
    prediction = 0.581,
    distance = 9000
}

local settings = {}
for k, v in pairs(getgenv().zeehood) do settings[k] = v end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local lastShotTime = 0
local targetEnabled = false
local targetPlayer = nil
local targetPart = nil
local lastTargetCheck = 0
local currentTargetPlayer = nil

local espLine = nil
local espText = nil
local espHealth = nil
local espConnection = nil

local function predictPosition(part, predictionTime)
    local currentPos = part.Position
    local velocity = part.Velocity or Vector3.new(0, 0, 0)
    return currentPos + (velocity * predictionTime)
end

local function getCurrentTool()
    local character = LocalPlayer.Character
    if not character then return nil end
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") then return item end
    end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    if bp then
        for _, item in pairs(bp:GetChildren()) do
            if item:IsA("Tool") then return item end
        end
    end
    return nil
end

local pelletOffsets = {
    Vector3.new(0, 0.3, 0.2),
    Vector3.new(0, 0.15, 0.4),
    Vector3.new(0.2, -0.1, 0.1),
    Vector3.new(0, -0.3, 0.3),
    Vector3.new(-0.2, -0.5, 0.1),
}

local function buildHitData(originPos, targetPlayer, targetPart)
    local hitData = {}
    local pelletTargets = {}
    local hitPos = targetPart.Position
    for i = 1, 5 do
        local pos = hitPos + pelletOffsets[i]
        hitData[i] = {
            hitPosition = pos,
            hitPart = "Hitbox",
            targetPlayer = targetPlayer.Name,
            origin = originPos,
        }
        pelletTargets[i] = pos
    end
    return hitData, pelletTargets
end

local function fireGun(originPos, predictedPos, hitData, pelletTargets, toolName)
    ReplicatedStorage.GunFireEvent:FireServer({
        destroyTime = 0.3601369698003377,
        isShotgun = true,
        origin = originPos,
        target = predictedPos,
        hitData = hitData,
        pelletTargets = pelletTargets,
        toolName = toolName,
    })
end

local function shootAtTarget()
    if not targetEnabled or not targetPlayer or not targetPart then return false end
    
    local currentTime = tick()
    if currentTime - lastShotTime < settings.shotdelay then return false end
    
    local lc = LocalPlayer.Character
    if not lc or not lc:FindFirstChild("HumanoidRootPart") then return false end
    
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then 
        DisableTarget()
        return false 
    end
    
    local tool = getCurrentTool()
    if not tool then return false end
    
    local originPos = lc.HumanoidRootPart.Position
    local predictedPos = predictPosition(targetPart, settings.prediction)
    local hitData, pelletTargets = buildHitData(originPos, targetPlayer, targetPart)
    
    fireGun(originPos, predictedPos, hitData, pelletTargets, tool.Name)
    lastShotTime = currentTime
    return true
end

local function FindClosestPlayerToCenter()
    local closestPlayer = nil
    local closestDistance = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    local localChar = LocalPlayer.Character
    if not localChar then return nil end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local part = player.Character:FindFirstChild("UpperTorso") or player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if part and humanoid and humanoid.Health > 0 then
                local position, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (screenCenter - Vector2.new(position.X, position.Y)).Magnitude
                    if dist < closestDistance then
                        closestPlayer = player
                        closestDistance = dist
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function UpdateTargetPart()
    if targetPlayer and targetPlayer.Character then
        targetPart = targetPlayer.Character:FindFirstChild("Head") or targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        return targetPart ~= nil
    end
    return false
end

local function CleanupESP()
    if espConnection then espConnection:Disconnect(); espConnection = nil end
    if espLine then espLine.Visible = false; espLine:Remove(); espLine = nil end
    if espText then espText.Visible = false; espText:Remove(); espText = nil end
    if espHealth then espHealth.Visible = false; espHealth:Remove(); espHealth = nil end
end

local function SetupESP()
    CleanupESP()
    if not targetPlayer then return end
    
    espLine = Drawing.new("Line")
    espLine.Visible = false
    espLine.Color = Color3.fromRGB(255, 100, 100)
    espLine.Thickness = 2
    
    espText = Drawing.new("Text")
    espText.Visible = false
    espText.Color = Color3.fromRGB(255, 100, 100)
    espText.Size = 14
    espText.Center = true
    espText.Outline = true
    espText.Text = targetPlayer.Name
    
    espHealth = Drawing.new("Text")
    espHealth.Visible = false
    espHealth.Color = Color3.fromRGB(255, 255, 255)
    espHealth.Size = 12
    espHealth.Center = true
    espHealth.Outline = true
    
    espConnection = RunService.RenderStepped:Connect(function()
        local p = targetPlayer
        if not p or not p.Parent or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
            espLine.Visible = false
            espText.Visible = false
            espHealth.Visible = false
            return
        end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            espLine.Visible = false
            espText.Visible = false
            espHealth.Visible = false
            return
        end
        
        local r1 = LocalPlayer.Character.HumanoidRootPart.Position
        local r2 = p.Character.HumanoidRootPart.Position
        local v1, on1 = Camera:WorldToViewportPoint(r1)
        local v2, on2 = Camera:WorldToViewportPoint(r2)
        local headPos, headOn = Camera:WorldToViewportPoint(p.Character.Head.Position)
        
        if on1 and on2 then
            espLine.Visible = true
            espLine.From = Vector2.new(v1.X, v1.Y)
            espLine.To = Vector2.new(v2.X, v2.Y)
        else
            espLine.Visible = false
        end
        
        if headOn then
            espText.Visible = true
            espText.Position = Vector2.new(headPos.X, headPos.Y - 20)
            local humanoid = p.Character:FindFirstChild("Humanoid")
            if humanoid then
                espHealth.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                espHealth.Visible = true
                espHealth.Position = Vector2.new(headPos.X, headPos.Y - 35)
            end
        else
            espText.Visible = false
            espHealth.Visible = false
        end
    end)
end

local function EnableTarget()
    local player = FindClosestPlayerToCenter()
    if player then
        targetPlayer = player
        if UpdateTargetPart() then
            targetEnabled = true
            SetupESP()
            if btn then 
                btn.Text = "ON"
                btn.TextColor3 = Color3.new(1, 0, 0)
            end
        end
    end
end

local function DisableTarget()
    targetEnabled = false
    targetPlayer = nil
    targetPart = nil
    CleanupESP()
    if btn then 
        btn.Text = "OFF"
        btn.TextColor3 = Color3.new(1, 1, 1)
    end
end

local function ToggleTarget()
    if targetEnabled then
        DisableTarget()
    else
        EnableTarget()
    end
end

local function RefreshTarget()
    if not targetEnabled then return end
    local currentTime = tick()
    if currentTime - lastTargetCheck >= 0.5 then
        lastTargetCheck = currentTime
        if targetPlayer and targetPlayer.Character then
            local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                return
            end
        end
        local newTarget = FindClosestPlayerToCenter()
        if newTarget and newTarget ~= targetPlayer then
            targetPlayer = newTarget
            UpdateTargetPart()
            SetupESP()
        elseif not newTarget then
            DisableTarget()
        end
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = "AimbotGui"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton")
btn.Text = "OFF"
btn.TextSize = 24
btn.TextColor3 = Color3.new(1, 1, 1)
btn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
btn.BorderColor3 = Color3.new(1, 0, 0)
btn.BorderSizePixel = 3
btn.BackgroundTransparency = 0.5
btn.Font = Enum.Font.GothamBold
btn.Size = UDim2.new(0.1, 0, 0.08, 0)
btn.Position = UDim2.new(0.9, 0, 0.3, 0)
btn.Parent = gui
btn.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = btn

btn.MouseButton1Click:Connect(ToggleTarget)

RunService.Heartbeat:Connect(function()
    if not targetEnabled then return end
    if not LocalPlayer.Character then return end
    RefreshTarget()
    shootAtTarget()
end)

Players.PlayerRemoving:Connect(function(player)
    if targetPlayer == player then DisableTarget() end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    DisableTarget()
end)
