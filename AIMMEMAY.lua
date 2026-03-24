
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe(data) m=string.sub(data, 0, 55) data=data:gsub(m,'')

data = string.gsub(data, '[^'..b..'=]', '') return (data:gsub('.', function(x) if (x == '=') then return '' end local r,f='',(b:find(x)-1) for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end return r; end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) if (#x ~= 8) then return '' end local c=0 for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end return string.char(c) end)) end


 




local Players = game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('AlLSlLrSEJHJUOpACOAgzCAebgjCHuaAdzdvUqzVcrTSWBAbHnOAZUxUGxheWVycw=='))
local SG = game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('XYahDLQfodujcinqmfTwomMHwMmjbPSmvcyLlnKjjrTxKYHUBPteElzU3RhcnRlckd1aQ=='))
local LP = Players.LocalPlayer

local correctKey = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('wnpGCLEdrbbLqojRvazHDmMsnyZHWcboTQqcOzxqUaqEokZIATiVfLVSm9yZ2UxOTUw')

local keyGui = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('PVnurtGOAVdBcnqYbpMVJYBEDXwJDtvWRIZXzSHVFEMyAebIvZCeqHlU2NyZWVuR3Vp'))
keyGui.ResetOnSpawn = false
keyGui.Parent = game.CoreGui

local frame = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('QfobjxOImZroffyWtmsmkIiHbUDuNZjptqIGcyoVGLpsRzbvJsAOzENRnJhbWU='), keyGui)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, -160, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
frame.BorderSizePixel = 0
Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('BKZqkLIAwknBTuihBXGkkdesPhaJSHCPbDfwOvEOuHcZbilwVErJjeqVUlDb3JuZXI='), frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('RfRrEdngHJsrjYHBpelwUokNIOEXqFJcaJdflanTJwQnZCZAYQVVJYoVGV4dExhYmVs'), frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('bUGWRsoxuoNoszbhDzPbcWNMGasSeigtSNAwQIFWyVEvkDmtxEVprsdSHlwZXIgQ2FtbG9jayAtIEtleSBTeXN0ZW0=')
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold

local input = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('qFdfGFHSRWDuZIfgNIPbBEYUTdJyCYXYSRVIairijRgrtPEalMyYJkGVGV4dEJveA=='), frame)
input.Size = UDim2.new(0.8, 0, 0, 40)
input.Position = UDim2.new(0.1, 0, 0.35, 0)
input.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
input.TextColor3 = Color3.new(1,1,1)
input.PlaceholderText = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('oylkrVoQzWUgfbEDdkBmbJqUdiHFvCUrUoodrhjCxETPZgylZFSQYxvRW50ZXIga2V5IGhlcmUuLi4=')
input.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('ohRnNXsZaTDyFjMWzxfUerhMfzYigWnJXbwayHmwcuuZvPqiztCzJyO')
input.Font = Enum.Font.Gotham
input.TextSize = 18
Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('DVMGSEioLFyxKrdpRzepnKoIOgFEdnvfnQGhlSBiwgaRYHruYikHUqGVUlDb3JuZXI='), input).CornerRadius = UDim.new(0, 8)

local submit = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('UKBORVOJaZoyiJegWalikYQZdXcTVgaMXpOTMDaoJeLhfLvtXTmhznWVGV4dEJ1dHRvbg=='), frame)
submit.Size = UDim2.new(0.8, 0, 0, 40)
submit.Position = UDim2.new(0.1, 0, 0.65, 0)
submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submit.TextColor3 = Color3.new(1,1,1)
submit.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('VexYdBByLfIHHPcPenGYhPYlmkOlgAVflcnODTAIwIJqhEroomSHFWyU3VibWl0')
submit.Font = Enum.Font.GothamBold
submit.TextSize = 20
Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('qOIEjUFGSOTJJodgSMHPRgpfcIQXWPJokfKsIsMIlPWtoOEuDLSvFCpVUlDb3JuZXI='), submit).CornerRadius = UDim.new(0, 8)

