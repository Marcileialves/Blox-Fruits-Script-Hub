--[[
    SISTEMA ANTI-BAN
]]

local AntiBan = {}

function AntiBan.Iniciar()
    AntiBan.Status = {
        HoraInicio = os.time(),
        SessaoAtiva = true,
        TotalPausas = 0,
    }
    print("[ANTI-BAN] 🛡️ Proteção ativada!")
end

function AntiBan.PausaAleatoria(Config)
    local duracao = math.random(Config.AntiBan.PausaMin * 10, Config.AntiBan.PausaMax * 10) / 10
    AntiBan.Status.TotalPausas = AntiBan.Status.TotalPausas + 1
    task.wait(duracao)
end

function AntiBan.Delay(Config)
    local delay = math.random(Config.AntiBan.DelayMin * 10, Config.AntiBan.DelayMax * 10) / 10
    task.wait(delay)
end

function AntiBan.Relatorio()
    print("[ANTI-BAN] 📊 Pausas: " .. AntiBan.Status.TotalPausas)
end

return AntiBan