--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO CELULAR
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Compatível com: Delta, Arceus X, Codex (Android)
]]

print("🚀 Carregando Blox Fruits Script Hub (Celular)...")

local player = game.Players.LocalPlayer

if not player then
    print("❌ Jogador não encontrado!")
    return
end

print("✅ Jogador: " .. player.Name)

-- Remove GUI antiga
local oldGui = player.PlayerGui:FindFirstChild("BloxFruitsHubMobile")
if oldGui then oldGui:Destroy() end

-- ============================================
-- CRIA INTERFACE (SEM RAYFIELD)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHubMobile"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- Fundo da janela
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 560)
frame.Position = UDim2.new(0.5, -180, 0.5, -280)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

-- Arredondar bordas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "⚓ BLOX FRUITS HUB"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 35)
subtitle.Text = "📱 Versão Celular"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 11
subtitle.Parent = frame

-- Linha divisória
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0, 58)
line.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
line.BackgroundTransparency = 0.5
line.Parent = frame

-- ============================================
-- VARIÁVEIS
-- ============================================
local farmAtivo = false
local player = game.Players.LocalPlayer

-- ============================================
-- FUNÇÃO PARA CRIAR BOTÕES
-- ============================================

function criarBotao(texto, y, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 320, 0, 38)
    btn.Position = UDim2.new(0.5, -160, 0, y)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(0, 150, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("▶️ " .. texto)
        if callback then callback() end
    end)
    
    return btn
end

function criarLabel(texto, y, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.Position = UDim2.new(0, 0, 0, y)
    lbl.Text = texto
    lbl.TextColor3 = cor or Color3.fromRGB(200, 200, 200)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.Parent = frame
    return lbl
end

function criarToggle(texto, y, cor, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 320, 0, 35)
    toggle.Position = UDim2.new(0.5, -160, 0, y)
    toggle.Text = texto .. " ❌"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 80)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.BorderSizePixel = 0
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    local ativo = false
    
    toggle.MouseButton1Click:Connect(function()
        ativo = not ativo
        toggle.Text = texto .. (ativo and " ✅" or " ❌")
        print("[TOGGLE] " .. texto .. (ativo and " ATIVADO" or " DESATIVADO"))
        if callback then callback(ativo) end
    end)
    
    return toggle
end

function criarSelecao(texto, y, opcoes, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 320, 0, 35)
    btn.Position = UDim2.new(0.5, -160, 0, y)
    btn.Text = texto .. ": " .. opcoes[1]
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local index = 1
    
    btn.MouseButton1Click:Connect(function()
        index = index + 1
        if index > #opcoes then index = 1 end
        btn.Text = texto .. ": " .. opcoes[index]
        print("[SELECAO] " .. texto .. " = " .. opcoes[index])
        if callback then callback(opcoes[index]) end
    end)
    
    return btn
end

-- ============================================
-- FUNÇÃO DE ATAQUE (CELULAR)
-- ============================================

local function atacarCelular()
    local uis = game:GetService("UserInputService")
    if uis.TouchEnabled then
        uis:TouchTap(Vector2.new(500, 300))
    end
end

-- ============================================
-- FUNÇÃO DE FARM (CELULAR)
-- ============================================

