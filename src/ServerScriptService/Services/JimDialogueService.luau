local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local InterfaceComponentService

local JimDialogueService = Knit.CreateService({
    Name = "JimDialogueService",
    Client = {},
})


function JimDialogueService:KnitInit()
    self.GaveCookie = false
    InterfaceComponentService = Knit.GetService("InterfaceComponentService")
end

function JimDialogueService:GiveCookies()
    if self.GaveCookie then
        return
    end

    self.GaveCookie = true

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