local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

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

function PunchingCharacterClient:Punch(targetTags)
    self._animationTrack:Play()

    local humanoid = self.Instance:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return false end

    local humanoidRootPart = humanoid.RootPart
    if not humanoidRootPart then return false end

    local punchPosition = humanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, 2))
    local hitParts = workspace:GetPartBoundsInRadius(punchPosition, 2)

    local hitInstances = {}

    for _, tag in targetTags do
        hitInstances[tag] = {} 
    end

    for _, part in hitParts do
        local instance = part

        while instance do
            for _, tag in targetTags do
                if CollectionService:HasTag(instance, tag) then
                    table.insert(hitInstances[tag], instance)
                end
            end
        end

        instance = instance.Parent
    end

    return hitInstances
end

function PunchingCharacterClient:Stop()
    self._animationTrack:Destroy()
end

return PunchingCharacterClient