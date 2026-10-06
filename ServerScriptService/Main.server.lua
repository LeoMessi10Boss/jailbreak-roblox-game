local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- =========================
-- CONFIG
-- =========================
local CITY_SIZE = 1000
local BASE_Y = -2
local SPAWN_POS = Vector3.new(0, 5, 0)

-- =========================
-- UTILITY
-- =========================
local function makePart(name, size, cframe, color, material, parent)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.CFrame = cframe
    p.Color = color
    p.Material = material or Enum.Material.SmoothPlastic
    p.Anchored = true
    p.TopSurface = Enum.SurfaceType.Smooth
    p.BottomSurface = Enum.SurfaceType.Smooth
    p.Parent = parent or Workspace
    return p
end

local function makeModel(name, parent)
    local m = Instance.new("Model")
    m.Name = name
    m.Parent = parent or Workspace
    return m
end

-- =========================
-- WORLD GENERATION
-- =========================
local base = makePart("Baseplate", Vector3.new(CITY_SIZE, 1, CITY_SIZE), CFrame.new(0, BASE_Y, 0), Color3.fromRGB(90, 120, 90), Enum.Material.Grass, Workspace)
local road = makePart("MainRoad", Vector3.new(120, 0.5, 600), CFrame.new(0, 0.3, 0), Color3.fromRGB(40, 40, 40), Enum.Material.Asphalt, Workspace)
local road2 = makePart("CrossRoad", Vector3.new(600, 0.5, 120), CFrame.new(0, 0.3, 0), Color3.fromRGB(40, 40, 40), Enum.Material.Asphalt, Workspace)

local jail = makePart("Jail", Vector3.new(80, 20, 80), CFrame.new(-280, 10, -300), Color3.fromRGB(115, 75, 75), Enum.Material.Brick, Workspace)
local jailGate = makePart("JailGate", Vector3.new(12, 8, 2), CFrame.new(-280, 6, -250), Color3.fromRGB(80, 80, 90), Enum.Material.Metal, Workspace)
local jailCell = makePart("JailCell", Vector3.new(8, 6, 8), CFrame.new(-280, 5, -272), Color3.fromRGB(50, 50, 50), Enum.Material.Metal, Workspace)
local jailSpawn = makePart("JailSpawn", Vector3.new(10, 1, 10), CFrame.new(-280, 3, -320), Color3.fromRGB(255, 0, 0), Enum.Material.Neon, Workspace)

local bank = makePart("Bank", Vector3.new(70, 30, 70), CFrame.new(300, 15, 300), Color3.fromRGB(210, 180, 90), Enum.Material.Brick, Workspace)
local bankVault = makePart("BankVault", Vector3.new(10, 10, 10), CFrame.new(300, 8, 300), Color3.fromRGB(90, 90, 90), Enum.Material.Metal, Workspace)
local bankSpawn = makePart("BankSpawn", Vector3.new(10, 1, 10), CFrame.new(320, 2, 330), Color3.fromRGB(255, 200, 0), Enum.Material.Neon, Workspace)

local policeStation = makePart("PoliceStation", Vector3.new(70, 18, 70), CFrame.new(-300, 9, 200), Color3.fromRGB(60, 100, 210), Enum.Material.Brick, Workspace)
local policeSpawn = makePart("PoliceSpawn", Vector3.new(12, 1, 12), CFrame.new(-300, 3, 240), Color3.fromRGB(0, 150, 255), Enum.Material.Neon, Workspace)

local garage = makePart("Garage", Vector3.new(80, 18, 80), CFrame.new(0, 9, -300), Color3.fromRGB(150, 110, 80), Enum.Material.Brick, Workspace)
local garageSpawn = makePart("GarageSpawn", Vector3.new(12, 1, 12), CFrame.new(0, 3, -330), Color3.fromRGB(90, 220, 120), Enum.Material.Neon, Workspace)

for i = 1, 6 do
    local x = -400 + i * 90
    local z = -180 + (i % 2 == 0 and 120 or -120)
    makePart("House" .. i, Vector3.new(28, 12, 28), CFrame.new(x, 6, z), Color3.fromRGB(180 + i * 5, 120, 100), Enum.Material.Brick, Workspace)
end

for i = 1, 4 do
    local x = -150 + i * 90
    local z = 100 + i * 80
    makePart("Store" .. i, Vector3.new(25, 10, 25), CFrame.new(x, 5, z), Color3.fromRGB(110, 150, 198), Enum.Material.Brick, Workspace)
end

makePart("Hospital", Vector3.new(50, 20, 50), CFrame.new(-120, 10, 300), Color3.fromRGB(255, 255, 255), Enum.Material.Brick, Workspace)
makePart("FireStation", Vector3.new(50, 18, 50), CFrame.new(300, 9, -180), Color3.fromRGB(255, 120, 0), Enum.Material.Brick, Workspace)

