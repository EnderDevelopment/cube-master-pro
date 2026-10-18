-- RubiksCubeGame.server.lua

-- Main script for the Rubik's Cube game with enhanced features

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Function to create a new Rubik's Cube
local function createRubiksCube(player)
    -- Create a new model for the Rubik's Cube
    local cubeModel = Instance.new("Model")
    cubeModel.Name = "RubiksCube"
    cubeModel.Parent = workspace

    -- Create the individual cube pieces
    for x = -1, 1 do
        for y = -1, 1 do
            for z = -1, 1 do
                local cubePiece = Instance.new("Part")
                cubePiece.Name = "CubePiece"
                cubePiece.Size = Vector3.new(1, 1, 1)
                cubePiece.Position = Vector3.new(x, y, z)
                cubePiece.Anchored = true
                cubePiece.Parent = cubeModel

                -- Assign a color to each face of the cube piece
                local colors = {
                    Color3.new(1, 0, 0), -- Red
                    Color3.new(0, 1, 0), -- Green
                    Color3.new(0, 0, 1), -- Blue
                    Color3.new(1, 1, 0), -- Yellow
                    Color3.new(1, 0.5, 0), -- Orange
                    Color3.new(1, 1, 1) -- White
                }

                -- Apply colors to each face of the cube piece
                for i, color in ipairs(colors) do
                    local face = Instance.new("Decal")
                    face.Name = "Face" .. i
                    face.Face = Enum.NormalId[i]
                    face.Color3 = color
                    face.Parent = cubePiece
                end
            end
        end
    end

    -- Create a RemoteEvent for player interactions
    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "RubiksCubeEvent"
    remoteEvent.Parent = ReplicatedStorage

    -- Function to handle player interactions
    local function onPlayerInteraction(player, part, face)
        -- Rotate the cube piece based on the player's interaction
        if part and part.Name == "CubePiece" then
            local rotationAxis = Vector3.new(0, 0, 0)
            if face == Enum.NormalId.Front then
                rotationAxis = Vector3.new(0, 1, 0)
            elseif face == Enum.NormalId.Back then
                rotationAxis = Vector3.new(0, -1, 0)
            elseif face == Enum.NormalId.Right then
                rotationAxis = Vector3.new(1, 0, 0)
            elseif face == Enum.NormalId.Left then
                rotationAxis = Vector3.new(-1, 0, 0)
            elseif face == Enum.NormalId.Top then
                rotationAxis = Vector3.new(0, 0, 1)
            elseif face == Enum.NormalId.Bottom then
                rotationAxis = Vector3.new(0, 0, -1)
            end

            -- Rotate the cube piece
            part:Rotate(rotationAxis, 90)
        end
    end

    -- Connect the RemoteEvent to the player interaction function
    remoteEvent.OnServerEvent:Connect(onPlayerInteraction)

    -- Create a hint for the player
    local hint = Instance.new("Hint")
    hint.Name = "RubiksCubeHint"
    hint.Text = "Use the RemoteEvent to interact with the Rubik's Cube!"
    hint.Parent = player.PlayerGui
end

-- Function to handle player joining
local function onPlayerAdded(player)
    -- Create a new Rubik's Cube for the player
    createRubiksCube(player)
end

-- Connect the player joining function to the Players service
Players.PlayerAdded:Connect(onPlayerAdded)
