-- Script A: Auto chạy + nhặt Bound nếu gần (noclip + tốc độ cao)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local speed = 120 -- Tốc độ siêu nhanh
local collecting = false

-- Noclip
RunService.Stepped:Connect(function()
    pcall(function()
        if Humanoid then
            Humanoid:ChangeState(11)
        end
    end)
end)

-- Nhặt Bound trong bán kính 15
function collectNearbyBounds()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name == "Bound" and not collecting then
            local dist = (HRP.Position - v.Position).Magnitude
            if dist <= 15 then
                collecting = true
                firetouchinterest(HRP, v, 0)
                wait(0.1)
                firetouchinterest(HRP, v, 1)
                wait(0.1)
                collecting = false
            end
        end
    end
end

-- Di chuyển liên tục
spawn(function()
    while true do
        if HRP and Humanoid then
            HRP.CFrame = HRP.CFrame + HRP.CFrame.LookVector * speed * 0.1
        end
        collectNearbyBounds()
        wait(0.1)
    end
end)

print("🛠️ Script A đang chạy: Tự chạy và nhặt Bound gần nếu có.")
