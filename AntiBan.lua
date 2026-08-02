--[[
    SISTEMA ANTI-BAN
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local AntiBan = {}

-- Configurações
AntiBan.Settings = {
    Enabled = true,
    SecurityLevel = "ALTO", -- BAIXO, MÉDIO, ALTO
    RandomPauses = true,
    HumanBehavior = true,
    ActionRotation = true,
    MinPause = 0.5,
    MaxPause = 5.0,
    MinDelay = 0.3,
    MaxDelay = 1.5,
    RotateEvery = 300, -- 5 minutos
    PauseAfterKills = 30
}

-- Status
AntiBan.Status = {
    IsPaused = false,
    KillCount = 0,
    CurrentRotation = 1,
    LastAction = 0
}

-- Função para pausa aleatória
function AntiBan.RandomPause()
    if not AntiBan.Settings.Enabled then return end
    if not AntiBan.Settings.RandomPauses then return end
    
    local pauseTime = math.random(AntiBan.Settings.MinPause * 10, AntiBan.Settings.MaxPause * 10) / 10
    AntiBan.Status.IsPaused = true
    
    print("[ANTI-BAN] ⏸️ Pausa aleatória de " .. pauseTime .. "s")
    
    task.wait(pauseTime)
    AntiBan.Status.IsPaused = false
end

-- Função para delay entre ações
function AntiBan.DelayBetweenActions()
    if not AntiBan.Settings.Enabled then return end
    
    local delayTime = math.random(AntiBan.Settings.MinDelay * 10, AntiBan.Settings.MaxDelay * 10) / 10
    task.wait(delayTime)
end

-- Função para simular comportamento humano
function AntiBan.SimulateHumanBehavior()
    if not AntiBan.Settings.Enabled then return end
    if not AntiBan.Settings.HumanBehavior then return end
    
    local behaviors = {
        "movendo mouse",
        "digitando",
        "caminhando",
        "parado"
    }
    
    local randomBehavior = behaviors[math.random(1, #behaviors)]
    
    -- Simula movimento de mouse
    if randomBehavior == "movendo mouse" then
        local x = math.random(-100, 100)
        local y = math.random(-100, 100)
        mousemoverel(x, y)
    end
    
    -- Simula digitação
    if randomBehavior == "digitando" then
        local keys = {"w", "a", "s", "d", "space", "e", "q"}
        local key = keys[math.random(1, #keys)]
        keypress(key)
        task.wait(0.1)
        keyrelease(key)
    end
    
    task.wait(math.random(1, 3))
end

-- Função para verificar perigo
function AntiBan.CheckDanger()
    if not AntiBan.Settings.Enabled then return end
    
    -- Verifica se há admin no servidor
    local players = game.Players:GetPlayers()
    for _, player in pairs(players) do
        if player:IsInGroup(1) or player.UserId == 1 then
            print("[ANTI-BAN] ⚠️ ADMIN DETECTADO! PAUSANDO...")
            AntiBan.Status.IsPaused = true
            task.wait(30)
            AntiBan.Status.IsPaused = false
            return false
        end
    end
    
    return true
end

-- Função para rotacionar ações
function AntiBan.RotateActions()
    if not AntiBan.Settings.Enabled then return end
    if not AntiBan.Settings.ActionRotation then return end
    
    AntiBan.Status.CurrentRotation = AntiBan.Status.CurrentRotation + 1
    if AntiBan.Status.CurrentRotation > 3 then
        AntiBan.Status.CurrentRotation = 1
    end
    
    print("[ANTI-BAN] 🔄 Rotacionando ações para: " .. AntiBan.Status.CurrentRotation)
end

-- Função para incrementar contagem de kills
function AntiBan.IncrementKill()
    AntiBan.Status.KillCount = AntiBan.Status.KillCount + 1
    
    if AntiBan.Status.KillCount >= AntiBan.Settings.PauseAfterKills then
        AntiBan.Status.KillCount = 0
        AntiBan.RandomPause()
    end
    
    if AntiBan.Status.KillCount % math.random(20, 40) == 0 then
        AntiBan.RotateActions()
    end
end

return AntiBan