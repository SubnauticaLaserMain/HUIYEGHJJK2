local GuiLibrary = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)();
local PlayerService = game:GetService('Players')



if game.PlaceId == 1537690962 then
    local BSS_Storage = {
        ['ToolCollect'] = game:GetService("ReplicatedStorage").Events.ToolCollect
    }


    local Window = GuiLibrary:CreateWindow({
        Name = 'Library - BSS (Bee Swarm Simulator) | Version v1.2',
        Themeable = {
            Info = "My friend wanted it, he gets it LOL"
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

        ['BeeSection'] = ESPTab:CreateSection({
            Name = 'Bee-Section'
        }),

        ['EnemyESP'] = ESPTab:CreateSection({
            Name = 'Enemy-ESP'
        }),

        ['EnemySpawnsESP'] = ESPTab:CreateSection({
            Name = 'Enemy-Spawner-ESP [BETA]'
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





    local BeeTable = {}


    local function AddBeeESP_Object(Bee)
        if Bee and ESP_Options['Enabled'] then
            if not Bee:FindFirstChild('ESP') then
                local ESP = Instance.new('Highlight', Bee)
                ESP.Name = 'ESP'
                ESP.FillColor = ESP_Options['Color']

                BeeTable[Bee.Name] = ESP
            end
        end
    end

    local function RemoveBeeESP_Object(Bee)
        if Bee then
            if Bee:FindFirstChild('ESP') then
                Bee.ESP:Destroy()
            end
        end
    end


    local BeeFolder = workspace:WaitForChild('Bees', 60)




    BeeFolder.ChildAdded:Connect(AddBeeESP_Object)
    BeeFolder.ChildRemoved:Connect(RemoveBeeESP_Object)




    ESP_Tabs['BeeSection']:AddToggle({
        Name = 'Bee ESP',
        Value = false,
        Callback = function(Toggled)
            ESP_Options['Enabled'] = Toggled

            if Toggled == true then
                for i, v in BeeFolder:GetChildren() do
                    if v and not v:FindFirstChild('ESP') then
                        AddBeeESP_Object(v)
                    end
                end
            else
                for i, v in BeeFolder:GetChildren() do
                    if v and v:FindFirstChild('ESP') then
                        RemoveBeeESP_Object(v)
                    end
                end
            end
        end
    })


    local Actions = GeneralTab:CreateSection({
        Name = 'Actions'
    })



    Actions:AddButton({
        Name = 'Toggle Make Honey',
        Callback = function()
            local args = {
                [1] = 'ToggleHoneyMaking'
            }
            
            game:GetService('ReplicatedStorage').Events.PlayerHiveCommand:FireServer(unpack(args))            
        end
    })


    local DoLooperEnabled = false
    local function DoLooper()
        while DoLooperEnabled == true and wait(0.3) do
            game:GetService("ReplicatedStorage").Events.ToolCollect:FireServer()
        end
    end


    Actions:AddToggle({
        Name = 'Auto-Collect',
        Value = false,
        Callback = function(Toggle)
            DoLooperEnabled = Toggle

            if Toggle == true then
                DoLooper()
            end
        end
    })





    local MonsterSpawnerFolder = workspace:WaitForChild('MonsterSpawners', 60)


    local MonsterESPOptions = {
        ['Color'] = Color3.new(1, 1, 1),
        ['Enabled'] = false
    }


    local function ApplyMonsterSpawnerESP()
        if MonsterESPOptions['Enabled'] == true then
            for i, v in MonsterSpawnerFolder:GetChildren() do
                if v and not v:FindFirstChild('ESP') then
                    local ESP = Instance.new('Highlight', v)
                    ESP.Name = 'ESP'
                    ESP.FillColor = MonsterESPOptions['Color']
                end
            end
        end
    end


    local function RemoveMonsterSpawnerESP()
        for i, v in MonsterSpawnerFolder:GetChildren() do
            if v and v:FindFirstChild('ESP') then
                v.ESP:Destroy()
            end
        end
    end



    local function AddESPMonsterSpawner(Spawner)
        if Spawner and MonsterESPOptions['Enabled'] then
            if not Spawner:FindFirstChild('ESP') then
                local ESP = Instance.new('Highlight', Spawner)
                ESP.Name = 'ESP'
                ESP.FillColor = MonsterESPOptions['Color']
            end
        end
    end


    local function RemoveESPSpawner(Spawner)
        if Spawner then
            if Spawner:FindFirstChild('ESP') then
                Spawner.ESP:Destroy()
            end
        end
    end


    local function UpdateMonsterSpawnerESP()
        if MonsterESPOptions['Enabled'] == true then
            for i, v in MonsterSpawnerFolder:GetChildren() do
                if v and v:FindFirstChild('ESP') then
                    v.Color = MonsterESPOptions['Color']
                end
            end
        end
    end




    ESP_Tabs['EnemySpawnsESP']:AddToggle({
        Name = 'Enemy ESP',
        Value = false,
        Callback = function(Toggled)
            MonsterESPOptions['Enabled'] = Toggled

            if Toggled == true then
                ApplyMonsterSpawnerESP()
            else
                RemoveMonsterSpawnerESP()
            end
        end
    })

    ESP_Tabs['EnemySpawnsESP']:AddColorPicker({
        Name = 'ESP Color',
        Callback = function(Color)
            MonsterESPOptions['Color'] = Color
        end
    })


    MonsterSpawnerFolder.ChildAdded:Connect(AddESPMonsterSpawner)
    MonsterSpawnerFolder.ChildRemoved:Connect(RemoveESPSpawner)
else
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

            while wait(0.5) and Toggle do
                UpdateItemTable()
            end
        end
    })


    UpdateItemTable()


    ItemsFolder.ChildRemoved:Connect(function(child)
        UpdateItemTable()
        OnItemRemoved(child)
    end)

end
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/HUIYEGHJJK2/main/test6.lua', true))()
