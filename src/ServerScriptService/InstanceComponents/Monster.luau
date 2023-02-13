local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local CharacterComponent = require(script.Parent.Character)

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

function MonsterServer:GetTarget()
    local monsterPosition = self.Instance:GetPivot().Position

    local closestCharacter = nil
    local closestDistance = math.huge

    for _, character in CharacterComponent:GetAll() do
        local characterPosition = character.Instance:GetPivot().Position

        local distance = (characterPosition - monsterPosition).Magnitude

        if distance < closestDistance then
            closestCharacter = character
            closestDistance = distance
        end
    end

    local target = {
        Character = closestCharacter,
        Distance = closestDistance,
    }

    return target
end

function MonsterServer:HeartbeatUpdate(deltaTime)
    local target = self:GetTarget()

    if not target.Character then
        print("Monster has no target")
        return 
    end

    if target.Distance > 30 then
        return
    end

    self.Humanoid:MoveTo(target.Character.Instance:GetPivot().Position)

    if target.Distance < 4 then
        target.Character:Damage(10 * deltaTime)
    end
end

function MonsterServer:Damage(damageAmount)
    self.Humanoid:TakeDamage(damageAmount)
end

return MonsterServer