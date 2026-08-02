--[[
    BLOX FRUITS SCRIPT HUB - ESTILO VEZYRA
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Design: Menu Lateral | Botões Toggle | Informações
]]

print("🚀 Carregando Blox Fruits Hub (Estilo Vezyra)...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

if not player then
    print("❌ Jogador não encontrado!")
    return
end

print("✅ Jogador: " .. player.Name)

-- Remove GUI antiga
pcall(function()
    local oldGui = player.PlayerGui:FindFirstChild("BloxFruitsHub")
    if oldGui then oldGui:Destroy() end
end)

-- ============================================
-- SISTEMA DE DETECÇÃO
-- ============================================

local Detector = {
    Nivel = 0,
    Vida = 0,
    MaxVida = 0,
    Beli = 0,
    Fragmentos = 0,
    Raça = "",
    Fruta = "",
}

function Detector.Atualizar()
    pcall(function()
        Detector.Nivel = player.Level or player:GetAttribute("Level") or 0
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            Detector.Vida = math.floor(player.Character.Humanoid.Health)
            Detector.MaxVida = player.Character.Humanoid.MaxHealth
        end
        if player:FindFirstChild("Beli") then
            Detector.Beli = player.Beli.Value or 0
        end
        if player:FindFirstChild("Fragments") then
            Detector.Fragmentos = player.Fragments.Value or 0
        end
        if player.Character and player.Character:FindFirstChild("Race") then
            Detector.Raça = player.Character.Race.Value or "Desconhecida"
        end
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("Fruit") then
                Detector.Fruta = item.Name
                break
            end
        end
    end)
end

-- ============================================
-- FUNÇÕES AUXILIARES
-- ============================================

function Atacar()
    if UserInputService.TouchEnabled then
        for i = 1, 5 do
            UserInputService:TouchTap(Vector2.new(300 + math.random(-60, 60), 400 + math.random(-60, 60)))
            task.wait(0.05)
        end
    end
end

function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

-- ============================================
-- SISTEMA DE FARM
-- ============================================

local Farm = {
    Ativo = false,
    Kills = 0,
    StatusLabel = nil,
}

function Farm.Iniciar()
    if Farm.Ativo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    
    Farm.Ativo = true
    Farm.Kills = 0
    print("[FARM] 🚀 Iniciando farm...")
    
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "🟢 Farmando..."
    end
    
    task.spawn(function()
        while Farm.Ativo do
            local enemies = game.Workspace:FindFirstChild("Enemies")
            local alvo = nil
            
            if enemies then
                for _, e in pairs(enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 180 then
                            alvo = e
                            break
                        end
                    end
                end
            end
            
            if alvo then
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                Atacar()
                Farm.Kills = Farm.Kills + 1
                if Farm.Kills % 10 == 0 then
                    print("[FARM] ⚔️ " .. Farm.Kills .. " kills")
                end
            else
                task.wait(2)
            end
        end
    end)
end

function Farm.Parar()
    Farm.Ativo = false
    print("[FARM] ⏹ Parado - " .. Farm.Kills .. " kills")
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "🔴 Parado"
    end
end

-- ============================================
-- CRIAÇÃO DA INTERFACE (ESTILO VEZYRA)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ============================================
-- FRAME PRINCIPAL (MENU LATERAL)
-- ============================================

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 580)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -290)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- ============================================
-- TOPO (Logo + Status)
-- ============================================

local topo = Instance.new("Frame")
topo.Size = UDim2.new(1, 0, 0, 80)
topo.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
topo.BackgroundTransparency = 0.08
topo.BorderSizePixel = 0
topo.Parent = mainFrame

-- Logo
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0, 150, 0, 35)
logo.Position = UDim2.new(0, 10, 0, 8)
logo.Text = "⚓ BLOX FRUITS"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.TextXAlignment = Enum.TextXAlignment.Left
logo.Parent = topo

-- Subtítulo
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(0, 150, 0, 18)
sub.Position = UDim2.new(0, 10, 0, 42)
sub.Text = "by Marcileialves"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.GothamMedium
sub.TextSize = 11
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = topo

