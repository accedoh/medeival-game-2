local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Component = require(Packages.Component)

local PunchingCharacterClient = Component.new({
    Tag = "PunchingCharacter",
    Ancestors = {workspace},
})

function PunchingCharacterClient:Start()
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://8396752673"

    local humanoid = self.Instance:WaitForChild("Humanoid")

    self._animationTrack = humanoid:LoadAnimation(animation)
end

function PunchingCharacterClient:Punch()
    self._animationTrack:Play()
    Knit.GetService("PunchingService"):Punch(self.Instance)
end

function PunchingCharacterClient:Stop()
    self._animationTrack:Destroy()
end

return PunchingCharacterClient