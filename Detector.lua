--[[
    SISTEMA DE DETECÇÃO DO JOGADOR
]]

local Detector = {}

function Detector.Atualizar(player)
    pcall(function()
        Detector.Nivel = player.Level or player:GetAttribute("Level") or 0
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            Detector.Vida = math.floor(player.Character.Humanoid.Health)
            Detector.MaxVida = player.Character.Humanoid.MaxHealth
        end
        if player:FindFirstChild("Beli") then
            Detector.Beli = player.Beli.Value or 0
        end
        Detector.Maestria = math.random(1, 600)
    end)
end

return Detector