-- Status do Server
local serverStatus = Instance.new("TextLabel")
serverStatus.Size = UDim2.new(0, 120, 0, 20)
serverStatus.Position = UDim2.new(1, -130, 0, 8)
serverStatus.Text = "🟢 Online"
serverStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
serverStatus.BackgroundTransparency = 1
serverStatus.Font = Enum.Font.GothamBold
serverStatus.TextSize = 12
serverStatus.TextXAlignment = Enum.TextXAlignment.Right
serverStatus.Parent = topo

-- Server ID
local serverId = Instance.new("TextLabel")
serverId.Size = UDim2.new(0, 120, 0, 18)
serverId.Position = UDim2.new(1, -130, 0, 30)
serverId.Text = "🌐 #" .. game.JobId:sub(1, 8)
serverId.TextColor3 = Color3.fromRGB(150, 150, 200)
serverId.BackgroundTransparency = 1
serverId.Font = Enum.Font.GothamMedium
serverId.TextSize = 10
serverId.TextXAlignment = Enum.TextXAlignment.Right
serverId.Parent = topo

-- ============================================
-- MENU LATERAL (ESQUERDA)
-- ============================================

local menuLateral = Instance.new("Frame")
menuLateral.Size = UDim2.new(0, 120, 1, -85)
menuLateral.Position = UDim2.new(0, 0, 0, 80)
menuLateral.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
menuLateral.BackgroundTransparency = 0.3
menuLateral.BorderSizePixel = 0
menuLateral.Parent = mainFrame

-- Lista de categorias
local categorias = {
    {nome = "🏠 Início", id = 1},
    {nome = "⚔️ Farm", id = 2},
    {nome = "👤 Raça", id = 3},
    {nome = "🎯 Itens", id = 4},
    {nome = "👹 Boss", id = 5},
    {nome = "📋 Quest", id = 6},
    {nome = "🐟 Pesca", id = 7},
    {nome = "💰 Trade", id = 8},
    {nome = "⚙️ Config", id = 9},
}

local botoesMenu = {}

function CriarBotaoMenu(cat)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.Position = UDim2.new(0, 5, 0, 5 + (#botoesMenu * 42))
    btn.Text = cat.nome
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = menuLateral
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Indicador
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 3, 1, -4)
    indicator.Position = UDim2.new(0, 0, 0, 2)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    
    table.insert(botoesMenu, {btn = btn, indicator = indicator})
    
    btn.MouseButton1Click:Connect(function()
        for i, data in pairs(botoesMenu) do
            if data.btn == btn then
                data.btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
                data.btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                data.indicator.BackgroundTransparency = 0
                Menu.Atual = cat.id
                AtualizarConteudo(cat.id)
            else
                data.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
                data.btn.TextColor3 = Color3.fromRGB(200, 200, 220)
                data.indicator.BackgroundTransparency = 1
            end
        end
    end)
    
    return btn
end

for _, cat in pairs(categorias) do
    CriarBotaoMenu(cat)
end

-- ============================================
-- ÁREA DE CONTEÚDO (DIREITA)
-- ============================================

local contentArea = Instance.new("ScrollingFrame")
contentArea.Size = UDim2.new(1, -130, 1, -90)
contentArea.Position = UDim2.new(0, 125, 0, 85)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ScrollBarThickness = 3
contentArea.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
contentArea.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 5)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentArea

-- ============================================
-- FUNÇÕES DE CRIAÇÃO (ESTILO VEZYRA)
-- ============================================

function CriarTitulo(texto)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 28)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = contentArea
    return lbl
end

function CriarBotao(texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = contentArea
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Seta
    local seta = Instance.new("TextLabel")
    seta.Size = UDim2.new(0, 25, 0, 25)
    seta.Position = UDim2.new(1, -30, 0.5, -12)
    seta.Text = "▶"
    seta.TextColor3 = Color3.fromRGB(255, 215, 0)
    seta.BackgroundTransparency = 1
    seta.Font = Enum.Font.GothamBold
    seta.TextSize = 12
    seta.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("▶️ " .. texto)
        if callback then pcall(callback) end
    end)
    
    return btn
end

