-- Estro Mobile - CHỈ AIMBOT (tối giản, không tính năng thừa)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Setting aimbot (chính xác theo yêu cầu)
getgenv().Aimbot = {
    Enabled = false,
    Prediction = 0.128,
    X_Offset   = 0.1452,
    Y_Offset   = 0.1235,
    AirOffset  = 0.735,
    FallOffset = 0.712,
    HitPart    = "Head",          -- có thể đổi thành "UpperTorso" hoặc "HumanoidRootPart"
    FOV_Radius = 320,
    Smoothing  = 0.88,            -- chỉnh 0.90-0.96 nếu muốn mượt hơn
    TeamCheck  = true,
    VisibleCheck = true,
}

local CurrentTarget = nil

-- Tìm địch gần nhất trong FOV
local function GetClosest()
    local closest, minDist = nil, Aimbot.FOV_Radius
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer or not plr.Character or not plr.Character:FindFirstChild("Humanoid") or plr.Character.Humanoid.Health <= 0 then
            continue
        end
        if Aimbot.TeamCheck and plr.Team == LocalPlayer.Team then continue end
        
        local part = plr.Character:FindFirstChild(Aimbot.HitPart) or plr.Character:FindFirstChild("HumanoidRootPart")
        if not part then continue end
        
        local screen, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        
        local dist = (Vector2.new(screen.X, screen.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        if dist >= minDist then continue end
        
        if Aimbot.VisibleCheck then
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character or {}}
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            
            local result = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 2000, rayParams)
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

-- Tính vị trí predict + offset
local function GetPredictedPos(target)
    local part = target.Character:FindFirstChild(Aimbot.HitPart) or target.Character.HumanoidRootPart
    if not part then return nil end
    
    local vel = part.Velocity
    local pos = part.Position + vel * Aimbot.Prediction
    
    local hum = target.Character:FindFirstChild("Humanoid")
    if hum then
        local state = hum:GetState()
        if state == Enum.HumanoidStateType.Freefall then
            pos += Vector3.new(0, Aimbot.FallOffset, 0)
        elseif state == Enum.HumanoidStateType.Jumping then
            pos += Vector3.new(0, Aimbot.AirOffset, 0)
        end
    end
    
    pos += Vector3.new(Aimbot.X_Offset, Aimbot.Y_Offset, 0)
    return pos
end

-- Loop aim chính
RunService.RenderStepped:Connect(function()
    if not Aimbot.Enabled then
        CurrentTarget = nil
        return
    end
    
    CurrentTarget = GetClosest()
    if CurrentTarget then
        local predPos = GetPredictedPos(CurrentTarget)
        if predPos then
            local screenPos = Camera:WorldToViewportPoint(predPos)
            local mousePos = Vector2.new(Mouse.X, Mouse.Y)
            local targetPos = Vector2.new(screenPos.X, screenPos.Y)
            
            local delta = (targetPos - mousePos) * Aimbot.Smoothing
            mousemoverel(delta.X, delta.Y)
        end
    end
end)

-- ================== GUI ĐƠN GIẢN CHỈ AIMBOT ==================
local gui = Instance.new("ScreenGui")
gui.Name = "AimbotOnlyGUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 140)
frame.Position = UDim2.new(0.5, -90, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "Aimbot Only"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Nút Toggle Aimbot
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

-- Draggable (kéo thả) - giữ nguyên nếu bạn có
-- (code draggable như trước, nếu cần paste lại thì bảo mình)
