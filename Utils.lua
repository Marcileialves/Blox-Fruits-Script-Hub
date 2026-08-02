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

function Utils.MostrarInfo(player, Detector, Farm)
    Detector.Atualizar(player)
    print("📊 INFORMAÇÕES:")
    print("  👤 " .. player.Name)
    print("  🎯 Nível: " .. Detector.Nivel)
    print("  💚 Vida: " .. Detector.Vida .. "/" .. Detector.MaxVida)
    print("  💰 Beli: " .. Detector.Beli)
    print("  🥊 Maestria: " .. Detector.Maestria .. "/600")
    if Farm.Ativo then
        print("  ⚔️ Kills: " .. Farm.Kills)
    end
end

return Utils