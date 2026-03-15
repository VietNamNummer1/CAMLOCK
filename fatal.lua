if not game:IsLoaded() then
    game.Loaded:Wait()
    end
    
    getgenv().Fatal = {
        Silentaim = {
            ["Toggle"] = "P",
            ["Enabled"] = true,
            ["Prediction"] = 0.13,
            ["AutoPrediction"] = true,
            ["AimPart"] = "Head",
            ["ClosestBodyPart"] = true,
            ["AntiGroundShots"] = true,
            ["HitChance"] = 100,
            ["WallCheck"] = true,
            ["UnlockOnDeath"] = true,
            ["AntiAimViewer"] = true,
        },
        FOV = {
            ["Visible"] = false,
            ["Radius"] = 15
        },
        Tracer = {
            ["Key"] = "C",
            ["Enabled"] = true,
            ["Part"] = "HumanoidRootPart",
            ["ClosestBodyPart"] = false,
            ["UseCircleRadius"] = true,
            ["DisableOutSideCircle"] = false,
            ["UnlockOnEnemyDeath"] = true,
            ["UnlockOnPlayerDeath"] = true,
            ["Predicting"] = true,
            ["Prediction"] = 0.13,
            ["Smoothness"] = 0.06,
            ["WallCheck"] = true,
            ["CheckIfKo"] = true,
            ["UseShake"] = true,
            ["ShakePower"] = 7.5
        },
        TracerFOV = {
            ["Visible"] = false,
            ["Radius"] = 60
        },
        SilentaimAndTracer = {
            ["DesyncResolver"] = true,
            ["DesyncDetection"] = 100,
            ["UnderGroundResolver"] = true,
        
        }
    }
    
    local Plr  = nil
    
    local Players, Client, Mouse, RS, Camera =
        game:GetService("Players"),
        game:GetService("Players").LocalPlayer,
        game:GetService("Players").LocalPlayer:GetMouse(),
        game:GetService("RunService"),
        game:GetService("Workspace").CurrentCamera
    
    local TracerCircle = Drawing.new("Circle")
    
    TracerCircle.Color     = Color3.new(0,0,0)
    TracerCircle.Thickness = 1
    
    local UpdateFOV = function ()
        if ( not TracerCircle) then
            return TracerCircle
        end
        TracerCircle.Visible  = getgenv().Fatal.TracerFOV.Visible
        TracerCircle.Radius   = getgenv().Fatal.TracerFOV.Radius * 3
        TracerCircle.Position = Vector2.new(Mouse.X, Mouse.Y + (game:GetService("GuiService"):GetGuiInset().Y))
        return TracerCircle
    end
    
    RS.Heartbeat:Connect(UpdateFOV)
    
    local WallCheck = function(destination, ignore)
        local Origin    = Camera.CFrame.p
        local CheckRay  = Ray.new(Origin, destination - Origin)
        local Hit       = game.workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
        return Hit      == nil
    end
    
    local WTS = function (Object)
        local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
        return Vector2.new(ObjectVector.X, ObjectVector.Y)
    end
    
    local IsOnScreen = function (Object)
        local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
        return IsOnScreen
    end
    
    local FilterObjs = function (Object)
        if string.find(Object.Name, "Gun") then
            return
        end
        if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
            return true
        end
    end
    
    local ClosestPlrFromMouse2 = function()
        local Target, Closest = nil, 1/0
        
        for _ ,v in pairs(Players:GetPlayers()) do
            if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
                if getgenv().Fatal.Tracer.WallCheck then
                    local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            
                    if (Distance < Closest and OnScreen) and WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}) then
                        Closest = Distance
                        Target = v
                    end
                    elseif getgenv().Fatal.Tracer.UseCircleRadius then
                        local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if (TracerCircle.Radius > Distance and Distance < Closest and OnScreen) and WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}) then
                            Closest = Distance
                            Target = v
                        end
                    else
                        local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            
                        if (Distance < Closest and OnScreen) then
                            Closest = Distance
                            Target = v
                        end
                    end
                end
            end
        return Target
    end
    
    local GetClosestBodyPart = function (character)
        local ClosestDistance = 1/0
        local BodyPart = nil
        
        if (character and character:GetChildren()) then
            for _,  x in next, character:GetChildren() do
                if FilterObjs(x) and IsOnScreen(x) then
                    local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if (Circle.Radius > Distance and Distance < ClosestDistance) then
                        ClosestDistance = Distance
                        BodyPart = x
                    end
                end
            end
        end
        return BodyPart
    end
    
    local GetClosestBodyPartV2 = function (character)
        local ClosestDistance = 1/0
        local BodyPart = nil
        
        if (character and character:GetChildren()) then
            for _,  x in next, character:GetChildren() do
                if FilterObjs(x) and IsOnScreen(x) then
                    local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if (Distance < ClosestDistance) then
                        ClosestDistance = Distance
                        BodyPart = x
                    end
                end
            end
        end
        return BodyPart
    end
    
    Mouse.KeyDown:Connect(function(Key)
        local Keybind = getgenv().Fatal.Tracer.Key:lower()
        if (Key == Keybind) then
            if getgenv().Fatal.Tracer.Enabled == true then
                IsTargetting = not IsTargetting
                if IsTargetting then
                    Plr = ClosestPlrFromMouse2()
                else
                    if Plr ~= nil then
                        Plr = nil
                        IsTargetting = false
                    end
                end
            end
        end
    end)

    RS.Heartbeat:Connect(function()
    if getgenv().Fatal.Silentaim.Enabled then
    if Silentaim and Silentaim.Character and Silentaim.Character:WaitForChild(getgenv().Fatal.Silentaim.Part) then
        if getgenv().Fatal.SilentaimAndTracer.DesyncResolver == true and Silentaim.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude > getgenv().Fatal.Boths.DesyncDetection then            
            pcall(function()
                local TargetVel = Silentaim.Character[getgenv().Fatal.Silentaim.Part]
                TargetVel.Velocity = Vector3.new(0, 0, 0)
                TargetVel.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        
            end)
        end
            if getgenv().Fatal.SilentaimAndTracer.AntiGroundShots == true and Prey.Character:FindFirstChild("Humanoid") == Enum.HumanoidStateType.Freefall then
                pcall(function()
                    local TargetVelv5 = Prey.Character[getgenv().Fatal.Silentaim.Part]
                    TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 0.5), TargetVelv5.Velocity.Z)
                    TargetVelv5.AssemblyLinearVelocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 0.5), TargetVelv5.Velocity.Z)
                end)
            end
            if getgenv().Fatal.SilentaimAndTracer.UnderGroundResolver == true then            
                pcall(function()
                    local TargetVelv2 = Prey.Character[getgenv().Fatal.Silentaim.Part]
                    TargetVelv2.Velocity = Vector3.new(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                    TargetVelv2.AssemblyLinearVelocity = Vector3.new(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                end)
            end
        end
    end
        if getgenv().Fatal.Tracer.Enabled == true then
        if getgenv().Fatal.SilentaimAndTracer.DesyncResolver == true and Plr and Plr.Character and Plr.Character:WaitForChild(getgenv().Fatal.Tracer.Part) and Plr.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude > getgenv().Fatal.SilentaimAndTracer.DesyncDetection then
            pcall(function()
                local TargetVelv3 = Plr.Character[getgenv().Fatal.Tracer.Part]
                TargetVelv3.Velocity = Vector3.new(0, 0, 0)
                TargetVelv3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
        end
            if getgenv().Fatal.SilentaimAndTracer.UnderGroundResolver == true and Plr and Plr.Character and Plr.Character:WaitForChild(getgenv().Fatal.Tracer.Part)then
            pcall(function()
                local TargetVelv4 = Plr.Character[getgenv().Fatal.Tracer.Part]
                TargetVelv4.Velocity = Vector3.new(TargetVelv4.Velocity.X, 0, TargetVelv4.Velocity.Z)
                TargetVelv4.AssemblyLinearVelocity = Vector3.new(TargetVelv4.Velocity.X, 0, TargetVelv4.Velocity.Z)
            end)
        end
    end
end)
    
    RS.RenderStepped:Connect(function()
        if getgenv().Fatal.Tracer.Enabled == true then
            if getgenv().Fatal.Tracer.CheckIfKo == true and Plr and Plr.Character then 
                local KOd = Plr.Character:WaitForChild("BodyEffects")["K.O"].Value
                local Grabbed = Plr.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
                if KOd or Grabbed then
                    Plr = nil
                    IsTargetting = false
                end
            end
            if getgenv().Fatal.Tracer.UnlockOnEnemyDeath == true and Plr and Plr.Character:FindFirstChild("Humanoid") then
                if Plr.Character.Humanoid.health < 4 then
                    Plr = nil
                    IsTargetting = false
                end
            end
            if getgenv().Fatal.Tracer.UnlockOnPlayerDeath == true and Plr and Plr.Character:FindFirstChild("Humanoid") then
                if Client.Character.Humanoid.health < 4 then
                    Plr = nil
                    IsTargetting = false
                end
            end
            if getgenv().Fatal.Tracer.DisableOutSideCircle == true and Plr and Plr.Character and Plr.Character:WaitForChild("HumanoidRootPart") then
                if
                TracerCircle.Radius <
                    (Vector2.new(
                        Camera:WorldToScreenPoint(Plr.Character.HumanoidRootPart.Position).X,
                        Camera:WorldToScreenPoint(Plr.Character.HumanoidRootPart.Position).Y
                    ) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                 then
                    Plr = nil
                    IsTargetting = false
                end
            end
            if getgenv().Fatal.Tracer.Predicting and Plr and Plr.Character and Plr.Character:FindFirstChild(getgenv().Fatal.Tracer.Part) then
                if getgenv().Fatal.Tracer.UseShake then
                    local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().Fatal.Tracer.Part].Position + Plr.Character[getgenv().Fatal.Tracer.Part].Velocity * getgenv().Fatal.Tracer.Prediction +
                    Vector3.new(
                        math.random(-getgenv().Fatal.Tracer.ShakePower, getgenv().Fatal.Tracer.ShakePower),
                        math.random(-getgenv().Fatal.Tracer.ShakePower, getgenv().Fatal.Tracer.ShakePower),
                        math.random(-getgenv().Fatal.Tracer.ShakePower, getgenv().Fatal.Tracer.ShakePower)
                    ) * 0.1)
                    Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().Fatal.Tracer.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                else
                    local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().Fatal.Tracer.Part].Position + Plr.Character[getgenv().Fatal.Tracer.Part].Velocity * getgenv().Fatal.Tracer.Prediction)
                    Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().Fatal.Tracer.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                end
            elseif getgenv().Fatal.Tracer.Predicting == false and Plr and Plr.Character and Plr.Character:FindFirstChild(getgenv().Fatal.Tracer.Part) then
                if getgenv().Fatal.Tracer.UseShake then
                    local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().Fatal.Tracer.Part].Position +
                    Vector3.new(
                        math.random(-getgenv().Fatal.Tracer.ShakePower, getgenv().Fatal.Tracer.ShakePower),
                        math.random(-getgenv().Fatal.Tracer.ShakePower, getgenv().Fatal.Tracer.ShakePower),
                        math.random(-getgenv().Fatal.Tracer.ShakePower, getgenv().Fatal.Tracer.ShakePower)
                    ) * 0.1)
                    Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().Fatal.Tracer.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                else
                    local Main = CFrame.new(Camera.CFrame.p,Plr.Character[getgenv().Fatal.Tracer.Part].Position)
                    Camera.CFrame = Camera.CFrame:Lerp(Main, getgenv().Fatal.Tracer.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                end
            end
        end
    end)
    
    task.spawn(function ()
        while task.wait() do
            if Plr then
                if getgenv().Fatal.Tracer.Enabled and (Plr.Character) and getgenv().Fatal.Tracer.ClosestBodyPart then
                    getgenv().Fatal.Tracer.Part = tostring(GetClosestBodyPartV2(Plr.Character))
                end
            end
        end
    end)
    
    RS.Heartbeat:Connect(function()
        if getgenv().Fatal.Tracer.AirshotFunc == true then
    if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            getgenv().Fatal.Tracer.Part = getgenv().Fatal.Tracer.AirshotPart
            else
            getgenv().Fatal.Tracer.Part = getgenv().Fatal.Tracer.Part
            end
        end
    end)
    -- SilentaimAim //
    
    local Players, Client, Mouse, RS, Camera, r =
    game:GetService("Players"),
    game:GetService("Players").LocalPlayer,
    game:GetService("Players").LocalPlayer:GetMouse(),
    game:GetService("RunService"),
    game.Workspace.CurrentCamera,
    math.random
    
    local Circle = Drawing.new("Circle")
    Circle.Color = Color3.new(0, 0, 0)
    Circle.Transparency = 0.5
    Circle.Thickness = 1
    
    local Prey
    local On
    
    local Vec2 = function(property)
    return Vector2.new(property.X, property.Y + (game:GetService("GuiService"):GetGuiInset().Y))
    end
    
    local UpdateSilentaimFOV = function()
    if not Circle then
        return Circle
    end
    Circle.Visible = getgenv().Fatal.FOV["Visible"]
    Circle.Radius = getgenv().Fatal.FOV["Radius"] * 3.05
    Circle.Position = Vec2(Mouse)
    local chance = CalcChance(Fatal.Silentaim.HitChance)
    if not chance then
        return nil
    end
    
    return Circle
    end
    
    game.RunService.RenderStepped:Connect(
    function()
        UpdateSilentaimFOV()
    end
    )
    
    local WallCheck = function(destination, ignore)
    if getgenv().Fatal.Silentaim.WallCheck then
        local Origin = Camera.CFrame.p
        local CheckRay = Ray.new(Origin, destination - Origin)
        local Hit = game.workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
        return Hit == nil
    else
        return true
    end
    end
    
    
    GetClosestToMouse = function()
    local Target, Closest = nil, 1 / 0
    
    for _, v in pairs(Players:GetPlayers()) do
        if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
            local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
    
            if
                (Circle.Radius > Distance and Distance < Closest and OnScreen and
                    WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}))
             then
                Closest = Distance
                Target = v
            end
        end
    end
    return Target
    end
    
    function TargetChecks(Target)
    if getgenv().Fatal.Silentaim.UnlockOnDeath == true and Target.Character then
        return Target.Character.BodyEffects["K.O"].Value and true or false
    end
    return false
    end
    
    function PredictionictTargets(Target, Value)
    return Target.Character[getgenv().Fatal.Silentaim.AimPart].CFrame +
        (Target.Character[getgenv().Fatal.Silentaim.AimPart].Velocity * Value)
    end
    
    local WTS = function(Object)
    local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
    end
    
    local IsOnScreen = function(Object)
    local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
    return IsOnScreen
    end
    
    local FilterObjs = function(Object)
    if string.find(Object.Name, "Gun") then
        return
    end
    if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
        return true
    end
    end
    
    local GetClosestBodyPart = function (character)
        local ClosestDistance = 1/0
        local BodyPart = nil
        
        if (character and character:GetChildren()) then
            for _,  x in next, character:GetChildren() do
                if FilterObjs(x) and IsOnScreen(x) then
                    local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if (Circle.Radius > Distance and Distance < ClosestDistance) then
                        ClosestDistance = Distance
                        BodyPart = x
                    end
                end
            end
        end
        return BodyPart
    end
    
    RS.RenderStepped:Connect(
    function()
        if Prey then
            if Prey ~= nil and getgenv().Fatal.Silentaim.Enabled and getgenv().Fatal.Silentaim.ClosestBodyPart == true then
                getgenv().Fatal.Silentaim["AimPart"] = tostring(GetClosestBodyPart(Prey.Character))
            end
        end
    end
    )
    
    local grmt = getrawmetatable(game)
    local index = grmt.__index
    local properties = {
    "Hit"
    }
    setreadonly(grmt, false)
    
    grmt.__index =
    newcclosure(
    function(self, v)
        if Mouse and (table.find(properties, v)) then
            Prey = GetClosestToMouse()
            if Prey ~= nil and getgenv().Fatal.Silentaim.Enabled and not TargetChecks(Prey) then
                local endpoint = PredictionictTargets(Prey, getgenv().Fatal.Silentaim.Prediction)
    
                return (table.find(properties, tostring(v)) and endpoint)
            end
        end
        return index(self, v)
    end
    )
    
    Mouse.KeyDown:Connect(
      function(Key)
        if (Key == getgenv().Fatal.Silentaim.Toggle:lower()) then
            if getgenv().Fatal.Silentaim.Enabled == true then
                getgenv().Fatal.Silentaim.Enabled = false
            else
                getgenv().Fatal.Silentaim.Enabled = true
            end
        end
      end
    )
    
    RS.Heartbeat:Connect(function()
    if getgenv().Fatal.Silentaim.UseAirShotPart == true and Prey.Character:FindFirstChild("Humanoid") then
        if Prey.Character.Humanoid.FloorMaterial == Enum.Material.Air and Prey.Character.Humanoid.Jump == true then
        getgenv().Fatal.Silentaim.AimPart = getgenv().Fatal.Silentaim.AirshotPart
        else
        getgenv().Fatal.Silentaim.AimPart = getgenv().Fatal.Silentaim.AimPart
           end
        end
    end)
    
        while getgenv().Fatal.Silentaim.AutoPrediction == true do
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local pingValue = string.split(ping, " ")[5]
    local pingNumber = tonumber(pingValue)
        if pingNumber < 30 then
        getgenv().Fatal.Silentaim.Prediction = 0.12588
        elseif pingNumber < 40 then
        getgenv().Fatal.Silentaim.Prediction = 0.11911
        elseif pingNumber < 50 then
        getgenv().Fatal.Silentaim.Prediction = 0.12471
        elseif pingNumber < 60 then
        getgenv().Fatal.Silentaim.Prediction = 0.12766
        elseif pingNumber < 70 then
        getgenv().Fatal.Silentaim.Prediction = 0.12731
        elseif pingNumber < 80 then
        getgenv().Fatal.Silentaim.Prediction = 0.12951
        elseif pingNumber < 90 then
        getgenv().Fatal.Silentaim.Prediction = 0.13181
        elseif pingNumber < 100 then
        getgenv().Fatal.Silentaim.Prediction = 0.13573
        elseif pingNumber < 110 then
        getgenv().Fatal.Silentaim.Prediction = 0.1455
        elseif pingNumber < 120 then
        getgenv().Fatal.Silentaim.Prediction = 0.1437
        elseif pingNumber < 130 then
        getgenv().Fatal.Silentaim.Prediction = 0.156692
        elseif pingNumber < 140 then
        getgenv().Fatal.Silentaim.Prediction = 0.1223333
        elseif pingNumber < 150 then
        getgenv().Fatal.Silentaim.Prediction = 0.15
        elseif pingNumber < 160 then
        getgenv().Fatal.Silentaim.Prediction = 0.16
        elseif pingNumber < 170 then
        getgenv().Fatal.Silentaim.Prediction = 0.1923111 
        elseif pingNumber < 180 then
        getgenv().Fatal.Silentaim.Prediction = 0.19284
        elseif pingNumber < 190 then
        getgenv().Fatal.Silentaim.Prediction = 0.166547
        elseif pingNumber < 200 then
        getgenv().Fatal.Silentaim.Prediction = 0.165566
        elseif pingNumber < 210 then
        getgenv().Fatal.Silentaim.Prediction = 0.16780
        elseif pingNumber < 220 then
        getgenv().Fatal.Silentaim.Prediction = 0.165566
        elseif pingNumber < 230 then
        getgenv().Fatal.Silentaim.Prediction = 0.15692
        elseif pingNumber < 240 then
        getgenv().Fatal.Silentaim.Prediction = 0.16780
        elseif pingNumber < 250 then
        getgenv().Fatal.Silentaim.Prediction = 0.1651
        elseif pingNumber < 300 then
        getgenv().Fatal.Silentaim.Prediction = 0.195566
        elseif pingNumber < 350 then
        getgenv().Fatal.Silentaim.Prediction = 0.16537
    
    end
    wait(0.25)
end
    
    if getgenv().Fatal.Silentaim.AntiAimViewer == true then
        for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= localPlayer and v.Character and v.Character:FindFirstChild("Head") and  v.Character:FindFirstChild("HumanoidRootPart")  then
            local c = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local d = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(c.X, c.Y)).Magnitude

            if a > d then
                b = v
                a = d
            end
        end
    end

    return b
end