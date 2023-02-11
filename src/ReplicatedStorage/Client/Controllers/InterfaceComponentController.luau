local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Fusion = require(Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local Children = Fusion.Children

local InterfaceComponentService = nil

local ValueDisplay = require(ReplicatedStorage.Client.InterfaceComponents.ValueDisplay)
local JimDialogue = require(ReplicatedStorage.Client.InterfaceComponents.JimDialogue)

local InterfaceComponentController = Knit.CreateController {
    Name = "InterfaceComponentController",
}

function InterfaceComponentController:KnitInit()
    -- Cookie Display
    self.Cookies = Value(0)

    -- Jim Dialogue
    self.JimDialogueEnabled = Value(false)
    self.AreHolyGrailsCollected = Value(false)
    self.AreMonstersAlive = Value(false)

    -- Knit Services
    InterfaceComponentService = Knit.GetService("InterfaceComponentService")
end

function InterfaceComponentController:KnitStart()
    self.CookieDisplay = ValueDisplay {
        HeaderText = Value("Cookies: "),
        Value = self.Cookies,
    }

    self.JimDialogue = JimDialogue {
        Visible = self.JimDialogueEnabled,
        
        Text = Computed(function()
            if self.AreMonstersAlive:get() then
                return "Hello, I'm Jim! You should go kill that monster and retrieve the holy grail!"
            end
          
            if self.AreHolyGrailsCollected:get() then
                return "Thank you for collecting the holy grail! I will now give you ...  a cookie!"
            else
                return "Bring me back the holy grail in exchange for a prize. I await your return"
            end
        end)
    }

    self.UI = New "ScreenGui" {
        Name = "GameUI",
        
        [Children] = {
            self.CookieDisplay,
            self.JimDialogue,
        },
        
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
    }

    InterfaceComponentService.StateUpdated:Connect(function(stateName, stateValue)
        self[stateName]:set(stateValue)
    end)

    InterfaceComponentService:RequestInitialStateSync()
end

return InterfaceComponentController