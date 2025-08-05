repeat wait() until game:IsLoaded()
if game.PlaceId ~= 4520749081 then return end
pcall(function()
    game.CoreGui.Rayfield:Destroy()
end)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
Rayfield:Credit{Name="Loading GUI hoàn chỉnh ♡"}
local Win = Rayfield:CreateWindow({
  Name="Bụng Béo Hub - King Legacy",
  LoadingTitle="Bụng Béo Tải GUI...",
  LoadingSubtitle="By Kyanh",
  KeySystem=false, ConfigurationSaving={Enabled=false}, Discord={Enabled=false}
})
local Tab = Win:CreateTab("Test GUI",4483362458)
Tab:CreateToggle({
  Name="Test AutoFarm",
  CurrentValue=false,
  Callback=function(v)
    _G.TestFarm=v
    while _G.TestFarm do
      wait(1)
      print("✅ TestFarm đang chạy")
    end
  end
})
Tab:CreateToggle({
  Name="Test FastAttack",
  CurrentValue=false,
  Callback=function(v)
    _G.TestAttack=v
    while _G.TestAttack do
      wait(1)
      print("⚡ TestAttack đang chạy")
    end
  end
})
