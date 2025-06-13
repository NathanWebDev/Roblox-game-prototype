local rollAnimation = script:WaitForChild("Roll")
local humanoid = script.Parent:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator")
local animationTrack = animator:LoadAnimation(rollAnimation)

task.wait(2)
animationTrack:Play()
print("Script ran")