local function loadCamlock()
    keyGui:Destroy()

    SG:SetCore(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('cxcRudoLfpMbmsFJvHbDXivWYfLyNnchMjRKOjxJKzYvKoPxQmcXWKbU2VuZE5vdGlmaWNhdGlvbg=='), {
        Title = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('CnmAumSPzNAEXHYulKXImyYZNtyFomvIgOEhNMhJSQzLtHcYVqGwdsZSHlwZXIgQ2FtbG9jaw=='),
        Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('mltQFCGEbVednOGHgCmZvFcDTUCntelkAsmXodLeBMrhhClWYomKTnUV2VsY29tZSwg') .. LP.Name .. JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('YuQhvgCLGPuGinDCDArFHWUKwubHoCccMPBlKdFIhwXmeeTALkHjNBRISBLZXkgYWNjZXB0ZWQg8J+UpQ=='),
        Duration = 6
    })

    -- ════════════════════════════════════════════════════════════
    -- Your camlock script starts here
    -- ════════════════════════════════════════════════════════════

    local Players = game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('pvEpHPecXqmCuJSbksvBxGgpphffJkqvlxJFKBAqllBUEESnDVlnzKXUGxheWVycw=='))
    local RunService = game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('sdjAVbyulhoYRTkZWHVlgGcUZhaNSyOGUxNiPXYVnyAEpcVkAusyRaeUnVuU2VydmljZQ=='))
    local UIS = game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('tQuuKnCALTAwfPmVLTlTShjhcJJFjaihgTmSZUudxFKWIaruIwJfSakVXNlcklucHV0U2VydmljZQ=='))
    local SG = game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('TRjVQiHQcIVnMDiVdzUfzcVWcNKLYEAQCJTGuxLTZgWJkbtpploZDtuU3RhcnRlckd1aQ=='))
    local Cam = workspace.CurrentCamera
    local LP = Players.LocalPlayer

    getgenv().Prediction = 0.142
    getgenv().AimPart = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('WkpaBjpnxwcQFekuAZXPQVsbbYegfjkvqtcZRaHXHuNTiBAJOLLZOeiSGVhZA==')
    getgenv().FOV = true
    getgenv().ShowFOV = true
    getgenv().FOVSize = 140
    getgenv().Resolver = true

    local CamlockOn = false
    local Target = nil

    if getgenv().FrankCenterCamlock then return end
    getgenv().FrankCenterCamlock = true

    local fov = Drawing.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('HBkwwiZfruWdbaSxLZPjRDhRsdCgRlNVDlwRykiMvOBEzssVMNJDfzLQ2lyY2xl'))
    fov.Thickness = 3
    fov.NumSides = 80
    fov.Color = Color3.fromRGB(255, 80, 80)
    fov.Transparency = 0.85
    fov.Filled = false

    local gui = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('XQGDZqAsKxJrYADwfIDMQpjvwJPnWgKgsGKbsIujTXTTUjXAwAiAOsyU2NyZWVuR3Vp'), game.CoreGui)
    gui.ResetOnSpawn = false

    local frame = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('uUAVoWilLFreJcCNnaONjfOeOZRwHbJJdnTCBrssJmdTUzRjMrDibIdRnJhbWU='), gui)
    frame.Size = UDim2.new(0, 90, 0, 110)
    frame.Position = UDim2.new(0.5, -45, 0.5, -55)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 60)
    frame.BackgroundTransparency = 0.4
    Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('hVpjITpxBgkwVxjlIQhQRGkWJqQIjPHRfvPtaHJnZlLgFXVQaDYTqPZVUlDb3JuZXI='), frame).CornerRadius = UDim.new(0, 20)

    local iconBtn = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('mVZpDpDiYdsSlTiQpNEhWnVJNyJRghBBLokzIiAPCnQtydGWlsoppFIVGV4dEJ1dHRvbg=='), frame)
    iconBtn.Size = UDim2.new(0, 70, 0, 70)
    iconBtn.Position = UDim2.new(0.5, -35, 0, 5)
    iconBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    iconBtn.BackgroundTransparency = 0.3
    iconBtn.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('UmshzDbLNAkYOSXqyWNnIqZznuFAfiRoIDCWUhDjSdWhfppXoPMYqNF8J+Ukg==')
    iconBtn.TextColor3 = Color3.new(1,1,1)
    iconBtn.TextScaled = true
    iconBtn.Font = Enum.Font.GothamBold
    Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('JoAowsNDpUPXHBfvynrYoJnLhrsvNeDxvjqrinhrxVXZPxboGqIaNuoVUlDb3JuZXI='), iconBtn).CornerRadius = UDim.new(1, 0)

    local label = Instance.new(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('YVDdjsLFfmwHxrkfoiyfPuadgtqrYiMdXycFiincENBqwoKGnvwcNYsVGV4dExhYmVs'), frame)
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 1, -35)
    label.BackgroundTransparency = 1
    label.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('cXUPhCfxxegnvrASgQIhbChfLhskvVSRlQpLAGuZFQNnPvDvHthYSZiT0ZG')
    label.TextColor3 = Color3.new(1, 0.3, 0.3)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham

    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    iconBtn.MouseButton1Click:Connect(function()
        CamlockOn = not CamlockOn
        if CamlockOn then
            iconBtn.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('zSvMZTpkTrAFynBtKVrEAGLFpwkaywTFxoxuZSOGaLEiboIIgQrWYDu8J+Ukw==')
            label.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('lDxArMtZKJeFDPSBtXPEqmnybymexBgQpsfOkIfqnXgTpjZgLYFMCbnT04=')
            label.TextColor3 = Color3.new(0.2, 1, 0.2)
            SG:SetCore(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('gAwryYYmhizDrvXXDxJyIMhoIOukhVdfzHaqzMAxkcVtTBQEKjqIOliU2VuZE5vdGlmaWNhdGlvbg=='), {Title = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('VadqUcKEcnxRhYqwzvzSqZLZjTZZquJnqpzIrtvEesmjkINLZsXaCtZQ2FtbG9jaw=='), Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('RUXuNwfkYkAGmkXFSMgeywkYfTSxojlFnUkDjaVSBimIwtjTrLofodmT04gLSBBaW0gY2VudGVyIG9uIHRhcmdldA=='), Duration = 4})
        else
            iconBtn.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('gZsmWBqpKuzifroiyIJgwHhMOQsjRXekWoMDbFmVbnqWaseDHVSLQuo8J+Ukg==')
            label.Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('fejlKpVJGSPixdrFMTinUkMFYiPWsZuDIAvIPKrjNjKGBzRZToWOzhfT0ZG')
            label.TextColor3 = Color3.new(1, 0.3, 0.3)
            Target = nil
            SG:SetCore(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('WhHoHEVhcvJXokyCJsHimTQSDVsqfdDoWCELtuseuYulTpwwENDhwaTU2VuZE5vdGlmaWNhdGlvbg=='), {Title = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('QpmnFpiSXgdNIrjyKlrLdzsbhnbblQmRKujRbYFDfOvLQhEVJIGTFmlQ2FtbG9jaw=='), Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('IdpzCfqAfpGJLAkvVUGWxNdnOkZhdbbEZEFGEZDGAOSsjpQWIPEwtzTT0ZG'), Duration = 3})
        end
    end)

    local function getScreenCenter()
        return Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    end

    local function getClosestInCenter()
        local center = getScreenCenter()
        local closest, minDist = nil, math.huge

        for _, p in Players:GetPlayers() do
            if p == LP or not p.Character then continue end
            local h = p.Character:FindFirstChildOfClass(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('SoAGInsxgSrQKvUWHGBRobaRKbnNvBLwkzbcHvHxlORzzaaOjjaQQYmSHVtYW5vaWQ='))
            if not h or h.Health <= 0 then continue end
            local ko = p.Character.BodyEffects and p.Character.BodyEffects[JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('hANwEdHefzpFUjeqsDszsXsnOrPqnMbjVEnofPzPoMIRvrdfOQTRrtYSy5P')] and p.Character.BodyEffects[JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('OUvYsYcVKaQEturnyXUfmSQxVxYwipVGzzVcypzUNztXYVOwRmgqvkzSy5P')].Value
            if ko then continue end
            if p.Character:FindFirstChild(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('erReZWPJcgDPMZoPxpVsGfWVOooNFjUXKtRxecUINVGhSHKoeMNWeSzR1JBQkJJTkdfQ09OU1RSQUlOVA==')) then continue end

            local part = p.Character[getgenv().AimPart]
            if not part then continue end

            local sp, onScreen = Cam:WorldToViewportPoint(part.Position)
            if not onScreen then continue end

            local dist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
            if getgenv().FOV and dist > getgenv().FOVSize then continue end

            if dist < minDist then
                minDist = dist
                closest = p
            end
        end

        return closest
    end

    local function resolvePos(part)
        if not getgenv().Resolver then return part.Position end

        local vel = part.Velocity
        local ping = tonumber(game:GetService(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('EgXRCtZmsFOKqEQtPgPUGuBIXSQlTKjNMWTZzUtxAOgmmIBqosUajmkU3RhdHM=')).Network.ServerStatsItem[JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('bSaUWPxIVuPvpvGxEQtegPmvZjmPDSoxNoBkGXacanHKpIyChecWaMtRGF0YSBQaW5n')]:GetValueString():match(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('NIwEGEYXHKskWPsZdiciOXuBiyJGjrvfpNhVCPDOcxqPbdaHWRAzlEpJWQr'))) or 100
        local pingAdjust = ping / 1000

        local candidates = {
            part.Position + vel * (getgenv().Prediction + pingAdjust),
            part.Position + vel * (getgenv().Prediction + pingAdjust) + Vector3.new(0, 1.5, 0),
            part.Position + vel * (getgenv().Prediction + pingAdjust) + Vector3.new(0, -1.5, 0),
            part.Position + vel * (getgenv().Prediction + pingAdjust) + Vector3.new(1.2, 0, 0),
            part.Position + vel * (getgenv().Prediction + pingAdjust) + Vector3.new(-1.2, 0, 0)
        }

        local best = part.Position
        for _, pos in candidates do
            if (pos - Cam.CFrame.Position).Magnitude < 350 then
                best = pos
                break
            end
        end

        return best
    end

    RunService.RenderStepped:Connect(function()
        if getgenv().ShowFOV then
            fov.Position = getScreenCenter()
            fov.Radius = getgenv().FOVSize
            fov.Visible = true
        else
            fov.Visible = false
        end

        if CamlockOn then
            if not Target or not Target.Character or not Target.Character:FindFirstChild(getgenv().AimPart) then
                Target = getClosestInCenter()
            end

            if Target and Target.Character then
                local part = Target.Character[getgenv().AimPart]
                local aimPos = resolvePos(part)
                Cam.CFrame = CFrame.new(Cam.CFrame.Position, aimPos)
            end
        end
    end)

    print(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('xHhdTkXcmvTLambATHGVXlSpfJggCtnsrADuOSdiwQHidFfuakwCmonQ2VudGVyIEZPViBDYW1sb2NrICsgUmVzb2x2ZXIgTG9hZGVkIQ=='))
    SG:SetCore(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('afqdCcFpdJsaTTNzXeJwjnDPznDbrTFZmJQLhrzXRwCWbnFeMrjyRiBU2VuZE5vdGlmaWNhdGlvbg=='), {Title = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('RNhvtuqyshojrsRSxANscqOERHkCjDGIppFENxmyzmZXWdRtxrkdrldUmVhZHk='), Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('XLUsqAbOyfHhAnEXMNyqOoXzFYonfduUYutppFgbHfjXIneDQYFByoqRk9WIGxvY2tlZCBpbiBjZW50ZXIgfCBUYXAgYnV0dG9uIHRvIHRvZ2dsZQ=='), Duration = 6})
