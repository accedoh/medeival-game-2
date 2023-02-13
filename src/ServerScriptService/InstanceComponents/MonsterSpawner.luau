local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local MonsterSpawnerServer = Component.new({
    Tag = "MonsterSpawner",
    Ancestors = {workspace},
})

function MonsterSpawnerServer:SpawnMonster()
    local newMonster = ReplicatedStorage.Assets.Monster:Clone()
    newMonster:PivotTo(self.Instance:GetPivot())
    CollectionService:AddTag(newMonster, "Monster")
    newMonster.Parent = workspace
end

return MonsterSpawnerServer