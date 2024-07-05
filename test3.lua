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
    }),

    ['ItemSection'] = ESPTab:CreateSection({
        Name = 'Item-Section'
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
            local Character = v.Character or v.CharacterAdded:Wait()

            if Character and Character:FindFirstChild('ESP') then
                local ESP = Character.ESP;

                ESP:Destroy()

                print('Removing ESP Object from: ' .. tostring(Character:GetFullName()))
                

                ESP_Table_Players[v.Name] = nil
            end
        end
    end
end




local function AddESP_Player(Player: Player)
    if ESP_Options['Enabled'] == true then
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




local function UpdateESP_ObjectPlayer()
    local Players = PlayerService:GetPlayers()


    for i, v in pairs(Players) do
        if v ~= PlayerService.LocalPlayer then
            local Character = v.Character or v.CharacterAdded:Wait()

            if Character and Character:FindFirstChild('ESP') then
                local ESP = Character.ESP;
                ESP.FillColor = ESP_Options['Color']

            end
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
        UpdateESP_ObjectPlayer()
    end
})


local ItemsFolder = (function()
    local Location = workspace;
    local Trash = {'GameFolder', 'LoadedMap', 'PiggyNPC'}
    local Type = 'Folder'

    for i, v in Location:GetChildren() do
        if v.ClassName == Type and not table.find(Trash, v.Name) then
            return v
        end
    end
end)()


local Items = {}


local IsEnabled = false

local function OnItemAdded(Item)
    if Item and IsEnabled == true then
        if Item:FindFirstChild('ItemPickupScript') and Item:FindFirstChild('ClickDetector') then
            local ESP = Instance.new('Highlight', Item)
            ESP.Name = 'ESP'
            ESP.FillColor = Color3.fromHex(Item.Color:ToHex())        
        end
    end
end

local function OnItemRemoved(Item)
    if Item then
        if Item:FindFirstChild('ItemPickupScript') and Item:FindFirstChild('ClickDetector') then
            if Item:FindFirstChild('ESP') then
                Item.ESP:Destroy()
            end
        end
    end
end

local function ApplyToAll()
    for i, v in pairs(Items) do
        if v and v:FindFirstChild('ItemPickupScript') and v:FindFirstChild('ClickDetector') then
            if not v:FindFirstChild('ESP') then
                local ESP = Instance.new('Highlight', v)
                ESP.Name = 'ESP'
                ESP.FillColor = Color3.fromHex(v.Color:ToHex())
                print('Applying ESP to item Name: ' .. tostring(v.Name))
            end
        end
    end
end

local function RemoveToAll()
    for i, v in pairs(Items) do
        if v and v:FindFirstChild('ItemPickupScript') and v:FindFirstChild('ClickDetector') then
            if v:FindFirstChild('ESP') then
                v.ESP:Destroy()
            end
        end
    end
end



local function ToggleItemESP(Toggled)
    if Toggled == true then
        ApplyToAll()
    else
        RemoveToAll()
    end
end



local function UpdateItemTable()
    Items = {}

    for i, v in ItemsFolder:GetChildren() do
        if v and v:FindFirstChild('ItemPickupScript') and v:FindFirstChild('ClickDetector') then
            Items[v.Name] = v
        end
    end
end




ESP_Tabs['ItemSection']:AddToggle({
    Name = 'Item ESP',
    Flag = 'Item-ESP-Body-Enabled-Toggle',
    Callback = function(Toggle)    
        UpdateItemTable()
        IsEnabled = Toggle
        ToggleItemESP(IsEnabled)
    end
})


UpdateItemTable()


ItemsFolder.ChildAdded:Connect(function(child)
    UpdateItemTable()
    OnItemAdded(child)
    print('Item added: ' .. tostring(child.Name) .. ' {HasESP: ' .. tostring(child:FindFirstChild('ESP')) .. '}')
end)
ItemsFolder.ChildRemoved:Connect(function(child)
    UpdateItemTable()
    OnItemRemoved(child)
end)


-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/HUIYEGHJJK2/main/test2.lua', true))()
