local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Loader = require(Packages.Loader)
local Knit = require(Packages.Knit)

-- Load Controllers
Loader.LoadChildren(ReplicatedStorage.Client.Controllers)

-- Load Knit
Knit.Start():await()

-- Load Components
Loader.LoadChildren(ReplicatedStorage.Client.InstanceComponents)