--[[
    SISTEMA DE QUESTS E PUZZLES
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Quests = {}

Quests.Settings = {
    TotalQuests = 6,
    CompletedQuests = 3
}

-- Lista de quests
Quests.QuestList = {
    {Name = "Quest CDK", Completed = false, Difficulty = "⭐⭐⭐⭐⭐"},
    {Name = "Quest Soul Guitar", Completed = false, Difficulty = "⭐⭐⭐⭐"},
    {Name = "Quest Godhuman", Completed = false, Difficulty = "⭐⭐⭐⭐⭐"},
    {Name = "Puzzle V4", Completed = false, Difficulty = "⭐⭐⭐⭐"},
    {Name = "Quest Musketeer Hat", Completed = true, Difficulty = "⭐⭐⭐"},
    {Name = "Quest Palm Scarf", Completed = false, Difficulty = "⭐⭐⭐"}
}

-- Função para fazer quest
function Quests.DoQuest(questName)
    print("[QUEST] ▶️ Fazendo: " .. questName)
    
    local found = false
    for _, quest in pairs(Quests.QuestList) do
        if quest.Name == questName then
            if quest.Completed then
                print("[QUEST] ⚠️ " .. questName .. " já foi completada!")
                return false
            end
            quest.Completed = true
            Quests.Settings.CompletedQuests = Quests.Settings.CompletedQuests + 1
            found = true
            print("[QUEST] ✅ " .. questName .. " completada com sucesso!")
            break
        end
    end
    
    if not found then
        print("[QUEST] ❌ " .. questName .. " não encontrada na lista")
        return false
    end
    
    Quests.CheckProgress()
    return true
end

-- Função para verificar progresso
function Quests.CheckProgress()
    print("[QUEST] 📊 Progresso:")
    print("  📋 Quests: " .. Quests.Settings.CompletedQuests .. "/" .. Quests.Settings.TotalQuests)
end

-- Função para listar quests faltando
function Quests.ListMissing()
    print("[QUEST] 📋 Quests faltando:")
    
    for _, quest in pairs(Quests.QuestList) do
        if not quest.Completed then
            print("  📋 " .. quest.Name .. " (" .. quest.Difficulty .. ")")
        end
    end
end

-- Função para mostrar passo a passo da quest
function Quests.ShowSteps(questName)
    print("[QUEST] 📋 Passo a passo - " .. questName)
    
    local steps = {
        ["Quest CDK"] = {
            "1. Mate 100 inimigos no Castelo",
            "2. Colete 50 fragmentos",
            "3. Derrote o boss final"
        },
        ["Quest Soul Guitar"] = {
            "1. Vá para a Ilha do Céu",
            "2. Encontre o NPC escondido",
            "3. Complete o puzzle musical"
        },
        ["Quest Godhuman"] = {
            "1. Aprenda todos os estilos",
            "2. Complete 100 combos",
            "3. Derrote 50 bosses"
        }
    }
    
    if steps[questName] then
        for _, step in pairs(steps[questName]) do
            print("  " .. step)
        end
    else
        print("[QUEST] ⚠️ Nenhum passo disponível para esta quest")
    end
end

return Quests