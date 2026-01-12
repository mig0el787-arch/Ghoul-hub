-- Ghoul Hub | Loader + Hub
-- Mobile Delta Friendly

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- =========================
-- LOADING SCREEN
-- =========================
local gui = Instance.new("ScreenGui", Player.PlayerGui)
gui.IgnoreGuiInset = true

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.fromRGB(10,10,10)

local img = Instance.new("ImageLabel", bg)
img.Size = UDim2.fromScale(1,1)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://74356605425526"

local barBg = Instance.new("Frame", bg)
barBg.Size = UDim2.new(0.6,0,0.04,0)
barBg.Position = UDim2.new(0.2,0,0.85,0)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBg.BorderSizePixel = 0

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(170,0,255)
bar.BorderSizePixel = 0

local txt = Instance.new("TextLabel", bg)
txt.Size = UDim2.new(1,0,0.05,0)
txt.Position = UDim2.new(0,0,0.9,0)
txt.BackgroundTransparency = 1
txt.Text = "Carregando 0%"
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.GothamBold
txt.TextScaled = true

-- Música clean
local music = Instance.new("Sound", SoundService)
music.SoundId = "rbxassetid://1843529634" -- clean / chill
music.Volume = 2
music:Play()

for i = 1,100 do
	bar.Size = UDim2.new(i/100,0,1,0)
	txt.Text = "Carregando "..i.."%"
	task.wait(0.05)
end

music:Stop()
bg:Destroy()

-- =========================
-- BOTÃO ON / OFF
-- =========================
local toggleGui = Instance.new("ScreenGui", Player.PlayerGui)

local btn = Instance.new("ImageButton", toggleGui)
btn.Size = UDim2.new(0,60,0,60)
btn.Position = UDim2.new(0,15,0.5,-30)
btn.Image = "rbxassetid://74356605425526"
btn.BackgroundTransparency = 1
btn.Active = true
btn.Draggable = true

-- =========================
-- HUB
-- =========================
local hub = Instance.new("Frame", toggleGui)
hub.Size = UDim2.new(0.75,0,0.6,0)
hub.Position = UDim2.new(0.125,0,0.2,0)
hub.BackgroundColor3 = Color3.fromRGB(15,15,15)
hub.Visible = false
hub.BorderSizePixel = 0

local corner = Instance.new("UICorner", hub)
corner.CornerRadius = UDim.new(0,20)

-- Sidebar
local side = Instance.new("Frame", hub)
side.Size = UDim2.new(0.25,0,1,0)
side.BackgroundColor3 = Color3.fromRGB(245,245,245)
side.BorderSizePixel = 0

local title = Instance.new("TextLabel", side)
title.Size = UDim2.new(1,0,0.15,0)
title.BackgroundTransparency = 1
title.Text = "GHOUL HUB"
title.TextColor3 = Color3.fromRGB(120,0,180)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true

-- Conteúdo
local content = Instance.new("Frame", hub)
content.Position = UDim2.new(0.27,0,0.05,0)
content.Size = UDim2.new(0.7,0,0.9,0)
content.BackgroundTransparency = 1

local function makeButton(text, y, callback)
	local b = Instance.new("TextButton", content)
	b.Size = UDim2.new(1,0,0.12,0)
	b.Position = UDim2.new(0,0,y,0)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(90,0,140)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
	b.MouseButton1Click:Connect(callback)
end

-- FUNÇÕES
makeButton("Fly", 0, function()
	local hrp = Player.Character.HumanoidRootPart
	local bv = Instance.new("BodyVelocity", hrp)
	bv.Velocity = Vector3.new(0,60,0)
	bv.MaxForce = Vector3.new(9e9,9e9,9e9)
	task.delay(2,function() bv:Destroy() end)
end)

makeButton("Noclip", 0.14, function()
	RunService.Stepped:Connect(function()
		for _,v in pairs(Player.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end)
end)

makeButton("Speed", 0.28, function()
	Player.Character.Humanoid.WalkSpeed = 60
end)

makeButton("Jump", 0.42, function()
	Player.Character.Humanoid.JumpPower = 120
end)

makeButton("Reset", 0.56, function()
	Player.Character.Humanoid.Health = 0
end)

-- Toggle
btn.MouseButton1Click:Connect(function()
	hub.Visible = not hub.Visible
end)
