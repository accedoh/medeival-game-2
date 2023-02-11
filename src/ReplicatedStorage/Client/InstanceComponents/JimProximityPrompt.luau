local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Component = require(Packages.Component)
local Signal = require(Packages.Signal)

local JimProximityPromptClient = Component.new({
    Tag = "JimProximityPrompt",
    Ancestors = {workspace},
})

function JimProximityPromptClient:Construct()
    -- Create Proximity Prompt
    self._proximityPrompt = Instance.new("ProximityPrompt")
    self._proximityPrompt.ObjectText = "Jim"
    self._proximityPrompt.ActionText = "<PLACEHOLDER>"
    self._proximityPrompt.Parent = self.Instance

    -- Signal
    self.Triggered = Signal.new()
end

function JimProximityPromptClient:Start()
    self._proximityPrompt.Triggered:Connect(function()
        self.Triggered:Fire()
    end)
end

function JimProximityPromptClient:Stop()
    self._proximityPrompt:Destroy()
end

return JimProximityPromptClient