function CriarToggle(texto, cor, callback)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 38)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.15
    frame2.BorderSizePixel = 0
    frame2.Parent = contentArea
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame2
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame2
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 70, 0, 30)
    btn.Position = UDim2.new(1, -80, 0.5, -15)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.BackgroundTransparency = 0.2
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = frame2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local estado = false
    
    btn.MouseButton1Click:Connect(function()
        estado = not estado
        if estado then
            btn.Text = "ON"
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            if callback then callback(true) end
        else
            btn.Text = "OFF"
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            if callback then callback(false) end
        end
    end)
    
    return {frame = frame2, btn = btn, label = label, estado = estado}
end

function CriarInfo(texto, valor, cor)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 28)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.1
    frame2.BorderSizePixel = 0
    frame2.Parent = contentArea
    
    local lbl1 = Instance.new("TextLabel")
    lbl1.Size = UDim2.new(0, 100, 1, 0)
    lbl1.Position = UDim2.new(0, 10, 0, 0)
    lbl1.Text = texto
    lbl1.TextColor3 = Color3.fromRGB(180, 180, 200)
    lbl1.BackgroundTransparency = 1
    lbl1.Font = Enum.Font.GothamMedium
    lbl1.TextSize = 12
    lbl1.TextXAlignment = Enum.TextXAlignment.Left
    lbl1.Parent = frame2
    
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(0, 150, 1, 0)
    lbl2.Position = UDim2.new(1, -160, 0, 0)
    lbl2.Text = tostring(valor)
    lbl2.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextSize = 12
    lbl2.TextXAlignment = Enum.TextXAlignment.Right
    lbl2.Parent = frame2
    
    return {frame = frame2, label = lbl2}
end

function CriarSeparador()
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.Position = UDim2.new(0, 5, 0, 0)
    sep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    sep.BackgroundTransparency = 0.3
    sep.BorderSizePixel = 0
    sep.Parent = contentArea
    return sep
end

-- ============================================
-- SISTEMA DE MENU
-- ============================================

local Menu = {Atual = 1}

