--// script made by vanhuy 
--[[
    C = select target 
    T = AutoShoot
    Z = Walkspeed
    Y = Tp Orbit
]]





loadstring(game:HttpGet("https://raw.githubusercontent.com/mainluaa/Bypass/refs/heads/main/Protected%20by%20Zummy.lol"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera


getgenv().x = {
    Targetaim = {
        enabled = false,
        target = nil,
        hitpart = "Head",  
        Horizontal = 0.06,  
        Vertical = 0.06    
    },
    AA = {  
        jump_offset = 0,
        fall_offset = 0
    },
    autoshoot = false,
    WalkspeedEnabled = false
}
local function updateSpeed()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if x.WalkspeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = 300
        end
    end
end


local speedConnection = RunService.RenderStepped:Connect(updateSpeed)

   
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    updateSpeed()
end)

local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(Self, k)
    if k:lower() == "hit" and x.Targetaim.enabled then
        local target = x.Targetaim.target
        if target and target.Character then
            local hitPart = target.Character:FindFirstChild(x.Targetaim.hitpart)
            if hitPart then
                local localHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                local targetHumanoid = target.Character:FindFirstChild("Humanoid")
                
                local jumpOffset = (localHumanoid and localHumanoid:GetState() == Enum.HumanoidStateType.Freefall) and x.AA.jump_offset or 0
                local fallOffset = (targetHumanoid and targetHumanoid:GetState() == Enum.HumanoidStateType.Freefall) and x.AA.fall_offset or 0
                
                return CFrame.new(hitPart.Position + (hitPart.Velocity * x.Targetaim.Horizontal) + Vector3.new(0, x.Targetaim.Vertical, 0) + Vector3.new(0, jumpOffset + fallOffset, 0))
            end
        end
    end
    return oldIndex(Self, k)
end)

local function getClosestPlayerInFOV()
    local closestPlayer = nil
    local closestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function canShootTarget(target)
    if not target or not target.Character then return false end
    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot or not targetRoot then return false end
    if target.Character:FindFirstChildOfClass("ForceField") then
        return false
    end
    local bodyEffects = target.Character:FindFirstChild("BodyEffects")
    local koValue = bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value
    if koValue then return false end
    
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    local rayResult = Workspace:Raycast(localRoot.Position, (targetRoot.Position - localRoot.Position).Unit * (targetRoot.Position - localRoot.Position).Magnitude, rayParams)
    
    return not rayResult or rayResult.Instance:IsDescendantOf(target.Character)
end

local orbiting = false
local orbitRadius = 10
local orbitSpeed = 500
local angle = 0

RunService.Heartbeat:Connect(function(deltaTime)
    if orbiting and x.Targetaim.target and x.Targetaim.target.Character and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local character = x.Targetaim.target.Character
        local localRoot = LocalPlayer.Character.HumanoidRootPart
        local targetRoot = character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then return end
        local bodyEffects = character:FindFirstChild("BodyEffects")
        local koValue = bodyEffects and bodyEffects:FindFirstChild("K.O")
        local isDeath = bodyEffects:FindFirstChild("SDeath") and bodyEffects["SDeath"].Value
        if koValue and koValue.Value and not isDeath then
            local upperTorso = character:FindFirstChild("UpperTorso")
            if upperTorso then
                localRoot.CFrame = CFrame.new(upperTorso.Position + Vector3.new(0, 3, 0))
                
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end
            return
        end
        local targetPos = x.Targetaim.target.Character.HumanoidRootPart.Position
        angle = angle + (orbitSpeed * deltaTime)
        local offset = Vector3.new(math.sin(math.rad(angle)) * orbitRadius, math.random(0, 10), math.cos(math.rad(angle)) * orbitRadius)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + offset, targetPos)
    end
end)

local lastShootTime = 0
local shootCooldown = 0.2
RunService.RenderStepped:Connect(function()
    if x.autoshoot and x.Targetaim.enabled and x.Targetaim.target and tick() - lastShootTime > shootCooldown then
        if canShootTarget(x.Targetaim.target) then
            mouse1press()
            wait(0.01)
            mouse1release()
            lastShootTime = tick()
        end
    end
end)

local function showNotification(message, target)
    StarterGui:SetCore("SendNotification", {
        Title = "Target Update",
        Text = message,
        Duration = 3
    })

end

local targetSelected = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.C then
        if not targetSelected then
            local target = getClosestPlayerInFOV()
            if target then
                x.Targetaim.target = target
                x.Targetaim.enabled = true
                targetSelected = true
                showNotification("Target selected: " .. target.Name)
            end
        else
            showNotification("Target unselected")
            x.Targetaim.target = nil
            x.Targetaim.enabled = false
            targetSelected = false
        end
    end
    
    if input.KeyCode == Enum.KeyCode.Y then
        if x.Targetaim.target then
            orbiting = not orbiting
            showNotification(orbiting and "Orbit enabled" or "Orbit disabled")
        end
    end
    
    if input.KeyCode == Enum.KeyCode.T then
        x.autoshoot = not x.autoshoot
        showNotification(x.autoshoot and "Autoshoot enabled" or "Autoshoot disabled")
    end
    if input.KeyCode == Enum.KeyCode.Z then
        isSpeedEnabled = not isSpeedEnabled
        if isSpeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().walkSpeedSettings.WalkSpeed.Speed
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)
