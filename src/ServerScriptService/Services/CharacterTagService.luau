local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local CharacterTagService = Knit.CreateService({
    Name = "CharacterTagService",
    Client = {}
})

function CharacterTagService:KnitInit()
    self.CharacterConnections = {}
end

function CharacterTagService:HandleCharacterAdded(character)
    CollectionService:AddTag(character, "Character")
end

function CharacterTagService:HandlePlayerAdded(player)
    self.CharacterConnections[player] = player.CharacterAdded:Connect(function(character)
        self:HandleCharacterAdded(character)
    end)

    if player.Character then
        self:HandleCharacterAdded(player.Character)
    end
end

function CharacterTagService:HandlePlayerRemoved(player)
    if self.CharacterConnections[player] then
        self.CharacterConnections[player]:Disconnect()
        self.CharacterConnections[player] = nil
    end
end

function CharacterTagService:KnitStart()
    Players.PlayerAdded:Connect(function(player)
        self:HandlePlayerAdded(player)
    end)
end

return CharacterTagService