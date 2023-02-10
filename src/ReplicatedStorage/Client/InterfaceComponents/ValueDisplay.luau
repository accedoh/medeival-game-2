local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Fusion = require(Packages.Fusion)

local New = Fusion.New
local Computed = Fusion.Computed

local function ValueDisplay(props)
    return New "TextLabel" {
        Name = props.Name,
        FontFace = Font.fromEnum(Enum.Font.SourceSans),
        TextColor3 = Color3.fromRGB(222, 169, 156),
        TextScaled = true,
        TextSize = 14,
        TextStrokeTransparency = 0,
        TextWrapped = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.fromScale(0.5, 0.95),
        Size = UDim2.fromScale(0.15, 0.05),

        Text = Computed(function()
            return props.HeaderText:get() .. props.Value:get() -- TODO: change when 'use' is implemented
        end)
    }
end

return ValueDisplay