--// Services

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera

local Mouse = LocalPlayer:GetMouse()

--// Config

local Config = {

    Enabled = false,

    Visible = true,

    FOV = 120,

    WallCheck = false,  -- Changed to false for better detection

    Target = nil,

    Sliding = false,

    TracerEnabled = true

}

--// GUI

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))

ScreenGui.ResetOnSpawn = false

local OpenBtn = Instance.new("TextButton", ScreenGui)

OpenBtn.Size = UDim2.new(0, 110, 0, 30)

OpenBtn.Position = UDim2.new(0.5, -55, 0, 35)

OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

OpenBtn.Text = "FatalSilent"

OpenBtn.TextColor3 = Color3.new(1, 0, 0)

OpenBtn.Font = Enum.Font.SourceSansBold

OpenBtn.TextSize = 15

Instance.new("UICorner", OpenBtn)

local OpenStroke = Instance.new("UIStroke", OpenBtn)

OpenStroke.Thickness = 2

local FOVCircle = Instance.new("Frame", ScreenGui)

FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)

FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)

FOVCircle.Size = UDim2.new(0, Config.FOV * 2, 0, Config.FOV * 2)

FOVCircle.BackgroundTransparency = 1

FOVCircle.Visible = false

local CircleStroke = Instance.new("UIStroke", FOVCircle)

CircleStroke.Color = Color3.new(1, 1, 1)

CircleStroke.Thickness = 2

Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)

--// Tracer Line

local TracerLine = Drawing.new("Line")

TracerLine.Visible = false

TracerLine.Thickness = 2

TracerLine.Transparency = 1

TracerLine.Color = Color3.new(1, 1, 1)

local Menu = Instance.new("Frame", ScreenGui)

Menu.Size = UDim2.new(0, 180, 0, 210)

Menu.Position = UDim2.new(0.1, 0, 0.3, 0)

Menu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

Instance.new("UICorner", Menu)

-- Menu UI

local Toggle = Instance.new("TextButton", Menu)

Toggle.Size = UDim2.new(0.9, 0, 0, 30)

Toggle.Position = UDim2.new(0.05, 0, 0.05, 0)

Toggle.Text = "SILENT: OFF"

Toggle.BackgroundColor3 = Color3.fromRGB(120, 30, 30)

Toggle.TextColor3 = Color3.new(1, 1, 1)

Toggle.Font = Enum.Font.SourceSansBold

Toggle.TextSize = 14

Instance.new("UICorner", Toggle)

-- Tracer Toggle Button

local TracerToggle = Instance.new("TextButton", Menu)

TracerToggle.Size = UDim2.new(0.9, 0, 0, 30)

TracerToggle.Position = UDim2.new(0.05, 0, 0.23, 0)

TracerToggle.Text = "TRACER: ON"

TracerToggle.BackgroundColor3 = Color3.fromRGB(50, 120, 50)

TracerToggle.TextColor3 = Color3.new(1, 1, 1)

TracerToggle.Font = Enum.Font.SourceSansBold

TracerToggle.TextSize = 14

Instance.new("UICorner", TracerToggle)

-- WallCheck Toggle

local WallToggle = Instance.new("TextButton", Menu)

WallToggle.Size = UDim2.new(0.9, 0, 0, 30)

WallToggle.Position = UDim2.new(0.05, 0, 0.41, 0)

WallToggle.Text = "WALLCHECK: OFF"

WallToggle.BackgroundColor3 = Color3.fromRGB(120, 30, 30)

WallToggle.TextColor3 = Color3.new(1, 1, 1)

WallToggle.Font = Enum.Font.SourceSansBold

WallToggle.TextSize = 14

Instance.new("UICorner", WallToggle)

local SliderLabel = Instance.new("TextLabel", Menu)

SliderLabel.Size = UDim2.new(0.9, 0, 0, 20)

SliderLabel.Position = UDim2.new(0.05, 0, 0.62, 0)

SliderLabel.Text = "FOV: " .. Config.FOV

