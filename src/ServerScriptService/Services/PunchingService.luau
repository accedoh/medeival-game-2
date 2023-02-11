local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local MonsterComponent = require(ServerScriptService.Source.InstanceComponents.Monster)
local CharacterComponent = require(ServerScriptService.Source.InstanceComponents.Character)

local PunchingService = Knit.CreateService {
    Name = "PunchingService",
    Client = {},
}

function PunchingService:GetHitComponents(hitParts, component)
    local visited = {}
    local hitComponents = {}

    for _, hitPart in hitParts do
        local instance = hitPart

        while instance do
            -- If we have already visited this instance, we can break out of the loop
            if visited[instance] then break end
            visited[instance] = true

            -- If the instance has the component, we can add it to the hitComponents table
            local hitComponent = component:FromInstance(instance)

            if hitComponent then
                hitComponents[hitComponent] = true
            end

            instance = instance.Parent
        end
    end

    return hitComponents
end

function PunchingService:CreateDebugPart(position)
    local debugPart = Instance.new("Part")
    debugPart.Anchored = true
    debugPart.CanCollide = false
    debugPart.Size = Vector3.new(4, 4, 4)
    debugPart.Shape = Enum.PartType.Ball
    debugPart.CFrame = CFrame.new(position)
    debugPart.Parent = workspace

    task.delay(3, function()
        debugPart:Destroy()
    end)
end

function PunchingService:Punch(character, component, damage)
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    local rootPart = humanoid.RootPart
    if not rootPart then return end

    local punchPosition = rootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, -4))

    self:CreateDebugPart(punchPosition)

    local hitParts = workspace:GetPartBoundsInRadius(punchPosition, 2)
    local hitComponents = self:GetHitComponents(hitParts, component)

    for hitComponent in hitComponents do
        hitComponent:Damage(damage)
    end
end

function PunchingService.Client:Punch(player, character)
    if CollectionService:HasTag(character, "Character") then
        self.Server:Punch(character, MonsterComponent, 10)
    end

    if CollectionService:HasTag(character, "Monster") then
        self.Server:Punch(character, CharacterComponent, 10)
    end
end

return PunchingService