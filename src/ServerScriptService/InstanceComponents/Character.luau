local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)

local HolyGrailComponent = require(script.Parent.HolyGrail)

local CharacterServer = Component.new({
    Tag = "Character",
    Ancestors = {workspace},
})

function CharacterServer:Start()
    self.Humanoid = self.Instance:WaitForChild("Humanoid")

    -- Bind Tags
    CollectionService:AddTag(self.Instance, "PunchingCharacter")
end

function CharacterServer:Damage(damage)
    self.Humanoid:TakeDamage(damage)
end

function CharacterServer:HeartbeatUpdate(dt)
    if not self.Humanoid then return end

    local rootPart = self.Humanoid.RootPart
    if not rootPart then return end

    for _, holyGrail in HolyGrailComponent:GetAll() do
        local distance = (rootPart.Position - holyGrail.Instance.Position).Magnitude

        if distance < 3 then
            holyGrail:Collect()
        end
    end
end

return CharacterServer