end

submit.MouseButton1Click:Connect(function()
    if input.Text == correctKey then
        loadCamlock()
    else
        SG:SetCore(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('qYpqyGrFdVCxIlHeOWjkAwkaUqJuGNVTyaKvNLgEiKNfDIWZahvwtcQU2VuZE5vdGlmaWNhdGlvbg=='), {
            Title = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('IwwmRmdKxppWTBxkhNYbCEAnypRmssuheBnqywhOKpUwlXvGzrfSYyKSW52YWxpZCBLZXk='),
            Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('TtuiGARkXlVKDPRwERfVWhcIETPHLqLYCKxGXNjGoAfjDakLicaobhUV3Jvbmcga2V5IQ=='),
            Duration = 4
        })
    end
end)

input.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        if input.Text == correctKey then
            loadCamlock()
        else
            SG:SetCore(JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('nEbHYtcjfHvxDrSTrQuBTRJrEcKYczzHiKVWznHOuWAhoafWnIczZCNU2VuZE5vdGlmaWNhdGlvbg=='), {
                Title = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('egTjVoQkfwSCYdHjYyMOMXvJuHoCsVQvrljaDuLCSDWrOzUDQLDYkmOSW52YWxpZCBLZXk='),
                Text = JkEIjBSwuTTAENBBglxsUzQLzHllYhYqMxpswTwJsYqqUryZoIkyQewVAGHDwiqEaqUreorMe('nJSNKsitkxlNrgZBXhyMJCyfYfaXcweEVHRMGcDlOsPPirYrPIGqXYhV3Jvbmcga2V5IQ=='),
                Duration = 4
            })
        end
    end
end)    