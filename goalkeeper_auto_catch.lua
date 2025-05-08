-- New example script written by wally
-- You can suggest changes with a pull request or something

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

-- Function to toggle the Auto GK
local function toggleAutoGK()
    if autoGKActive then
        print("Auto GK turned OFF")
        -- Add code here to disable auto GK catching
    else
        print("Auto GK turned ON")
        -- Add code here to enable auto GK catching
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

-- Add more UI elements here...

-- Add buttons, sliders, etc., as needed for your menu...
