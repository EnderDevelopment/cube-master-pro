-- RubiksCubeClient.client.lua

-- Client script for handling player interactions with the Rubik's Cube

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Get the local player
local player = Players.LocalPlayer

-- Get the RemoteEvent for player interactions
local remoteEvent = ReplicatedStorage:WaitForChild("RubiksCubeEvent")

-- Function to handle player interactions with the Rubik's Cube
local function onPlayerInteraction(part, face)
    -- Fire the RemoteEvent to notify the server of the player's interaction
    remoteEvent:FireServer(part, face)
end

-- Connect the player interaction function to the player's input
player:GetMouse().Button1Down:Connect(function()
    local mouse = player:GetMouse()
    local target = mouse.Target
    local face = mouse.TargetSurface
    
    -- Check if the player clicked on a cube piece
    if target and target.Name == "CubePiece" then
        onPlayerInteraction(target, face)
    end
end)
