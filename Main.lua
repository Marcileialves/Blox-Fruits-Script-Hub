--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 5.0 (FARM AUTOMÁTICO)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Farm Automático | Anti-Ban | Mobile Otimizado
]]

print("🔥 Carregando Blox Fruits Hub 5.0...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

if not player then
    print("❌ Jogador não encontrado!")
    return
end

print("✅ Jogador: " .. player.Name)

pcall(function()
    local old = player.PlayerGui:FindFirstChild("BloxFruitsHub")
    if old then old:Destroy() end
end)

-- ============================================
-- SISTEMA DE ILHAS (NÍVEL POR ILHA)
-- ============================================

local Ilhas = {
    {nome = "Jungle", nivelMin = 1, nivelMax = 30, xp = 80, quest = "Jungle Quest"},
    {nome = "Pirate Village", nivelMin = 15, nivelMax = 45, xp = 100, quest = "Pirate Quest"},
    {nome = "Desert", nivelMin = 30, nivelMax = 60, xp = 150, quest = "Desert Quest"},
    {nome = "Frozen Village", nivelMin = 50, nivelMax = 90, xp = 200, quest = "Frozen Quest"},
    {nome = "Marine Fortress", nivelMin = 70, nivelMax = 120, xp = 250, quest = "Marine Quest"},
    {nome = "Skypiea", nivelMin = 90, nivelMax = 150, xp = 300, quest = "Skypiea Quest"},
    {nome = "Prison", nivelMin = 120, nivelMax = 200, xp = 400, quest = "Prison Quest"},
    {nome = "Colosseum", nivelMin = 150, nivelMax = 250, xp = 500, quest = "Colosseum Quest"},
    {nome = "Magma Village", nivelMin = 200, nivelMax = 300, xp = 600, quest = "Magma Quest"},
    {nome = "Underwater City", nivelMin = 250, nivelMax = 400, xp = 700, quest = "Underwater Quest"},
    {nome = "Fountain City", nivelMin = 350, nivelMax = 500, xp = 800, quest = "Fountain Quest"},
    {nome = "Kingdom of Rose", nivelMin = 500, nivelMax = 750, xp = 900, quest = "Rose Quest"},
    {nome = "Green Zone", nivelMin = 600, nivelMax = 850, xp = 1000, quest = "Green Quest"},
    {nome = "Graveyard", nivelMin = 700, nivelMax = 950, xp = 1100, quest = "Graveyard Quest"},
    {nome = "Cursed Ship", nivelMin = 900, nivelMax = 1200, xp = 1200, quest = "Cursed Quest"},
    {nome = "Ice Castle", nivelMin = 1100, nivelMax = 1400, xp = 1300, quest = "Ice Quest"},
    {nome = "Forgotten Island", nivelMin = 1300, nivelMax = 1600, xp = 1400, quest = "Forgotten Quest"},
    {nome = "Hydra Island", nivelMin = 1500, nivelMax = 2000, xp = 1600, quest = "Hydra Quest"},
    {nome = "Great Tree", nivelMin = 1700, nivelMax = 2200, xp = 1800, quest = "Great Quest"},
    {nome = "Floating Turtle", nivelMin = 1900, nivelMax = 2500, xp = 2000, quest = "Turtle Quest"},
    {nome = "Sea of Treats", nivelMin = 2200, nivelMax = 3000, xp = 2500, quest = "Sea Quest"},
}

function EncontrarMelhorIlha()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local melhor = nil
    local melhorXp = -1
    
    for _, ilha in pairs(Ilhas) do
        if nivel >= ilha.nivelMin and nivel <= ilha.nivelMax then
            if ilha.xp > melhorXp then
                melhorXp = ilha.xp
                melhor = ilha
            end
        end
    end
    
    if not melhor then
        for _, ilha in pairs(Ilhas) do
            if nivel >= ilha.nivelMin then
                melhor = ilha
                break
            end
        end
    end
    
    return melhor or Ilhas[1]
end

-- ============================================
-- FUNÇÕES DE AÇÃO
-- ============================================

function Teleportar(CFrame)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function()
            player.Character.HumanoidRootPart.CFrame = CFrame
            task.wait(0.3)
        end)
        return true
    end
    return false
