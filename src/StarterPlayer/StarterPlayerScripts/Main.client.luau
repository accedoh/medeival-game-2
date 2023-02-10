local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Fusion = require(Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value

local ValueDisplay = require(ReplicatedStorage.Client.ValueDisplay)

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