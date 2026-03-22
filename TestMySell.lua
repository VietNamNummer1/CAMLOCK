local rainbowGradient = Instance.new("UIGradient")
rainbowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),    -- đỏ
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 127, 0)),  -- cam
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),  -- vàng
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),    -- xanh lá
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),    -- xanh dương
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),   -- chàm
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(148, 0, 211))   -- tím
})
rainbowGradient.Rotation = 45
rainbowGradient.Parent = vu45

-- Hiệu ứng chuyển động cầu vồng (offset liên tục)
game:GetService("RunService").Heartbeat:Connect(function(dt)
    rainbowGradient.Offset = Vector2.new((tick() * 0.15) % 1, 0)
end)imbot
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.85, 0, 0, 50)
toggleBtn.Position = UDim2.new(0.075, 0, 0.4, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.Text = "Aimbot: OFF"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 18
toggleBtn.Parent = frame

local state = false
toggleBtn.Activated:Connect(function()
    state = not state
    Aimbot.Enabled = state
    toggleBtn.Text = "Aimbot: " .. (state and "ON" or "OFF")
    toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
end)

-- Nút Đóng GUI
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.Parent = frame

closeBtn.Activated:Connect(function()
    gui.Enabled = false
    task.delay(0.1, function()
        pcall(function()
            gui:Destroy()
        end)
    end)
    print("GUI aimbot đã đóng")
end)

print("Aimbot only loaded - bấm nút để bật/tắt")minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
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
-- Xóa BackgroundColor3 cũ của vu52
vu52.BackgroundColor3 = Color3.new(1,1,1) -- tạm để gradient hoạt động

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = rainbowGradient.Color -- dùng chung bảng màu
btnGradient.Rotation = 90
btnGradient.Parent = vu52

-- Cập nhật offset giống frame chính
game:GetService("RunService").Heartbeat:Connect(function()
    btnGradient.Offset = Vector2.new((tick() * 0.2) % 1, 0)
end)

-- Khi hover thì tăng tốc độ rainbow
vu52.MouseEnter:Connect(function()
    btnGradient.Offset = Vector2.new((tick() * 0.4) % 1, 0) -- tăng tốc
end)
vu52.MouseLeave:Connect(function()
    -- quay lại tốc độ bình thường (không cần làm gì vì Heartbeat vẫn chạy)
end)
local function updateCheckButton(btn, isOn)
    if isOn then
        btn.BackgroundColor3 = Color3.new(1,1,1) -- để gradient hiện
        if not btn:FindFirstChild("RainbowGradient") then
            local g = Instance.new("UIGradient")
            g.Name = "RainbowGradient"
            g.Color = rainbowGradient.Color
            g.Rotation = 45
            g.Parent = btn
            
            game:GetService("RunService").Heartbeat:Connect(function()
                if btn:FindFirstChild("RainbowGradient") then
                    g.Offset = Vector2.new((tick() * 0.25) % 1, 0)
                end
            end)
        end
    else
        -- Tắt rainbow → quay về màu xám/tĩnh
        local g = btn:FindFirstChild("RainbowGradient")
        if g then g:Destroy() end
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end

-- Gọi lại mỗi khi toggle
vu59.MouseButton1Click:Connect(function()
    vu14.Checks.KnifeCheck = not vu14.Checks.KnifeCheck
    vu59.Text = vu14.Checks.KnifeCheck and "Knife Check: ON" or "Knife Check: OFF"
    updateCheckButton(vu59, vu14.Checks.KnifeCheck)
    vu68()
end)
-- Với vu45
local stroke = vu45:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", vu45)
stroke.Thickness = 3
stroke.Transparency = 0.4

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = rainbowGradient.Color
strokeGradient.Parent = stroke

game:GetService("RunService").Heartbeat:Connect(function()
    strokeGradient.Offset = Vector2.new((tick() * 0.18) % 1, 0)
end)
