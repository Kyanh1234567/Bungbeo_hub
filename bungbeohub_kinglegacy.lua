-- Bụng Béo Hub - King Legacy Mobile | UI giống Arc Hub + Tween + Auto Farm Full
repeat wait() until game:IsLoaded()
if game.PlaceId ~= 4520749081 then return end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

-- UI: Nút bật/tắt hub
local gui = Instance.new("ScreenGui", game.CoreGui)
local openBtn = Instance.new("TextButton", gui)
openBtn.Text = "🍋"
openBtn.Size = UDim2.new(0, 40, 0, 40)
openBtn.Position = UDim2.new(0, 10, 0.5, -20)
openBtn.BackgroundColor3 = Color3.fromRGB(255, 221, 130)
openBtn.TextScaled = true
openBtn.Draggable = true
openBtn.Active = true

-- Giao diện chính
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 400)
main.Position = UDim2.new(0.5, -150, 0.5, -200)
main.Visible = false
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5, 0.5)

local title = Instance.new("TextLabel", main)
title.Text = "Bụng Béo Hub - King Legacy"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,0.7)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local UIListLayout = Instance.new("UIListLayout", main)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Padding = UDim.new(0, 6)

-- Toggle button
function createToggle(text, callback)
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.Text = text
	btn.MouseButton1Click:Connect(function()
		callback()
	end)
end

-- Tween Teleport
function tweenTo(pos)
	local info = TweenInfo.new((hrp.Position - pos).Magnitude / 250, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(hrp, info, {CFrame = CFrame.new(pos)})
	tween:Play()
	tween.Completed:Wait()
end

-- Bring Mob
function bringMobs()
	for _, mob in pairs(workspace:GetChildren()) do
		if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
			if (mob.HumanoidRootPart.Position - hrp.Position).Magnitude < 100 then
				mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-5)
			end
		end
	end
end

-- Fast Attack
function fastAttack()
	local tool = plr.Character:FindFirstChildOfClass("Tool")
	if tool then
		local event = tool:FindFirstChild("RemoteEvent") or tool:FindFirstChildWhichIsA("RemoteEvent", true)
		if event then
			event:FireServer()
		end
	end
end

-- Auto Farm
local farming = false
createToggle("Auto Farm Level", function()
	farming = not farming
	while farming do
		pcall(function()
			-- Find quest button (dummy logic, bạn nên cải tiến)
			local mob = workspace:FindFirstChild("Skull Pirate") or workspace:FindFirstChildWhichIsA("Model")
			if mob and mob:FindFirstChild("HumanoidRootPart") then
				tweenTo(mob.HumanoidRootPart.Position + Vector3.new(0,10,0))
				wait(0.5)
				bringMobs()
				fastAttack()
			end
		end)
		wait(0.2)
	end
end)

-- Auto Melee
local autoStat = false
createToggle("Auto Up Melee", function()
	autoStat = not autoStat
	while autoStat do
		pcall(function()
			ReplicatedStorage.Remotes.AddPoint:FireServer("Melee", 1)
		end)
		wait(1)
	end
end)

-- Nút đóng mở hub
openBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
