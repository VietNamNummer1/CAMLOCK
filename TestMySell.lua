-- Tạo GUI cho mobile/PC (có Close + Minimize + Draggable)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TienAIMTEST"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 340)
frame.Position = UDim2.new(0.5, -110, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui

-- Title bar (có thể kéo)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Estro Mobile"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Nút Minimize (-)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 2)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 24
minimizeBtn.Parent = titleBar

-- Nút Close (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 22
closeBtn.Parent = titleBar

-- Biến trạng thái
local minimized = false
local originalSize = frame.Size
local originalPos = frame.Position

-- Hàm tạo button toggle (như cũ, nhưng điều chỉnh vị trí)
local function createToggleButton(name, yOffset, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name .. ": OFF"
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Parent = frame
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 45)
        callback(state)
    end)
    return btn
end

-- Các button toggle (bắt đầu từ dưới title bar)
local y = 45  -- bắt đầu sau title
createToggleButton("Aimbot", y, function(s) estro.aimbot.Settings.Enabled = s end); y = y + 50
createToggleButton("Silent Aim", y, function(s) estro.Silent.Settings.Enable = s end); y = y + 50
createToggleButton("Speed Walk", y, function(s) estro.Movement.Settings.SpeedWalk.Enabled = s end); y = y + 50
createToggleButton("Aim TP", y, function(s) estro.aimbot.Settings.AimTP.Use = s end); y = y + 50
createToggleButton("Emote Macro", y, function(s) estro.Macro.Settings.Emote.Enable = s end); y = y + 50

-- Logic Minimize
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        frame.Size = UDim2.new(0, 220, 0, 35)
        minimizeBtn.Text = "+"
    else
        frame.Size = originalSize
        minimizeBtn.Text = "-"
    end
end)

-- Logic Close (đóng GUI hoàn toàn)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Làm GUI draggable (kéo thả)
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
