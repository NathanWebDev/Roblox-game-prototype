local UserInputService = game:GetService("UserInputService")

local rollDebounce = false
UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		local humanoid = script.Parent:WaitForChild("Humanoid")
		local rollAnimation = script:WaitForChild("Roll Animation")
		local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator")
		local loadRollingAnimation = animator:LoadAnimation(rollAnimation)

		if rollDebounce then
			return
		end
		rollDebounce = true
		loadRollingAnimation:Play()
		wait(0.75)
		rollDebounce = false
	end
end)
