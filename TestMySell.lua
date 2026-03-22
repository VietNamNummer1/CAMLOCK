-- ================== NÂNG CẤP GUI: CLOSE + MINIMIZE + FLOATING REOPEN ==================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "EstroMobileGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")  -- Nếu vẫn lỗi destroy, thử đổi sang game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 340)
frame.Position = UDim2.new(0.5, -110, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui

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

-- Minimize button (+/-)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 2)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 24
minimizeBtn.Parent = titleBar

-- Close button (X)
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

-- Hàm tạo toggle button (giữ nguyên như cũ, chỉ thêm Visible control)
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
    btn.Activated:Connect(function()
        state = not state
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(45, 45, 45)
        callback(state)
    end)
    return btn
end

-- Các button toggle (ví dụ, chỉnh yOffset nếu cần)
local y = 45
createToggleButton("Aimbot", y, function(s) estro.aimbot.Settings.Enabled = s end); y += 50
createToggleButton("Silent Aim", y, function(s) estro.Silent.Settings.Enable = s end); y += 50
createToggleButton("Speed Walk", y, function(s) estro.Movement.Settings.SpeedWalk.Enabled = s end); y += 50
createToggleButton("Aim TP", y, function(s) estro.aimbot.Settings.AimTP.Use = s end); y += 50
createToggleButton("Emote Macro", y, function(s) estro.Macro.Settings.Emote.Enable = s end); y += 50
-- Thêm nút Aimbot Custom nếu bạn có
createToggleButton("Aimbot Custom", y, function(s) CustomAimbot.Enabled = s end); y += 50

-- Minimize logic (ẩn/hiện button thay resize để ổn định mobile)
minimizeBtn.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        minimizeBtn.Text = "+"
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA("TextButton") and child \~= minimizeBtn and child \~= closeBtn then
                child.Visible = false
            end
        end
        frame.Size = UDim2.new(0, 220, 0, 35)  -- vẫn resize nhẹ để gọn
    else
        minimizeBtn.Text = "-"
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA("TextButton") and child \~= minimizeBtn and child \~= closeBtn then
                child.Visible = true
            end
        end
        frame.Size = originalSize
    end
    -- Force render fix
    frame.Visible = false
    task.wait(0.02)
    frame.Visible = true
end)

-- Close logic nâng cấp (ẩn + destroy an toàn)
closeBtn.Activated:Connect(function()
    gui.Enabled = false
    frame.Visible = false
    
    task.delay(0.15, function()
        pcall(function()
            gui:Destroy()
        end)
        pcall(function()
            gui.Parent = nil
        end)
    end)
    
    -- Tạo floating reopen button (mở lại GUI)
    local floatBtn = Instance.new("TextButton")
    floatBtn.Size = UDim2.new(0, 70, 0, 40)
    floatBtn.Position = UDim2.new(0, 10, 0.1, 0)  -- góc trên trái, chỉnh nếu cần
    floatBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    floatBtn.Text = "Estro"
    floatBtn.TextColor3 = Color3.new(1,1,1)
    floatBtn.Font = Enum.Font.SourceSansBold
    floatBtn.TextSize = 18
    floatBtn.Parent = gui  -- vẫn trong gui cũ để reopen
    
    floatBtn.Activated:Connect(function()
        gui.Enabled = true
        frame.Visible = true
        floatBtn:Destroy()  -- xóa floating sau khi mở
    end)
end)

-- Draggable (kéo thả) - giữ nguyên nếu bạn có
-- (code draggable như trước, nếu cần paste lại thì bảo mình)
