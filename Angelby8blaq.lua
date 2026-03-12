--// Angel.lol by 8blaq

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DaddyFelixFucks/MainLib/refs/heads/main/Main"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DaddyFelixFucks/ThemeManager/refs/heads/main/Theme"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DaddyFelixFucks/SaveLib/refs/heads/main/SaveAh"))()

getgenv().Angel = {
    TargetAim = {
        Enabled = true,
        Prediction = 0.168,
        JumpOffset = -1.5
    },
    
    CamLock = {
        Enabled = false,
        Smoothness = 0.1
    },
    
    Highlight = {
        Enabled = true,
        Color = Color3.fromRGB(0, 120, 255),
        Rainbow = false
    },
    
    Speed = {
        Enabled = false,
        Value = 50
    },
    
    JumpPower = {
        Enabled = false,
        Value = 100
    },
    
    AutoAir = {
        Enabled = false,
        Delay = 0.2
    },
    
    Keybind = "C",
    
    UI = {
        ShowLockButton = true
    }
}

--// RapidFire Configuration
getgenv().RapidFire = {
    Enabled = false,
    Delay = 0.1,
    FOV = 400,
    Keybind = "F"
}

local plrs = game:GetService("Players")
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local lp = plrs.LocalPlayer
local gui = lp:WaitForChild("PlayerGui")
local cam = workspace.CurrentCamera

local locked = false
local tgt = nil
local savedKey = "ANGEL_UI_POS"
local currentHighlight = nil
local rainbowHighlightConnection

--// Auto Air Variables
local lastAutoAirTime = 0

local function hsv(h, s, v)
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6
    
    if i == 0 then 
        return Color3.new(v, t, p)
    elseif i == 1 then 
        return Color3.new(q, v, p)
    elseif i == 2 then 
        return Color3.new(p, v, t)
    elseif i == 3 then 
        return Color3.new(p, q, v)
    elseif i == 4 then 
        return Color3.new(t, p, v)
    else 
        return Color3.new(v, p, q)
    end
end

local function alive(p)
    if not p.Character then return false end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function getClosest()
    local closest, dist
    
    for _, p in pairs(plrs:GetPlayers()) do
        if p ~= lp and alive(p) then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos, on = cam:WorldToViewportPoint(hrp.Position)
                if on then
                    local mousePos = uis:GetMouseLocation()
                    local m = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if not dist or m < dist then
                        dist = m
                        closest = p
                    end
                end
            end
        end
    end
    
    return closest
end

--// Enhanced getClosest with FOV
local function getClosestInFOV(maxFOV)
    local closest, dist = nil, maxFOV
    
    for _, p in pairs(plrs:GetPlayers()) do
        if p ~= lp and alive(p) then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local mousePos = uis:GetMouseLocation()
                    local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if distance < dist then
                        dist = distance
                        closest = p
                    end
                end
            end
        end
    end
    
    return closest
end

local function updateHighlight()
    if currentHighlight then
        currentHighlight:Destroy()
        currentHighlight = nil
    end

    if rainbowHighlightConnection then
        rainbowHighlightConnection:Disconnect()
        rainbowHighlightConnection = nil
    end
    
    if Angel.Highlight.Enabled and locked and tgt and tgt.Character then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = tgt.Character
        highlight.Parent = tgt.Character
        
        if Angel.Highlight.Rainbow then
            local hue = 0
            rainbowHighlightConnection = run.RenderStepped:Connect(function()
                hue = (hue + 0.01) % 1
                highlight.FillColor = hsv(hue, 1, 1)
                highlight.OutlineColor = hsv((hue + 0.5) % 1, 1, 1)
            end)
        else
            highlight.FillColor = Angel.Highlight.Color
            highlight.OutlineColor = Angel.Highlight.Color
        end
        
        currentHighlight = highlight
    end
end

--// RapidFire Auto Shoot Function
local function rapidFireAutoShoot()
    if not RapidFire.Enabled then return end
    
    local target = getClosestInFOV(RapidFire.FOV)
    if target and target.Character then
        local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
end

