local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumExploitGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 550)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

local glowFrame = Instance.new("Frame")
glowFrame.Size = UDim2.new(1, 20, 1, 20)
glowFrame.Position = UDim2.new(0, -10, 0, -10)
glowFrame.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
glowFrame.BackgroundTransparency = 0.8
glowFrame.BorderSizePixel = 0
glowFrame.ZIndex = mainFrame.ZIndex - 1
glowFrame.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 25)
glowCorner.Parent = glowFrame

local glowGradient = Instance.new("UIGradient")
glowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 150))
}
glowGradient.Rotation = 45
glowGradient.Parent = glowFrame

local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0, 60)
headerFrame.Position = UDim2.new(0, 0, 0, 0)
headerFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = headerFrame

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 35, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 35))
}
headerGradient.Rotation = 90
headerGradient.Parent = headerFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🚀 PREMIUM EXPLOIT HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = headerFrame

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 60, 0, 20)
versionLabel.Position = UDim2.new(0, 15, 0, 35)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v2.0 PRO"
versionLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
versionLabel.TextScaled = true
versionLabel.Font = Enum.Font.Gotham
versionLabel.Parent = headerFrame

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -90, 0, 12.5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
minimizeBtn.Text = "—"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = headerFrame

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -45, 0, 12.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = headerFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -80)
scrollFrame.Position = UDim2.new(0, 10, 0, 70)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 700)
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

local isSpeedEnabled = false
local isTPEnabled = false
local isRegenEnabled = false
local isAntiFallEnabled = false
local isFlyEnabled = false
local isInfiniteJumpEnabled = false
local isESPEnabled = false
local isNoClipEnabled = false

local speedLoop, regenLoop, antiFallLoop, flyLoop, espLoop, noClipLoop
local bodyVelocity, bodyAngularVelocity
local currentSpeed = 150
local currentFlySpeed = 50

function createAdvancedButton(text, icon, colorMain, colorAccent, layoutOrder)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, -20, 0, 55)
    buttonFrame.BackgroundColor3 = colorMain
    buttonFrame.BorderSizePixel = 0
    buttonFrame.LayoutOrder = layoutOrder
    buttonFrame.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = buttonFrame
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, colorMain),
        ColorSequenceKeypoint.new(1, colorAccent)
    }
    buttonGradient.Rotation = 45
    buttonGradient.Parent = buttonFrame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = buttonFrame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 40, 0, 40)
    iconLabel.Position = UDim2.new(0, 10, 0, 7.5)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = buttonFrame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -130, 1, 0)
    textLabel.Position = UDim2.new(0, 55, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = buttonFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 60, 0, 25)
    statusLabel.Position = UDim2.new(1, -70, 0, 15)
    statusLabel.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    statusLabel.Text = "OFF"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.Parent = buttonFrame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 12)
    statusCorner.Parent = statusLabel
    
    button.MouseEnter:Connect(function()
        TweenService:Create(buttonFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(1, -15, 0, 60)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(buttonFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(1, -20, 0, 55)
        }):Play()
    end)
    
    return button, statusLabel, textLabel
end

local speedBtn, speedStatus = createAdvancedButton("SPEED BOOST", "⚡", Color3.fromRGB(52, 152, 219), Color3.fromRGB(74, 175, 242), 1)
local tpBtn, tpStatus = createAdvancedButton("TELEPORT TO PLAYER", "📍", Color3.fromRGB(46, 204, 113), Color3.fromRGB(69, 227, 136), 2)
local regenBtn, regenStatus = createAdvancedButton("HEALTH REGENERATION", "❤️", Color3.fromRGB(231, 76, 60), Color3.fromRGB(254, 99, 83), 3)
local antiFallBtn, antiFallStatus = createAdvancedButton("ANTI FALL PROTECTION", "🛡️", Color3.fromRGB(230, 126, 34), Color3.fromRGB(253, 149, 57), 4)
local flyBtn, flyStatus = createAdvancedButton("FLY MODE", "🕊️", Color3.fromRGB(155, 89, 182), Color3.fromRGB(178, 112, 205), 5)
local jumpBtn, jumpStatus = createAdvancedButton("INFINITE JUMP", "🦘", Color3.fromRGB(26, 188, 156), Color3.fromRGB(49, 211, 179), 6)
local espBtn, espStatus = createAdvancedButton("ESP PLAYER VISION", "👁️", Color3.fromRGB(241, 196, 15), Color3.fromRGB(254, 211, 48), 7)
local noClipBtn, noClipStatus = createAdvancedButton("NO CLIP WALLS", "👻", Color3.fromRGB(127, 140, 141), Color3.fromRGB(149, 165, 166), 8)