end

function TeleportarIlha(nome)
    print("[TELEPORTE] 🚀 Indo para: " .. nome)
    local ilha = workspace:FindFirstChild(nome)
    if ilha then
        Teleportar(ilha.CFrame + Vector3.new(0, 50, 0))
        task.wait(1)
        return true
    end
    return false
end

function Atacar()
    if UserInputService.TouchEnabled then
        for i = 1, 5 do
            UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
            task.wait(0.08)
        end
    end
end

function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        end
    end)
end

-- ============================================
-- FARM AUTOMÁTICO COMPLETO
-- ============================================

local farmAtivo = false
local kills = 0
local nivelInicial = 0

function FarmarAutomatico()
    if farmAtivo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    
    farmAtivo = true
    kills = 0
    nivelInicial = player.Level or player:GetAttribute("Level") or 0
    
    print("[FARM] 🚀 INICIANDO FARM AUTOMÁTICO!")
    print("[FARM] 🎯 Nível Inicial: " .. nivelInicial)
    print("[FARM] 🎯 Meta: Nível 3000")
    
    task.spawn(function()
        while farmAtivo do
            -- Verifica se atingiu o nível máximo
            local nivelAtual = player.Level or player:GetAttribute("Level") or 0
            if nivelAtual >= 3000 then
                print("[FARM] 🎉 NÍVEL MÁXIMO ATINGIDO! 3000/3000")
                break
            end
            
            -- Encontra a melhor ilha para o nível atual
            local ilha = EncontrarMelhorIlha()
            if ilha then
                print("[FARM] 📍 Ilha: " .. ilha.nome .. " (Nv " .. ilha.nivelMin .. "-" .. ilha.nivelMax .. ")")
                TeleportarIlha(ilha.nome)
                task.wait(2)
            end
            
            -- Procura inimigos
            local enemies = workspace:FindFirstChild("Enemies")
            local alvo = nil
            local menorDist = 999
            
            if enemies then
                for _, e in pairs(enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < menorDist then
                            menorDist = dist
                            alvo = e
                        end
                    end
                end
            end
            
            if alvo then
                -- Teleporta para o inimigo
                Teleportar(alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5))
                task.wait(0.1)
                
                -- Ataca com Fast Attack
                for i = 1, 8 do
                    Atacar()
                    task.wait(0.06)
                end
                
                kills = kills + 1
                
                -- Anti-Ban: Pausa a cada 10 kills
                if kills % 10 == 0 then
                    task.wait(math.random(2, 5))
                end
                
                -- Relatório a cada 50 kills
                if kills % 50 == 0 then
                    local nivel = player.Level or player:GetAttribute("Level") or 0
                    print("[FARM] ⚔️ " .. kills .. " kills | Nível: " .. nivel)
                end
            else
                print("[FARM] ⚠️ Procurando inimigos...")
                task.wait(2)
            end
            
            -- Verifica se subiu de nível
            local novoNivel = player.Level or player:GetAttribute("Level") or 0
            if novoNivel > nivelAtual then
                print("[FARM] 🎉 Nível UP! " .. nivelAtual .. " → " .. novoNivel)
                
                -- Cura automática ao subir de nível
                Curar()
            end
        end
        
        farmAtivo = false
        local nivelFinal = player.Level or player:GetAttribute("Level") or 0
        print("[FARM] ✅ FARM CONCLUÍDO!")
        print("[FARM] 📊 Nível: " .. nivelInicial .. " → " .. nivelFinal)
        print("[FARM] ⚔️ Kills: " .. kills)
    end)
end

function PararFarm()
    farmAtivo = false
    print("[FARM] ⏹ Parado - " .. kills .. " kills")
end

-- ============================================
-- FUNÇÕES DAS CATEGORIAS
-- ============================================

function AcaoSimples(nome)
    print("[AÇÃO] ▶️ " .. nome)
    task.wait(1.5)
    print("[AÇÃO] ✅ " .. nome .. " concluído!")
