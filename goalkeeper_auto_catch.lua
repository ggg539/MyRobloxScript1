local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'AutoGK Menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Auto Goalkeeper')

local autoGKActive = false
local statusLabel = LeftGroupBox:AddLabel("Auto GK Status: OFF")

local function updateStatusText(status)
    statusLabel:SetText("Auto GK Status: " .. status)
end

-- Settings
local REACH_RADIUS = 10  -- Adjustable reach radius for catching the ball
local CHECK_INTERVAL = 0.5  -- Reduced check interval for performance optimization

local function findBall()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("ball") then
            return obj
        end
    end
end

local function findGoalkeeper()
    local player = game.Players.LocalPlayer
    if not player then return nil end
    local character = player.Character or player.CharacterAdded:Wait()
    return character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
end

local function simulateCatch()
    -- Simulate the action when the ball is within reach
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- Example: triggering an animation for catching (this can be customized further)
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://ANIMATION_ASSET_ID"  -- Replace with your animation ID
        humanoid:LoadAnimation(animation):Play()
    end

    print("AutoGK: Ball is within reach - attempt catch!")
end

local function enableAutoGK()
    print("Auto GK enabled")
    while autoGKActive do
        local ball = findBall()
        local goalkeeper = findGoalkeeper()
        
        if ball and goalkeeper then
            local distance = (ball.Position - goalkeeper.Position).Magnitude
            if distance <= REACH_RADIUS then
                simulateCatch()  -- Simulate the goalkeeper action if the ball is in range
            end
        else
            print("AutoGK: Ball or Goalkeeper not found.")
        end
        
        task.wait(CHECK_INTERVAL)  -- Checking every 0.5 seconds for better performance
    end
end

local function disableAutoGK()
    print("Auto GK disabled")
end

local function toggleAutoGK()
    autoGKActive = not autoGKActive
    if autoGKActive then
        enableAutoGK()
        updateStatusText("ON")
    else
        disableAutoGK()
        updateStatusText("OFF")
    end
end

LeftGroupBox:AddToggle('AutoGKToggle', {
    Text = 'Enable Auto GK',
    Default = false,
    Tooltip = 'Toggle automatic goalkeeper reach simulation',
    Callback = function(value)
        toggleAutoGK()
    end
})
