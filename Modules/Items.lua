--[[
    SISTEMA DE ITENS E ACESSÓRIOS
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Items = {}

Items.Settings = {
    TotalItems = 9,
    CollectedItems = 5
}

-- Lista de itens
Items.ItemList = {
    {Name = "Palm Scarf", Obtained = false, Effect = "Dano +15%"},
    {Name = "Lei", Obtained = false, Effect = "Defesa +20%"},
    {Name = "Hunter Cap", Obtained = true, Effect = "Energia +30%"},
    {Name = "Sword Master Hat", Obtained = false, Effect = "Dano Espada +25%"},
    {Name = "Ghost Band", Obtained = false, Effect = "Velocidade +10%"},
    {Name = "Musketeer Hat", Obtained = false, Effect = "Precisão +20%"},
    {Name = "Dark Coat", Obtained = false, Effect = "Defesa +25%"},
    {Name = "Cake Prince Crown", Obtained = false, Effect = "Dano +30%"},
    {Name = "Dough Crown", Obtained = false, Effect = "Dano +35%"}
}

-- Função para pegar item
function Items.GetItem(itemName)
    print("[ITENS] ▶️ Pegando: " .. itemName)
    
    local found = false
    for _, item in pairs(Items.ItemList) do
        if item.Name == itemName then
            if item.Obtained then
                print("[ITENS] ⚠️ " .. itemName .. " já foi obtido!")
                return false
            end
            item.Obtained = true
            Items.Settings.CollectedItems = Items.Settings.CollectedItems + 1
            found = true
            print("[ITENS] ✅ " .. itemName .. " obtido com sucesso!")
            print("[ITENS] 🎯 Efeito: " .. item.Effect)
            break
        end
    end
    
    if not found then
        print("[ITENS] ❌ " .. itemName .. " não encontrado na lista")
        return false
    end
    
    Items.CheckProgress()
    return true
end

-- Função para verificar progresso
function Items.CheckProgress()
    print("[ITENS] 📊 Progresso:")
    print("  🎯 Itens: " .. Items.Settings.CollectedItems .. "/" .. Items.Settings.TotalItems)
end

-- Função para listar itens faltando
function Items.ListMissing()
    print("[ITENS] 📋 Itens faltando:")
    
    for _, item in pairs(Items.ItemList) do
        if not item.Obtained then
            print("  🎯 " .. item.Name .. " - " .. item.Effect)
        end
    end
end

return Items