local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui

player:SetAttribute("Health", 100)
player:SetAttribute("MaxHealth", 100)

player:SetAttribute("Mana", 50)
player:SetAttribute("MaxMana", 50)

player:SetAttribute("Stamina", 80)
player:SetAttribute("MaxStamina", 80)

--Health Logic
player:GetAttributeChangedSignal("Health"):Connect(function()
	local newHealth = player:GetAttribute("Health")
	playerGui.ScreenGui.HealthContainer.Health.Size = UDim2.new(
		0,
		newHealth * 3,
		playerGui.ScreenGui.HealthContainer.Health.Size.X.Scale,
		playerGui.ScreenGui.HealthContainer.Health.Size.Y.Offset
	)
end)

player:GetAttributeChangedSignal("MaxHealth"):Connect(function()
	local newMaxHealth = player:GetAttribute("MaxHealth")
	playerGui.ScreenGui.HealthContainer.Size = UDim2.new(
		0,
		newMaxHealth * 3,
		playerGui.ScreenGui.HealthContainer.Size.X.Scale,
		playerGui.ScreenGui.HealthContainer.Size.Y.Offset
	)
end)

--Stamina Logic
player:GetAttributeChangedSignal("MaxStamina"):Connect(function()
	local newMaxHealth = player:GetAttribute("MaxStamina")
	playerGui.ScreenGui.StaminaContainer.Size = UDim2.new(
		0,
		newMaxHealth * 3,
		playerGui.ScreenGui.StaminaContainer.Size.X.Scale,
		playerGui.ScreenGui.StaminaContainer.Size.Y.Offset
	)
end)
