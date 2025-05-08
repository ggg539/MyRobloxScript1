local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

-- Global variable to store whether the AutoGK is active or not
local autoGKActive = false

-- Example: Basic AutoGK Logic
local goalkeeper = game.Workspace.Goalkeeper -- Replace with the actual goalkeeper object
local ball = game.Workspace.Ball -- Replace with the actual ball object

-- Label to display the AutoGK status
local statusLabel = LeftGroupBox:AddLabel("Auto GK Status: OFF")

-- Function to update the status text on the UI
local function updateStatusText(status)
    statusLabel:SetText("Auto GK Status: " .. status)
end

local function enableAutoGK()
    print("Auto GK is enabled!")
    -- Example logic to make the goalkeeper follow or catch the ball
    -- Make the goalkeeper move towards the ball (simplified)
    while autoGKActive do
        if ball and goalkeeper then
            goalkeeper:MoveTo(ball.Position) -- Make goalkeeper move to ball's position
        end
        wait(0.1) -- Adjust wait time for smoother movement
    end
end

local function disableAutoGK()
    print("Auto GK is disabled!")
    -- Stop the goalkeeper's movement or reset its state
    if goalkeeper then
        -- You may need to add specific code here to stop the goalkeeper's movement
        -- This depends on how the goalkeeper's movement is controlled in your game
    end
end

-- Function to toggle the Auto GK state
local function toggleAutoGK()
    if autoGKActive then
        print("Auto GK turned OFF")
        disableAutoGK()
        updateStatusText("OFF")
    else
        print("Auto GK turned ON")
        enableAutoGK()
        updateStatusText("ON")
    end
    autoGKActive = not autoGKActive  -- Toggle the state
end

-- Add a toggle to the UI for auto GK
LeftGroupBox:AddToggle('AutoGKToggle', {
    Text = 'Enable Auto GK',
    Default = false,  -- Initial state is off
    Tooltip = 'Enable or disable automatic goalkeeper catching',
    Callback = function(value)
        if value then
            toggleAutoGK()  -- Turn on auto GK if toggle is true
        else
            toggleAutoGK()  -- Turn off auto GK if toggle is false
        end
    end
})

-- You can add more UI elements as needed for the menu...
