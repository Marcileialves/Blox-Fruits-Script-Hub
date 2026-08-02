--[[
    FUNÇÕES AUXILIARES
]]

local Utils = {}

function Utils.Curar(player)
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

function Utils.MostrarInfo(player)
    Detector.Atualizar(player)
    local info = Detector.GetInfo()
    local ilha = Farm.EncontrarIlha(player)
    
    print("📊 INFORMAÇÕES:")
    print("  👤 " .. player.Name)
    print("  🎯 Nível: " .. info.Nivel)
    print("  💚 Vida: " .. info.Vida .. "/" .. info.MaxVida)
    print("  💰 Beli: " .. info.Beli)
    print("  💎 Fragmentos: " .. info.Fragmentos)
    print("  👤 Raça: " .. info.Raça)
    print("  🍎 Fruta: " .. info.Fruta)
    print("  ⚔️ Arma: " .. info.Arma)
    print("  🥊 Maestria: " .. info.Maestria)
    if Farm.Ativo then
        print("  ⚡ Farmando: SIM (" .. Farm.Kills .. " kills)")
        print("  ⚡ KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
    else
        print("  ⚡ Farmando: NÃO")
    end
    if ilha then
        print("  📍 Ilha: " .. ilha.nome)
    end
end

return Utils