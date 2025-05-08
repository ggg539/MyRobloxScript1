-- URL of the external script you want to load (your script from GitHub)
local repo = 'https://raw.githubusercontent.com/ggg539/MyRobloxScript1/main/goalkeeper_auto_catch.lua'

-- Function to load and execute the external script from GitHub
local function loadExternalScript()
    print("Fetching external script from GitHub...")
    local success, scriptCode = pcall(function() 
        return game:HttpGet(repo)
    end)
    
    if success then
        print("Script fetched. Running the script...")
        loadstring(scriptCode)()  -- Execute the fetched code
    else
        warn("Failed to fetch script: " .. scriptCode)
    end
end

-- Function to enable AutoGK when triggered (using your UI from earlier)
local function setupAutoGKMenu()
    print("Setting up AutoGK Menu...")
    
    -- Ensure the player and character are loaded before accessing them
    local player = game.Players.LocalPlayer
    if not player then
        warn("LocalPlayer not found!")
        return
    end
    
    local character = player.Character or player.CharacterAdded:Wait()
    if not character then
        warn("Character not found!")
        return
    end

    -- Create a UI window for the AutoGK settings
    local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua'))()

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
end

-- Ensure the script is running properly in the public server
print("Script starting...")
loadExternalScript()
setupAutoGKMenu()
print("Script execution complete!")
