-- Ghoul Hub Loader (Mobile Safe)

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Música de entrada
pcall(function()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://74356605425526" -- seu ID
	sound.Volume = 2
	sound.Looped = true
	sound.Parent = game:GetService("SoundService")
	sound:Play()
end)

-- UI simples (teste)
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "GhoulHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.5,0.5)
frame.Position = UDim2.fromScale(0.25,0.25)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Visible = true

local uicorner = Instance.new("UICorner", frame)
uicorner.CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "GHOUL HUB 💜"
title.TextColor3 = Color3.fromRGB(170,0,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

print("Ghoul Hub carregado com sucesso")
