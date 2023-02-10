local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Fusion = require(Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children

local ValueDisplay = require(ReplicatedStorage.Client.InterfaceComponents.ValueDisplay)
local JimDialogue = require(ReplicatedStorage.Client.InterfaceComponents.JimDialogue)

local InterfaceComponentController = Knit.CreateController {
    Name = "InterfaceComponentController",
}

function InterfaceComponentController:KnitInit()
    self.Cookies = Value(0)
    self.JimDialogueEnabled = Value(false)
    self.JimDialogueText = Value("Hello, I'm jim!")
end

function InterfaceComponentController:KnitStart()
    self.CookieDisplay = ValueDisplay {
        HeaderText = Value("Cookies: "),
        Value = self.Cookies,
    }

    self.JimDialogue = JimDialogue {
        Visible = self.JimDialogueEnabled,
        Text = self.JimDialogueText,
    }

    self.UI = New "ScreenGui" {
        Name = "GameUI",
        
        [Children] = {
            self.CookieDisplay,
            self.JimDialogue,
        },
        
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
    }
end

return InterfaceComponentController