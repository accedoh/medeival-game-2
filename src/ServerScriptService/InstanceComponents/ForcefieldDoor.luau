local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local ForcefieldDoorServer = Component.new({
    Tag = "ForcefieldDoor",
    Ancestors = {workspace},
})

function ForcefieldDoorServer:Construct()
    self.ClosedTransparency = self.Instance.Transparency
end

function ForcefieldDoorServer:Open()
    self.Instance.Transparency = 1
    self.Instance.CanCollide = false
end

function ForcefieldDoorServer:Close()
    self.Instance.Transparency = self.ClosedTransparency
    self.Instance.CanCollide = true
end

return ForcefieldDoorServer