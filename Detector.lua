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
        if player:FindFirstChild("Fragments") then
            Detector.Fragmentos = player.Fragments.Value or 0
        end
        if player.Character and player.Character:FindFirstChild("Race") then
            Detector.Raça = player.Character.Race.Value or "Desconhecida"
        end
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("Fruit") then
                Detector.Fruta = item.Name
                break
            end
        end
        if player.Character then
            for _, item in pairs(player.Character:GetChildren()) do
                if item:IsA("Tool") then
                    Detector.Arma = item.Name
                    break
                end
            end
        end
        -- Maestria (simulada)
        Detector.Maestria = math.random(1, 600)
    end)
end

function Detector.GetInfo()
    return {
        Nivel = Detector.Nivel or 0,
        Vida = Detector.Vida or 0,
        MaxVida = Detector.MaxVida or 100,
        Beli = Detector.Beli or 0,
        Fragmentos = Detector.Fragmentos or 0,
        Raça = Detector.Raça or "Desconhecida",
        Fruta = Detector.Fruta or "Nenhuma",
        Arma = Detector.Arma or "Nenhuma",
        Maestria = Detector.Maestria or 0,
    }
end

return Detector