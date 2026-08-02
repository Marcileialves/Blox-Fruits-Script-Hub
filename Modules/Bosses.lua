--[[
    SISTEMA DE BOSSES
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Bosses = {}

Bosses.Settings = {
    TotalBosses = 7,
    DefeatedBosses = 4
}

-- Lista de bosses
Bosses.BossList = {
    {Name = "Darkbeard", Defeated = false, Location = "Dark Arena", Difficulty = "⭐⭐⭐⭐"},
    {Name = "Rip Indra", Defeated = false, Location = "Sea of Treats", Difficulty = "⭐⭐⭐⭐⭐"},
    {Name = "Dough King", Defeated = true, Location = "Sea of Treats", Difficulty = "⭐⭐⭐⭐⭐"},
    {Name = "Cake Prince", Defeated = false, Location = "Cake Island", Difficulty = "⭐⭐⭐⭐"},
    {Name = "Leviathan", Defeated = false, Location = "Sea of Treats", Difficulty = "⭐⭐⭐⭐⭐"},
    {Name = "Sea Beast", Defeated = false, Location = "Sea", Difficulty = "⭐⭐⭐"},
    {Name = "Territory Boss", Defeated = false, Location = "Various", Difficulty = "⭐⭐⭐"}
}

-- Função para derrotar boss
function Bosses.DefeatBoss(bossName)
    print("[BOSS] ▶️ Derrotando: " .. bossName)
    
    local found = false
    for _, boss in pairs(Bosses.BossList) do
        if boss.Name == bossName then
            if boss.Defeated then
                print("[BOSS] ⚠️ " .. bossName .. " já foi derrotado!")
                return false
            end
            boss.Defeated = true
            Bosses.Settings.DefeatedBosses = Bosses.Settings.DefeatedBosses + 1
            found = true
            print("[BOSS] ✅ " .. bossName .. " derrotado com sucesso!")
            print("[BOSS] 📍 Local: " .. boss.Location)
            break
        end
    end
    
    if not found then
        print("[BOSS] ❌ " .. bossName .. " não encontrado na lista")
        return false
    end
    
    Bosses.CheckProgress()
    return true
end

-- Função para verificar progresso
function Bosses.CheckProgress()
    print("[BOSS] 📊 Progresso:")
    print("  👹 Bosses: " .. Bosses.Settings.DefeatedBosses .. "/" .. Bosses.Settings.TotalBosses)
end

-- Função para listar bosses faltando
function Bosses.ListMissing()
    print("[BOSS] 📋 Bosses faltando:")
    
    for _, boss in pairs(Bosses.BossList) do
        if not boss.Defeated then
            print("  👹 " .. boss.Name .. " - " .. boss.Location .. " (" .. boss.Difficulty .. ")")
        end
    end
end

-- Função para mostrar próximo spawn
function Bosses.NextSpawn()
    print("[BOSS] ⏱️ Próximo spawn:")
    print("  👹 Darkbeard: 00:15")
    print("  👹 Dough King: 00:45")
    print("  👹 Cake Prince: 01:30")
end

return Bosses