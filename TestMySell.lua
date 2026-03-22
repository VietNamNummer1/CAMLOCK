-- Tạo GUI cho mobile/PC
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0.5, -100, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Estro Mobile GUI"
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Hàm tạo button
local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = name .. ": OFF"
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Parent = frame
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)
    
    return btn
end
getgenv().estro = {
    ["aimbot"] = {
        ["Settings"] = {
            ["Enabled"] = false,  -- Bắt đầu OFF, toggle bằng button
            -- Xóa: ["Key"] = "c",
            -- Xóa: ["Method"] = "Toggle",
            -- ... giữ nguyên các phần còn lại
            ["AimTP"] = {
                ["Use"] = false,  -- toggle bằng button
                -- Xóa: ["Key"] = "q",
                -- ...
            },
            ["Target_switch"] = {
                ["Use"] = false,
                -- Xóa: ["Key"] = "v",
                -- ...
            },
            -- Giữ Drawing FOV nếu executor mobile hỗ trợ
        },
    },
    ["Silent"] = {
        ["Settings"] = {
            ["Enable"] = false,  -- toggle bằng button
            -- Xóa priority nếu không cần
        },
    },
    -- Tương tự xóa key ở Movement, Macro, v.v.
    ["Movement"] = {
        ["Settings"] = {
            ["SpeedWalk"] = {
                ["Enabled"] = false,
                -- Xóa: ["Keybind"] = "Z",
                -- Xóa: ["Method"] = "toggle",
            },
            ["JumpPower"] = {
                ["Enable"] = false,
                -- Xóa keybind
            },
        },
    },
    ["Macro"] = {
        ["Settings"] = {
            ["Emote"] = {
                ["Enable"] = false,
                -- Xóa: ["Keybind"] = "m",
            },
            ["FirstPersonMacro"] = {
                ["Enable"] = false,
                -- Xóa keybind
            },
            -- Tương tự cho ThirdPersonMacro
        },
    },
    -- Checks, Visuals, Others giữ nguyên
}
-- Toggle Aimbot
createButton("Aimbot", 50, function(state)
    estro.aimbot.Settings.Enabled = state
    -- Nếu có hàm toggle aimbot riêng thì gọi ở đây
end)

-- Toggle Silent Aim
createButton("Silent Aim", 100, function(state)
    estro.Silent.Settings.Enable = state
end)

-- Toggle SpeedWalk
createButton("Speed Walk", 150, function(state)
    estro.Movement.Settings.SpeedWalk.Enabled = state
end)

-- Toggle AimTP (nếu có logic riêng)
createButton("Aim TP", 200, function(state)
    estro.aimbot.Settings.AimTP.Use = state
end)

-- Thêm button cho macro nếu cần
createButton("Emote Macro", 250, function(state)
    estro.Macro.Settings.Emote.Enable = state
    -- Nếu macro cần loop thì thêm logic ở đây
end)
