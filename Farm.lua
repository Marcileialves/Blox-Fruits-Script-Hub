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
}

function Farm.Iniciar(player, Detector, AntiBan, Config)
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
    
    print("[FARM] 🚀 INICIANDO FARM!")
    print("[FARM] 🎯 Nível: " .. Detector.Nivel .. " → 3000")
    
    AntiBan.Iniciar()
    
    task.spawn(function()
        while Farm.Ativo do
            -- Verifica cura automática
            if Config.Farm.AutoCura and Detector.Vida < Config.Farm.VidaMinimaCura then
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
                        print("[ANTI-BAN] 💚 Cura automática!")
                        task.wait(1)
                    end
                end)
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
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                local uis = game:GetService("UserInputService")
                if uis.TouchEnabled then
                    for i = 1, 3 do
                        uis:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
                        task.wait(0.06)
                    end
                end
                
                Farm.Kills = Farm.Kills + 1
                Farm.KillsTotal = Farm.KillsTotal + 1
                Farm.XpGanho = Farm.XpGanho + 100
                Farm.BeliGanho = Farm.BeliGanho + 60
                
                if Farm.Kills % Config.AntiBan.PausaAPosKills == 0 then
                    AntiBan.PausaAleatoria(Config)
                end
                
                AntiBan.Delay(Config)
                
                if Farm.Kills % 10 == 0 then
                    print("[FARM] ⚔️ " .. Farm.Kills .. " kills")
                    Detector.Atualizar(player)
                    print("[FARM] 🎯 Nível: " .. Detector.Nivel)
                end
            else
                task.wait(2)
            end
            
            Detector.Atualizar(player)
            if Detector.Nivel >= Config.Farm.TargetLevel then
                print("[FARM] 🎉 NÍVEL MÁXIMO! 3000/3000")
                break
            end
        end
        
        Farm.Ativo = false
        Farm.Finalizar(Detector, AntiBan)
    end)
end

function Farm.Parar()
    Farm.Ativo = false
    print("[FARM] ⏹ Parado - " .. Farm.Kills .. " kills")
end

function Farm.Finalizar(Detector, AntiBan)
    local tempo = os.time() - Farm.TempoInicio
    print("[FARM] ✅ CONCLUÍDO!")
    print("  ⏱️ " .. math.floor(tempo/60) .. "m")
    print("  ⚔️ " .. Farm.KillsTotal .. " kills")
    print("  📈 " .. Farm.XpGanho .. " XP")
    print("  💰 " .. Farm.BeliGanho .. " Beli")
    print("  🎯 Nível: " .. Detector.Nivel)
    AntiBan.Relatorio()
end

return Farm