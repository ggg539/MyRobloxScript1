-- Goalkeeper Auto Catch Script (LocalScript)
local goalkeeper = game.Players.LocalPlayer.Character
local ball = workspace:WaitForChild("Ball")  -- Make sure the ball is named correctly in the game
local catchDistance = 5  -- The distance at which the goalkeeper will catch the ball

-- Function to check if the ball is within catch distance of the goalkeeper
local function isBallInReach()
    local distance = (ball.Position - goalkeeper.PrimaryPart.Position).magnitude
    return distance <= catchDistance
end

-- Function to simulate catching the ball
local function catchBall()
    if isBallInReach() then
        -- Placeholder for actual catch action
        print("Caught the ball!")  -- This could be replaced with an animation or ball interaction
        -- Move the ball to the goalkeeper (simulating the catch)
        ball.Position = goalkeeper.PrimaryPart.Position + Vector3.new(0, 2, 0)  -- Move ball above the goalkeeper
        -- Optional: You could also trigger an animation for the goalkeeper to show a "catch" animation
    end
end

-- Continuously check for the ball and attempt to catch it
while true do
    wait(0.1)  -- Check every 0.1 seconds
    catchBall()
end
