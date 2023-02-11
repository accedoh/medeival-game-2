local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local HolyGrailServer = Component.new({
    Tag = "HolyGrail",
    Ancestors = {workspace},
})

function HolyGrailServer:Collect()
    self.Instance:Destroy()
end

return HolyGrailServer