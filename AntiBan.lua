--[[
    SISTEMA ANTI-BAN
]]

local AntiBan = {}

function AntiBan.Iniciar()
    AntiBan.Status = {
        HoraInicio = os.time(),
        SessaoAtiva = true,
        KillCount = 0,
    }
    AntiBan.Stats = {TotalKills = 0, TotalPausas = 0}
    print("[ANTI-BAN] 🛡️ Proteção ativada!")
end

function AntiBan.DetectarAdmins(Players)
    if not Config.AntiBan.DetectarAdmins then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p:IsInGroup(1) or p.UserId == 1 or p:FindFirstChild("Admin") then
            print("[ANTI-BAN] ⚠️ ADMIN: " .. p.Name)
            task.wait(60)
            return true
        end
    end
    return false
end

function AntiBan.PausaAleatoria()
    local duracao = math.random(Config.AntiBan.PausaMin * 10, Config.AntiBan.PausaMax * 10) / 10
    print("[ANTI-BAN] ⏸️ Pausa " .. string.format("%.1f", duracao) .. "s")
    AntiBan.Stats.TotalPausas = AntiBan.Stats.TotalPausas + 1
    task.wait(duracao)
end

function AntiBan.Delay()
    local delay = math.random(Config.AntiBan.DelayMin * 10, Config.AntiBan.DelayMax * 10) / 10
    task.wait(delay)
end

function AntiBan.PausaLonga()
    local duracao = math.random(Config.AntiBan.PausaLongaMin, Config.AntiBan.PausaLongaMax)
    print("[ANTI-BAN] ⏰ Pausa longa " .. duracao .. "s")
    task.wait(duracao)
end

function AntiBan.VerificarTempo()
    if os.time() - AntiBan.Status.HoraInicio > Config.AntiBan.TempoMaxSessao then
        AntiBan.PausaLonga()
        AntiBan.Status.HoraInicio = os.time()
    end
end

function AntiBan.VerificarCura(player)
    if not Config.Farm.AutoCura then return end
    Detector.Atualizar(player)
    if Detector.Vida < Config.Farm.VidaMinimaCura then
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
                print("[ANTI-BAN] 💚 Cura automática!")
                task.wait(1)
            end
        end)
    end
end

function AntiBan.Relatorio()
    local tempo = os.time() - AntiBan.Status.HoraInicio
    print("[ANTI-BAN] 📊 Relatório:")
    print("  ⏱️ " .. math.floor(tempo/60) .. "m")
    print("  ⚔️ " .. AntiBan.Stats.TotalKills .. " kills")
    print("  ⏸️ " .. AntiBan.Stats.TotalPausas .. " pausas")
end

return AntiBan