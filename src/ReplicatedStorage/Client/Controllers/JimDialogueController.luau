local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)

local JimProximityPromptComponent = require(ReplicatedStorage.Client.InstanceComponents.JimProximityPrompt)

local JimDialogueController = Knit.CreateController {
    Name = "JimDialogueController",
}

-- Knit Imports
local InterfaceComponentController = nil

function JimDialogueController:KnitInit()
    InterfaceComponentController = Knit.GetController("InterfaceComponentController")
end

function JimDialogueController:OpenDialogue()
    InterfaceComponentController.JimDialogueEnabled:set(true)

    task.delay(4, function()
        self:CloseDialogue()
    end)
end

function JimDialogueController:CloseDialogue()
    InterfaceComponentController.JimDialogueEnabled:set(false)
end

function JimDialogueController:SetDialogue(text)
    InterfaceComponentController.JimDialogueText:set(text)
end

function JimDialogueController:KnitStart()
    JimProximityPromptComponent.Started:Connect(function(component)
        component.Triggered:Connect(function()
            self:OpenDialogue()
        end)
    end)
end

function JimDialogueController:RenderSteppedUpdate()

end

return JimDialogueController