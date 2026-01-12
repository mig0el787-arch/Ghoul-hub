-- GHOUL HUB | Loader Final
-- Mobile Friendly | Delta / Fluxus

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GhoulHub"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- ===== MÚSICA CLEAN (EMO / DARK) =====
local sound = Instance.new("Sound")
sound.Parent = gui
sound.SoundId = "rbxassetid://1837467337" -- música clean emo
sound.Volume = 2
sound.Looped = true
sound:Play()

-- ===== MAIN FRAME =====
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,420,0,280)
main.Position = UDim2.new(0.5,-210,0.5,-140)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Visible = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

-- borda roxa
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(170,0,255)
stroke.Thickness = 2

-- ===== TÍTULO =====
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "GHOUL HUB 🖤"
title.TextColor3 = Color3.fromRGB(190,0,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

-- ===== CONTEÚDO =====
local content = Instance.new("TextLabel")
content.Parent = main
content.Position = UDim2.new(0,20,0,60)
content.Size = UDim2.new(1,-40,1,-80)
content.BackgroundTransparency = 1
content.TextWrapped = true
content.TextYAlignment = Enum.TextYAlignment.Top
content.Text = [[
• Speed Player
• Jump Power
• Fly
• Noclip
• Car Speed
• Infinite Jump
• House Tools

(Interface base pronta)
]]
content.TextColor3 = Color3.fromRGB(230,230,230)
content.Font = Enum.Font.Gotham
content.TextSize = 14

-- ===== BOTÃO FLUTUANTE (CÍRCULO) =====
local toggle = Instance.new("ImageButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0,20,0.5,-30)
toggle.BackgroundColor3 = Color3.fromRGB(10,10,10)
toggle.Image = "rbxassetid://74356605425526"
toggle.AutoButtonColor = false
toggle.BorderSizePixel = 0
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

local stroke2 = Instance.new("UIStroke", toggle)
stroke2.Color = Color3.fromRGB(170,0,255)
stroke2.Thickness = 2

-- abrir / fechar
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- ===== ARRASTAR (MOBILE) =====
local dragging = false
local dragStart, startPos

toggle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = toggle.Position
	end
end)

toggle.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		toggle.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
