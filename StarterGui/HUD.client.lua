local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JailbreakHUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local cashLabel = Instance.new("TextLabel")
cashLabel.Size = UDim2.new(0, 300, 0, 60)
cashLabel.Position = UDim2.new(1, -320, 0, 20)
cashLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
cashLabel.BackgroundTransparency = 0.3
cashLabel.Font = Enum.Font.GothamBold
cashLabel.TextScaled = true
cashLabel.TextColor3 = Color3.fromRGB(0, 220, 100)
cashLabel.Text = "💰 $0"
cashLabel.BorderSizePixel = 2
cashLabel.BorderColor3 = Color3.fromRGB(0, 200, 100)
cashLabel.Parent = screenGui

local roleLabel = Instance.new("TextLabel")
roleLabel.Size = UDim2.new(0, 300, 0, 60)
roleLabel.Position = UDim2.new(1, -320, 0, 90)
roleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
roleLabel.BackgroundTransparency = 0.3
roleLabel.Font = Enum.Font.GothamBold
roleLabel.TextScaled = true
roleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
roleLabel.Text = "Role: Criminal"
roleLabel.BorderSizePixel = 2
roleLabel.BorderColor3 = Color3.fromRGB(255, 100, 100)
roleLabel.Parent = screenGui

local info = Instance.new("TextLabel")
info.Size = UDim2.new(0, 440, 0, 180)
info.Position = UDim2.new(0, 20, 0, 20)
info.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
info.BackgroundTransparency = 0.4
info.TextColor3 = Color3.fromRGB(255, 255, 255)
info.Font = Enum.Font.Gotham
info.TextScaled = true
info.TextWrapped = true
info.Text = "🚗 Vezmi si auto v garáži\n🏦 Jdi do banky a dokonči heist\n🚓 Policisté mohou zatýkat\n💰 Peníze se přidávají do leaderstats"
info.Parent = screenGui

local objective = Instance.new("TextLabel")
objective.Size = UDim2.new(0, 420, 0, 90)
objective.Position = UDim2.new(0, 20, 1, -110)
objective.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
objective.BackgroundTransparency = 0.4
objective.TextColor3 = Color3.fromRGB(255, 200, 0)
objective.Font = Enum.Font.GothamBold
objective.TextScaled = true
objective.Text = "Cíl: Vezmi si auto, jdi do banky a získej peníze!"
objective.Parent = screenGui

local function updateHUD()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local cash = leaderstats:FindFirstChild("Cash")
        local role = leaderstats:FindFirstChild("Role")
        if cash then
            cashLabel.Text = "💰 $" .. tostring(cash.Value)
        end
        if role then
            roleLabel.Text = "Role: " .. role.Value
            if role.Value == "Police" then
                roleLabel.TextColor3 = Color3.fromRGB(100, 160, 255)
            else
                roleLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end
    end
end

while true do
    updateHUD()
    task.wait(0.5)
end