function updateStatus(statusLabel, enabled)
    if enabled then
        statusLabel.Text = "ON"
        statusLabel.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        TweenService:Create(statusLabel, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        }):Play()
    else
        statusLabel.Text = "OFF"
        TweenService:Create(statusLabel, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        }):Play()
    end
end

function createNotification(text, color)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.Position = UDim2.new(1, -320, 0, 20)
    notif.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
    notif.BorderSizePixel = 0
    notif.Parent = screenGui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 10)
    notifCorner.Parent = notif
    
    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, -20, 1, 0)
    notifText.Position = UDim2.new(0, 10, 0, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = text
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextScaled = true
    notifText.Font = Enum.Font.Gotham
    notifText.Parent = notif
    
    TweenService:Create(notif, TweenInfo.new(0.5), {
        Position = UDim2.new(1, -320, 0, 20)
    }):Play()
    
    wait(2)
    TweenService:Create(notif, TweenInfo.new(0.5), {
        Position = UDim2.new(1, 20, 0, 20)
    }):Play()
    
    game:GetService("Debris"):AddItem(notif, 0.6)
end

speedBtn.MouseButton1Click:Connect(function()
    isSpeedEnabled = not isSpeedEnabled
    updateStatus(speedStatus, isSpeedEnabled)
    
    if isSpeedEnabled then
        createNotification("Speed Boost Activated!", Color3.fromRGB(52, 152, 219))
        humanoid.WalkSpeed = currentSpeed
        speedLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = currentSpeed
                end
            end)
        end)
    else
        createNotification("Speed Boost Deactivated", Color3.fromRGB(220, 53, 69))
        humanoid.WalkSpeed = 16
        if speedLoop then
            speedLoop:Disconnect()
            speedLoop = nil
        end
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    local targetPlayer = nil
    local minDistance = math.huge
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (rootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < minDistance then
                minDistance = distance
                targetPlayer = otherPlayer
            end
        end
    end
    
    if targetPlayer then
        rootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        createNotification("Teleported to " .. targetPlayer.Name, Color3.fromRGB(46, 204, 113))
    else
        createNotification("No players found!", Color3.fromRGB(220, 53, 69))
    end
end)

regenBtn.MouseButton1Click:Connect(function()
    isRegenEnabled = not isRegenEnabled
    updateStatus(regenStatus, isRegenEnabled)
    
    if isRegenEnabled then
        createNotification("Health Regen Activated!", Color3.fromRGB(231, 76, 60))
        regenLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if character and character:FindFirstChild("Humanoid") then
                    local hum = character.Humanoid
                    if hum.Health < hum.MaxHealth then
                        hum.Health = math.min(hum.Health + 2, hum.MaxHealth)
                    end
                end
            end)
        end)
    else
        createNotification("Health Regen Deactivated", Color3.fromRGB(220, 53, 69))
        if regenLoop then
            regenLoop:Disconnect()
            regenLoop = nil
        end
    end
end)

antiFallBtn.MouseButton1Click:Connect(function()
    isAntiFallEnabled = not isAntiFallEnabled
    updateStatus(antiFallStatus, isAntiFallEnabled)
    
    if isAntiFallEnabled then
        createNotification("Anti-Fall Protection On!", Color3.fromRGB(230, 126, 34))
        antiFallLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local pos = character.HumanoidRootPart.Position
                    if pos.Y < -50 then
                        character.HumanoidRootPart.CFrame = CFrame.new(pos.X, 50, pos.Z)
                    end
                end
            end)
        end)
    else
        createNotification("Anti-Fall Protection Off", Color3.fromRGB(220, 53, 69))
        if antiFallLoop then
            antiFallLoop:Disconnect()
            antiFallLoop = nil
        end
    end
end)

