if not game:IsLoaded() then game.Loaded:Wait() end

local repo = 'https://raw.githubusercontent.com/vanhuydeptraitop1thegioi/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
if vanhuyhandsome then 
    title67 = "bunny.win - have a good fps" 
else
    title67 = "alwayswin - have a good ping" or "stop cheating"
end
local Window = Library:CreateWindow({
    Title = title67 or "nigga looking this code",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    main = Window:AddTab('Main'),
    ragebot = Window:AddTab('Ragebot'),
    visuals = Window:AddTab('Visuals'),
    character = Window:AddTab('Character'),
    ['UI Settings'] = Window:AddTab('Settings'),
}

local SilentAimGroupBox = Tabs.main:AddLeftGroupbox('Silent Aim')
local TargetsGroupBox = Tabs.main:AddLeftGroupbox('Targets')
local RagebotGroupBox = Tabs.ragebot:AddLeftGroupbox('Ragebot')
local HitboxGroupBox = Tabs.main:AddRightGroupbox("Hitbox Expander")
local GunGroupBox = Tabs.main:AddRightGroupbox('Gun')
local UilityGroupBox = Tabs.main:AddRightGroupbox('Utility')
local ProtectionGroupBox = Tabs.character:AddRightGroupbox('Protection')
local FakepositionGroupBox = Tabs.character:AddRightGroupbox('Fake Position')
local VoidGroupBox = Tabs.character:AddRightGroupbox('Void')
local MovementGroupBox = Tabs.character:AddLeftGroupbox('Movement')
local CharacterGroupBox = Tabs.character:AddLeftGroupbox('Character')
local ESPGroupBox = Tabs.visuals:AddLeftGroupbox('ESP')
local WorldGroupBox = Tabs.visuals:AddRightGroupbox('World')
local HitDetectionGroupBox = Tabs.main:AddLeftGroupbox("Hit Effects")
local BulletTracersGroupBox = Tabs.visuals:AddLeftGroupbox("Bullet Tracers")
local SelfGroupBox = Tabs.visuals:AddRightGroupbox("Self")
local TrollStuffGroupBox = Tabs.character:AddRightGroupbox("Troll Stuff")
local PlayerInfoGroupBox = Tabs.ragebot:AddRightGroupbox("Player Info")
local RespawnAbuseGroupBox = Tabs.ragebot:AddLeftGroupbox("Respawn Abuse")
local SkyboxGroupBox = Tabs.visuals:AddRightGroupbox("Skybox")
local AuraGroupBox = Tabs.visuals:AddLeftGroupbox("Aura")

local Alwayswin = {  --// Name like Alwayswin paid 1k Robux
    JewAim = {
        Enabled = false,
        Target = "None",
        AutoFire = false,
        Strafe = false,
        CSync = false,
        VisualizeStrafe = false,
        VisualizeStrafeColor = Color3.new(155, 125, 175),
        StrafeMethod = "Randomize",
        Highlight = false,
        HighlightFillColor = Color3.new(155, 125, 175),
        HighlightOutlineColor = Color3.new(129, 105, 145),
        Tracer = false,
        TracerPosition = "Mouse",
        TracerFillColor = Color3.new(155, 125, 175),
        TracerOutlineColor = Color3.new(0, 0, 0),
        LookAt = false,
        VoidResolver = false,
        AutoStomp = false,
    },

    KillAura = {
        Enabled = false,
        Keybind = false,
        Distance = 200,
        StompAura = false,
    },

    ExtraESP = {
        MaterialEnabled = false,
        Material = "Neon",
        MaterialColor = Color3.new(255, 255, 255),
        HighlightEnabled = false,
        HighlightFillColor = Color3.new(0, 0, 0),
        HighlightOutlineColor = Color3.new(0, 0, 0),
    },

    CheaterProtection = {
        Enabled = false,
    },

    HitboxExpander = {
        Enabled = false,
        Visualize = false,
        Color = Color3.new(155, 125, 175),
        OutlineColor = Color3.new(155, 125, 175),
        FillTransparency = 0.5,
        OutlineTransparency = 0.3,
        Size = 37,
    },

    Target = {
        AutoKill = false,
        AutoKillDesync = false,
        Target = nil,
    },

    Desync = {
        Enabled = false,
        Keybind = false,
        Visualize = false,
        Tranparency = 0,
        Spam = false,
        InVoid = 0.4,
        OnGround = 0.133,
        Method = "Custom",
    },

    Network = {
        Desync = false,
        UseSenderRate = false,
        SenderRate = 60,
        FakePos = false,
        RefreshRate = 20,
    },

    Speed = {
        Enabled = false,
        Keybind = false,
        Speed = 20,
    },

    Fly = {
        Enabled = false,
        Keybind = false, 
        Speed = 20,
    },

    BulletTracers = {
        Enabled = false,
        TextureID = "rbxassetid://12781852245",
        Color = Color3.new(155, 125, 175),
        Size = 0.4,
        Transparency = 0,
        TimeAlive = 3,
    },

    HitEffects = {
        HitSounds = true,
        HitSoundID = "rbxassetid://97643101798871",
        HitSoundVolume = 1,
        HitNotifications = true,
        HitNotificationsTime = 3,
    },

    AutoReload = {
        Enabled = false,
    },

    AntiStomp = {
        Enabled = false,
    },

    RapidFire = {
        Enabled = false,
    },

    AutoLoadout = {
        Enabled = false,
        Gun = "[Rifle]"
    },

    AutoArmor = {
        Enabled = false,
    },

    SelfVisuals = {
        Character = false,
        CharacterMaterial = "ForceField",
        CharacterColor = Color3.new(155, 125, 175),
        Tool = false,
        ToolMaterial = "ForceField",
        ToolColor = Color3.new(155, 125, 175),
        Aura = false,
        AuraColor = Color3.new(155, 125, 175),
        AuraTexture = "Pink Shyt",
        WalkSteps = false,
        WalkStepsRate = 0.5,
        WalkStepsSize = NumberSequence.new(0, 0.25, 0, 0.5, 1.5, 0, 1, 2, 0),
        WalkStepsColor = Color3.new(255, 255, 255),
    },

}
local symbolhit = true  --// ragebot value like symbol 
local Player = game.Players.LocalPlayer
local LocalPlayer = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local bodyEffects = character:FindFirstChild("67BodyEffects")
local lockedTarget = nil
local ReplicatedStorage = game:GetService('ReplicatedStorage')

purchasinggun = false
purchasingammo = false
purchasingmask = false
purchasingarmor = false

local autoReloadEnabled = false
local autoResetEnabled = false

randomnumber = 676767

local ragebottargets = {}

task.spawn(function()
	while task.wait() do
		if autoReloadEnabled and character then
			local reloadPlayer = Player
			local reloadChar = reloadPlayer and reloadPlayer.Character
			if reloadChar then
				for _, tool in ipairs(reloadChar:GetChildren()) do
					if tool:IsA("Tool") and tool:FindFirstChild("Ammo") and tool.Ammo.Value <= 67 then
						ReplicatedStorage.MainEvent:FireServer("Reload", tool)
					end
				end
			end
		end
        
        if autoResetEnabled and character then
			local ko = character:FindFirstChild("BodyEffects") and character.BodyEffects:FindFirstChild("K.O")
			if ko and ko.Value then
				character.Humanoid.Health = 36
            end
		end
	end
end)

GunGroupBox:AddToggle("AutoReload", {
    Text = "Auto Reload",
    Default = false,
    Callback = function(state)
        autoReloadEnabled = state
    end
})

ProtectionGroupBox:AddToggle('antistomp', {
    Text = 'Anti Stomp',
    Default = false,
    Callback = function(Value)
        autoResetEnabled = Value
    end
})
ProtectionGroupBox:AddToggle('antijew', {
    Text = 'Anti jew',
    Default = false,
})
ProtectionGroupBox:AddToggle('antinigga', {
    Text = 'Anti nigga',
    Default = false,
})
