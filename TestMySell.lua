-- ================== AIMBOT SETTINGS & LOGIC ==================
getgenv().CustomAimbot = {
    Enabled = false,
    
    -- Setting từ bạn
    Prediction = 0.128,
    X_Offset   = 0.1452,
    Y_Offset   = 0.1235,
    AirOffset  = 0.735,
    FallOffset = 0.712,
    
    -- Các setting khác (có thể chỉnh)
    HitPart    = "Head",          -- Head / UpperTorso / HumanoidRootPart
    FOV_Radius = 320,             -- bán kính FOV
    Smoothing  = 0.88,            -- 0.8–0.95 (càng cao càng mượt nhưng chậm)
    TeamCheck  = true,
    VisibleCheck = true,
}

local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UserInput     = game:GetService("UserInputService")
local LocalPlayer   = Players.LocalPlayer
local Camera        = workspace.CurrentCamera
local Mouse         = LocalPlayer:GetMouse()

local CurrentTarget = nil

local function GetClosestInFOV()
    local closest, minDist = nil, CustomAimbot.FOV_Radius
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer or not plr.Character or not plr.Character:FindFirstChild("Humanoid") then
            continue
        end
        if CustomAimbot.TeamCheck and plr.Team == LocalPlayer.Team then
            continue
        end
        
        local root = plr.Character:FindFirstChild(CustomAimbot.HitPart) or plr.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        
        local screen, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then continue end
        
        local dist = (Vector2.new(screen.X, screen.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        if dist >= minDist then continue end
        
        if CustomAimbot.VisibleCheck then
            local rayOrigin = Camera.CFrame.Position
            local rayDir = (root.Position - rayOrigin).Unit * 1000
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            
            local result = workspace:Raycast(rayOrigin, rayDir, raycastParams)
            if result and result.Instance:IsDescendantOf(plr.Character) then
                closest = plr
                minDist = dist
            end
        else
            closest = plr
            minDist = dist
        end
    end
    return closest
end

local function GetPredictedPosition(target)
    if not target or not target.Character then return nil end
    
    local part = target.Character:FindFirstChild(CustomAimbot.HitPart) or target.Character.HumanoidRootPart
    if not part then return nil end
    
    local velocity = part.Velocity
    local basePos = part.Position + (velocity * CustomAimbot.Prediction)
    
    local hum = target.Character:FindFirstChild("Humanoid")
    if hum then
        local state = hum:GetState()
        if state == Enum.HumanoidStateType.Freefall then
            basePos += Vector3.new(0, CustomAimbot.FallOffset, 0)
        elseif state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Landed then
            basePos += Vector3.new(0, CustomAimbot.AirOffset, 0)
        end
    end
    
    -- Áp dụng offset X Y
    basePos += Vector3.new(CustomAimbot.X_Offset, CustomAimbot.Y_Offset, 0)
    
    return basePos
end

-- Main loop
RunService.RenderStepped:Connect(function()
    if not CustomAimbot.Enabled then
        CurrentTarget = nil
        return
    end
    
    CurrentTarget = GetClosestInFOV()
    
    if CurrentTarget then
        local predPos = GetPredictedPosition(CurrentTarget)
        if predPos then
            local screenPos = Camera:WorldToViewportPoint(predPos)
            local mousePos = Vector2.new(Mouse.X, Mouse.Y)
            local targetPos = Vector2.new(screenPos.X, screenPos.Y)
            
            local delta = (targetPos - mousePos) * CustomAimbot.Smoothing
            mousemoverel(delta.X, delta.Y)
        end
    end
end)
-- Thêm button thủ công (nếu không có hàm create)
local aimbotBtn = Instance.new("TextButton")
aimbotBtn.Size = UDim2.new(0.9, 0, 0, 45)
aimbotBtn.Position = UDim2.new(0.05, 0, 0, 350)  -- chỉnh vị trí Y tùy ý
aimbotBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
aimbotBtn.TextColor3 = Color3.new(1,1,1)
aimbotBtn.Text = "Aimbot Custom: OFF"
aimbotBtn.Font = Enum.Font.SourceSans
aimbotBtn.TextSize = 18
aimbotBtn.Parent = frame

local aimState = false
aimbotBtn.Activated:Connect(function()  -- Activated tốt cho mobile
    aimState = not aimState
    CustomAimbot.Enabled = aimState
    
    aimbotBtn.Text = "Aimbot Custom: " .. (aimState and "ON" or "OFF")
    aimbotBtn.BackgroundColor3 = aimState and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 45)
end)
