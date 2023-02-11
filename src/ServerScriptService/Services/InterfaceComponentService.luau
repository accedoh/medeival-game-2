local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local MonsterComponent = require(ServerScriptService.Source.InstanceComponents.Monster)
local HolyGrailComponent = require(ServerScriptService.Source.InstanceComponents.HolyGrail)

local InterfaceComponentService = Knit.CreateService({
    Name = "InterfaceComponentService",
    Client = {
        StateUpdated = Knit.CreateSignal(),
    },
})

function InterfaceComponentService:KnitInit()
    self.States = {
        AreHolyGrailsCollected = false,
        AreMonstersAlive = false,
    }
end

function InterfaceComponentService:InitialStateSync(player)
    for stateName, stateValue in self.States do
        self.Client.StateUpdated:Fire(player, stateName, stateValue)
    end
end

function InterfaceComponentService:UpdateState(stateName, stateValue)
    if self.States[stateName] == stateValue then
        return
    end

    self.States[stateName] = stateValue
    self.Client.StateUpdated:FireAll(stateName, stateValue)
end


function InterfaceComponentService.Client:RequestInitialStateSync(player)
    self.Server:InitialStateSync(player)
end

return InterfaceComponentService