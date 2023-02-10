local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local PunchingCharacter = Component.new({
    Tag = "PunchingCharacter",
    Ancestors = {workspace},
})

function PunchingCharacter:Start()
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://8396752673"

    local humanoid = self.Instance:WaitForChild("Humanoid")

    self._animationTrack = humanoid:LoadAnimation(animation)
end

function PunchingCharacter:Punch()
    self._animationTrack:Play()
end

function PunchingCharacter:Stop()
    self._animationTrack:Destroy()
end

return PunchingCharacter