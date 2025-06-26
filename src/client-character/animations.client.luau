local player = game.Players.LocalPlayer
local rollDebounce = false
local playerGui = player.PlayerGui

local humanoid = script.Parent:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local stamina = player:GetAttribute("Stamina")
local maxStamina = player:GetAttribute("MaxStamina")

--Handle Sprint
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
		player:SetAttribute("Stamina", stamina)
		if stamina == 0 then
			sprint(false)
			exhausted = true
			wait(1)
		end
	else
		stamina = math.min(maxStamina, stamina + refreshRate * deltaTime)
		updateStamina()
		player:SetAttribute("Stamina", stamina)
		if stamina >= staminaRefresh then
			exhausted = false
			if sprintHeld then
				sprint(true)
			end
		end
	end
end)

--Handle Roll Animation
UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		local duration = 0.35

		local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		local rootPart = character:WaitForChild("HumanoidRootPart")
		local rollAnimation = script:WaitForChild("Roll Animation")
		local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator")
		local loadRollingAnimation = animator:LoadAnimation(rollAnimation)

		local distance = 10

		if rollDebounce then
			return
		end
		rollDebounce = true
		if humanoid.FloorMaterial ~= Enum.Material.Air then
			loadRollingAnimation:Play()
			stamina = math.max(0, stamina - 20)
			updateStamina()
			player:SetAttribute("Stamina", stamina)
			print(math.floor(stamina))
			local goalCFrame = rootPart.CFrame * CFrame.new(0, 0, -distance)
			local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
			local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = goalCFrame })
			tween:Play()
		end
		wait(0.75)
		rollDebounce = false
	end
end)
