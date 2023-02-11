local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local CharacterClient = Component.new({
    Tag = "Character",
    Ancestors = {workspace},
})

function CharacterClient:Start()
    self.Humanoid = self.Instance:FindFirstChildWhichIsA("Humanoid")
end

return CharacterClient