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
        Cookies = 0,
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

function InterfaceComponentService:GetState(stateName)
    return self.States[stateName]
end

function InterfaceComponentService:HeartbeatUpdate()
    if next(MonsterComponent:GetAll()) then
        self:UpdateState("AreMonstersAlive", true)
    else
        self:UpdateState("AreMonstersAlive", false)
    end

    if next(HolyGrailComponent:GetAll()) then
        self:UpdateState("AreHolyGrailsCollected", false)
    else
        self:UpdateState("AreHolyGrailsCollected", true)
    end
end

function InterfaceComponentService:KnitStart()
    RunService.Heartbeat:Connect(function()
        self:HeartbeatUpdate()
    end)
end

function InterfaceComponentService.Client:RequestInitialStateSync(player)
    self.Server:InitialStateSync(player)
end

return InterfaceComponentService