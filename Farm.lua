--[[
    SISTEMA DE FARM
]]

local Farm = {
    Ativo = false,
    Kills = 0,
    KillsTotal = 0,
    XpGanho = 0,
    BeliGanho = 0,
    TempoInicio = 0,
    NivelInicio = 0,
    NivelAtual = 0,
    KillsPorMinuto = 0,
    IlhaAtual = nil,
}

function Farm.EncontrarIlha(player)
    Detector.Atualizar(player)
    local nivel = Detector.Nivel
    local melhor = nil
    local melhorXp = -1
    
    for _, ilha in pairs(Config.Ilhas) do
        if nivel >= ilha.min and nivel <= ilha.max then
            if ilha.xp > melhorXp then
                melhorXp = ilha.xp
                melhor = ilha
            end
        end
    end
    
    if not melhor then
        for _, ilha in pairs(Config.Ilhas) do
            if nivel >= ilha.min then
                melhor = ilha
                break
            end
        end
    end
    
    return melhor or Config.Ilhas[#Config.Ilhas]
end

function Farm.Teleportar(player, nomeIlha)
    print("[TELEPORTE] 🚀 " .. nomeIlha)
    
    pcall(function()
        local spawns = game.Workspace:FindFirstChild("Spawns")
        if spawns then
            for _, spawn in pairs(spawns:GetChildren()) do
                if spawn.Name == nomeIlha then
                    player.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 10, 0)
                    task.wait(0.5)
                    return true
                end
            end
        end
    end)
    
    pcall(function()
        local ilha = game.Workspace:FindFirstChild(nomeIlha)
        if ilha then
            player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
            task.wait(0.5)
            return true
        end
    end)
    
    return false
end

function Farm.Atacar(player, UserInputService, VirtualInput)
    if UserInputService.TouchEnabled then
        for i = 1, 3 do
            UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
            task.wait(0.06)
        end
        return true
    end
    
    if VirtualInput then
        for i = 1, 3 do
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, true, game, 0)
            task.wait(0.06)
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, false, game, 0)
            task.wait(0.06)
        end
        return true
    end
    
    if mouse1click then
        for i = 1, 3 do
            mouse1click()
            task.wait(0.1)
        end
        return true
    end
    
    return false
end

function Farm.Iniciar(player, UserInputService, VirtualInput)
    if Farm.Ativo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    
    Farm.Ativo = true
    Farm.Kills = 0
    Farm.KillsTotal = 0
    Farm.XpGanho = 0
    Farm.BeliGanho = 0
    Farm.TempoInicio = os.time()
    Detector.Atualizar(player)
    Farm.NivelInicio = Detector.Nivel
    Farm.NivelAtual = Farm.NivelInicio
    
    print("[FARM] 🚀 INICIANDO FARM!")
    print("[FARM] 🎯 Nível: " .. Farm.NivelInicio .. " → 3000")
    
    AntiBan.Iniciar()
    
    task.spawn(function()
        local semInimigos = 0
        
        while Farm.Ativo do
            if AntiBan.DetectarAdmins(game.Players) then
                task.wait(60)
                continue
            end
            
            AntiBan.VerificarTempo()
            AntiBan.VerificarCura(player)
            
            local ilha = Farm.EncontrarIlha(player)
            if ilha and (not Farm.IlhaAtual or ilha.nome ~= Farm.IlhaAtual.nome) then
                Farm.IlhaAtual = ilha
                print("[FARM] 📍 " .. ilha.nome .. " (XP: " .. ilha.xp .. ")")
                Farm.Teleportar(player, ilha.nome)
                task.wait(2)
            end
            
            local enemies = game.Workspace:FindFirstChild("Enemies")
            local alvo = nil
            
            if enemies then
                for _, e in pairs(enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 150 then
                            alvo = e
                            break
                        end
                    end
                end
            end
            
            if alvo then
                semInimigos = 0
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                Farm.Atacar(player, UserInputService, VirtualInput)
                task.wait(0.15)
                Farm.Atacar(player, UserInputService, VirtualInput)
                task.wait(0.15)
                
                Farm.Kills = Farm.Kills + 1
                Farm.KillsTotal = Farm.KillsTotal + 1
                Farm.XpGanho = Farm.XpGanho + (Farm.IlhaAtual and Farm.IlhaAtual.xp or 100)
                Farm.BeliGanho = Farm.BeliGanho + 60
                AntiBan.Stats.TotalKills = AntiBan.Stats.TotalKills + 1
                
                if Farm.Kills % Config.AntiBan.PausaAPosKills == 0 then
                    AntiBan.PausaAleatoria()
                end
                
                AntiBan.Delay()
                
                if Farm.Kills % 10 == 0 then
                    local tempo = os.time() - Farm.TempoInicio
                    Farm.KillsPorMinuto = Farm.Kills / (tempo / 60)
                    print("[FARM] ⚔️ " .. Farm.Kills .. " kills | KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
                    Detector.Atualizar(player)
                    print("[FARM] 🎯 Nível: " .. Detector.Nivel)
                end
            else
                semInimigos = semInimigos + 1
                if semInimigos > 5 then
                    print("[FARM] ⚠️ Sem inimigos! Teleportando...")
                    if Farm.IlhaAtual then
                        Farm.Teleportar(player, Farm.IlhaAtual.nome)
                    end
                    semInimigos = 0
                end
                task.wait(2)
            end
            
            Detector.Atualizar(player)
            if Detector.Nivel > Farm.NivelAtual then
                Farm.NivelAtual = Detector.Nivel
                print("[FARM] 🎉 Nível " .. Farm.NivelAtual .. "!")
                local novaIlha = Farm.EncontrarIlha(player)
                if novaIlha and Farm.IlhaAtual and novaIlha.nome ~= Farm.IlhaAtual.nome then
                    print("[FARM] 🔄 Nova ilha: " .. novaIlha.nome)
                    Farm.IlhaAtual = novaIlha
                    Farm.Teleportar(player, novaIlha.nome)
                end
            end
            
            if Farm.NivelAtual >= Config.Farm.TargetLevel then
                print("[FARM] 🎉 NÍVEL MÁXIMO! 3000/3000")
                break
            end
        end
        
        Farm.Ativo = false
        Farm.Finalizar()
    end)
end

function Farm.Parar()
    Farm.Ativo = false
    AntiBan.Status.SessaoAtiva = false
    print("[FARM] ⏹ Parado - " .. Farm.Kills .. " kills")
end

function Farm.Finalizar()
    local tempo = os.time() - Farm.TempoInicio
    local minutos = math.floor(tempo / 60)
    
    print("[FARM] ✅ CONCLUÍDO!")
    print("  ⏱️ " .. minutos .. "m")
    print("  ⚔️ " .. Farm.KillsTotal .. " kills")
    print("  📈 " .. Farm.XpGanho .. " XP")
    print("  💰 " .. Farm.BeliGanho .. " Beli")
    print("  🎯 " .. Farm.NivelInicio .. " → " .. Detector.Nivel)
    AntiBan.Relatorio()
end

return Farm