--// Auto Air Function (from your script)
local function autoAirShoot()
    if not Angel.AutoAir.Enabled then return end
    if not locked or not tgt or not tgt.Character then return end
    
    local currentTime = tick()
    if currentTime - lastAutoAirTime >= Angel.AutoAir.Delay then
        local targetRootPart = tgt.Character:FindFirstChild("HumanoidRootPart")
        if targetRootPart then
            local humanoid = tgt.Character:FindFirstChild("Humanoid")
            if humanoid and (humanoid:GetState() == Enum.HumanoidStateType.Jumping or humanoid:GetState() == Enum.HumanoidStateType.Freefall) then
                local character = lp.Character
                if character then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        lastAutoAirTime = currentTime
                    end
                end
            end
        end
    end
end

local function makeAngelUI()
    if not Angel.UI.ShowLockButton then return end
    
    local scr = Instance.new("ScreenGui", gui)
    scr.Name = "ANGEL_UI"
    scr.ResetOnSpawn = false

    local btn = Instance.new("TextButton", scr)
    btn.Size = UDim2.new(0, 180, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.BorderColor3 = Color3.fromRGB(0, 120, 255)
    btn.BorderSizePixel = 3
    btn.Font = Enum.Font.GothamBlack
    btn.TextSize = 18
    btn.Text = "Angel.LOL"
    btn.TextColor3 = Color3.new(1, 1, 1)

    local save = getshared and getshared(savedKey)
    if save and typeof(save) == "UDim2" then
        btn.Position = save
    else
        btn.Position = UDim2.new(0, 15, 0, 15)
    end

    local lbl = Instance.new("TextLabel", btn)
    lbl.AnchorPoint = Vector2.new(0, 1)
    lbl.Position = UDim2.new(0, 5, 1, -3)
    lbl.Size = UDim2.new(1, -10, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.Text = "No target"

    local dragging = false
    local dragStart, posStart
    local activeTouch = nil

    local function upd(i)
        local d = i.Position - dragStart
        btn.Position = UDim2.new(posStart.X.Scale, posStart.X.Offset + d.X, posStart.Y.Scale, posStart.Y.Offset + d.Y)
    end

    btn.InputBegan:Connect(function(i)
        if (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) and not activeTouch then
            activeTouch = i
            dragging = true
            dragStart = i.Position
            posStart = btn.Position

            local move, stop
            move = uis.InputChanged:Connect(function(m)
                if dragging and (m == activeTouch) then
                    upd(m)
                end
            end)

            stop = i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    activeTouch = nil
                    move:Disconnect()
                    stop:Disconnect()
                    if setshared then 
                        setshared(savedKey, btn.Position) 
                    end
                end
            end)
        end
    end)

    btn.MouseButton1Click:Connect(function()
        locked = not locked
        if locked then
            tgt = getClosest()
            if tgt then
                lbl.Text = "Target: " .. tgt.Name
                updateHighlight()
            else
                lbl.Text = "No valid target"
            end
        else
            tgt = nil
            lbl.Text = "No target"
            updateHighlight()
        end
    end)

    run.RenderStepped:Connect(function()
        local h = (tick() * 0.25) % 1
        btn.TextColor3 = hsv(h, 1, 1)
        lbl.TextColor3 = hsv((h + 0.2) % 1, 1, 1)
    end)
end

--// Draggable RapidFire Button
local function createRapidFireButton()
    local rapidFireGui = Instance.new("ScreenGui")
    rapidFireGui.Name = "RapidFireUI"
    rapidFireGui.ResetOnSpawn = false
    rapidFireGui.Parent = gui

    local dragFrame = Instance.new("Frame")
    dragFrame.Size = UDim2.new(0, 120, 0, 40)
    dragFrame.Position = UDim2.new(0, 200, 0, 100)
    dragFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dragFrame.BackgroundTransparency = 0.3
    dragFrame.BorderSizePixel = 0
    dragFrame.Active = true
    dragFrame.Draggable = true
    dragFrame.Parent = rapidFireGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = dragFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 2
    stroke.Parent = dragFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, -10, 1, -10)
    toggleButton.Position = UDim2.new(0, 5, 0, 5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Text = "RapidFire: OFF"
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 14
    toggleButton.Parent = dragFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = toggleButton

    -- Toggle Logic
    toggleButton.MouseButton1Click:Connect(function()
        RapidFire.Enabled = not RapidFire.Enabled
        toggleButton.Text = RapidFire.Enabled and "RapidFire: ON" or "RapidFire: OFF"
        toggleButton.BackgroundColor3 = RapidFire.Enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    end)

    return rapidFireGui
end

--// Draggable Auto Air Button
local function createAutoAirButton()
    local autoAirGui = Instance.new("ScreenGui")
    autoAirGui.Name = "AutoAirUI"
    autoAirGui.ResetOnSpawn = false
    autoAirGui.Parent = gui

    local dragFrame = Instance.new("Frame")
    dragFrame.Size = UDim2.new(0, 120, 0, 40)
    dragFrame.Position = UDim2.new(0, 200, 0, 150)
    dragFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dragFrame.BackgroundTransparency = 0.3
    dragFrame.BorderSizePixel = 0
    dragFrame.Active = true
    dragFrame.Draggable = true
    dragFrame.Parent = autoAirGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = dragFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 80)
    stroke.Thickness = 2
    stroke.Parent = dragFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, -10, 1, -10)
    toggleButton.Position = UDim2.new(0, 5, 0, 5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Text = "AutoAir: OFF"
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 14
    toggleButton.Parent = dragFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = toggleButton

    -- Toggle Logic
    toggleButton.MouseButton1Click:Connect(function()
        Angel.AutoAir.Enabled = not Angel.AutoAir.Enabled
        toggleButton.Text = Angel.AutoAir.Enabled and "AutoAir: ON" or "AutoAir: OFF"
        toggleButton.BackgroundColor3 = Angel.AutoAir.Enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    end)

    return autoAirGui
end

local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local window = Library:CreateWindow({
    Title = 'Angel.lol v2 by 8blaq | ' .. game_name,
    Center = true,
    AutoShow = true
})

local tabs = {
    aimbot = window:AddTab('Aimbot'),
    config = window:AddTab('Config')
}

local TargetSection = tabs.aimbot:AddRightGroupbox("TargetAim & SilentAim")
local CamlockSection = tabs.aimbot:AddLeftGroupbox("Aim Assist")
local HighlightSection = tabs.aimbot:AddRightGroupbox("Highlight Settings")
local MovementSection = tabs.aimbot:AddLeftGroupbox("Movement")

--// Auto Air Section (Left Side)
local AutoAirSection = tabs.aimbot:AddLeftGroupbox("Auto Air")

AutoAirSection:AddToggle("autoair_enabled", {
    Text = "Enable Auto Air",
    Default = Angel.AutoAir.Enabled,
    Callback = function(v)
        Angel.AutoAir.Enabled = v
    end
})

AutoAirSection:AddInput("autoair_delay", {
    Text = "Auto Air Delay",
    Default = tostring(Angel.AutoAir.Delay),
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            Angel.AutoAir.Delay = n
        end
    end
})

TargetSection:AddToggle("targetaim_enabled", {
    Text = "Enable Target Aim",
    Default = Angel.TargetAim.Enabled,
    Callback = function(v)
        Angel.TargetAim.Enabled = v
    end
})

TargetSection:AddInput("targetaim_prediction", {
    Text = "Prediction",
    Default = tostring(Angel.TargetAim.Prediction),
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            Angel.TargetAim.Prediction = n
        end
    end
})

TargetSection:AddInput("targetaim_jumpoffset", {
    Text = "Jump Offset",
    Default = tostring(Angel.TargetAim.JumpOffset),
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            Angel.TargetAim.JumpOffset = n
        end
    end
})

CamlockSection:AddToggle("camlock_enabled", {
    Text = "Enable CamLock",
    Default = Angel.CamLock.Enabled,
    Callback = function(v)
        Angel.CamLock.Enabled = v
    end
})

CamlockSection:AddInput("camlock_smoothness", {
    Text = "Smoothness",
    Default = tostring(Angel.CamLock.Smoothness),
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            Angel.CamLock.Smoothness = n
        end
    end
})

MovementSection:AddToggle("speed_enabled", {
    Text = "Enable Speed",
    Default = Angel.Speed.Enabled,
    Callback = function(v)
        Angel.Speed.Enabled = v
    end
})

MovementSection:AddSlider("speed_value", {
    Text = "Speed Value",
    Default = Angel.Speed.Value,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(v)
        Angel.Speed.Value = v
    end
})

MovementSection:AddToggle("jumppower_enabled", {
    Text = "Enable Jump Power",
    Default = Angel.JumpPower.Enabled,
    Callback = function(v)
        Angel.JumpPower.Enabled = v
    end
})

MovementSection:AddSlider("jumppower_value", {
    Text = "Jump Power Value",
    Default = Angel.JumpPower.Value,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(v)
        Angel.JumpPower.Value = v
    end
})

TargetSection:AddLabel("Keybind"):AddKeyPicker('aim_keybind', {
    Default = Angel.Keybind,
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Aimbot Keybind',
    NoUI = false,
    Callback = function(v)
        Angel.Keybind = v
    end
})

HighlightSection:AddToggle("highlight_enabled", {
    Text = "Enable Highlight",
    Default = Angel.Highlight.Enabled,
    Callback = function(v)
        Angel.Highlight.Enabled = v
        updateHighlight()
    end
})

HighlightSection:AddLabel('Highlight Color'):AddColorPicker('HighlightColor', {
    Default = Angel.Highlight.Color,
    Title = 'Highlight Color',
    Callback = function(Value)
        Angel.Highlight.Color = Value
        updateHighlight()
    end,
})

HighlightSection:AddToggle("highlight_rainbow", {
    Text = "Rainbow Highlight",
    Default = Angel.Highlight.Rainbow,
    Callback = function(v)
        Angel.Highlight.Rainbow = v
        updateHighlight()
    end
})

TargetSection:AddToggle("show_lock_button", {
    Text = "Show Lock Button",
    Default = Angel.UI.ShowLockButton,
    Callback = function(v)
        Angel.UI.ShowLockButton = v
        if not v then
            local existingUI = gui:FindFirstChild("ANGEL_UI")
            if existingUI then
                existingUI:Destroy()
            end
        else
            makeAngelUI()
        end
    end
})

--// RapidFire Combat Section
local CombatSection = tabs.aimbot:AddRightGroupbox("RapidFire")

CombatSection:AddToggle("rapidfire_enabled", {
    Text = "Enable RapidFire",
    Default = RapidFire.Enabled,
    Callback = function(v)
        RapidFire.Enabled = v
    end
})

CombatSection:AddInput("rapidfire_delay", {
    Text = "Fire Delay",
    Default = tostring(RapidFire.Delay),
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then
            RapidFire.Delay = n
        end
    end
})

CombatSection:AddSlider("rapidfire_fov", {
    Text = "Target FOV",
    Default = RapidFire.FOV,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        RapidFire.FOV = v
    end
})

CombatSection:AddLabel("RapidFire Keybind"):AddKeyPicker('rapidfire_keybind', {
    Default = RapidFire.Keybind,
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'RapidFire Keybind',
    NoUI = false,
    Callback = function(v)
        RapidFire.Keybind = v
    end
})

local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "UIToggle"
ToggleGui.ResetOnSpawn = false
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.Parent = game.CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 70, 0, 50)
ToggleButton.Position = UDim2.new(1, -110, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "Hide UI"
ToggleButton.Font = Enum.Font.Code
ToggleButton.TextSize = 14
ToggleButton.Parent = ToggleGui

local Outline = Instance.new("UIStroke")
Outline.Color = Color3.fromRGB(255, 255, 255)
Outline.Thickness = 1
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Outline.Parent = ToggleButton

Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

local toggleDragging = false
local toggleDragStart, togglePosStart
local toggleActiveTouch = nil

local function toggleUpd(i)
    local d = i.Position - toggleDragStart
    ToggleButton.Position = UDim2.new(togglePosStart.X.Scale, togglePosStart.X.Offset + d.X, togglePosStart.Y.Scale, togglePosStart.Y.Offset + d.Y)
end

ToggleButton.InputBegan:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) and not toggleActiveTouch then
        toggleActiveTouch = i
        toggleDragging = true
        toggleDragStart = i.Position
        togglePosStart = ToggleButton.Position

        local move, stop
        move = uis.InputChanged:Connect(function(m)
            if toggleDragging and (m == toggleActiveTouch) then
                toggleUpd(m)
            end
        end)

        stop = i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then
                toggleDragging = false
                toggleActiveTouch = nil
                move:Disconnect()
                stop:Disconnect()
            end
        end)
    end
