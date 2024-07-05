local GuiLibrary = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)();
local PlayerService = game:GetService('Players')


local Window = GuiLibrary:CreateWindow({
    Name = 'Library - Piggy | Version v1.1',
    Themeable = {
        Info = "Discord Server: VzYTJ7Y"
    }
})


local GeneralTab = Window:CreateTab({
    Name = 'Main'
})


local ESPTab = Window:CreateTab({
    Name = 'ESP-Tab'
})

local ESP_Tabs = {
    ['EntitySection'] = ESPTab:CreateSection({
        Name = 'Entity-Section'
    }),

    ['PlayerSection'] = ESPTab:CreateSection({
        Name = 'Player-Section'
    })
}


local ESP_Player_Default_Options = {
    ['Color'] = Color3.new(1, 1, 1),
    ['Enabled'] = false
}





local ESP_Options = {
    ['Enabled'] = false,
    ['Color'] = ESP_Player_Default_Options['Color']
}





local ESP_Table_Players = {}

local function ESP_Script()
    local Players = PlayerService:GetPlayers()


    for i, v in pairs(Players) do
        if v ~= PlayerService.LocalPlayer then
            local Character = v.Character or v.CharacterAdded:Wait()

            if Character and not Character:FindFirstChild('ESP') then
                local ESP = Instance.new('Highlight', Character)
                ESP.Name = 'ESP'
                ESP.FillColor = ESP_Options['Color']

                ESP_Table_Players[v.Name] = ESP
            end
        end
    end
end



local function RemoveAllESP()
    local Players = PlayerService:GetPlayers()


    for i, v in pairs(Players) do
        if v ~= PlayerService.LocalPlayer then
            local Character = v.Character and v.CharacterAdded:Wait()

            if Character and Character:FindFirstChild('ESP') then
                local ESP = Character:FindFirstChild('ESP')

                ESP:Destroy()
                ESP_Table_Players[v.Name] = nil
            end
        end
    end
end




local function AddESP_Player(Player: Player)
    if Player and Player.ClassName == 'Player' and Player ~= PlayerService.LocalPlayer then
        local Character = Player.Character or Player.CharacterAdded:Wait()

        if Character and not Character:FindFirstChild('ESP') then
            local ESP = Instance.new('Highlight', Character)
            ESP.Name = 'ESP'
            ESP.FillColor = ESP_Options['Color']

            ESP_Table_Players[Player.Name] = ESP
        end
    end
end


local function RemoveESP_Player(Player: Player)
    if Player and Player.ClassName == 'Player' and Player ~= PlayerService.LocalPlayer then
        local Character = Player.Character or Player.CharacterAdded:Wait()

        if Character and Character:FindFirstChild('ESP') then
            Character:FindFirstChild('ESP'):Destroy()

            ESP_Table_Players[Player.Name] = nil
        end
    end
end





PlayerService.PlayerAdded:Connect(AddESP_Player)
PlayerService.PlayerRemoving:Connect(RemoveESP_Player)



local function ToggleESP(bool)
    if bool == true then
        ESP_Script()
    else
        RemoveAllESP()
    end
end




local PlayerESPToggle = ESP_Tabs['PlayerSection']:AddToggle({
    Name = 'ESP Toggle',
    Flag = 'ESP-Toggle-Player-Section',
    Enabled = ESP_Player_Default_Options['Enabled'],
    Callback = function(NewValue)
        ToggleESP(NewValue)
        ESP_Options['Enabled'] = NewValue
    end
})


local PlayerESP_ColorPicker_ESPColor = ESP_Tabs['PlayerSection']:AddColorPicker({
    Name = 'ESP Color',
    Value = ESP_Player_Default_Options['Color'],
    Flag = 'ESP-Color-Body-Picker',
    Callback = function(Color)
        ESP_Options['Color'] = Color
    end
})



-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/HUIYEGHJJK2/main/test5.lua', true))()
