-- GHOUL HUB
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "GhoulHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 320)
main.Position = UDim2.new(0.5,-250,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- SIDEBAR
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0,120,1,0)
side.BackgroundColor3 = Color3.fromRGB(40,0,60)

local tabs = {}

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,120,0,0)
content.Size = UDim2.new(1,-120,1,0)
content.BackgroundTransparency = 1

-- FUNÇÃO PRA CRIAR ABA
local function createTab(name, order)
local btn = Instance.new("TextButton", side)
btn.Size = UDim2.new(1,0,0,45)
btn.Position = UDim2.new(0,0,0,(order-1)*50)
btn.Text = name
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(60,0,90)
btn.Font = Enum.Font.GothamBold
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

-- 6 ABAS
local tab1 = createTab("Player",1)
local tab2 = createTab("Movement",2)
local tab3 = createTab("World",3)
local tab4 = createTab("Visual",4)
local tab5 = createTab("Fun",5)
local tab6 = createTab("Settings",6)

tabs[1].Visible = true

-- BOTÃO SIMPLES
local function button(parent,text,y,callback)
local b = Instance.new("TextButton", parent)
b.Size = UDim2.new(0,200,0,40)
b.Position = UDim2.new(0,20,0,y)
b.Text = text
b.BackgroundColor3 = Color3.fromRGB(90,0,140)
b.TextColor3 = Color3.new(1,1,1)
b.Font = Enum.Font.GothamBold
b.TextSize = 14
b.MouseButton1Click:Connect(callback)
end

-- FLY
local flying = false
button(tab2,"Fly",30,function()
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
button(tab2,"Noclip",80,function()
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

-- EXEMPLOS
button(tab1,"Reset Character",30,function()
char:BreakJoints()
end)

button(tab6,"Close Hub",30,function()
gui:Destroy()
end)
