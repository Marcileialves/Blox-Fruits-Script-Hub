--[[
    BLOX FRUITS SCRIPT HUB
    Versão 3.0
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🚀 Carregando Blox Fruits Script Hub...")

-- Carrega bibliotecas
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

if not Rayfield then
    print("❌ Erro ao carregar Rayfield!")
    return
end

-- Carrega os módulos
local Config = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Config.lua'))()
local AntiBan = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/AntiBan.lua'))()
local AutoFarm = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/AutoFarm.lua'))()
local AutoServer = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/AutoServer.lua'))()

-- Carrega os módulos da pasta Modules
local Race = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Race.lua'))()
local Weapons = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Weapons.lua'))()
local FightingStyles = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/FightingStyles.lua'))()
local Items = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Items.lua'))()
local Bosses = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Bosses.lua'))()
local Quests = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Quests.lua'))()
local Fishing = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Fishing.lua'))()
local Trade = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Modules/Trade.lua'))()

print("✅ Bibliotecas e módulos carregados com sucesso!")

-- Criar Interface
local Window = Rayfield:CreateWindow({
    Name = "⚓ BLOX FRUITS HUB",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "Aguarde",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BloxFruitsHub",
        FileName = "Config"
    },
    KeySystem = false
})

-- Atualiza informações do player
local player = game.Players.LocalPlayer
local level = player.Level or player:GetAttribute("Level") or 0

-- ================================
-- 👤 RAÇA
-- ================================
local RaceTab = Window:CreateTab("👤 RAÇA", "user")

RaceTab:CreateButton({
    Name = "FAZER TRIAL 1 - SHARK",
    Callback = function()
        Race.DoTrial(1)
    end
})

RaceTab:CreateButton({
    Name = "FAZER TRIAL 2 - SHARK",
    Callback = function()
        Race.DoTrial(2)
    end
})

RaceTab:CreateButton({
    Name = "FAZER TRIAL 3 - SHARK",
    Callback = function()
        Race.DoTrial(3)
    end
})

RaceTab:CreateButton({
    Name = "FAZER TRIAL 4 - SHARK",
    Callback = function()
        Race.DoTrial(4)
    end
})

RaceTab:CreateButton({
    Name = "PEGAR GEAR 1 - SHARK",
    Callback = function()
        Race.GetGear(1)
    end
})

RaceTab:CreateButton({
    Name = "PEGAR GEAR 2 - SHARK",
    Callback = function()
        Race.GetGear(2)
    end
})

RaceTab:CreateButton({
    Name = "PEGAR GEAR 3 - SHARK",
    Callback = function()
        Race.GetGear(3)
    end
})

RaceTab:CreateButton({
    Name = "ATIVAR V4 - SHARK",
    Callback = function()
        Race.ActivateV4()
    end
})

-- ================================
-- ⚔️ ARMAS
-- ================================
local WeaponsTab = Window:CreateTab("⚔️ ARMAS", "sword")

WeaponsTab:CreateSection("COMUNS")

WeaponsTab:CreateButton({
    Name = "PEGAR SABER",
    Callback = function()
        Weapons.GetSword("Saber")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR LONGSWORD",
    Callback = function()
        Weapons.GetSword("Longsword")
    end
})

WeaponsTab:CreateSection("RARAS")

WeaponsTab:CreateButton({
    Name = "PEGAR RENGOKU",
    Callback = function()
        Weapons.GetSword("Rengoku")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR BUDDY SWORD",
    Callback = function()
        Weapons.GetSword("Buddy Sword")
    end
})

WeaponsTab:CreateSection("LENDÁRIAS")

WeaponsTab:CreateButton({
    Name = "PEGAR SHISUI",
    Callback = function()
        Weapons.GetSword("Shisui")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR SADDI",
    Callback = function()
        Weapons.GetSword("Saddi")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR WANDO",
    Callback = function()
        Weapons.GetSword("Wando")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR TUSHITA",
    Callback = function()
        Weapons.GetSword("Tushita")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR YAMA",
    Callback = function()
        Weapons.GetSword("Yama")
    end
})

WeaponsTab:CreateSection("END GAME")

WeaponsTab:CreateButton({
    Name = "PEGAR TRUE TRIPLE KATANA",
    Callback = function()
        Weapons.GetSword("True Triple Katana")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR CURSED DUAL KATANA",
    Callback = function()
        Weapons.GetSword("Cursed Dual Katana")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR DARK BLADE",
    Callback = function()
        Weapons.GetSword("Dark Blade")
    end
})

WeaponsTab:CreateSection("GUNS")

WeaponsTab:CreateButton({
    Name = "PEGAR KABUCHA",
    Callback = function()
        Weapons.GetGun("Kabucha")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR ACIDUM RIFLE",
    Callback = function()
        Weapons.GetGun("Acidum Rifle")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR SERPENT BOW",
    Callback = function()
        Weapons.GetGun("Serpent Bow")
    end
})

WeaponsTab:CreateButton({
    Name = "PEGAR SOUL GUITAR",
    Callback = function()
        Weapons.GetGun("Soul Guitar")
    end
})

-- ================================
-- 🥊 ESTILOS
-- ================================
local StylesTab = Window:CreateTab("🥊 ESTILOS", "fist")

StylesTab:CreateSection("INICIAIS")

StylesTab:CreateButton({
    Name = "APRENDER COMBAT",
    Callback = function()
        FightingStyles.LearnStyle("Combat")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER DARK STEP",
    Callback = function()
        FightingStyles.LearnStyle("Dark Step")
    end
})

StylesTab:CreateSection("AVANÇADOS")

StylesTab:CreateButton({
    Name = "APRENDER ELECTRIC",
    Callback = function()
        FightingStyles.LearnStyle("Electric")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER WATER KUNG FU",
    Callback = function()
        FightingStyles.LearnStyle("Water Kung Fu")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER DRAGON BREATH",
    Callback = function()
        FightingStyles.LearnStyle("Dragon Breath")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER SUPERHUMAN",
    Callback = function()
        FightingStyles.LearnStyle("Superhuman")
    end
})

StylesTab:CreateSection("FINAIS")

StylesTab:CreateButton({
    Name = "APRENDER DEATH STEP",
    Callback = function()
        FightingStyles.LearnStyle("Death Step")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER SHARKMAN KARATE",
    Callback = function()
        FightingStyles.LearnStyle("Sharkman Karate")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER ELECTRIC CLAW",
    Callback = function()
        FightingStyles.LearnStyle("Electric Claw")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER DRAGON TALON",
    Callback = function()
        FightingStyles.LearnStyle("Dragon Talon")
    end
})

StylesTab:CreateButton({
    Name = "APRENDER GODHUMAN",
    Callback = function()
        FightingStyles.LearnStyle("Godhuman")
    end
})

-- ================================
-- 🎯 ITENS
-- ================================
local ItemsTab = Window:CreateTab("🎯 ITENS", "backpack")

ItemsTab:CreateButton({
    Name = "PEGAR PALM SCARF",
    Callback = function()
        Items.GetItem("Palm Scarf")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR LEI",
    Callback = function()
        Items.GetItem("Lei")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR HUNTER CAP",
    Callback = function()
        Items.GetItem("Hunter Cap")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR SWORD MASTER HAT",
    Callback = function()
        Items.GetItem("Sword Master Hat")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR GHOST BAND",
    Callback = function()
        Items.GetItem("Ghost Band")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR MUSKETEER HAT",
    Callback = function()
        Items.GetItem("Musketeer Hat")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR DARK COAT",
    Callback = function()
        Items.GetItem("Dark Coat")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR CAKE PRINCE CROWN",
    Callback = function()
        Items.GetItem("Cake Prince Crown")
    end
})

ItemsTab:CreateButton({
    Name = "PEGAR DOUGH CROWN",
    Callback = function()
        Items.GetItem("Dough Crown")
    end
})

-- ================================
-- 👹 BOSS
-- ================================
local BossTab = Window:CreateTab("👹 BOSS", "skull")

BossTab:CreateButton({
    Name = "DERROTAR DARKBEARD",
    Callback = function()
        Bosses.DefeatBoss("Darkbeard")
    end
})

BossTab:CreateButton({
    Name = "DERROTAR RIP INDRA",
    Callback = function()
        Bosses.DefeatBoss("Rip Indra")
    end
})

BossTab:CreateButton({
    Name = "DERROTAR DOUGH KING",
    Callback = function()
        Bosses.DefeatBoss("Dough King")
    end
})

BossTab:CreateButton({
    Name = "DERROTAR CAKE PRINCE",
    Callback = function()
        Bosses.DefeatBoss("Cake Prince")
    end
})

BossTab:CreateButton({
    Name = "DERROTAR LEVIATHAN",
    Callback = function()
        Bosses.DefeatBoss("Leviathan")
    end
})

BossTab:CreateButton({
    Name = "DERROTAR SEA BEAST",
    Callback = function()
        Bosses.DefeatBoss("Sea Beast")
    end
})

-- ================================
-- 📋 QUEST
-- ================================
local QuestTab = Window:CreateTab("📋 QUEST", "scroll")

QuestTab:CreateButton({
    Name = "FAZER QUEST CDK",
    Callback = function()
        Quests.DoQuest("Quest CDK")
    end
})

QuestTab:CreateButton({
    Name = "FAZER QUEST SOUL GUITAR",
    Callback = function()
        Quests.DoQuest("Quest Soul Guitar")
    end
})

QuestTab:CreateButton({
    Name = "FAZER QUEST GODHUMAN",
    Callback = function()
        Quests.DoQuest("Quest Godhuman")
    end
})

QuestTab:CreateButton({
    Name = "FAZER PUZZLE V4",
    Callback = function()
        Quests.DoQuest("Puzzle V4")
    end
})

QuestTab:CreateButton({
    Name = "FAZER QUEST MUSKETEER HAT",
    Callback = function()
        Quests.DoQuest("Quest Musketeer Hat")
    end
})

QuestTab:CreateButton({
    Name = "FAZER QUEST PALM SCARF",
    Callback = function()
        Quests.DoQuest("Quest Palm Scarf")
    end
})

-- ================================
-- 🐟 PESCA
-- ================================
local FishingTab = Window:CreateTab("🐟 PESCA", "fish")

FishingTab:CreateButton({
    Name = "PEGAR FISHING ROD",
    Callback = function()
        Fishing.GetItem("Fishing Rod")
    end
})

FishingTab:CreateButton({
    Name = "PEGAR GOLD ROD",
    Callback = function()
        Fishing.GetItem("Gold Rod")
    end
})

FishingTab:CreateButton({
    Name = "PEGAR SHARK ROD",
    Callback = function()
        Fishing.GetItem("Shark Rod")
    end
})

FishingTab:CreateButton({
    Name = "PEGAR SHELL ROD",
    Callback = function()
        Fishing.GetItem("Shell Rod")
    end
})

FishingTab:CreateButton({
    Name = "PEGAR BASIC BAIT",
    Callback = function()
        Fishing.GetItem("Basic Bait")
    end
})

FishingTab:CreateButton({
    Name = "PEGAR GOOD BAIT",
    Callback = function()
        Fishing.GetItem("Good Bait")
    end
})

FishingTab:CreateButton({
    Name = "PEGAR EPIC BAIT",
    Callback = function()
        Fishing.GetItem("Epic Bait")
    end
})

FishingTab:CreateButton({
    Name = "PESCAR PEIXE RARO",
    Callback = function()
        Fishing.CatchFish()
    end
})

-- ================================
-- 💰 TRADE
-- ================================
local TradeTab = Window:CreateTab("💰 TRADE", "diamond")

TradeTab:CreateButton({
    Name = "VER VALOR DARK BLADE",
    Callback = function()
        Trade.CheckValue("Dark Blade")
    end
})

TradeTab:CreateButton({
    Name = "VER VALOR FRUTAS",
    Callback = function()
        Trade.CheckValue("Dough Fruit")
        Trade.CheckValue("Leopard Fruit")
        Trade.CheckValue("Dragon Fruit")
        Trade.CheckValue("Kitsune Fruit")
    end
})

TradeTab:CreateButton({
    Name = "LISTAR ITENS RAROS",
    Callback = function()
        Trade.ListRareItems()
    end
})

TradeTab:CreateButton({
    Name = "VER COLECAO 100%",
    Callback = function()
        Trade.CheckCollection()
    end
})

-- ================================
-- ⚡ FARM
-- ================================
local FarmTab = Window:CreateTab("⚡ FARM", "lightning")

FarmTab:CreateSection("FARM DE LEVEL")

FarmTab:CreateButton({
    Name = "⚡ FARMAR NÍVEL MÁXIMO",
    Callback = function()
        if AutoFarm.Settings.IsRunning then
            AutoFarm.Stop()
        else
            AutoFarm.Start()
        end
    end
})

FarmTab:CreateButton({
    Name = "⏹ PARAR FARM",
    Callback = function()
        AutoFarm.Stop()
    end
})

-- ================================
-- ✅ CHECKLIST
-- ================================
local CheckTab = Window:CreateTab("✅ CHECKLIST", "check")

CheckTab:CreateSection("PROGRESSO GERAL")

CheckTab:CreateButton({
    Name = "VERIFICAR RAÇAS",
    Callback = function()
        Race.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "VERIFICAR ARMAS",
    Callback = function()
        Weapons.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "VERIFICAR ESTILOS",
    Callback = function()
        FightingStyles.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "VERIFICAR ITENS",
    Callback = function()
        Items.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "VERIFICAR BOSSES",
    Callback = function()
        Bosses.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "VERIFICAR QUESTS",
    Callback = function()
        Quests.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "VERIFICAR PESCA",
    Callback = function()
        Fishing.CheckProgress()
    end
})

CheckTab:CreateButton({
    Name = "ATUALIZAR CHECKLIST",
    Callback = function()
        print("[CHECKLIST] 🔄 Atualizando...")
        Race.CheckProgress()
        Weapons.CheckProgress()
        FightingStyles.CheckProgress()
        Items.CheckProgress()
        Bosses.CheckProgress()
        Quests.CheckProgress()
        Fishing.CheckProgress()
        print("[CHECKLIST] ✅ Checklist atualizado!")
    end
})

-- ================================
-- ⚙️ CONFIG
-- ================================
local ConfigTab = Window:CreateTab("⚙️ CONFIG", "settings")

ConfigTab:CreateButton({
    Name = "ALTERAR TEMA",
    Callback = function()
        print("[CONFIG] 🎨 Alterando tema...")
    end
})

ConfigTab:CreateButton({
    Name = "RELATAR BUG",
    Callback = function()
        print("[CONFIG] 🐛 Relatar bug no GitHub")
        print("  https://github.com/Marcileialves/Blox-Fruits-Script-Hub/issues")
    end
})

ConfigTab:CreateButton({
    Name = "ATUALIZAR CHECKLIST",
    Callback = function()
        print("[CONFIG] 🔄 Atualizando checklist...")
    end
})

-- ================================
-- RODAPÉ
-- ================================
print("✅ Hub carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")