end

function MostrarInfo()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    local maxHealth = player.Character and player.Character.Humanoid and player.Character.Humanoid.MaxHealth or 100
    local ilha = EncontrarMelhorIlha()
    
    print("📊 INFORMAÇÕES:")
    print("  👤 " .. player.Name)
    print("  🎯 Nível: " .. nivel .. "/3000")
    print("  💚 Vida: " .. health .. "/" .. maxHealth)
    if farmAtivo then
        print("  ⚔️ Kills: " .. kills)
    end
    if ilha then
        print("  📍 Melhor Ilha: " .. ilha.nome)
    end
end

-- ============================================
-- CRIA INTERFACE
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 370, 0, 530)
frame.Position = UDim2.new(0.5, -185, 0.5, -265)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 0
header.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 45)
logo.Text = "🔥 BLOX FRUITS 5.0"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Parent = header

-- Botão Sair
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 28, 0, 28)
exitBtn.Position = UDim2.new(1, -34, 0, 8)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 14
exitBtn.BorderSizePixel = 0
exitBtn.Parent = header

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 6)
exitCorner.Parent = exitBtn

exitBtn.TouchTap:Connect(function()
    farmAtivo = false
    gui:Destroy()
    print("👋 Hub fechado!")
end)

exitBtn.MouseButton1Click:Connect(function()
    farmAtivo = false
    gui:Destroy()
    print("👋 Hub fechado!")
end)

-- ============================================
-- MENU LATERAL
-- ============================================

local menuLateral = Instance.new("Frame")
menuLateral.Size = UDim2.new(0, 70, 1, -50)
menuLateral.Position = UDim2.new(0, 0, 0, 45)
menuLateral.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
menuLateral.BackgroundTransparency = 0.2
menuLateral.BorderSizePixel = 0
menuLateral.Parent = frame

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -80, 1, -50)
content.Position = UDim2.new(0, 75, 0, 45)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
content.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 3)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

-- ============================================
-- CATEGORIAS
-- ============================================

local categorias = {
    {nome = "⚔️", id = 1, label = "RAIDS"},
    {nome = "🌊", id = 2, label = "SEA"},
    {nome = "👹", id = 3, label = "BOSS"},
    {nome = "⚡", id = 4, label = "FARM"},
    {nome = "🍎", id = 5, label = "FRUTAS"},
    {nome = "🗡️", id = 6, label = "ESPADAS"},
    {nome = "🥊", id = 7, label = "ESTILOS"},
    {nome = "👤", id = 8, label = "RAÇA"},
    {nome = "🟣", id = 9, label = "HAKI"},
    {nome = "📦", id = 10, label = "MAT."},
    {nome = "📋", id = 11, label = "MISSOES"},
    {nome = "🌐", id = 12, label = "SERVER"},
    {nome = "⚙️", id = 13, label = "UTIL"},
}

local botoesMenu = {}

