-- Bung Béo Hub - King Legacy Mobile | Fix không hiện GUI
repeat wait() until game:IsLoaded()
if game.PlaceId ~= 4520749081 then return end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local plr = Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

-- UI fix: Đưa vào PlayerGui thay vì CoreGui
local gui = Instance.new("ScreenGui")
gui.Parent = plr:WaitForChild("PlayerGui")

local openBtn = Instance.new("TextButton", gui)
openBtn.Text = "🥭"
openBtn.Size = UDim2.new(0, 40, 0, 40)
openBtn.Position = UDim2.new(0, 0.5, 0, -20)
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
    btn.MouseButton1Click:Connect(callback)
end

-- Tween Teleport
function tweenTo(pos)
    local info = TweenInfo.new((hrp.Position - pos).Magnitude / 250, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, info, {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

function bringMobs()
    for _, mob in pairs(workspace.Mobs:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") then
            mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
        end
    end
end

-- Auto Farm
local autofarm = false
function doAutoFarm()
    while autofarm and task.wait() do
        for _, mob in pairs(workspace.Mobs:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                local mobPos = mob.HumanoidRootPart.Position
                tweenTo(mobPos + Vector3.new(0, 0, 5))
                bringMobs()
                for _, v in pairs(plr.Backpack:GetChildren()) do
                    if v:IsA("Tool") then
                        v:Activate()
                    end
                end
                repeat
                    bringMobs()
                    task.wait()
                until mob.Humanoid.Health <= 0 or not autofarm
            end
        end
    end
end

-- Nút Auto Farm
createToggle("Auto Farm", function()
    autofarm = not autofarm
    if autofarm then
        doAutoFarm()
    end
end)

-- Toggle UI
openBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)
