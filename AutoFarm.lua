--[[
    SISTEMA DE FARM AUTOMÁTICO
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local AutoFarm = {}
local AntiBan = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/AntiBan.lua'))()

-- Configurações
AutoFarm.Settings = {
    Enabled = false,
    IsRunning = false,
    TargetLevel = 3000,
    CurrentLevel = 0,
    StartTime = 0,
    TotalXp = 0,
    TotalBeli = 0
}

-- Lista de ilhas por nível
AutoFarm.Islands = {
    -- Primeiro Mar (1-700)
    {Name = "Starter Island", MinLevel = 1, MaxLevel = 15, XpPerKill = 50},
    {Name = "Jungle", MinLevel = 15, MaxLevel = 60, XpPerKill = 80},
    {Name = "Pirate Village", MinLevel = 30, MaxLevel = 60, XpPerKill = 100},
    {Name = "Desert", MinLevel = 60, MaxLevel = 90, XpPerKill = 150},
    {Name = "Frozen Village", MinLevel = 90, MaxLevel = 120, XpPerKill = 200},
    {Name = "Marine Fortress", MinLevel = 120, MaxLevel = 150, XpPerKill = 250},
    {Name = "Skypiea", MinLevel = 150, MaxLevel = 200, XpPerKill = 300},
    {Name = "Prison", MinLevel = 190, MaxLevel = 275, XpPerKill = 400},
    {Name = "Colosseum", MinLevel = 225, MaxLevel = 300, XpPerKill = 500},
    {Name = "Magma Village", MinLevel = 300, MaxLevel = 375, XpPerKill = 600},
    {Name = "Underwater City", MinLevel = 375, MaxLevel = 450, XpPerKill = 700},
    {Name = "Fountain City", MinLevel = 625, MaxLevel = 700, XpPerKill = 800},
    
    -- Segundo Mar (700-1500)
    {Name = "Kingdom of Rose", MinLevel = 700, MaxLevel = 850, XpPerKill = 900},
    {Name = "Green Zone", MinLevel = 875, MaxLevel = 925, XpPerKill = 1000},
    {Name = "Graveyard", MinLevel = 950, MaxLevel = 975, XpPerKill = 1100},
    {Name = "Cursed Ship", MinLevel = 1000, MaxLevel = 1325, XpPerKill = 1200},
    {Name = "Ice Castle", MinLevel = 1350, MaxLevel = 1400, XpPerKill = 1300},
    {Name = "Forgotten Island", MinLevel = 1425, MaxLevel = 1475, XpPerKill = 1400},
    
    -- Terceiro Mar (1500-3000)
    {Name = "Port Town", MinLevel = 1500, MaxLevel = 1575, XpPerKill = 1500},
    {Name = "Hydra Island", MinLevel = 1575, MaxLevel = 1675, XpPerKill = 1600},
    {Name = "Great Tree", MinLevel = 1700, MaxLevel = 1750, XpPerKill = 1700},
    {Name = "Floating Turtle", MinLevel = 1775, MaxLevel = 2000, XpPerKill = 1800},
    {Name = "Haunted Castle", MinLevel = 1975, MaxLevel = 2075, XpPerKill = 1900},
    {Name = "Sea of Treats", MinLevel = 2075, MaxLevel = 2275, XpPerKill = 2000},
    {Name = "Easter Island", MinLevel = 2275, MaxLevel = 2475, XpPerKill = 2100},
    {Name = "Turtle Shell", MinLevel = 2475, MaxLevel = 2600, XpPerKill = 2200},
    {Name = "Mount Olympus", MinLevel = 2600, MaxLevel = 2800, XpPerKill = 2300},
    {Name = "Isle of Treats", MinLevel = 2800, MaxLevel = 3000, XpPerKill = 2500}
}

-- Encontra a melhor ilha para o nível atual
function AutoFarm.FindBestIsland()
    local player = game.Players.LocalPlayer
    local level = player.Level or player:GetAttribute("Level")
    
    if not level then
        print("[FARM] ⚠️ Não foi possível encontrar o nível do jogador")
        return nil
    end
    
    local bestIsland = nil
    local bestXp = 0
    
    for _, island in pairs(AutoFarm.Islands) do
        if level >= island.MinLevel and level <= island.MaxLevel then
            if island.XpPerKill > bestXp then
                bestXp = island.XpPerKill
                bestIsland = island
            end
        end
    end
    
    return bestIsland
end

-- Função para teleportar para ilha
function AutoFarm.TeleportToIsland(islandName)
    print("[FARM] 🚀 Teleportando para: " .. islandName)
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    if not character then
        print("[FARM] ⚠️ Personagem não encontrado")
        return false
    end
    
    -- Tenta encontrar a ilha no workspace
    local island = game.Workspace:FindFirstChild(islandName)
    if island and island:FindFirstChild("CFrame") then
        character.HumanoidRootPart.CFrame = island.CFrame + Vector3.new(0, 50, 0)
        task.wait(1)
        return true
    end
    
    -- Se não encontrar, tenta teleportar para a posição do spawn da ilha
    local spawns = game.Workspace:FindFirstChild("Spawns")
    if spawns then
        for _, spawn in pairs(spawns:GetChildren()) do
            if spawn.Name == islandName then
                character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 10, 0)
                task.wait(1)
                return true
            end
        end
    end
    
    print("[FARM] ⚠️ Não foi possível teleportar para: " .. islandName)
    return false
end

-- Função para farmar inimigos
function AutoFarm.FarmEnemies()
    local island = AutoFarm.FindBestIsland()
    if not island then
        print("[FARM] ⚠️ Nenhuma ilha disponível para seu nível")
        return false
    end
    
    print("[FARM] ⚔️ Farmando em: " .. island.Name)
    print("[FARM] ⚔️ XP por kill: " .. island.XpPerKill)
    
    AutoFarm.TeleportToIsland(island.Name)
    task.wait(2)
    
    local killed = 0
    local targetKills = 50
    
    while AutoFarm.Settings.IsRunning and killed < targetKills do
        -- Procura inimigos próximos
        local enemies = game.Workspace:FindFirstChild("Enemies")
        local enemy = nil
        
        if enemies then
            for _, child in pairs(enemies:GetChildren()) do
                if child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
                    local distance = (child.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 100 then
                        enemy = child
                        break
                    end
                end
            end
        end
        
        if enemy then
            -- Ataca o inimigo
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
            task.wait(0.1)
            
            -- Simula ataque
            mouse1click()
            task.wait(0.5)
            
            killed = killed + 1
            AutoFarm.Settings.TotalXp = AutoFarm.Settings.TotalXp + island.XpPerKill
            AutoFarm.Settings.TotalBeli = AutoFarm.Settings.TotalBeli + 100
            
            -- Anti-ban
            AntiBan.IncrementKill()
            AntiBan.DelayBetweenActions()
            AntiBan.SimulateHumanBehavior()
            
            if not AntiBan.CheckDanger() then
                AutoFarm.Stop()
                return false
            end
            
            local progress = (killed / targetKills) * 100
            print("[FARM] 📊 Progresso: " .. string.format("%.1f", progress) .. "% - Kills: " .. killed .. "/" .. targetKills)
        else
            print("[FARM] ⚠️ Nenhum inimigo encontrado, esperando...")
            task.wait(2)
        end
        
        -- Verifica se nivelou
        local player = game.Players.LocalPlayer
        local currentLevel = player.Level or player:GetAttribute("Level")
        
        if currentLevel and currentLevel > AutoFarm.Settings.CurrentLevel then
            AutoFarm.Settings.CurrentLevel = currentLevel
            print("[FARM] 🎉 Nível up! Nível: " .. currentLevel)
            
            local newIsland = AutoFarm.FindBestIsland()
            if newIsland and newIsland.Name ~= island.Name then
                print("[FARM] 🚀 Nova ilha disponível: " .. newIsland.Name)
                island = newIsland
                AutoFarm.TeleportToIsland(island.Name)
            end
        end
        
        if AutoFarm.Settings.CurrentLevel >= AutoFarm.Settings.TargetLevel then
            print("[FARM] 🎉 Nível máximo atingido!")
            AutoFarm.Stop()
            return true
        end
    end
    
    return true
end

-- Função para iniciar o farm
function AutoFarm.Start()
    if AutoFarm.Settings.IsRunning then
        print("[FARM] ⚠️ Farm já está em execução")
        return false
    end
    
    print("[FARM] 🚀 Iniciando farm...")
    AutoFarm.Settings.IsRunning = true
    
    local player = game.Players.LocalPlayer
    AutoFarm.Settings.CurrentLevel = player.Level or player:GetAttribute("Level") or 0
    AutoFarm.Settings.StartTime = os.time()
    AutoFarm.Settings.TotalXp = 0
    AutoFarm.Settings.TotalBeli = 0
    
    task.spawn(function()
        while AutoFarm.Settings.IsRunning do
            local success = AutoFarm.FarmEnemies()
            if not success then
                print("[FARM] ⚠️ Falha no farm, tentando novamente...")
                task.wait(5)
            end
        end
    end)
    
    return true
end

-- Função para parar o farm
function AutoFarm.Stop()
    if not AutoFarm.Settings.IsRunning then
        print("[FARM] ⚠️ Farm não está em execução")
        return false
    end
    
    print("[FARM] ⏹ Parando farm...")
    AutoFarm.Settings.IsRunning = false
    
    local elapsedTime = os.time() - AutoFarm.Settings.StartTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = elapsedTime % 60
    
    print("[FARM] 📊 Estatísticas:")
    print("  ⏱️ Tempo: " .. hours .. "h " .. minutes .. "m " .. seconds .. "s")
    print("  📈 XP Total: " .. AutoFarm.Settings.TotalXp)
    print("  💰 Beli Total: " .. AutoFarm.Settings.TotalBeli)
    print("  🎯 Nível Atual: " .. AutoFarm.Settings.CurrentLevel)
    
    return true
end

return AutoFarm