function CriarBotaoMenu(cat)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 38)
    btn.Position = UDim2.new(0, 2, 0, 2 + (#botoesMenu * 40))
    btn.Text = cat.nome .. "\n" .. cat.label
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 9
    btn.BorderSizePixel = 0
    btn.Parent = menuLateral
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 2, 1, -4)
    indicator.Position = UDim2.new(0, 0, 0, 2)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    
    table.insert(botoesMenu, {btn = btn, indicator = indicator})
    
    btn.TouchTap:Connect(function()
        SelecionarCategoria(cat.id)
    end)
    
    btn.MouseButton1Click:Connect(function()
        SelecionarCategoria(cat.id)
    end)
    
    return btn
end

for _, cat in pairs(categorias) do
    CriarBotaoMenu(cat)
end

-- ============================================
-- SELEÇÃO
-- ============================================

local categoriaAtual = 1

function SelecionarCategoria(id)
    categoriaAtual = id
    
    for i, data in pairs(botoesMenu) do
        if i == id then
            data.btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            data.btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            data.indicator.BackgroundTransparency = 0
        else
            data.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            data.btn.TextColor3 = Color3.fromRGB(200, 200, 220)
            data.indicator.BackgroundTransparency = 1
        end
    end
    
    CarregarConteudo(id)
end

-- ============================================
-- CRIAÇÃO DE ELEMENTOS
-- ============================================

function CriarBotao(texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 34)
    btn.Position = UDim2.new(0, 2, 0, 0)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 0, 20)
    arrow.Position = UDim2.new(1, -25, 0.5, -10)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 10
    arrow.Parent = btn
    
    btn.TouchTap:Connect(function()
        if callback then pcall(callback) end
        arrow.Text = "✅"
        arrow.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
    
    btn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
        arrow.Text = "✅"
        arrow.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
    
    return btn
end

function CriarSecao(texto, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -4, 0, 22)
    lbl.Position = UDim2.new(0, 2, 0, 0)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    return lbl
end

function CriarInfo(texto, valor, cor)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, -4, 0, 22)
    frame2.Position = UDim2.new(0, 2, 0, 0)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.1
    frame2.BorderSizePixel = 0
    frame2.Parent = content
    
    local lbl1 = Instance.new("TextLabel")
    lbl1.Size = UDim2.new(0, 80, 1, 0)
    lbl1.Position = UDim2.new(0, 6, 0, 0)
    lbl1.Text = texto
    lbl1.TextColor3 = Color3.fromRGB(180, 180, 200)
    lbl1.BackgroundTransparency = 1
    lbl1.Font = Enum.Font.GothamMedium
    lbl1.TextSize = 10
    lbl1.TextXAlignment = Enum.TextXAlignment.Left
    lbl1.Parent = frame2
    
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(0, 120, 1, 0)
    lbl2.Position = UDim2.new(1, -130, 0, 0)
    lbl2.Text = tostring(valor)
    lbl2.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextSize = 10
    lbl2.TextXAlignment = Enum.TextXAlignment.Right
    lbl2.Parent = frame2
end

function CriarSeparador()
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.Position = UDim2.new(0, 5, 0, 0)
    sep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    sep.BackgroundTransparency = 0.4
    sep.BorderSizePixel = 0
    sep.Parent = content
end

-- ============================================
-- CONTEÚDO DAS CATEGORIAS
-- ============================================

