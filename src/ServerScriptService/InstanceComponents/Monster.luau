local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local MonsterServer = Component.new({
    Tag = "Monster",
    Ancestors = {workspace},
})

function MonsterServer:OnDeath()
    self.Instance:BreakJoints()

    for _, descendant in self.Instance:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false
        end
    end

    task.delay(2, function()
        self.Instance:Destroy()
    end)
end

function MonsterServer:Start()
    self.Humanoid = self.Instance:WaitForChild("Humanoid")

    self.Humanoid.Died:Connect(function()
        self:OnDeath()
    end)
end

function MonsterServer:Damage(damageAmount)
    self.Humanoid:TakeDamage(damageAmount)
end

return MonsterServer