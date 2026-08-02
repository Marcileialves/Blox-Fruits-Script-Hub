--[[
    SISTEMA DE RAÇAS
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Race = {}

Race.Settings = {
    CurrentRace = "SHARK",
    CurrentV = 3,
    TrialsComplete = {
        Trial1 = false,
        Trial2 = true,
        Trial3 = false,
        Trial4 = false
    },
    GearsCollected = {
        Gear1 = true,
        Gear2 = false,
        Gear3 = false
    }
}

-- Lista de raças disponíveis
Race.Races = {
    "HUMAN",
    "SHARK",
    "ANGEL",
    "MINK",
    "GHOUL",
    "CYBORG",
    "DRACO"
}

-- Função para verificar progresso da raça atual
function Race.CheckProgress()
    print("[RAÇA] 📊 Verificando progresso...")
    print("  👤 Raça: " .. Race.Settings.CurrentRace)
    print("  📈 Estágio: V" .. Race.Settings.CurrentV)
    print("  📋 Trials: ")
    print("    Trial 1: " .. (Race.Settings.TrialsComplete.Trial1 and "✅" or "⬜"))
    print("    Trial 2: " .. (Race.Settings.TrialsComplete.Trial2 and "✅" or "⬜"))
    print("    Trial 3: " .. (Race.Settings.TrialsComplete.Trial3 and "✅" or "⬜"))
    print("    Trial 4: " .. (Race.Settings.TrialsComplete.Trial4 and "✅" or "⬜"))
    print("  ⚙️ Gears:")
    print("    Gear 1: " .. (Race.Settings.GearsCollected.Gear1 and "✅" or "⬜"))
    print("    Gear 2: " .. (Race.Settings.GearsCollected.Gear2 and "✅" or "⬜"))
    print("    Gear 3: " .. (Race.Settings.GearsCollected.Gear3 and "✅" or "⬜"))
end

-- Função para fazer trial
function Race.DoTrial(trialNumber)
    print("[RAÇA] ▶️ Iniciando Trial " .. trialNumber)
    
    local trialNames = {
        "Sobrevivência",
        "Dano",
        "Velocidade",
        "Precisão"
    }
    
    print("[RAÇA] ⚔️ Trial: " .. trialNames[trialNumber])
    print("[RAÇA] 📍 Local: Temple of Time")
    print("[RAÇA] ⏳ Aguarde completar...")
    
    -- Simula execução do trial
    task.wait(3)
    
    -- Marca como completo
    if trialNumber == 1 then
        Race.Settings.TrialsComplete.Trial1 = true
    elseif trialNumber == 2 then
        Race.Settings.TrialsComplete.Trial2 = true
    elseif trialNumber == 3 then
        Race.Settings.TrialsComplete.Trial3 = true
    elseif trialNumber == 4 then
        Race.Settings.TrialsComplete.Trial4 = true
    end
    
    print("[RAÇA] ✅ Trial " .. trialNumber .. " completo!")
    Race.CheckProgress()
end

-- Função para pegar gear
function Race.GetGear(gearNumber)
    print("[RAÇA] ▶️ Pegando Gear " .. gearNumber)
    
    local gearLocations = {
        "Ilha do Céu",
        "Castelo no Mar",
        "Fundo do Mar"
    }
    
    print("[RAÇA] 📍 Local: " .. gearLocations[gearNumber])
    print("[RAÇA] ⏳ Coletando gear...")
    
    task.wait(2)
    
    if gearNumber == 1 then
        Race.Settings.GearsCollected.Gear1 = true
    elseif gearNumber == 2 then
        Race.Settings.GearsCollected.Gear2 = true
    elseif gearNumber == 3 then
        Race.Settings.GearsCollected.Gear3 = true
    end
    
    print("[RAÇA] ✅ Gear " .. gearNumber .. " coletado!")
    Race.CheckProgress()
end

-- Função para ativar V4
function Race.ActivateV4()
    print("[RAÇA] ▶️ Ativando V4...")
    
    local allTrials = Race.Settings.TrialsComplete.Trial1 and 
                      Race.Settings.TrialsComplete.Trial2 and 
                      Race.Settings.TrialsComplete.Trial3 and 
                      Race.Settings.TrialsComplete.Trial4
    
    local allGears = Race.Settings.GearsCollected.Gear1 and 
                      Race.Settings.GearsCollected.Gear2 and 
                      Race.Settings.GearsCollected.Gear3
    
    if not allTrials then
        print("[RAÇA] ❌ Complete todos os trials primeiro!")
        return false
    end
    
    if not allGears then
        print("[RAÇA] ❌ Colete todos os gears primeiro!")
        return false
    end
    
    print("[RAÇA] ⚡ Ativando Transformação V4...")
    task.wait(2)
    print("[RAÇA] 🎉 V4 Ativado com sucesso!")
    Race.Settings.CurrentV = 4
    
    return true
end

return Race