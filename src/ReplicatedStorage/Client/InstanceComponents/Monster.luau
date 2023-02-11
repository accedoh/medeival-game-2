local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local Monster = Component.new({
    Tag = "Monster",
    Ancestors = {workspace},
})

function Monster:Start()
    self.Humanoid = self.Instance:WaitForChild("Humanoid") 
end

function Monster:Damage(damageAmount)
    if damageAmount >= self.Humanoid.Health then
        self.Instance:Destroy()
    end

    self.Humanoid.Health = self.Humanoid.Health - damageAmount
end

return Monster