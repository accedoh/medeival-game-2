local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local MonsterServer = Component.new({
    Tag = "MonsterServer",
    Tag = "Monster",
    Ancestors = {workspace},
})

function MonsterServer:Start()
    self.Humanoid = self.Instance:WaitForChild("Humanoid") 
end

function MonsterServer:Damage(damageAmount)
    if damageAmount >= self.Humanoid.Health then
        self.Instance:Destroy()
    end

    self.Humanoid.Health = self.Humanoid.Health - damageAmount
end

return MonsterServer