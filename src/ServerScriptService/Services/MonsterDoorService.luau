local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local MonsterComponent = require(ServerScriptService.Source.InstanceComponents.Monster)
local ForcefieldDoorComponent = require(ServerScriptService.Source.InstanceComponents.ForcefieldDoor)

local MonsterDoorService = Knit.CreateService {
    Name = "MonsterDoorService",
    Client = {}
}

function MonsterDoorService:OpenDoors()
    for _, forcefieldDoor in ForcefieldDoorComponent:GetAll() do
        forcefieldDoor:Open()
    end
end

function MonsterDoorService:CloseDoors()
    for _, forcefieldDoor in ForcefieldDoorComponent:GetAll() do
        forcefieldDoor:Close()
    end
end

function MonsterDoorService:AreMonstersAlive()
    if next(MonsterComponent:GetAll()) then
        return true
    end

    return false
end

function MonsterDoorService:UpdateDoors()
    if self:AreMonstersAlive() then
        self:CloseDoors()
    else
        self:OpenDoors()
    end
end

function MonsterDoorService:KnitStart()
    self:UpdateDoors()

    MonsterComponent.Started:Connect(function(monster)
        self:UpdateDoors()
    end)

    MonsterComponent.Stopped:Connect(function(monster)
        self:UpdateDoors()
    end)
end

return MonsterDoorService