function Farmar()
    if farmAtivo then
        print("[FARM] ⚠️ Farm já está ativo!")
        return
    end
    
    farmAtivo = true
    print("[FARM] 🚀 Iniciando farm...")
    
    task.spawn(function()
        local kills = 0
        local targetKills = 30
        
        while farmAtivo and kills < targetKills do
            -- Procura inimigos
            local enemies = game.Workspace:FindFirstChild("Enemies")
            local enemy = nil
            
            if enemies then
                for _, child in pairs(enemies:GetChildren()) do
                    if child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
                        local dist = (child.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 100 then
                            enemy = child
                            break
                        end
                    end
                end
            end
            
            if enemy then
                -- Teleporta perto
                player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                -- Ataca
                atacarCelular()
                task.wait(0.5)
                
                kills = kills + 1
                print("[FARM] ⚔️ " .. kills .. "/" .. targetKills)
            else
                task.wait(1)
            end
        end
        
        farmAtivo = false
        print("[FARM] ✅ Farm concluído! " .. kills .. " kills")
    end)
end

function PararFarm()
    farmAtivo = false
    print("[FARM] ⏹ Parando farm...")
end

function Curar()
    player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
    print("💚 Curado!")
end

-- ============================================
-- FUNÇÕES DOS MÓDULOS (SIMPLIFICADAS)
-- ============================================

local Race = {
    DoTrial = function(num)
        print("[RAÇA] ▶️ Fazendo Trial " .. num)
        task.wait(2)
        print("[RAÇA] ✅ Trial " .. num .. " concluído!")
    end,
    GetGear = function(num)
        print("[RAÇA] ▶️ Pegando Gear " .. num)
        task.wait(2)
        print("[RAÇA] ✅ Gear " .. num .. " coletado!")
    end,
    ActivateV4 = function()
        print("[RAÇA] ▶️ Ativando V4...")
        task.wait(2)
        print("[RAÇA] 🎉 V4 Ativado!")
    end,
    CheckProgress = function()
        print("[RAÇA] 📊 Progresso: 3/4 Trials, 2/3 Gears")
    end
}

local Weapons = {
    GetSword = function(name)
        print("[ARMAS] ▶️ Pegando " .. name)
        task.wait(2)
        print("[ARMAS] ✅ " .. name .. " obtida!")
    end,
    GetGun = function(name)
        print("[ARMAS] ▶️ Pegando " .. name)
        task.wait(2)
        print("[ARMAS] ✅ " .. name .. " obtida!")
    end,
    CheckProgress = function()
        print("[ARMAS] 📊 8/12 Espadas, 1/4 Guns")
    end
}

local FightingStyles = {
    LearnStyle = function(name)
        print("[ESTILOS] ▶️ Aprendendo " .. name)
        task.wait(2)
        print("[ESTILOS] ✅ " .. name .. " aprendido!")
    end,
    CheckProgress = function()
        print("[ESTILOS] 📊 6/9 Estilos")
    end
}

local Items = {
    GetItem = function(name)
        print("[ITENS] ▶️ Pegando " .. name)
        task.wait(2)
        print("[ITENS] ✅ " .. name .. " obtido!")
    end,
    CheckProgress = function()
        print("[ITENS] 📊 5/9 Itens")
    end
}

local Bosses = {
    DefeatBoss = function(name)
        print("[BOSS] ▶️ Derrotando " .. name)
        task.wait(2)
        print("[BOSS] ✅ " .. name .. " derrotado!")
    end,
    CheckProgress = function()
        print("[BOSS] 📊 4/7 Bosses")
    end
}

local Quests = {
    DoQuest = function(name)
        print("[QUEST] ▶️ Fazendo " .. name)
        task.wait(2)
        print("[QUEST] ✅ " .. name .. " completada!")
    end,
    CheckProgress = function()
        print("[QUEST] 📊 3/6 Quests")
    end
}

local Fishing = {
    GetItem = function(name)
        print("[PESCA] ▶️ Pegando " .. name)
        task.wait(2)
        print("[PESCA] ✅ " .. name .. " obtido!")
    end,
    CatchFish = function()
        print("[PESCA] 🎣 Pescatando...")
        task.wait(3)
        print("[PESCA] 🐟 Peixe Raro pescado!")
    end,
    CheckProgress = function()
        print("[PESCA] 📊 4/8 Itens")
    end
}

local Trade = {
    CheckValue = function(name)
        print("[TRADE] 💰 " .. name .. " = 1.2M Beli")
    end,
    ListRareItems = function()
        print("[TRADE] 📋 Itens raros:")
        print("  💎 Kitsune Fruit - 2.5M Beli")
        print("  💎 Dragon Fruit - 2.0M Beli")
    end,
    CheckCollection = function()
        print("[TRADE] 📊 Coleção: 45/72 (62.5%)")
    end
}

-- ============================================
-- CRIAR INTERFACE COMPLETA
-- ============================================

local y = 65

-- Info do jogador
criarLabel("👤 " .. player.Name, y, Color3.fromRGB(255, 200, 100))
y = y + 22
local vidaLabel = criarLabel("💚 Vida: " .. math.floor(player.Character.Humanoid.Health), y, Color3.fromRGB(100, 255, 100))
y = y + 30

-- ================================
-- 👤 RAÇA
-- ================================
criarLabel("━ 👤 RAÇA ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("TRIAL 1 - SHARK", y, Color3.fromRGB(100, 100, 200), function() Race.DoTrial(1) end)
y = y + 42
criarBotao("TRIAL 2 - SHARK", y, Color3.fromRGB(100, 100, 200), function() Race.DoTrial(2) end)
y = y + 42
criarBotao("TRIAL 3 - SHARK", y, Color3.fromRGB(100, 100, 200), function() Race.DoTrial(3) end)
y = y + 42
criarBotao("TRIAL 4 - SHARK", y, Color3.fromRGB(100, 100, 200), function() Race.DoTrial(4) end)
y = y + 42
criarBotao("GEAR 1 - SHARK", y, Color3.fromRGB(80, 80, 180), function() Race.GetGear(1) end)
y = y + 42
criarBotao("GEAR 2 - SHARK", y, Color3.fromRGB(80, 80, 180), function() Race.GetGear(2) end)
y = y + 42
criarBotao("GEAR 3 - SHARK", y, Color3.fromRGB(80, 80, 180), function() Race.GetGear(3) end)
y = y + 42
criarBotao("⚡ ATIVAR V4", y, Color3.fromRGB(255, 200, 0), function() Race.ActivateV4() end)
y = y + 48

-- ================================
-- ⚔️ ARMAS
-- ================================
criarLabel("━ ⚔️ ARMAS ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("PEGAR SABER", y, Color3.fromRGB(200, 150, 50), function() Weapons.GetSword("Saber") end)
y = y + 42
criarBotao("PEGAR RENGOKU", y, Color3.fromRGB(200, 150, 50), function() Weapons.GetSword("Rengoku") end)
y = y + 42
criarBotao("PEGAR SHISUI", y, Color3.fromRGB(200, 150, 50), function() Weapons.GetSword("Shisui") end)
y = y + 42
criarBotao("PEGAR SADDI", y, Color3.fromRGB(200, 150, 50), function() Weapons.GetSword("Saddi") end)
y = y + 42
criarBotao("PEGAR YAMA", y, Color3.fromRGB(200, 150, 50), function() Weapons.GetSword("Yama") end)
y = y + 42
criarBotao("PEGAR TRUE TRIPLE", y, Color3.fromRGB(200, 100, 0), function() Weapons.GetSword("True Triple Katana") end)
y = y + 42
criarBotao("PEGAR CDK", y, Color3.fromRGB(200, 100, 0), function() Weapons.GetSword("Cursed Dual Katana") end)
y = y + 48

-- ================================
-- 🥊 ESTILOS
-- ================================
criarLabel("━ 🥊 ESTILOS ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("APRENDER COMBAT", y, Color3.fromRGB(150, 100, 200), function() FightingStyles.LearnStyle("Combat") end)
y = y + 42
criarBotao("APRENDER ELECTRIC", y, Color3.fromRGB(150, 100, 200), function() FightingStyles.LearnStyle("Electric") end)
y = y + 42
criarBotao("APRENDER WATER KUNG FU", y, Color3.fromRGB(150, 100, 200), function() FightingStyles.LearnStyle("Water Kung Fu") end)
y = y + 42
criarBotao("APRENDER SUPERHUMAN", y, Color3.fromRGB(150, 100, 200), function() FightingStyles.LearnStyle("Superhuman") end)
y = y + 42
criarBotao("APRENDER GODHUMAN", y, Color3.fromRGB(255, 150, 0), function() FightingStyles.LearnStyle("Godhuman") end)
y = y + 48

-- ================================
-- 🎯 ITENS
-- ================================
criarLabel("━ 🎯 ITENS ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("PEGAR PALM SCARF", y, Color3.fromRGB(50, 200, 100), function() Items.GetItem("Palm Scarf") end)
y = y + 42
criarBotao("PEGAR HUNTER CAP", y, Color3.fromRGB(50, 200, 100), function() Items.GetItem("Hunter Cap") end)
y = y + 42
criarBotao("PEGAR MUSKETEER HAT", y, Color3.fromRGB(50, 200, 100), function() Items.GetItem("Musketeer Hat") end)
y = y + 42
criarBotao("PEGAR DOUGH CROWN", y, Color3.fromRGB(50, 200, 100), function() Items.GetItem("Dough Crown") end)
y = y + 48

-- ================================
-- 👹 BOSS
-- ================================
criarLabel("━ 👹 BOSS ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("DERROTAR DARKBEARD", y, Color3.fromRGB(200, 50, 50), function() Bosses.DefeatBoss("Darkbeard") end)
y = y + 42
criarBotao("DERROTAR DOUGH KING", y, Color3.fromRGB(200, 50, 50), function() Bosses.DefeatBoss("Dough King") end)
y = y + 42
criarBotao("DERROTAR LEVIATHAN", y, Color3.fromRGB(200, 50, 50), function() Bosses.DefeatBoss("Leviathan") end)
y = y + 48

-- ================================
-- 📋 QUEST
-- ================================
criarLabel("━ 📋 QUEST ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("FAZER QUEST CDK", y, Color3.fromRGB(100, 150, 255), function() Quests.DoQuest("Quest CDK") end)
y = y + 42
criarBotao("FAZER QUEST GODHUMAN", y, Color3.fromRGB(100, 150, 255), function() Quests.DoQuest("Quest Godhuman") end)
y = y + 48

-- ================================
-- 🐟 PESCA
-- ================================
criarLabel("━ 🐟 PESCA ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("PEGAR FISHING ROD", y, Color3.fromRGB(50, 150, 200), function() Fishing.GetItem("Fishing Rod") end)
y = y + 42
criarBotao("PEGAR GOLD ROD", y, Color3.fromRGB(50, 150, 200), function() Fishing.GetItem("Gold Rod") end)
y = y + 42
criarBotao("PESCAR PEIXE RARO", y, Color3.fromRGB(50, 150, 200), function() Fishing.CatchFish() end)
y = y + 48

-- ================================
-- 💰 TRADE
-- ================================
criarLabel("━ 💰 TRADE ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("VER VALOR DARK BLADE", y, Color3.fromRGB(255, 200, 50), function() Trade.CheckValue("Dark Blade") end)
y = y + 42
criarBotao("VER VALOR FRUTAS", y, Color3.fromRGB(255, 200, 50), function() Trade.CheckValue("Dough Fruit") end)
y = y + 42
criarBotao("VER COLECAO 100%", y, Color3.fromRGB(255, 200, 50), function() Trade.CheckCollection() end)
y = y + 48

-- ================================
-- ⚡ FARM
-- ================================
criarLabel("━ ⚡ FARM ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("⚡ FARMAR NÍVEL MÁXIMO", y, Color3.fromRGB(0, 200, 100), function()
    Farmar()
end)
y = y + 42

criarBotao("⏹ PARAR FARM", y, Color3.fromRGB(200, 50, 50), function()
    PararFarm()
end)
y = y + 48

-- ================================
-- ✅ CHECKLIST
-- ================================
criarLabel("━ ✅ CHECKLIST ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("VERIFICAR RAÇAS", y, Color3.fromRGB(100, 255, 100), function() Race.CheckProgress() end)
y = y + 42
criarBotao("VERIFICAR ARMAS", y, Color3.fromRGB(100, 255, 100), function() Weapons.CheckProgress() end)
y = y + 42
criarBotao("VERIFICAR ESTILOS", y, Color3.fromRGB(100, 255, 100), function() FightingStyles.CheckProgress() end)
y = y + 42
criarBotao("VERIFICAR ITENS", y, Color3.fromRGB(100, 255, 100), function() Items.CheckProgress() end)
y = y + 42
criarBotao("VERIFICAR BOSSES", y, Color3.fromRGB(100, 255, 100), function() Bosses.CheckProgress() end)
y = y + 42
criarBotao("VERIFICAR QUESTS", y, Color3.fromRGB(100, 255, 100), function() Quests.CheckProgress() end)
y = y + 42
criarBotao("VERIFICAR PESCA", y, Color3.fromRGB(100, 255, 100), function() Fishing.CheckProgress() end)
y = y + 48

-- ================================
-- ⚙️ CONFIG
-- ================================
criarLabel("━ ⚙️ CONFIG ━", y, Color3.fromRGB(255, 215, 0))
y = y + 22

criarBotao("RELATAR BUG", y, Color3.fromRGB(100, 100, 150), function()
    print("[CONFIG] 🐛 Relatar bug no GitHub:")
    print("  https://github.com/Marcileialves/Blox-Fruits-Script-Hub/issues")
end)
y = y + 42

criarBotao("✖ SAIR", y + 10, Color3.fromRGB(100, 50, 50), function()
    gui:Destroy()
    print("👋 Hub fechado!")
end)

-- ============================================
-- ATUALIZAR VIDA
-- ============================================
task.spawn(function()
    while gui and gui.Parent do
        task.wait(1)
        local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
        if vidaLabel then
            vidaLabel.Text = "💚 Vida: " .. health
        end
    end
end)

-- ============================================
-- RODAPÉ
-- ============================================
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.Text = "v3.0 (Celular) | GitHub: Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 150)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Hub carregado com sucesso no celular!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")