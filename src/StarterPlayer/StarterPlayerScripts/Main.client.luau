local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Fusion = require(Packages.Fusion)
local Knit = require(Packages.Knit)

local New = Fusion.New
local Value = Fusion.Value

local ValueDisplay = require(ReplicatedStorage.Client.InterfaceComponents.ValueDisplay)

local Children = Fusion.Children

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local playerCookies = Value(0)

New "ScreenGui" {
    Name = "GameUI",

    [Children] = {
        ValueDisplay {
            Name = "CookieDisplay",
            HeaderText = Value("Cookies: "), -- TODO: change when 'use' is implemented
            Value = playerCookies,
        },
    },

    Parent = PlayerGui,
}

-- Load Controllers
local _PunchingController = require(ReplicatedStorage.Client.Controllers.PunchingController)

-- Load Knit
Knit.Start():await()

-- Load Components
local _PunchingCharacterComponent = require(ReplicatedStorage.Client.InstanceComponents.PunchingCharacter)