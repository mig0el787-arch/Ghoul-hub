-- GHOUL HUB ☠️ (DELTA COMPATÍVEL)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI BASE
local gui = Instance.new("ScreenGui")
gui.Name = "GhoulHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ================= BOTÃO FLUTUANTE =================
local floatBtn = Instance.new("ImageButton", gui)
floatBtn.Size = UDim2.new(0,60,0,60)
floatBtn.Position = UDim2.new(0,20,0.5,-30)
floatBtn.Image = "rbxassetid://74356605425526" -- FOTO DO GHOUL
floatBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
floatBtn.BorderSizePixel = 0
floatBtn.AutoButtonColor = false
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1,0)

-- Drag
local dragging, dragStart, startPos
floatBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = floatBtn.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		floatBtn.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- ================= MAIN UI =================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,520,0,320)
main.Position = UDim2.new(0.5,-260,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.Visible = false
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- TOGGLE
floatBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0,120,1,0)
side.BackgroundColor3 = Color3.fromRGB(0,0,0)
side.BorderSizePixel = 0

-- TITLE
local title = Instance.new("TextLabel", side)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "GHOUL"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,120,0,0)
content.Size = UDim2.new(1,-120,1,0)
content.BackgroundTransparency = 1

local tabs = {}

local function createTab(name, order)
	local btn = Instance.new("TextButton", side)
	btn.Size = UDim2.new(1,0,0,40)
	btn.Position = UDim2.new(0,0,0,50 + (order-1)*42)
	btn.Text = name
	btn.BackgroundTransparency = 1
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14

	local frame = Instance.new("Frame", content)
	frame.Size = UDim2.new(1,0,1,0)
	frame.Visible = false
	frame.BackgroundTransparency = 1

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(tabs) do v.Visible = false end
		frame.Visible = true
	end)

	table.insert(tabs, frame)
	return frame
end

-- TABS
local tabMove = createTab("Movement",1)
local tabPlayer = createTab("Player",2)
local tabSettings = createTab("Settings",3)
tabs[1].Visible = true

-- BOTÃO
local function makeButton(parent, text, y, callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0,220,0,42)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(callback)
end

-- FLY
local flying = false
makeButton(tabMove,"Fly",30,function()
	flying = not flying
	if flying then
		local bv = Instance.new("BodyVelocity", hrp)
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
makeButton(tabMove,"Noclip",80,function()
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

-- RESET
makeButton(tabPlayer,"Reset Character",30,function()
	char:BreakJoints()
end)

-- CLOSE
makeButton(tabSettings,"Close Hub",30,function()
	gui:Destroy()
end)