-- =========================
-- SIMPLE CARS
-- =========================
local function createCar(name, position, color)
    local model = Instance.new("Model")
    model.Name = name

    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(5, 1.5, 9)
    body.Color = color
    body.Material = Enum.Material.SmoothPlastic
    body.Position = position
    body.Anchored = false
    body.Parent = model

    local seat = Instance.new("VehicleSeat")
    seat.Name = "VehicleSeat"
    seat.Size = Vector3.new(2, 1, 2)
    seat.CFrame = body.CFrame * CFrame.new(0, 2, 0)
    seat.Parent = model

    local root = Instance.new("Part")
    root.Name = "Root"
    root.Size = Vector3.new(1, 1, 1)
    root.Transparency = 1
    root.CanCollide = false
    root.CFrame = body.CFrame * CFrame.new(0, 2, 0)
    root.Parent = model

    for _, info in ipairs({
        {name = "FrontLeft", offset = Vector3.new(-2, -1, 3)},
        {name = "FrontRight", offset = Vector3.new(2, -1, 3)},
        {name = "BackLeft", offset = Vector3.new(-2, -1, -3)},
        {name = "BackRight", offset = Vector3.new(2, -1, -3)},
    }) do
        local wheel = Instance.new("Part")
        wheel.Name = info.name
        wheel.Size = Vector3.new(1.5, 1.5, 1.5)
        wheel.Shape = Enum.PartType.Cylinder
        wheel.Color = Color3.fromRGB(30, 30, 30)
        wheel.Material = Enum.Material.SmoothPlastic
        wheel.CFrame = body.CFrame * CFrame.new(info.offset.X, info.offset.Y, info.offset.Z)
        wheel.Parent = model

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = wheel
        weld.Part1 = body
        weld.Parent = wheel
    end

    local seatWeld = Instance.new("WeldConstraint")
    seatWeld.Part0 = seat
    seatWeld.Part1 = body
    seatWeld.Parent = seat

    local rootWeld = Instance.new("WeldConstraint")
    rootWeld.Part0 = root
    rootWeld.Part1 = body
    rootWeld.Parent = root

    model.Parent = Workspace
    return model
end

local carSpawns = {
    {name = "PoliceCar", pos = Vector3.new(-300, 4, 210), color = Color3.fromRGB(50, 120, 255)},
    {name = "CivilCar1", pos = Vector3.new(-40, 4, -300), color = Color3.fromRGB(255, 80, 80)},
    {name = "CivilCar2", pos = Vector3.new(30, 4, -300), color = Color3.fromRGB(0, 200, 120)},
    {name = "CivilCar3", pos = Vector3.new(-20, 4, -250), color = Color3.fromRGB(255, 200, 0)},
}

for _, info in ipairs(carSpawns) do
    createCar(info.name, info.pos, info.color)
end

-- =========================
-- PLAYER MONEY + STATS
-- =========================
local moneyData = {}

local function initPlayerStats(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local cash = Instance.new("IntValue")
    cash.Name = "Cash"
    cash.Value = moneyData[player.UserId] or 0
    cash.Parent = leaderstats

    local role = Instance.new("StringValue")
    role.Name = "Role"
    role.Value = "Criminal"
    role.Parent = leaderstats
end

local function setMoney(player, value)
    moneyData[player.UserId] = value
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local cash = leaderstats:FindFirstChild("Cash")
        if cash then
            cash.Value = value
        end
    end
end

local function awardMoney(player, amount)
    local current = moneyData[player.UserId] or 0
    setMoney(player, current + amount)
end

local function randomRole()
    return math.random(1, 2) == 1 and "Criminal" or "Police"
end

-- =========================
-- HEIST
-- =========================
local bankHeistActive = false

local function startBankHeist(player)
    if bankHeistActive then return end
    bankHeistActive = true
    task.wait(15)
    awardMoney(player, 1000)
    print(player.Name .. " completed the bank heist and received $1000")
    bankHeistActive = false
end

bankVault.Touched:Connect(function(hit)
    local model = hit.Parent
    local player = Players:GetPlayerFromCharacter(model)
    if player then
        startBankHeist(player)
    end
end)

-- =========================
-- SPAWN SYSTEM
-- =========================
local criminalSpawn = makePart("CriminalSpawn", Vector3.new(12, 1, 12), CFrame.new(0, 3, 0), Color3.fromRGB(255, 80, 80), Enum.Material.Neon, Workspace)
local policeSpawnPoint = makePart("PoliceSpawnPoint", Vector3.new(12, 1, 12), CFrame.new(-300, 3, 200), Color3.fromRGB(80, 120, 255), Enum.Material.Neon, Workspace)

Players.PlayerAdded:Connect(function(player)
    initPlayerStats(player)

    local role = randomRole()
    local roleValue = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Role")
    if roleValue then
        roleValue.Value = role
    end

    player.CharacterAdded:Connect(function(character)
        task.wait(0.2)
        local hrp = character:WaitForChild("HumanoidRootPart")
        local spawnPos = role == "Criminal" and criminalSpawn or policeSpawnPoint
        hrp.CFrame = spawnPos.CFrame + Vector3.new(0, 2, 0)
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    initPlayerStats(player)
end

print("Jailbreak-style starter loaded successfully")
