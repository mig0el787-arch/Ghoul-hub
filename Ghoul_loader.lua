--[[ =========================
      GHOUL HUB LOADER
========================= ]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- LOADER GUI
local loaderGui = Instance.new("ScreenGui", player.PlayerGui)
loaderGui.IgnoreGuiInset = true
loaderGui.ResetOnSpawn = false

local bg = Instance.new("Frame", loaderGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)

-- BARRA
local barBg = Instance.new("Frame", bg)
barBg.Size = UDim2.new(0.5,0,0,10)
barBg.Position = UDim2.new(0.25,0,0.65,0)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1,0)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(170,0,255)
Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

local percent = Instance.new("TextLabel", bg)
percent.Position = UDim2.new(0.5,-50,0.7,0)
percent.Size = UDim2.new(0,100,0,30)
percent.Text = "0%"
percent.TextColor3 = Color3.new(1,1,1)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 16
percent.BackgroundTransparency = 1

-- MÚSICA (TROCA O ID SE QUISER)
local sound = Instance.new("Sound", bg)
sound.SoundId = "rbxassetid://1843529602" -- exemplo
sound.Volume = 1
sound:Play()

-- ANIMAÇÃO
for i = 1,100 do
	bar.Size = UDim2.new(i/100,0,1,0)
	percent.Text = i.."%"
	task.wait(0.05)
end

sound:Stop()
loaderGui:Destroy()

--[[ =========================
         GHOUL HUB
========================= ]]

local RunService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "GhoulHub"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,330)
main.Position = UDim2.new(0.5,-260,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- TOP
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,45)
top.BackgroundColor3 = Color3.fromRGB(120,0,200)
Instance.new("UICorner", top).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.Text = "GHOUL HUB"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1

-- SIDEBAR BRANCA
local side = Instance.new("Frame", main)
side.Position = UDim2.new(0,0,0,45)
side.Size = UDim2.new(0,130,1,-45)
side.BackgroundColor3 = Color3.fromRGB(245,245,245)
Instance.new("UICorner", side).CornerRadius = UDim.new(0,14)

local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,140,0,55)
content.Size = UDim2.new(1,-150,1,-65)
content.BackgroundTransparency = 1

local tabs = {}

local function createTab(name,y)
	local b = Instance.new("TextButton", side)
	b.Size = UDim2.new(1,-10,0,40)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(120,0,200)
	b.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

	local f = Instance.new("Frame", content)
	f.Size = UDim2.new(1,0,1,0)
	f.Visible = false
	f.BackgroundTransparency = 1

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(tabs) do v.Visible = false end
		f.Visible = true
	end)

	table.insert(tabs,f)
	return f
end

local tab1 = createTab("Player",10)
local tab2 = createTab("Movement",60)
local tab3 = createTab("Fun",110)
local tab4 = createTab("Settings",160)

tabs[1].Visible = true

-- BOTÃO
local function button(parent,text,y,cb)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0,200,0,40)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(120,0,200)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(cb)
end

-- FLY
local flying = false
button(tab2,"Fly",20,function()
	flying = not flying
	if flying then
		local bv = Instance.new("BodyVelocity",hrp)
		bv.Name = "FlyForce"
		bv.MaxForce = Vector3.new(1,1,1)*1e5
		RunService.RenderStepped:Connect(function()
			if flying then
				bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
			end
		end)
	else
		if hrp:FindFirstChild("FlyForce") then
			hrp.FlyForce:Destroy()
		end
	end
end)

-- NOCLIP
local noclip = false
button(tab2,"Noclip",70,function()
	noclip = not noclip
	RunService.Stepped:Connect(function()
		if noclip then
			for _,p in pairs(char:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CanCollide = false
				end
			end
		end
	end)
end)

button(tab4,"Close Hub",20,function()
	gui:Destroy()
end)
