-- GHOUL HUB | Emo Coquette Style
-- Sidebar: Branco + Roxo
-- Música emo ativada
-- Brookhaven RP

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ================= UI =================
local Library = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"
))()

local Window = Library.CreateLib("GHOUL HUB ☾ EMO", {
    MainColor = Color3.fromRGB(255,255,255), -- branco
    SecondaryColor = Color3.fromRGB(160,70,255), -- roxo
    TextColor = Color3.fromRGB(20,20,20)
})

-- ================= MUSIC =================
local Sound = Instance.new("Sound", workspace)
Sound.SoundId = "rbxassetid://74356605425526" -- música emo
Sound.Volume = 2
Sound.Looped = true
Sound:Play()

-- ================= FUN =================
local FunTab = Window:NewTab("Fun")
local Fun = FunTab:NewSection("Player")

Fun:NewSlider("Speed Player", "Velocidade", 200, 16, function(v)
    Humanoid.WalkSpeed = v
end)

Fun:NewSlider("Jump Power", "Pulo", 200, 50, function(v)
    Humanoid.JumpPower = v
end)

Fun:NewSlider("Gravity", "Gravidade", 400, 196, function(v)
    workspace.Gravity = v
end)

Fun:NewToggle("Infinite Jump", "Pulo infinito", function(state)
    _G.InfJump = state
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        Humanoid:ChangeState("Jumping")
    end
end)

-- ================= AVATAR =================
local AvatarTab = Window:NewTab("Avatar")
local Avatar = AvatarTab:NewSection("Avatar")

Avatar:NewButton("Invisível", "Ficar invisível", function()
    for _,v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        end
    end
end)

-- ================= CAR =================
local CarTab = Window:NewTab("Car")
local Car = CarTab:NewSection("Veículo")

Car:NewButton("Fly Car", "Carro voador", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- ================= HOUSE =================
local HouseTab = Window:NewTab("House")
local House = HouseTab:NewSection("Casa")

House:NewButton("TP para Cofre", "Teleporta pro cofre", function()
    local cf = workspace:FindFirstChild("Safe", true)
    if cf then
        Character:MoveTo(cf.Position)
    end
end)

-- ================= TOOLS =================
local ToolsTab = Window:NewTab("Tools")
local Tools = ToolsTab:NewSection("Extras")

Tools:NewButton("Rejoin", "Entrar de novo", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

Tools:NewButton("Desligar Música", "Mute", function()
    Sound:Stop()
end)