SliderLabel.TextColor3 = Color3.new(1, 1, 1)

SliderLabel.BackgroundTransparency = 1

SliderLabel.Font = Enum.Font.SourceSansBold

SliderLabel.TextSize = 14

local SliderBack = Instance.new("Frame", Menu)

SliderBack.Size = UDim2.new(0.9, 0, 0, 15)

SliderBack.Position = UDim2.new(0.05, 0, 0.75, 0)

SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

Instance.new("UICorner", SliderBack)

local SliderFill = Instance.new("Frame", SliderBack)

SliderFill.Size = UDim2.new((Config.FOV - 50) / 250, 0, 1, 0)

SliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 100)

Instance.new("UICorner", SliderFill)

local SliderButton = Instance.new("Frame", SliderBack)

SliderButton.Size = UDim2.new(0, 20, 0, 20)

SliderButton.Position = UDim2.new((Config.FOV - 50) / 250, -10, 0.5, -10)

SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)

SliderButton.BorderSizePixel = 0

Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(1, 0)

--// Logic

local Highlight = Instance.new("Highlight", ScreenGui)

Highlight.Enabled = false

Highlight.FillTransparency = 0.5

Highlight.OutlineTransparency = 0

local function getClosestPlayerToCursor()

    local closestPlayer = nil

    local shortestDistance = math.huge

    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do

        if player ~= LocalPlayer and player.Character then

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

            local hrp = player.Character:FindFirstChild("HumanoidRootPart")

            

            if humanoid and humanoid.Health > 0 and hrp then

                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                

                if onScreen and screenPos.Z > 0 then

                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude

                    

                    if distance < Config.FOV and distance < shortestDistance then

                        if Config.WallCheck then

                            local rayParams = RaycastParams.new()

                            rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}

                            rayParams.FilterType = Enum.RaycastFilterType.Blacklist

                            

                            local ray = workspace:Raycast(Camera.CFrame.Position, (hrp.Position - Camera.CFrame.Position), rayParams)

                            

                            if ray then

                                if ray.Instance:IsDescendantOf(player.Character) then

                                    closestPlayer = player

                                    shortestDistance = distance

                                end

                            else

                                closestPlayer = player

                                shortestDistance = distance

                            end

                        else

                            closestPlayer = player

                            shortestDistance = distance

                        end

                    end

                end

            end

        end

    end

    return closestPlayer

end

--// NO-LAG REDIRECTION (Da Hood Shiftlock Fix)

local mt = getrawmetatable(game)

local oldNamecall = mt.__namecall

local oldIndex = mt.__index

setreadonly(mt, false)

mt.__index = newcclosure(function(self, idx)

    if self == Mouse and (idx == "Hit" or idx == "Target") and Config.Enabled and Config.Target then

        local char = Config.Target.Character

        if char then

            local head = char:FindFirstChild("Head")

            if head then 

                return (idx == "Hit" and head.CFrame or head) 

            end

        end

    end

    return oldIndex(self, idx)

end)

mt.__namecall = newcclosure(function(self, ...)

    local method = getnamecallmethod()

    if Config.Enabled and Config.Target and self == Camera then

        if method == "ViewportPointToRay" or method == "ScreenPointToRay" then

            local char = Config.Target.Character

            if char then

                local head = char:FindFirstChild("Head")

                if head then

                    return Ray.new(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit)

                end

            end

        end

    end

    return oldNamecall(self, ...)

end)

setreadonly(mt, true)

--// Target Update Loop (Faster for better detection)

task.spawn(function()

    while task.wait(0.03) do  -- Faster update rate

        if Config.Enabled then

            Config.Target = getClosestPlayerToCursor()

            if Config.Target and Config.Target.Character then

                Highlight.Adornee = Config.Target.Character

                Highlight.Enabled = true

            else 

                Highlight.Enabled = false 

            end

        else 

            Highlight.Enabled = false 

        end

    end

end)

--// Tracer & Rainbow Update