end)

local isVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    if Library and Library.Unloaded then return end
    if Library and Library.Toggle then
        Library:Toggle()
        isVisible = not isVisible
        ToggleButton.Text = isVisible and "Hide UI" or "Show UI"
    end
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

ThemeManager:SetFolder("Angel")
SaveManager:SetFolder("Angel")

ThemeManager:ApplyToTab(tabs.config)

local mt = getrawmetatable(game)
local oldNameCall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    
    if Angel.TargetAim.Enabled and locked and tgt and tgt.Character and getnamecallmethod() == "FireServer" then
        if typeof(args[3]) == "Vector3" then
            local part = tgt.Character.HumanoidRootPart
            if part then
                local isJumping = tgt.Character.Humanoid.FloorMaterial == Enum.Material.Air
                local jumpOffset = isJumping and Angel.TargetAim.JumpOffset or 0
                local predictedPos = part.Position + (part.Velocity * Angel.TargetAim.Prediction) + Vector3.new(0, jumpOffset, 0)
                
                args[3] = predictedPos
                return oldNameCall(unpack(args))
            end
        end
    end
    return oldNameCall(...)
end)

setreadonly(mt, true)

uis.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode[Angel.Keybind] then
        locked = not locked
        if locked then
            tgt = getClosest()
            if tgt then
                Library:Notify("Locked onto: " .. tgt.Name)
                updateHighlight()
            else
                Library:Notify("No valid target found")
                locked = false
            end
        else
            tgt = nil
            Library:Notify("Target unlocked")
            updateHighlight()
        end
    end
    
    -- RapidFire Keybind Toggle
    if input.KeyCode == Enum.KeyCode[RapidFire.Keybind] then
        RapidFire.Enabled = not RapidFire.Enabled
        Library:Notify("RapidFire: " .. (RapidFire.Enabled and "ENABLED" or "DISABLED"))
    end
