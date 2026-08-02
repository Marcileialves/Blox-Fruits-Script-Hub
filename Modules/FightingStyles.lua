--[[
    SISTEMA DE ESTILOS DE LUTA
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local FightingStyles = {}

FightingStyles.Settings = {
    TotalStyles = 11,
    LearnedStyles = 6
}

-- Lista de estilos
FightingStyles.Styles = {
    -- Iniciais
    {Name = "Combat", Category = "Inicial", Learned = true},
    {Name = "Dark Step", Category = "Inicial", Learned = false},
    -- Avançados
    {Name = "Electric", Category = "Avançado", Learned = false},
    {Name = "Water Kung Fu", Category = "Avançado", Learned = true},
    {Name = "Dragon Breath", Category = "Avançado", Learned = false},
    {Name = "Superhuman", Category = "Avançado", Learned = false},
    -- Finais
    {Name = "Death Step", Category = "Final", Learned = false},
    {Name = "Sharkman Karate", Category = "Final", Learned = false},
    {Name = "Electric Claw", Category = "Final", Learned = false},
    {Name = "Dragon Talon", Category = "Final", Learned = false},
    {Name = "Godhuman", Category = "Final", Learned = false}
}

-- Função para aprender estilo
function FightingStyles.LearnStyle(styleName)
    print("[ESTILOS] ▶️ Aprendendo: " .. styleName)
    
    local found = false
    for _, style in pairs(FightingStyles.Styles) do
        if style.Name == styleName then
            if style.Learned then
                print("[ESTILOS] ⚠️ " .. styleName .. " já foi aprendido!")
                return false
            end
            style.Learned = true
            FightingStyles.Settings.LearnedStyles = FightingStyles.Settings.LearnedStyles + 1
            found = true
            print("[ESTILOS] ✅ " .. styleName .. " aprendido com sucesso!")
            break
        end
    end
    
    if not found then
        print("[ESTILOS] ❌ " .. styleName .. " não encontrado na lista")
        return false
    end
    
    FightingStyles.CheckProgress()
    return true
end

-- Função para verificar progresso
function FightingStyles.CheckProgress()
    print("[ESTILOS] 📊 Progresso:")
    print("  🥊 Estilos: " .. FightingStyles.Settings.LearnedStyles .. "/" .. FightingStyles.Settings.TotalStyles)
end

-- Função para listar estilos faltando
function FightingStyles.ListMissing()
    print("[ESTILOS] 📋 Estilos faltando:")
    
    for _, style in pairs(FightingStyles.Styles) do
        if not style.Learned then
            print("  🥊 " .. style.Name .. " (" .. style.Category .. ")")
        end
    end
end

-- Função para listar por categoria
function FightingStyles.ListByCategory(category)
    print("[ESTILOS] 📋 Estilos " .. category .. ":")
    
    for _, style in pairs(FightingStyles.Styles) do
        if style.Category == category then
            local status = style.Learned and "✅" or "⬜"
            print("  " .. status .. " " .. style.Name)
        end
    end
end

return FightingStyles