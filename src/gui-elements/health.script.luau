--Variables
local player = game.Players.LocalPlayer
local charachter = player.Character or player.Character.wait()
local humanoid = charachter:WaitForChild("Humanoid")

local healthBar = script.Parent

local function updateHealth()
	local health = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
	healthBar.Size = UDim2.new(health, 1, 1, 0)
end

updateHealth()

humanoid:GetPropertyChangedSignal("Health"):Connect(updateHealth)
humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateHealth)