end)

--// RapidFire Auto Shoot Loop
local lastFireTime = 0
run.RenderStepped:Connect(function()
    -- Movement features
    if Angel.Speed.Enabled and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
        humanoid.WalkSpeed = Angel.Speed.Value
    end
    
    if Angel.JumpPower.Enabled and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
        humanoid.JumpPower = Angel.JumpPower.Value
    end
    
    -- CamLock feature
    if Angel.CamLock.Enabled and locked and tgt and alive(tgt) then
        local prt = tgt.Character:FindFirstChild("HumanoidRootPart") or tgt.Character:FindFirstChild("Head")
        if prt then
            local currentCF = cam.CFrame
            local targetCF = CFrame.new(cam.CFrame.Position, prt.Position)
            cam.CFrame = currentCF:Lerp(targetCF, Angel.CamLock.Smoothness)
        end
    end
    
    -- RapidFire Auto Shoot
    if RapidFire.Enabled and tick() - lastFireTime >= RapidFire.Delay then
        rapidFireAutoShoot()
        lastFireTime = tick()
    end
    
    -- Auto Air Functionality
    autoAirShoot()
end)

-- Create UI elements
makeAngelUI()
createRapidFireButton()
createAutoAirButton()
Library:Notify("Angel.lol v2 loaded successfully!")
Library:Notify("RapidFire Keybind: " .. RapidFire.Keybind)
Library:Notify("Auto Air: Toggle in UI or use draggable button")
