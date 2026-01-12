--// GHOUL HUB LOADER (PURPLE EDITION)
--// Executor: Delta / Mobile friendly

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

--================ LOADER ================
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.IgnoreGuiInset = true

local loader = Instance.new("Frame", gui)
loader.Size = UDim2.new(1,0,1,0)
loader.BackgroundColor3 = Color3.fromRGB(10,10,10)

local title = Instance.new("TextLabel", loader)
title.Size = UDim2.new(1,0,0.2,0)
title.Position = UDim2.new(0,0,0.25,0)
title.BackgroundTransparency = 1
title.Text = "GHOUL HUB"
title.TextColor3 = Color3.fromRGB(170,0,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local barBG = Instance.new("Frame", loader)
barBG.Size = UDim2.new(0.6,0,0.03,0)
barBG.Position = UDim2.new(0.2,0,0.55,0)
barBG.BackgroundColor3 = Color3.fromRGB(40,40,40)

local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(170,0,255)

local percent = Instance.new("TextLabel", loader)
percent.Size = UDim2.new(1,0,0.05,0)
percent.Position = UDim2.new(0,0,0.6,0)
percent.BackgroundTransparency = 1
percent.Text = "Carregando 0%"
percent.TextColor3 = Color3.fromRGB(255,255,255)
percent.Font = Enum.Font.Gotham
percent.TextScaled = true

--================ SOM CLEAN ================
local intro = Instance.new("Sound")
intro.SoundId = "rbxassetid://1843529631" -- clean
intro.Volume = 0.8
intro.Parent = SoundService
intro:Play()

for i = 1,100 do
	bar.Size = UDim2.new(i/100,0,1,0)
	percent.Text = "Carregando "..i.."%"
	task.wait(0.05)
end

intro:Stop()
loader:Destroy()

--================ HUB ================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,260)
main.Position = UDim2.new(0.5,-210,0.5,-130)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Visible = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0,110,1,0)
sidebar.BackgroundColor3 = Color3.fromRGB(245,245,245)

Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,12)

local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1,-110,0,40)
header.Position = UDim2.new(0,110,0,0)
header.BackgroundTransparency = 1
header.Text = "Ghoul Hub"
header.TextColor3 = Color3.fromRGB(170,0,255)
header.Font = Enum.Font.GothamBold
header.TextScaled = true

--================ FUNÇÕES ================
local function createBtn(text,y,callback)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0,260,0,40)
	b.Position = UDim2.new(0,130,0,y)
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextScaled = true
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(callback)
end

-- Fly
createBtn("Fly",60,function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NoobHubV1/NoobHubV1/main/Fly.lua"))()
end)

-- Noclip
createBtn("Noclip",110,function()
	local noclip = true
	game:GetService("RunService").Stepped:Connect(function()
		if noclip and LocalPlayer.Character then
			for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide = false end
			end
		end
	end)
end)

-- Free Gamepass (visual)
createBtn("Free Gamepass",160,function()
	game.StarterGui:SetCore("SendNotification",{
		Title="Ghoul Hub",
		Text="Gamepasses desbloqueados (visual)",
		Duration=3
	})
end)

--================ BOTÃO ON/OFF ================
local toggle = Instance.new("ImageButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,15,0.5,-30)
toggle.Image = "rbxassetid://134981298826118"
toggle.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)
local stroke = Instance.new("UIStroke", toggle)
stroke.Color = Color3.fromRGB(170,0,255)
stroke.Thickness = 2

local open = true
toggle.MouseButton1Click:Connect(function()
	open = not open
	main.Visible = open
end)
