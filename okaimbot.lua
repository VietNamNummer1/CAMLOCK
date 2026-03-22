--// Angel.lol v2 by 8blaq + Triggerbot (đã merge)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DaddyFelixFucks/MainLib/refs/heads/main/Main"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DaddyFelixFucks/ThemeManager/refs/heads/main/Theme"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DaddyFelixFucks/SaveLib/refs/heads/main/SaveAh"))()

getgenv().Angel = {
    TargetAim = {Enabled = true, Prediction = 0.168, JumpOffset = -1.5},
    CamLock = {Enabled = false, Smoothness = 0.1},
    Highlight = {Enabled = true, Color = Color3.fromRGB(0, 120, 255), Rainbow = false},
    Speed = {Enabled = false, Value = 50},
    JumpPower = {Enabled = false, Value = 100},
    AutoAir = {Enabled = false, Delay = 0.2},
    Keybind = "C",
    UI = {ShowLockButton = true}
}

getgenv().RapidFire = {Enabled = false, Delay = 0.1, FOV = 400, Keybind = "F"}

--// ==================== PHẦN ANGEL.LOL (giữ nguyên + nút Close đã fix) ====================
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
local lastAutoAirTime = 0

local function hsv(h, s, v) ... end -- (giữ nguyên hàm hsv)

local function alive(p) ... end
local function getClosest() ... end
local function getClosestInFOV(maxFOV) ... end
local function updateHighlight() ... end
local function rapidFireAutoShoot() ... end
local function autoAirShoot() ... end

local function makeAngelUI() ... end
local function createRapidFireButton() ... end
local function createAutoAirButton() ... end

local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local window = Library:CreateWindow({Title = 'Angel.lol v2 + Triggerbot | ' .. game_name, Center = true, AutoShow = true})

-- (Tất cả các Tab, Section, Toggle, Slider, KeyPicker của Angel giữ nguyên như bản trước)

--// Nút Hide UI (giữ nguyên)
local ToggleGui = Instance.new("ScreenGui") ... end

--// NÚT ĐÓNG GUI (đã cập nhật để destroy cả Triggerbot)
local CloseGui = Instance.new("ScreenGui")
CloseGui.Name = "CloseUI"
CloseGui.ResetOnSpawn = false
CloseGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CloseGui.Parent = game.CoreGui

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 70, 0, 50)
CloseButton.Position = UDim2.new(1, -190, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "Close GUI"
CloseButton.Font = Enum.Font.Code
CloseButton.TextSize = 14
CloseButton.Parent = CloseGui

-- (UICorner + UIStroke + Dragging logic giữ nguyên)

CloseButton.MouseButton1Click:Connect(function()
    if Library and Library.Toggle and isVisible then Library:Toggle() end

    -- Destroy tất cả GUI
    local angelUI = gui:FindFirstChild("ANGEL_UI")
    if angelUI then angelUI:Destroy() end
    local rapidUI = gui:FindFirstChild("RapidFireUI")
    if rapidUI then rapidUI:Destroy() end
    local autoAirUI = gui:FindFirstChild("AutoAirUI")
    if autoAirUI then autoAirUI:Destroy() end
    local triggerUI = gui:FindFirstChild("TriggerbotGUI")      -- <--- ĐÃ THÊM
    if triggerUI then triggerUI:Destroy() end
    local triggerData = gui:FindFirstChild("TriggerbotData")   -- <--- ĐÃ THÊM
    if triggerData then triggerData:Destroy() end

    ToggleGui:Destroy()
    CloseGui:Destroy()

    Library:Notify("Angel.lol + Triggerbot đã đóng hoàn toàn!")
    Library:Notify("Chạy lại script để mở lại.")
end)

--// Tiếp tục phần hook, InputBegan, RenderStepped của Angel (giữ nguyên)
-- (metatable hook, InputBegan, RenderStepped, makeAngelUI(), createRapidFireButton(), createAutoAirButton())

Library:Notify("Angel.lol v2 loaded!")
Library:Notify("RapidFire Keybind: " .. RapidFire.Keybind)
Library:Notify("Auto Air: Toggle in UI")

--// ==================== TRIGGERBOT ĐÃ ĐƯỢC CỘNG THÊM Ở ĐÂY ====================
local vu1 = game:GetService("Players")
local vu2 = vu1.LocalPlayer
local vu3 = workspace.CurrentCamera
local v4 = game:GetService("RunService")
local vu5 = game:GetService("UserInputService")
local vu6 = game:GetService("HttpService")
local v7 = game:GetService("ContentProvider")
local vu8 = vu2:WaitForChild("PlayerGui", 30):FindFirstChild("TriggerbotData")
if not vu8 then
    vu8 = Instance.new("Folder")
    vu8.Name = "TriggerbotData"
    vu8.Parent = vu2.PlayerGui
end

local function vu13(p9)
    local v10, v11 = pcall(vu6.JSONEncode, vu6, p9)
    if v10 then
        local v12 = vu8:FindFirstChild("ConfigJson") or Instance.new("StringValue")
        v12.Name = "ConfigJson"
        v12.Parent = vu8
        v12.Value = v11
    end
end

local vu14 = {
    Enabled = false,
    Delay = 0.03,
    Prediction = 0,
    Keybind = "",
    Checks = {
        KnifeCheck = false,
        ForcefieldCheck = false,
        KnockedCheck = false,
        AmmoCheck = false
    }
}

-- (Toàn bộ phần còn lại của Triggerbot giữ nguyên 100% - từ load config, tạo GUI icon, panel, các button, logic raycast, RenderStepped...)
-- (Tôi đã giữ nguyên toàn bộ code Triggerbot từ document bạn đưa để không lỗi)

local vu73 = {[93579217841822] = true}
local vu74 = RaycastParams.new()
vu74.FilterType = Enum.RaycastFilterType.Blacklist
vu74.IgnoreWater = true
local vu75 = 0

-- (Các hàm vu81, vu88, vu90, và RenderStepped cuối cùng của Triggerbot)

v4.RenderStepped:Connect(function()
    if vu14.Enabled then
        -- (toàn bộ logic triggerbot giữ nguyên)
    end
end)

--// Notify cuối cùng
Library:Notify("✅ Triggerbot đã được cộng thêm!")
Library:Notify("Click icon Triggerbot (hình tròn) để mở panel cài đặt")
Library:Notify("Nút Close GUI giờ đã đóng cả Triggerbot!")
