--[[
    SISTEMA DE ARMAS
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Weapons = {}

Weapons.Settings = {
    TotalSwords = 12,
    CollectedSwords = 8,
    TotalGuns = 4,
    CollectedGuns = 1
}

-- Lista de espadas
Weapons.Swords = {
    -- Comuns
    {Name = "Saber", Rarity = "Comum", Obtained = true},
    {Name = "Longsword", Rarity = "Comum", Obtained = false},
    -- Raras
    {Name = "Rengoku", Rarity = "Rara", Obtained = false},
    {Name = "Buddy Sword", Rarity = "Rara", Obtained = false},
    -- Lendárias
    {Name = "Shisui", Rarity = "Lendária", Obtained = false},
    {Name = "Saddi", Rarity = "Lendária", Obtained = true},
    {Name = "Wando", Rarity = "Lendária", Obtained = false},
    {Name = "Tushita", Rarity = "Lendária", Obtained = false},
    {Name = "Yama", Rarity = "Lendária", Obtained = false},
    -- End Game
    {Name = "True Triple Katana", Rarity = "End Game", Obtained = false},
    {Name = "Cursed Dual Katana", Rarity = "End Game", Obtained = false},
    {Name = "Dark Blade", Rarity = "End Game", Obtained = false}
}

-- Lista de guns
Weapons.Guns = {
    {Name = "Kabucha", Obtained = true},
    {Name = "Acidum Rifle", Obtained = false},
    {Name = "Serpent Bow", Obtained = false},
    {Name = "Soul Guitar", Obtained = false}
}

-- Função para pegar espada
function Weapons.GetSword(swordName)
    print("[ARMAS] ▶️ Pegando: " .. swordName)
    
    local found = false
    for _, sword in pairs(Weapons.Swords) do
        if sword.Name == swordName then
            if sword.Obtained then
                print("[ARMAS] ⚠️ " .. swordName .. " já foi obtida!")
                return false
            end
            sword.Obtained = true
            Weapons.Settings.CollectedSwords = Weapons.Settings.CollectedSwords + 1
            found = true
            print("[ARMAS] ✅ " .. swordName .. " obtida com sucesso!")
            break
        end
    end
    
    if not found then
        print("[ARMAS] ❌ " .. swordName .. " não encontrada na lista")
        return false
    end
    
    Weapons.CheckProgress()
    return true
end

-- Função para pegar gun
function Weapons.GetGun(gunName)
    print("[ARMAS] ▶️ Pegando: " .. gunName)
    
    local found = false
    for _, gun in pairs(Weapons.Guns) do
        if gun.Name == gunName then
            if gun.Obtained then
                print("[ARMAS] ⚠️ " .. gunName .. " já foi obtida!")
                return false
            end
            gun.Obtained = true
            Weapons.Settings.CollectedGuns = Weapons.Settings.CollectedGuns + 1
            found = true
            print("[ARMAS] ✅ " .. gunName .. " obtida com sucesso!")
            break
        end
    end
    
    if not found then
        print("[ARMAS] ❌ " .. gunName .. " não encontrada na lista")
        return false
    end
    
    Weapons.CheckProgress()
    return true
end

-- Função para verificar progresso
function Weapons.CheckProgress()
    print("[ARMAS] 📊 Progresso:")
    print("  ⚔️ Espadas: " .. Weapons.Settings.CollectedSwords .. "/" .. Weapons.Settings.TotalSwords)
    print("  🔫 Guns: " .. Weapons.Settings.CollectedGuns .. "/" .. Weapons.Settings.TotalGuns)
end

-- Função para listar armas faltando
function Weapons.ListMissing()
    print("[ARMAS] 📋 Armas faltando:")
    
    for _, sword in pairs(Weapons.Swords) do
        if not sword.Obtained then
            print("  ⚔️ " .. sword.Name .. " (" .. sword.Rarity .. ")")
        end
    end
    
    for _, gun in pairs(Weapons.Guns) do
        if not gun.Obtained then
            print("  🔫 " .. gun.Name)
        end
    end
end

return Weapons