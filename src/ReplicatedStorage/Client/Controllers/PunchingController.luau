local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local PunchingCharacterComponent = require(ReplicatedStorage.Client.InstanceComponents.PunchingCharacter)

local PunchingController = Knit.CreateController {
    Name = "PunchingController",
}

function PunchingController:KnitStart()
    RunService:BindToRenderStep("PunchingController", Enum.RenderPriority.Last.Value, function()
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
            local character = Players.LocalPlayer.Character
            if not character then return end

            local punchingCharacter = PunchingCharacterComponent:FromInstance(character)
            if not punchingCharacter then return end

            punchingCharacter:Punch()
        end
    end)
end

return PunchingController