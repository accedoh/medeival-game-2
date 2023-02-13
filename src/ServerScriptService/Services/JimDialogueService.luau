
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local MonsterSpawnerComponent = require(ServerScriptService.Source.InstanceComponents.MonsterSpawner)
local HolyGrailSpawnerComponent = require(ServerScriptService.Source.InstanceComponents.HolyGrailSpawner)

local InterfaceComponentService

local JimDialogueService = Knit.CreateService({
    Name = "JimDialogueService",
    Client = {},
})

function JimDialogueService:KnitInit()
    InterfaceComponentService = Knit.GetService("InterfaceComponentService")
end

function JimDialogueService:GiveCookies()
    for _, monsterSpawner in MonsterSpawnerComponent:GetAll() do
        monsterSpawner:SpawnMonster()
    end

    for _, grailSpawner in HolyGrailSpawnerComponent:GetAll() do
        grailSpawner:SpawnHolyGrail()
    end

    local cookies = InterfaceComponentService:GetState("Cookies")
    InterfaceComponentService:UpdateState("Cookies", cookies + 1)
end

function JimDialogueService.Client:InteractWithJim()
    local areGrailsCollected = InterfaceComponentService:GetState("AreHolyGrailsCollected")
    
    if areGrailsCollected then
        self.Server:GiveCookies()
    end
end

return JimDialogueService