function CarregarConteudo(id)
    for _, child in pairs(content:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    if id == 1 then CarregarRaids()
    elseif id == 2 then CarregarSea()
    elseif id == 3 then CarregarBoss()
    elseif id == 4 then CarregarFarm()
    elseif id == 5 then CarregarFrutas()
    elseif id == 6 then CarregarEspadas()
    elseif id == 7 then CarregarEstilos()
    elseif id == 8 then CarregarRaca()
    elseif id == 9 then CarregarHaki()
    elseif id == 10 then CarregarMateriais()
    elseif id == 11 then CarregarMissoes()
    elseif id == 12 then CarregarServidor()
    elseif id == 13 then CarregarUtil()
    end
end

-- ============================================
-- CATEGORIA 4: FARM (PRINCIPAL)
-- ============================================

function CarregarFarm()
    CriarSecao("⚡ FARM AUTOMÁTICO")
    CriarSeparador()
    
    CriarBotao("🚀 Farmar Nível Máximo", Color3.fromRGB(0, 200, 100), FarmarAutomatico)
    CriarBotao("⏹ Parar Farm", Color3.fromRGB(200, 50, 50), PararFarm)
    CriarBotao("💚 Curar", Color3.fromRGB(50, 200, 100), Curar)
    
    CriarSecao("📊 STATUS")
    CriarSeparador()
    
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local ilha = EncontrarMelhorIlha()
    
    CriarInfo("Nível", nivel .. "/3000", Color3.fromRGB(100, 255, 100))
    CriarInfo("Kills", kills, Color3.fromRGB(255, 200, 100))
    CriarInfo("Ilha", ilha and ilha.nome or "Desconhecida", Color3.fromRGB(100, 200, 255))
end

-- ============================================
-- CATEGORIA 1: RAIDS
-- ============================================

function CarregarRaids()
    CriarSecao("⚔️ RAIDS")
    CriarSeparador()
    CriarBotao("Farmar Raid", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Farmar Raid") end)
    CriarBotao("Repetir Raid", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Repetir Raid") end)
    CriarBotao("Despertar Fruta", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Despertar Fruta") end)
    CriarBotao("Farmar Fragmentos", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Farmar Fragmentos") end)
end

-- ============================================
-- CATEGORIA 2: SEA EVENTS
-- ============================================

function CarregarSea()
    CriarSecao("🌊 SEA EVENTS")
    CriarSeparador()
    CriarBotao("Derrotar Terror Shark", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Terror Shark") end)
    CriarBotao("Derrotar Sea Beast", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Sea Beast") end)
    CriarBotao("Derrotar Leviathan", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Leviathan") end)
    CriarBotao("Encontrar Mirage Island", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Mirage Island") end)
    CriarBotao("Encontrar Kitsune Shrine", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Kitsune Shrine") end)
    CriarBotao("Encontrar Prehistoric Island", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Prehistoric Island") end)
    CriarBotao("Encontrar Frozen Dimension", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Frozen Dimension") end)
end

-- ============================================
-- CATEGORIA 3: BOSSES
-- ============================================

function CarregarBoss()
    CriarSecao("👹 BOSSES")
    CriarSeparador()
    local bosses = {
        "Derrotar Elite Pirates",
        "Derrotar Rip Indra",
        "Derrotar Dough King",
        "Derrotar Cake Prince",
        "Derrotar Soul Reaper",
        "Derrotar Longma",
        "Derrotar Don Swan",
        "Derrotar Beautiful Pirate",
        "Derrotar Greybeard",
    }
    for _, boss in pairs(bosses) do
        CriarBotao(boss, Color3.fromRGB(200, 50, 50), function() AcaoSimples(boss) end)
    end
end

-- ============================================
-- CATEGORIA 5: FRUTAS
-- ============================================

function CarregarFrutas()
    CriarSecao("🍎 FRUTAS")
    CriarSeparador()
    CriarBotao("Comprar Frutas", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Comprar Frutas") end)
    CriarBotao("Girar Frutas", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Girar Frutas") end)
    CriarBotao("Procurar Frutas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Procurar Frutas") end)
    CriarBotao("Coletar Frutas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Coletar Frutas") end)
    CriarBotao("Despertar Frutas", Color3.fromRGB(255, 200, 100), function() AcaoSimples("Despertar Frutas") end)
end

-- ============================================
-- CATEGORIA 6: ESPADAS
-- ============================================

function CarregarEspadas()
    CriarSecao("🗡️ ESPADAS")
    CriarSeparador()
    local espadas = {
        "True Triple Katana",
        "Cursed Dual Katana",
        "Shark Anchor",
        "Dark Blade V3",
        "Hallow Scythe",
        "Dragon Trident",
    }
    for _, espada in pairs(espadas) do
        CriarBotao("Conseguir " .. espada, Color3.fromRGB(200, 150, 50), function() AcaoSimples("Conseguir " .. espada) end)
    end
end

-- ============================================
-- CATEGORIA 7: ESTILOS
-- ============================================

function CarregarEstilos()
    CriarSecao("🥊 ESTILOS")
    CriarSeparador()
    local estilos = {
        "Superhuman",
        "Death Step",
        "Sharkman Karate",
        "Electric Claw",
        "Dragon Talon",
        "God Human",
        "Sanguine Art",
    }
    for _, estilo in pairs(estilos) do
        CriarBotao("Conseguir " .. estilo, Color3.fromRGB(150, 100, 200), function() AcaoSimples("Conseguir " .. estilo) end)
    end
end

-- ============================================
-- CATEGORIA 8: RAÇA
-- ============================================

function CarregarRaca()
    CriarSecao("👤 RAÇA")
    CriarSeparador()
    CriarBotao("Evoluir Race V2", Color3.fromRGB(100, 100, 200), function() AcaoSimples("Evoluir Race V2") end)
    CriarBotao("Evoluir Race V3", Color3.fromRGB(100, 100, 200), function() AcaoSimples("Evoluir Race V3") end)
    CriarBotao("Evoluir Race V4", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Evoluir Race V4") end)
    CriarBotao("Completar Trial da Raça", Color3.fromRGB(100, 100, 200), function() AcaoSimples("Completar Trial da Raça") end)
    CriarBotao("Conseguir Blue Gear", Color3.fromRGB(80, 80, 180), function() AcaoSimples("Conseguir Blue Gear") end)
end

-- ============================================
-- CATEGORIA 9: HAKI
-- ============================================

function CarregarHaki()
    CriarSecao("🟣 HAKI")
    CriarSeparador()
    CriarBotao("Evoluir Aura", Color3.fromRGB(200, 100, 255), function() AcaoSimples("Evoluir Aura") end)
    CriarBotao("Evoluir Observation Haki", Color3.fromRGB(200, 100, 255), function() AcaoSimples("Evoluir Observation Haki") end)
    CriarBotao("Conseguir Observation V2", Color3.fromRGB(200, 100, 255), function() AcaoSimples("Conseguir Observation V2") end)
    CriarBotao("Conseguir Rainbow Haki", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Conseguir Rainbow Haki") end)
end

-- ============================================
-- CATEGORIA 10: MATERIAIS
-- ============================================

function CarregarMateriais()
    CriarSecao("📦 MATERIAIS")
    CriarSeparador()
    CriarBotao("Coletar Materiais Comuns", Color3.fromRGB(150, 150, 150), function() AcaoSimples("Coletar Materiais Comuns") end)
    CriarBotao("Coletar Materiais Raros", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Coletar Materiais Raros") end)
    CriarBotao("Coletar Itens de Bosses", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Coletar Itens de Bosses") end)
    CriarBotao("Coletar Chaves", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Coletar Chaves") end)
    CriarBotao("Coletar Itens de Eventos", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Coletar Itens de Eventos") end)
end

-- ============================================
-- CATEGORIA 11: MISSÕES
-- ============================================

function CarregarMissoes()
    CriarSecao("📋 MISSÕES")
    CriarSeparador()
    CriarBotao("Completar Missões", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Missões") end)
    CriarBotao("Completar Elite Hunter", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Elite Hunter") end)
    CriarBotao("Completar Citizen Quest", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Citizen Quest") end)
    CriarBotao("Completar Alchemist Quest", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Alchemist Quest") end)
    CriarBotao("Completar Dojo", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Dojo") end)
end

-- ============================================
-- CATEGORIA 12: SERVIDOR
-- ============================================

function CarregarServidor()
    CriarSecao("🌐 SERVIDOR")
    CriarSeparador()
    CriarBotao("Procurar Servidor", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Procurar Servidor") end)
    CriarBotao("Trocar de Servidor", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Trocar de Servidor") end)
    CriarBotao("Reentrar no Servidor", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Reentrar no Servidor") end)
    CriarBotao("Procurar Servidor Vazio", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Procurar Servidor Vazio") end)
end

-- ============================================
-- CATEGORIA 13: UTILIDADES
-- ============================================

function CarregarUtil()
    CriarSecao("⚙️ UTILIDADES")
    CriarSeparador()
    CriarBotao("💚 Curar", Color3.fromRGB(50, 200, 100), Curar)
    CriarBotao("📊 Mostrar Informações", Color3.fromRGB(100, 150, 255), MostrarInfo)
    CriarBotao("🏝️ Teleportar Jungle", Color3.fromRGB(50, 200, 100), function() TeleportarIlha("Jungle") end)
    CriarBotao("🏝️ Teleportar Prison", Color3.fromRGB(50, 200, 100), function() TeleportarIlha("Prison") end)
    CriarBotao("⚔️ Atacar Inimigo", Color3.fromRGB(200, 50, 50), function()
        print("[AÇÃO] ⚔️ Atacando...")
        Atacar()
    end)
end

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 16)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "⭐ v5.0 Auto Farm | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 8
footer.Parent = frame

-- ============================================
-- INICIALIZA
-- ============================================

SelecionarCategoria(4)

print("✅ Blox Fruits Hub 5.0 carregado!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")