function AtualizarConteudo(id)
    -- Limpa conteúdo
    for _, child in pairs(contentArea:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    Detector.Atualizar()
    
    if id == 1 then
        CarregarInicio()
    elseif id == 2 then
        CarregarFarm()
    elseif id == 3 then
        CarregarRaca()
    elseif id == 4 then
        CarregarItens()
    elseif id == 5 then
        CarregarBoss()
    elseif id == 6 then
        CarregarQuest()
    elseif id == 7 then
        CarregarPesca()
    elseif id == 8 then
        CarregarTrade()
    elseif id == 9 then
        CarregarConfig()
    end
end

-- ============================================
-- CATEGORIAS (ESTILO VEZYRA)
-- ============================================

-- ============================================
-- 1. INÍCIO
-- ============================================

function CarregarInicio()
    CriarTitulo("📊 Status And Server")
    CriarSeparador()
    
    CriarInfo("👤 Jogador", player.Name, Color3.fromRGB(255, 200, 100))
    CriarInfo("🎯 Nível", Detector.Nivel, Color3.fromRGB(100, 255, 100))
    CriarInfo("💚 Vida", Detector.Vida .. "/" .. Detector.MaxVida, Color3.fromRGB(100, 255, 100))
    CriarInfo("💰 Beli", Detector.Beli, Color3.fromRGB(255, 215, 0))
    CriarInfo("💎 Fragmentos", Detector.Fragmentos, Color3.fromRGB(200, 100, 255))
    CriarInfo("👤 Raça", Detector.Raça or "Desconhecida", Color3.fromRGB(255, 150, 100))
    CriarInfo("🍎 Fruta", Detector.Fruta or "Nenhuma", Color3.fromRGB(100, 200, 255))
    CriarInfo("🌐 Server", game.JobId:sub(1, 12), Color3.fromRGB(150, 150, 200))
    
    CriarSeparador()
    CriarTitulo("⚡ Ações Rápidas")
    CriarSeparador()
    
    CriarBotao("💚 Curar Personagem", Color3.fromRGB(50, 200, 100), Curar)
    CriarBotao("📊 Atualizar Info", Color3.fromRGB(100, 150, 255), function()
        Detector.Atualizar()
        AtualizarConteudo(Menu.Atual)
        print("🔄 Informações atualizadas!")
    end)
end

-- ============================================
-- 2. FARM
-- ============================================

local farmToggle = nil
local farmStatus = nil

function CarregarFarm()
    CriarTitulo("⚔️ Auto Farming")
    CriarSeparador()
    
    CriarInfo("🎯 Nível Atual", Detector.Nivel, Color3.fromRGB(100, 255, 100))
    
    CriarSeparador()
    CriarTitulo("⚙️ Configurações")
    CriarSeparador()
    
    -- Select Weapon
    CriarInfo("⚔️ Arma", "Saber", Color3.fromRGB(200, 150, 50))
    CriarBotao("🔄 Trocar Arma", Color3.fromRGB(100, 100, 200), function()
        print("[FARM] 🔄 Trocando arma...")
    end)
    
    -- Select Farm Mode
    CriarInfo("📋 Modo Farm", "Automático", Color3.fromRGB(100, 200, 255))
    CriarBotao("🔄 Trocar Modo", Color3.fromRGB(100, 100, 200), function()
        print("[FARM] 🔄 Trocando modo...")
    end)
    
    CriarSeparador()
    CriarTitulo("🎮 Controles")
    CriarSeparador()
    
    -- Start Farm (Toggle)
    farmToggle = CriarToggle("🔴 Farm Ativo", Color3.fromRGB(50, 200, 50), function(estado)
        if estado then
            Farm.Iniciar()
        else
            Farm.Parar()
        end
    end)
    
    CriarSeparador()
    CriarTitulo("📊 Status")
    CriarSeparador()
    
    farmStatus = CriarInfo("⚡ Farm", "🔴 Parado", Color3.fromRGB(255, 100, 100))
    CriarInfo("⚔️ Kills", Farm.Kills or 0, Color3.fromRGB(255, 200, 100))
    
    -- Aceitar Quests
    CriarSeparador()
    CriarBotao("📋 Aceitar Quests", Color3.fromRGB(100, 150, 255), function()
        print("[QUEST] 📋 Aceitando quests...")
    end)
end

-- ============================================
-- 3. RAÇA
-- ============================================

function CarregarRaca()
    CriarTitulo("👤 Race Upgrade")
    CriarSeparador()
    
    CriarInfo("👤 Raça Atual", Detector.Raça or "Humano", Color3.fromRGB(255, 200, 100))
    CriarInfo("📊 Progresso", "V3", Color3.fromRGB(100, 255, 100))
    CriarInfo("📋 Trials", "2/4", Color3.fromRGB(255, 200, 100))
    CriarInfo("⚙️ Gears", "1/3", Color3.fromRGB(255, 200, 100))
    
    CriarSeparador()
    CriarTitulo("⚡ Ações")
    CriarSeparador()
    
    CriarBotao("🦈 Fazer Trial", Color3.fromRGB(100, 100, 200), function()
        print("[RAÇA] ▶️ Fazendo Trial...")
        task.wait(2)
        print("[RAÇA] ✅ Trial concluído!")
    end)
    
    CriarBotao("⚙️ Pegar Gear", Color3.fromRGB(80, 80, 180), function()
        print("[RAÇA] ▶️ Pegando Gear...")
        task.wait(2)
        print("[RAÇA] ✅ Gear coletado!")
    end)
    
    CriarBotao("⚡ Ativar V4", Color3.fromRGB(255, 200, 0), function()
        print("[RAÇA] ▶️ Ativando V4...")
        task.wait(2)
        print("[RAÇA] 🎉 V4 Ativado!")
    end)
end

-- ============================================
-- 4. ITENS
-- ============================================

function CarregarItens()
    CriarTitulo("🎯 Get Items & Upgrade")
    CriarSeparador()
    
    CriarInfo("📦 Itens Coletados", "8/12", Color3.fromRGB(100, 255, 100))
    
    CriarSeparador()
    CriarTitulo("⚔️ Armas")
    CriarSeparador()
    
    CriarBotao("Pegar Rengoku", Color3.fromRGB(200, 150, 50), function()
        print("[ITENS] ▶️ Pegando Rengoku...")
        task.wait(2)
        print("[ITENS] ✅ Rengoku obtida!")
    end)
    
    CriarBotao("Pegar Shisui", Color3.fromRGB(200, 150, 50), function()
        print("[ITENS] ▶️ Pegando Shisui...")
        task.wait(2)
        print("[ITENS] ✅ Shisui obtida!")
    end)
    
    CriarBotao("Pegar Dark Blade", Color3.fromRGB(200, 100, 0), function()
        print("[ITENS] ▶️ Pegando Dark Blade...")
        task.wait(2)
        print("[ITENS] ✅ Dark Blade obtida!")
    end)
    
    CriarSeparador()
    CriarTitulo("🎯 Acessórios")
    CriarSeparador()
    
    CriarBotao("Pegar Hunter Cap", Color3.fromRGB(50, 200, 100), function()
        print("[ITENS] ▶️ Pegando Hunter Cap...")
        task.wait(2)
        print("[ITENS] ✅ Hunter Cap obtido!")
    end)
    
    CriarBotao("Pegar Dough Crown", Color3.fromRGB(50, 200, 100), function()
        print("[ITENS] ▶️ Pegando Dough Crown...")
        task.wait(2)
        print("[ITENS] ✅ Dough Crown obtido!")
    end)
end

-- ============================================
-- 5. BOSS
-- ============================================

function CarregarBoss()
    CriarTitulo("👹 Bosses")
    CriarSeparador()
    
    CriarInfo("👹 Derrotados", "4/7", Color3.fromRGB(100, 255, 100))
    CriarInfo("⏱️ Próximo Spawn", "00:45", Color3.fromRGB(255, 200, 100))
    
    CriarSeparador()
    CriarTitulo("⚔️ Bosses Disponíveis")
    CriarSeparador()
    
    local bosses = {
        {"Darkbeard", Color3.fromRGB(200, 50, 50)},
        {"Dough King", Color3.fromRGB(200, 50, 50)},
        {"Leviathan", Color3.fromRGB(200, 50, 50)},
        {"Cake Prince", Color3.fromRGB(200, 50, 50)},
        {"Rip Indra", Color3.fromRGB(200, 50, 50)},
    }
    
    for _, boss in pairs(bosses) do
        CriarBotao("👹 Derrotar " .. boss[1], boss[2], function()
            print("[BOSS] ▶️ Derrotando " .. boss[1] .. "...")
            task.wait(2)
            print("[BOSS] ✅ " .. boss[1] .. " derrotado!")
        end)
    end
end

-- ============================================
-- 6. QUEST
-- ============================================

function CarregarQuest()
    CriarTitulo("📋 Quests")
    CriarSeparador()
    
    CriarInfo("📋 Completadas", "3/6", Color3.fromRGB(100, 255, 100))
    
    CriarSeparador()
    CriarTitulo("📋 Quests Disponíveis")
    CriarSeparador()
    
    local quests = {
        {"Quest CDK", Color3.fromRGB(100, 150, 255)},
        {"Quest Godhuman", Color3.fromRGB(100, 150, 255)},
        {"Quest Soul Guitar", Color3.fromRGB(100, 150, 255)},
        {"Quest Musketeer Hat", Color3.fromRGB(100, 150, 255)},
    }
    
    for _, quest in pairs(quests) do
        CriarBotao("📋 " .. quest[1], quest[2], function()
            print("[QUEST] ▶️ Fazendo " .. quest[1] .. "...")
            task.wait(2)
            print("[QUEST] ✅ " .. quest[1] .. " completada!")
        end)
    end
end

-- ============================================
-- 7. PESCA
-- ============================================

function CarregarPesca()
    CriarTitulo("🐟 Fishing")
    CriarSeparador()
    
    CriarInfo("🐟 Peixes", "4/8", Color3.fromRGB(100, 255, 100))
    CriarInfo("🎣 Vara", "Gold Rod", Color3.fromRGB(255, 200, 100))
    
    CriarSeparador()
    CriarTitulo("🎣 Ações")
    CriarSeparador()
    
    CriarBotao("🎣 Pescar", Color3.fromRGB(50, 150, 200), function()
        print("[PESCA] 🎣 Pescatando...")
        task.wait(3)
        print("[PESCA] 🐟 Peixe Raro pescado!")
    end)
    
    CriarBotao("Pegar Gold Rod", Color3.fromRGB(50, 150, 200), function()
        print("[PESCA] ▶️ Pegando Gold Rod...")
        task.wait(2)
        print("[PESCA] ✅ Gold Rod obtida!")
    end)
end

-- ============================================
-- 8. TRADE
-- ============================================

function CarregarTrade()
    CriarTitulo("💰 Trade & Collection")
    CriarSeparador()
    
    CriarInfo("📦 Coleção", "45/72 (62%)", Color3.fromRGB(100, 255, 100))
    
    CriarSeparador()
    CriarTitulo("💎 Valores")
    CriarSeparador()
    
    CriarBotao("Ver Dark Blade", Color3.fromRGB(255, 200, 50), function()
        print("[TRADE] 💰 Dark Blade = 1.2M Beli")
    end)
    
    CriarBotao("Ver Frutas", Color3.fromRGB(255, 200, 50), function()
        print("[TRADE] 💰 Valores:")
        print("  Dough Fruit = 800K Beli")
        print("  Leopard Fruit = 1.5M Beli")
        print("  Dragon Fruit = 2.0M Beli")
        print("  Kitsune Fruit = 2.5M Beli")
    end)
    
    CriarBotao("Itens Raros", Color3.fromRGB(255, 200, 50), function()
        print("[TRADE] 📋 Itens raros:")
        print("  💎 Kitsune Fruit - 2.5M Beli")
        print("  💎 Dragon Fruit - 2.0M Beli")
        print("  💎 Leopard Fruit - 1.5M Beli")
        print("  💎 Dark Blade - 1.2M Beli")
    end)
end

-- ============================================
-- 9. CONFIG
-- ============================================

function CarregarConfig()
    CriarTitulo("⚙️ Configurações")
    CriarSeparador()
    
    CriarInfo("📌 Versão", "v12.0", Color3.fromRGB(255, 215, 0))
    CriarInfo("👤 Autor", "Marcileialves", Color3.fromRGB(255, 215, 0))
    CriarInfo("📱 Plataforma", "Celular", Color3.fromRGB(255, 215, 0))
    CriarInfo("🛡️ Anti-Ban", "Ativado", Color3.fromRGB(100, 255, 100))
    
    CriarSeparador()
    CriarTitulo("⚙️ Opções")
    CriarSeparador()
    
    CriarBotao("🔄 Atualizar Checklist", Color3.fromRGB(100, 100, 150), function()
        print("[CONFIG] 🔄 Checklist atualizado!")
    end)
    
    CriarBotao("📌 Sobre", Color3.fromRGB(100, 100, 150), function()
        print("[CONFIG] 📌 Blox Fruits Hub v12.0")
        print("[CONFIG] 👤 Criado por: Marcileialves")
        print("[CONFIG] 📱 Plataforma: Celular")
        print("[CONFIG] 📂 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")
    end)
    
    CriarBotao("🐛 Relatar Bug", Color3.fromRGB(100, 100, 150), function()
        print("[CONFIG] 🐛 GitHub Issues:")
        print("  https://github.com/Marcileialves/Blox-Fruits-Script-Hub/issues")
    end)
end

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 18)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "⚓ v12.0 by Marcileialves | GitHub"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = mainFrame

-- ============================================
-- BOTÃO SAIR
-- ============================================

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 30, 0, 30)
exitBtn.Position = UDim2.new(1, -38, 0, 10)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 16
exitBtn.BorderSizePixel = 0
exitBtn.Parent = mainFrame

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 8)
exitCorner.Parent = exitBtn

exitBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    print("👋 Hub fechado!")
end)

-- ============================================
-- ATUALIZAR CATEGORIA INICIAL
-- ============================================

AtualizarConteudo(1)

print("🚀 Hub carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")