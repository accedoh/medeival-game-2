local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Loader = require(Packages.Loader)
local Knit = require(Packages.Knit)

-- Load Controllers
Loader.LoadChildren(ServerScriptService.Source.Services)

-- Load Knit
Knit.Start():await()

-- Load Components
Loader.LoadChildren(ServerScriptService.Source.InstanceComponents)