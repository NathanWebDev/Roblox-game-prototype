local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local rollDebounce = false
UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		local duration = 0.35

		local humanoid = script.Parent:WaitForChild("Humanoid")
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
		loadRollingAnimation:Play()
		local goalCFrame = rootPart.CFrame * CFrame.new(0, 0, -distance)
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
		local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = goalCFrame })
		tween:Play()
		wait(0.75)
		rollDebounce = false
	end
end)
