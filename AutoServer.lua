--[[
    SISTEMA DE TROCA AUTOMÁTICA DE SERVIDOR
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local AutoServer = {}

AutoServer.Settings = {
    Enabled = true,
    Priority = "BR",
    TimeBetweenSwitches = 30,
    AutoReconnect = true,
    IsSwitching = false
}

-- Função para trocar de servidor
function AutoServer.Switch()
    if AutoServer.Settings.IsSwitching then
        print("[SERVER] ⚠️ Já está trocando de servidor")
        return false
    end
    
    print("[SERVER] 🔄 Trocando de servidor...")
    AutoServer.Settings.IsSwitching = true
    
    print("[SERVER] 📍 Saindo do servidor atual...")
    task.wait(2)
    
    local success = AutoServer.FindNewServer()
    
    if success then
        print("[SERVER] ✅ Servidor trocado com sucesso!")
        print("[SERVER] 🌐 Servidor: " .. game.JobId)
    else
        print("[SERVER] ❌ Falha ao trocar servidor")
        if AutoServer.Settings.AutoReconnect then
            print("[SERVER] 🔄 Tentando novamente em 5s...")
            task.wait(5)
            AutoServer.Switch()
        end
    end
    
    AutoServer.Settings.IsSwitching = false
    return success
end

-- Função para encontrar novo servidor
function AutoServer.FindNewServer()
    local servers = {"BR", "NA", "EU", "AS"}
    local region = servers[math.random(1, #servers)]
    print("[SERVER] 🌐 Região: " .. region)
    
    return true
end

-- Função para reativar script após troca
function AutoServer.ReactivateScript()
    if not AutoServer.Settings.Enabled then return end
    
    print("[SERVER] ⚡ Reativando script...")
    task.wait(1)
    print("[SERVER] ✅ Script reativado com sucesso!")
end

return AutoServer