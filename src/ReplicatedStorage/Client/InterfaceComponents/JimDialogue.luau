local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Fusion = require(Packages.Fusion)

local New = Fusion.New

local function JimDialogue(props)
    return New "TextLabel" {
        Visible = props.Visible,
        Size = UDim2.fromScale(0.75, 0.22),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Name = "JimDialogue",
        Text = props.Text,
    }
end

return JimDialogue