flyBtn.MouseButton1Click:Connect(function()
    isFlyEnabled = not isFlyEnabled
    updateStatus(flyStatus, isFlyEnabled)
    
    if isFlyEnabled then
        createNotification("Fly Mode Activated! Use WASD", Color3.fromRGB(155, 89, 182))
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity.Parent = rootPart
        
        flyLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                if character and character:FindFirstChild("HumanoidRootPart") and bodyVelocity then
                    local camera = Workspace.CurrentCamera
                    local moveVector = humanoid.MoveDirection
                    
                    bodyVelocity.Velocity = camera.CFrame.LookVector * moveVector.Z * currentFlySpeed + 
                                          camera.CFrame.RightVector * moveVector.X * currentFlySpeed
                end
            end)
        end)
    else
        createNotification("Fly Mode Deactivated", Color3.fromRGB(220, 53, 69))
        if flyLoop then
            flyLoop:Disconnect()
            flyLoop = nil
        end
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyAngularVelocity then
            bodyAngularVelocity:Destroy()
            bodyAngularVelocity = nil
        end
    end
end)

jumpBtn.MouseButton1Click:Connect(function()
    isInfiniteJumpEnabled = not isInfiniteJumpEnabled
    updateStatus(jumpStatus, isInfiniteJumpEnabled)
    
    if isInfiniteJumpEnabled then
        createNotification("Infinite Jump Enabled!", Color3.fromRGB(26, 188, 156))
        humanoid.JumpHeight = 50
    else
        createNotification("Infinite Jump Disabled", Color3.fromRGB(220, 53, 69))
        humanoid.JumpHeight = 7.2
    end
end)

espBtn.MouseButton1Click:Connect(function()
    isESPEnabled = not isESPEnabled
    updateStatus(espStatus, isESPEnabled)
    
    if isESPEnabled then
        createNotification("ESP Vision Activated!", Color3.fromRGB(241, 196, 15))
        espLoop = RunService.Heartbeat:Connect(function()
            pcall(function()
                for _, otherPlayer in pairs(Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local character = otherPlayer.Character
                        if not character:FindFirstChild("ESP_Highlight") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "ESP_Highlight"
                            highlight.Adornee = character
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.FillTransparency = 0.5
                            highlight.OutlineTransparency = 0
                            highlight.Parent = character
                        end
                    end
                end
            end)
        end)
    else
        createNotification("ESP Vision Deactivated", Color3.fromRGB(220, 53, 69))
        if espLoop then
            espLoop:Disconnect()
            espLoop = nil
        end
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer.Character and otherPlayer.Character:FindFirstChild("ESP_Highlight") then
                otherPlayer.Character.ESP_Highlight:Destroy()
            end
        end
    end
end)

noClipBtn.MouseButton1Click:Connect(function()
    isNoClipEnabled = not isNoClipEnabled
    updateStatus(noClipStatus, isNoClipEnabled)
    
    if isNoClipEnabled then
        createNotification("NoClip Activated!", Color3.fromRGB(127, 140, 141))
        noClipLoop = RunService.Stepped:Connect(function()
            pcall(function()
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
    else
        createNotification("NoClip Deactivated", Color3.fromRGB(220, 53, 69))
        if noClipLoop then
            noClipLoop:Disconnect()
            noClipLoop = nil
        end
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end)

local isMinimized = false

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 400, 0, 60)
        }):Play()
        minimizeBtn.Text = "+"
        scrollFrame.Visible = false
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 400, 0, 550)
        }):Play()
        minimizeBtn.Text = "—"
        scrollFrame.Visible = true
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.3)
    
    if speedLoop then speedLoop:Disconnect() end
    if regenLoop then regenLoop:Disconnect() end
    if antiFallLoop then antiFallLoop:Disconnect() end
    if flyLoop then flyLoop:Disconnect() end
    if espLoop then espLoop:Disconnect() end
    if noClipLoop then noClipLoop:Disconnect() end
    
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer.Character and otherPlayer.Character:FindFirstChild("ESP_Highlight") then
            otherPlayer.Character.ESP_Highlight:Destroy()
        end
    end
    
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
    
    screenGui:Destroy()
end)

local glowTween = TweenService:Create(glowGradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Rotation = glowGradient.Rotation + 360
})
glowTween:Play()

player.CharacterAdded:Connect(function(newCharacter)
    wait(1)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    if isSpeedEnabled then
        humanoid.WalkSpeed = currentSpeed
    end
    if isInfiniteJumpEnabled then
        humanoid.JumpHeight = 50
    end
end)

spawn(function()
    while wait(0.1) do
        if glowFrame and glowFrame.Parent then
            TweenService:Create(glowFrame, TweenInfo.new(2, Enum.EasingStyle.Sine), {
                BackgroundTransparency = math.random(70, 90) / 100
            }):Play()
        end
    end
end)

createNotification("Premium Exploit Hub Loaded!", Color3.fromRGB(0, 255, 127))
