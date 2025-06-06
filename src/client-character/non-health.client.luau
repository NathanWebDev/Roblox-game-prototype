local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local playerGui = player.PlayerGui

local stamina = 100
local maxStamina = 100

local speedDifference = 8
local drainRate = 20
local refreshRate = 10
local staminaRefresh = 20

local sprintHeld = false
local sprinting = false
local exhausted = false

local function sprint(active)
	if exhausted then
		return
	end

	humanoid.WalkSpeed = active and humanoid.WalkSpeed + speedDifference or humanoid.WalkSpeed - speedDifference
	sprinting = active
end

local function onInput(input)
	if input.KeyCode == Enum.KeyCode.LeftShift and input.UserInputType ~= Enum.UserInputType.Gamepad1 then
		sprintHeld = input.UserInputState == Enum.UserInputState.Begin
		sprint(sprintHeld)
	end
end

local function updateStamina()
	playerGui.ScreenGui.StaminaContainer.Stamina.Size = UDim2.new(math.clamp(stamina / maxStamina, 0, 1), 0, 1, 0)
end

userInputService.InputBegan:Connect(onInput)
userInputService.InputEnded:Connect(onInput)

runService.Heartbeat:Connect(function(deltaTime)
	if sprinting then
		stamina = math.max(0, stamina - drainRate * deltaTime)
		updateStamina()
		print(math.floor(stamina))
		if stamina == 0 then
			sprint(false)
			exhausted = true
		end
	else
		stamina = math.min(100, stamina + refreshRate * deltaTime)
		updateStamina()
		if stamina >= staminaRefresh then
			exhausted = false
			print(math.floor(stamina))
			if sprintHeld then
				sprint(true)
			end
		end
	end
end)
