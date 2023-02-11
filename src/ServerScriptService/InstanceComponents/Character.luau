local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local CharacterServer = Component.new({
    Tag = "Character",
    Ancestors = {workspace},
})

function CharacterServer:Start()
    self.Humanoid = self.Instance:WaitForChild("Humanoid")

    -- Bind Tags
    CollectionService:AddTag(self.Instance, "PunchingCharacter")
end

function CharacterServer:Damage(damage)
    self.Humanoid:TakeDamage(damage)
end

return CharacterServer