local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local HolyGrailSpawnerServer = Component.new({
    Tag = "HolyGrailSpawner",
    Ancestors = {workspace},
})

function HolyGrailSpawnerServer:SpawnHolyGrail()
    local newHolyGrail = ReplicatedStorage.Assets.HolyGrail:Clone()
    newHolyGrail:PivotTo(self.Instance:GetPivot())
    CollectionService:AddTag(newHolyGrail, "HolyGrail")
    newHolyGrail.Parent = workspace
end

function HolyGrailSpawnerServer:Start()
    self:SpawnHolyGrail()
end

return HolyGrailSpawnerServer