RunService.RenderStepped:Connect(function()

    local color = Color3.fromHSV(tick() % 4 / 4, 1, 1)

    OpenStroke.Color = color

    OpenBtn.TextColor3 = color

    Highlight.FillColor = color

    Highlight.OutlineColor = color

    

    -- Update tracer line

    if Config.Enabled and Config.TracerEnabled and Config.Target then

        local targetChar = Config.Target.Character

        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then

            local hrp = targetChar.HumanoidRootPart

            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

            

            if onScreen and pos.Z > 0 then

                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

                TracerLine.From = screenCenter

                TracerLine.To = Vector2.new(pos.X, pos.Y)

                TracerLine.Color = color

                TracerLine.Visible = true

            else

                TracerLine.Visible = false

            end

        else

            TracerLine.Visible = false

        end

    else

        TracerLine.Visible = false

    end

end)

--// UI Interaction

OpenBtn.MouseButton1Click:Connect(function()

    Config.Visible = not Config.Visible

    Menu.Visible = Config.Visible

    Config.Sliding = false

end)

Toggle.MouseButton1Click:Connect(function()

    Config.Enabled = not Config.Enabled

    FOVCircle.Visible = Config.Enabled

    Toggle.Text = Config.Enabled and "SILENT: ON" or "SILENT: OFF"

    Toggle.BackgroundColor3 = Config.Enabled and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(120, 30, 30)

end)

TracerToggle.MouseButton1Click:Connect(function()

    Config.TracerEnabled = not Config.TracerEnabled

    TracerToggle.Text = Config.TracerEnabled and "TRACER: ON" or "TRACER: OFF"

    TracerToggle.BackgroundColor3 = Config.TracerEnabled and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(120, 30, 30)

    if not Config.TracerEnabled then

        TracerLine.Visible = false

    end

end)

WallToggle.MouseButton1Click:Connect(function()

    Config.WallCheck = not Config.WallCheck

    WallToggle.Text = Config.WallCheck and "WALLCHECK: ON" or "WALLCHECK: OFF"

    WallToggle.BackgroundColor3 = Config.WallCheck and Color3.fromRGB(50, 120, 50) or Color3.fromRGB(120, 30, 30)

end)

--// Fixed Slider Logic

local function updateSlider(inputPos)

    local relativeX = math.clamp((inputPos.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)

    Config.FOV = math.floor(relativeX * 250 + 50)

    SliderLabel.Text = "FOV: " .. Config.FOV

    FOVCircle.Size = UDim2.new(0, Config.FOV * 2, 0, Config.FOV * 2)

    SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)

    SliderButton.Position = UDim2.new(relativeX, -10, 0.5, -10)

end

UIS.InputBegan:Connect(function(input)

    if Config.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then

        local mPos = input.Position

        local sPos = SliderBack.AbsolutePosition

        local sSize = SliderBack.AbsoluteSize

        

        if mPos.X >= sPos.X and mPos.X <= sPos.X + sSize.X and mPos.Y >= sPos.Y and mPos.Y <= sPos.Y + sSize.Y then

            Config.Sliding = true

            updateSlider(mPos)

        end

    end

end)

UIS.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

        Config.Sliding = false

    end

end)

UIS.InputChanged:Connect(function(input)

    if Config.Sliding and Config.Visible and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then

        local mPos = UIS:GetMouseLocation()

        updateSlider(mPos)

    end

end)

-- Draggable Menu

local dragging, dragStart, startPos

Menu.InputBegan:Connect(function(input)

    if not Config.Sliding and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then

        dragging = true

        dragStart = input.Position

        startPos = Menu.Position

        

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then

                dragging = false

            end

        end)

    end

end)

UIS.InputChanged:Connect(function(input)

    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then

        local delta = input.Position - dragStart

        Menu.Position = UDim2.new(

            startPos.X.Scale,

            startPos.X.Offset + delta.X,

            startPos.Y.Scale,

            startPos.Y.Offset + delta.Y

        )

    end

end)
