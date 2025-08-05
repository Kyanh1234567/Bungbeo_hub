repeat wait() until game:IsLoaded()
if game.PlaceId ~= 4520749081 then return end

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Variables
local plr = Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

--// UI - Bubble Style
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Library:MakeWindow({Name = "🥭 Bụng Béo Hub - King Legacy", HidePremium = false, SaveConfig = true, IntroEnabled = false})

--// Auto Farm Tab
local FarmTab = Window:MakeTab({Name = "Auto Farm", Icon = "rbxassetid://9945293280", PremiumOnly = false})

--// Settings
getgenv().BungBeo = {
    AutoFarm = false,
    Weapon = "Melee",
    AutoStatMelee = false
}

--// Tween Function
function TweenTo(pos)
    local info = TweenInfo.new((hrp.Position - pos).Magnitude/250, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, info, {CFrame = CFrame.new(pos)})
    tween:Play()
    repeat wait() until (hrp.Position - pos).Magnitude < 10 or not getgenv().BungBeo.AutoFarm
    tween:Cancel()
end

--// Get Quest & Mob
function GetNearestMob()
    for _,v in pairs(workspace.Mobs:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
end

function AttackMob(mob)
    if not mob then return end
    while mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and getgenv().BungBeo.AutoFarm do
        pcall(function()
            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
            local args = {[1] = mob}
            if getgenv().BungBeo.Weapon == "Melee" then
                ReplicatedStorage.Remotes.DamageMelee:FireServer(unpack(args))
            elseif getgenv().BungBeo.Weapon == "Sword" then
                ReplicatedStorage.Remotes.DamageSword:FireServer(unpack(args))
            elseif getgenv().BungBeo.Weapon == "Fruit" then
                ReplicatedStorage.Remotes.DamageSkill:FireServer(unpack(args))
            end
        end)
        wait(0.2)
    end
end

--// Auto Stat
spawn(function()
    while wait(3) do
        if getgenv().BungBeo.AutoStatMelee then
            ReplicatedStorage.Remotes.AddStatPoint:FireServer("Melee", 1)
        end
    end
end)

--// Auto Farm Loop
spawn(function()
    while wait() do
        if getgenv().BungBeo.AutoFarm then
            local mob = GetNearestMob()
            if mob then
                TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0,10,0))
                AttackMob(mob)
            end
        end
    end
end)

--// GUI Toggles
FarmTab:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(v)
        getgenv().BungBeo.AutoFarm = v
    end
})

FarmTab:AddDropdown({
    Name = "Chọn vũ khí đánh",
    Default = "Melee",
    Options = {"Melee", "Sword", "Fruit"},
    Callback = function(v)
        getgenv().BungBeo.Weapon = v
    end
})

FarmTab:AddToggle({
    Name = "Auto tăng chỉ số Melee",
    Default = false,
    Callback = function(v)
        getgenv().BungBeo.AutoStatMelee = v
    end
})
