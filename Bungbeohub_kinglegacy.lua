repeat wait() until game:IsLoaded()
if game.PlaceId ~= 4520749081 then return end

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
repeat wait() until plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "Bụng Béo Hub - King Legacy",
    LoadingTitle = "Đang tải Bụng Béo...",
    LoadingSubtitle = "by Kỳ Anh",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BungBeoHub",
        FileName = "kinglegacy"
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false,
})

local Tab = Window:CreateTab("🏝️ Auto Farm", 4483362458)
Tab:CreateSection("Chức năng chính")

Tab:CreateToggle({
    Name = "Tự động đánh quái",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Farm:", Value)
    end,
})
