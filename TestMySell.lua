-- Estro Mobile - ONLY AIMBOT (tối giản, setting chính xác theo yêu cầu)
-- Prediction = 0.128, X = 0.1452, Y = 0.1235, AirOffset = 0.735, FallOffset = 0.712

local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local LocalPlayer   = Players.LocalPlayer
local Camera        = workspace.CurrentCamera
local Mouse         = LocalPlayer:GetMouse()

-- Setting aimbot
getgenv().Aimbot = {
    Enabled     = false,
    Prediction  = 0.128,
    X_Offset    = 0.1452,
    Y_Offset    = 0.1235,
    AirOffset   = 0.735,
    FallOffset  = 0.712,
    HitPart     = "Head",          -- đổi thành "UpperTorso" hoặc "HumanoidRootPart" nếu muốn
    FOV_Radius  = 320,             -- bán kính FOV (giảm xuống 250-280 nếu aim quá rộng)
    Smoothing   = 0.88,            -- tăng lên 0.92-0.96 nếu muốn mượt hơn (nhưng chậm hơn)
    TeamCheck   = true,
    VisibleCheck= true,
}

local CurrentTarget = nil

-----------------------------------------------------------------
-- Hàm tìm mục tiêu gần nhất trong FOV
-----------------------------------------------------------------
local function GetClosestPlayer()
    local closest, minDist = nil, Aimbot.FOV_Radius

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer or not player.Character then continue end
        
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        if Aimbot.TeamCheck and player.Team == LocalPlayer.Team then continue end
        
        local targetPart = player.Character:FindFirstChild(Aimbot.HitPart) 
                         or player.Character:FindFirstChild("HumanoidRootPart")
        if not targetPart then continue end
        
        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
        if not onScreen then continue end
        
        local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
        if distance >= minDist then continue end
        
        if Aimbot.VisibleCheck then
            local rayParams           = RaycastParams.new()
            rayParams.FilterType      = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character or game}
            
            local rayResult = workspace:Raycast(
                Camera.CFrame.Position,
                (targetPart.Position - Camera.CFrame.Position).Unit * 3000,
                rayParams
            )
            
            if rayResult and rayResult.Instance:IsDescendantOf(player.Character) then
                closest = player
                minDist = distance
            end
        else
            closest = player
            minDist = distance
        end
    end
    
    return closest
end

-----------------------------------------------------------------
-- Tính vị trí dự đoán + offset
-----------------------------------------------------------------
local function GetPredictedPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return nil end
    
    local part = targetPlayer.Character:FindFirstChild(Aimbot.HitPart) 
               or targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not part then return nil end
    
    local velocity = part.Velocity
    local predicted = part.Position + (velocity * Aimbot.Prediction)
    
    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        local state = humanoid:GetState()
        if state == Enum.HumanoidStateType.Freefall then
            predicted = predicted + Vector3.new(0, Aimbot.FallOffset, 0)
        elseif state == Enum.HumanoidStateType.Jumping then
            predicted = predicted + Vector3.new(0, Aimbot.AirOffset, 0)
        end
    end
    
    -- Áp dụng offset X Y
    predicted = predicted + Vector3.new(Aimbot.X_Offset, Aimbot.Y_Offset, 0)
    
    return predicted
end

-----------------------------------------------------------------
-- Loop aim chính (chạy mỗi frame)
-----------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    if not Aimbot.Enabled then
        CurrentTarget = nil
        return
    end
    
    CurrentTarget = GetClosestPlayer()
    
    if CurrentTarget then
        local aimPosition = GetPredictedPosition(CurrentTarget)
        if aimPosition then
            local screenPoint = Camera:WorldToViewportPoint(aimPosition)
            local currentMouse = Vector2.new(Mouse.X, Mouse.Y)
            local targetMouse  = Vector2.new(screenPoint.X, screenPoint.Y)
            
            local delta = (targetMouse - currentMouse) * Aimbot.Smoothing
            mousemoverel(delta.X, delta.Y)
        end
    end
end)

-----------------------------------------------------------------
-- GUI đơn giản chỉ có nút bật/tắt + đóng
-----------------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "AimbotGUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(0.5, -100, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "Aimbot Only"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.Parent = frame

-- Nút Toggle
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0.8, 0, 0, 50)
toggle.Position = UDim2.new(0.1, 0, 0.35, 0)
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.Text = "Aimbot: OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.SourceSans
toggle.TextSize = 20
toggle.Parent = frame

local enabled = false
toggle.Activated:Connect(function()
    enabled = not enabled
    Aimbot.Enabled = enabled
    
    toggle.Text = "Aimbot: " .. (enabled and "ON" or "OFF")
    toggle.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(60, 60, 60)
end)

-- Nút đóng GUI
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 3)
close.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.SourceSansBold
close.TextSize = 22
close.Parent = frame

close.Activated:Connect(function()
    gui.Enabled = false
    task.delay(0.08, function()
        pcall(function() gui:Destroy() end)
    end)
end)

print("Aimbot script loaded - GUI đã hiện, bấm để bật/tắt")        local part = plr.Character:FindFirstChild(Aimbot.HitPart) or plr.Character:FindFirstChild("HumanoidRootPart")
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
