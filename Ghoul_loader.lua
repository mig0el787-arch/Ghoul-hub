-- GHOUL HUB LOADER
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- CONFIG
local IMAGE_ID = "rbxassetid://IMAGEM_AQUI" -- SUA IMAGEM
local MUSIC_ID = "rbxassetid://MUSICA_HEAVY_LOVE_AQUI" -- Heavy Love (parte famosa)
local LOAD_TIME = 5 -- segundos

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GhoulLoader"
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- BACKGROUND
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.new(0,0,0)

-- IMAGE
local img = Instance.new("ImageLabel", bg)
img.Size = UDim2.new(1,0,1,0)
img.Image = IMAGE_ID
img.BackgroundTransparency = 1
img.ScaleType = Enum.ScaleType.Crop

-- DARK OVERLAY
local overlay = Instance.new("Frame", bg)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency = 0.35

-- LOADING BAR BG
local barBG = Instance.new("Frame", bg)
barBG.Size = UDim2.new(0.4,0,0,18)
barBG.Position = UDim2.new(0.3,0,0.85,0)
barBG.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", barBG).CornerRadius = UDim.new(1,0)

-- LOADING BAR
local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(160,0,255)
Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

-- TEXT
local text = Instance.new("TextLabel", bg)
text.Size = UDim2.new(1,0,0,30)
text.Position = UDim2.new(0,0,0.82,0)
text.BackgroundTransparency = 1
text.Text = "Carregando 0%"
text.TextColor3 = Color3.new(1,1,1)
text.Font = Enum.Font.GothamBold
text.TextSize = 18

-- MUSIC
local sound = Instance.new("Sound", bg)
sound.SoundId = MUSIC_ID
sound.Volume = 3
sound.Looped = false
sound:Play()

-- LOADING ANIMATION
local start = tick()
while tick() - start < LOAD_TIME do
	local progress = math.clamp((tick() - start) / LOAD_TIME, 0, 1)
	bar.Size = UDim2.new(progress,0,1,0)
	text.Text = "Carregando "..math.floor(progress * 100).."%"
	task.wait()
end

bar.Size = UDim2.new(1,0,1,0)
text.Text = "Carregando 100%"

-- FADE OUT
TweenService:Create(bg, TweenInfo.new(0.6), {
	BackgroundTransparency = 1
}):Play()

task.wait(0.6)
gui:Destroy()

-- AQUI você pode carregar o HUB PRINCIPAL depois
-- loadstring(game:HttpGet("URL_DO_GHOUL_HUB"))()
