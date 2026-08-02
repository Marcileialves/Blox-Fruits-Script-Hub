--[[
    SISTEMA DE TRADE E COLEÇÃO
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Trade = {}

Trade.Settings = {
    TotalItems = 72,
    CollectedItems = 45
}

-- Valores de itens
Trade.Values = {
    ["Dark Blade"] = "1.2M Beli",
    ["Dough Fruit"] = "800K Beli",
    ["Leopard Fruit"] = "1.5M Beli",
    ["Dragon Fruit"] = "2.0M Beli",
    ["Kitsune Fruit"] = "2.5M Beli",
    ["Venom Fruit"] = "600K Beli",
    ["Spirit Fruit"] = "700K Beli",
    ["Control Fruit"] = "500K Beli",
    ["Shadow Fruit"] = "400K Beli",
    ["Gravity Fruit"] = "300K Beli"
}

-- Função para verificar valor
function Trade.CheckValue(itemName)
    print("[TRADE] 💰 Verificando valor de: " .. itemName)
    
    local value = Trade.Values[itemName]
    if value then
        print("[TRADE] 💎 " .. itemName .. " = " .. value)
    else
        print("[TRADE] ⚠️ Item não encontrado na lista de valores")
        print("[TRADE] 📋 Itens disponíveis:")
        for name, val in pairs(Trade.Values) do
            print("  💎 " .. name .. " = " .. val)
        end
    end
end

-- Função para listar itens raros
function Trade.ListRareItems()
    print("[TRADE] 📋 Itens raros:")
    print("  💎 Kitsune Fruit - 2.5M Beli")
    print("  💎 Dragon Fruit - 2.0M Beli")
    print("  💎 Leopard Fruit - 1.5M Beli")
    print("  💎 Dark Blade - 1.2M Beli")
    print("  💎 Dough Fruit - 800K Beli")
end

-- Função para ver coleção
function Trade.CheckCollection()
    print("[TRADE] 📊 Coleção:")
    print("  📦 Itens: " .. Trade.Settings.CollectedItems .. "/" .. Trade.Settings.TotalItems)
    print("  📊 Progresso: " .. string.format("%.1f", (Trade.Settings.CollectedItems / Trade.Settings.TotalItems) * 100) .. "%")
end

-- Função para adicionar item à coleção
function Trade.AddItemToCollection(itemName)
    print("[TRADE] ▶️ Adicionando: " .. itemName)
    
    Trade.Settings.CollectedItems = Trade.Settings.CollectedItems + 1
    print("[TRADE] ✅ " .. itemName .. " adicionado à coleção!")
    Trade.CheckCollection()
end

return Trade