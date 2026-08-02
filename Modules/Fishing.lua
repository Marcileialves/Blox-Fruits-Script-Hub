--[[
    SISTEMA DE PESCA
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Fishing = {}

Fishing.Settings = {
    TotalItems = 8,
    CollectedItems = 4
}

-- Lista de itens de pesca
Fishing.Items = {
    -- Varas
    {Name = "Fishing Rod", Category = "Vara", Obtained = true},
    {Name = "Gold Rod", Category = "Vara", Obtained = false},
    {Name = "Shark Rod", Category = "Vara", Obtained = false},
    {Name = "Shell Rod", Category = "Vara", Obtained = false},
    -- Iscas
    {Name = "Basic Bait", Category = "Isca", Obtained = false},
    {Name = "Good Bait", Category = "Isca", Obtained = false},
    {Name = "Epic Bait", Category = "Isca", Obtained = false},
    -- Peixes
    {Name = "Rare Fish", Category = "Peixe", Obtained = false}
}

-- Função para pegar item de pesca
function Fishing.GetItem(itemName)
    print("[PESCA] ▶️ Pegando: " .. itemName)
    
    local found = false
    for _, item in pairs(Fishing.Items) do
        if item.Name == itemName then
            if item.Obtained then
                print("[PESCA] ⚠️ " .. itemName .. " já foi obtido!")
                return false
            end
            item.Obtained = true
            Fishing.Settings.CollectedItems = Fishing.Settings.CollectedItems + 1
            found = true
            print("[PESCA] ✅ " .. itemName .. " obtido com sucesso!")
            break
        end
    end
    
    if not found then
        print("[PESCA] ❌ " .. itemName .. " não encontrado na lista")
        return false
    end
    
    Fishing.CheckProgress()
    return true
end

-- Função para pescar
function Fishing.CatchFish()
    print("[PESCA] 🎣 Pescatando...")
    print("[PESCA] ⏳ Aguardando peixe...")
    
    task.wait(5)
    
    local fishTypes = {
        "Peixe Comum",
        "Peixe Raro",
        "Peixe Épico",
        "Peixe Lendário"
    }
    
    local fish = fishTypes[math.random(1, #fishTypes)]
    print("[PESCA] 🐟 Você pescou: " .. fish)
    
    if fish == "Peixe Raro" or fish == "Peixe Épico" or fish == "Peixe Lendário" then
        Fishing.Settings.CollectedItems = Fishing.Settings.CollectedItems + 1
        print("[PESCA] ✅ Peixe adicionado à coleção!")
    end
    
    return fish
end

-- Função para verificar progresso
function Fishing.CheckProgress()
    print("[PESCA] 📊 Progresso:")
    print("  🐟 Itens: " .. Fishing.Settings.CollectedItems .. "/" .. Fishing.Settings.TotalItems)
end

-- Função para listar itens faltando
function Fishing.ListMissing()
    print("[PESCA] 📋 Itens faltando:")
    
    for _, item in pairs(Fishing.Items) do
        if not item.Obtained then
            print("  🐟 " .. item.Name .. " (" .. item.Category .. ")")
        end
    end
end

return Fishing