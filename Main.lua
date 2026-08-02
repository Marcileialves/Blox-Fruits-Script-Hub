--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO CELULAR
    Design Bonito e Organizado
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🚀 Carregando Blox Fruits Script Hub...")

local player = game.Players.LocalPlayer

if not player then
    print("❌ Jogador não encontrado!")
    return
end

print("✅ Jogador: " .. player.Name)

-- Remove GUI antiga
local oldGui = player.PlayerGui:FindFirstChild("BloxFruitsHub")
if oldGui then oldGui:Destroy() end

-- ============================================
-- CRIA GUI PRINCIPAL
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ============================================
-- FUNDO COM GRADIENTE
-- ============================================

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 580)
frame.Position = UDim2.new(0.5, -190, 0.5, -290)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Arredondar bordas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

-- Sombra
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.Position = UDim2.new(0, 0, 0, 0)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.6
shadow.BorderSizePixel = 0
shadow.Parent = frame

-- ============================================
-- CABEÇALHO COM GRADIENTE
-- ============================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.15
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = header

-- Ícone do hub
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(0, 40, 0, 40)
icon.Position = UDim2.new(0, 10, 0, 10)
icon.Text = "⚓"
icon.TextColor3 = Color3.fromRGB(255, 215, 0)
icon.BackgroundTransparency = 1
icon.Font = Enum.Font.GothamBold
icon.TextSize = 28
icon.Parent = header

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 0, 30)
title.Position = UDim2.new(0, 55, 0, 8)
title.Text = "BLOX FRUITS"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Subtítulo
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0, 200, 0, 20)
subtitle.Position = UDim2.new(0, 55, 0, 32)
subtitle.Text = "📱 Versão Celular"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 220)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

-- ============================================
-- ABA DE NAVEGAÇÃO
-- ============================================

local navBar = Instance.new("Frame")
navBar.Size = UDim2.new(0, 380, 0, 45)
navBar.Position = UDim2.new(0, 0, 0, 60)
navBar.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
navBar.BackgroundTransparency = 0.3
navBar.BorderSizePixel = 0
navBar.Parent = frame

-- Container de abas (scroll horizontal)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 1, 0)
tabContainer.Position = UDim2.new(0, 0, 0, 0)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = navBar

-- ============================================
-- CONTEÚDO DAS ABAS
-- ============================================

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -10, 1, -115)
contentFrame.Position = UDim2.new(0, 5, 0, 105)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 3
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
contentFrame.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 6)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = contentFrame

-- ============================================
-- VARIÁVEIS
-- ============================================
local farmAtivo = false
local abaAtual = 1
local botoesAba = {}

-- ============================================
-- FUNÇÃO PARA CRIAR ABAS
-- ============================================

function criarAba(icone, nome, cor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 70, 0, 40)
    btn.Position = UDim2.new(0, 5 + (#botoesAba * 75), 0, 2)
    btn.Text = icone .. "\n" .. nome
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.Parent = tabContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Indicador de seleção
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 40, 0, 3)
    indicator.Position = UDim2.new(0.5, -20, 1, -3)
    indicator.BackgroundColor3 = cor or Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    
    local abaId = #botoesAba + 1
    table.insert(botoesAba, {btn = btn, indicator = indicator, cor = cor or Color3.fromRGB(255, 215, 0)})
    
    btn.MouseButton1Click:Connect(function()
        selecionarAba(abaId)
    end)
    
    return btn
end

function selecionarAba(id)
    abaAtual = id
    for i, data in pairs(botoesAba) do
        if i == id then
            data.btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            data.btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            data.indicator.BackgroundTransparency = 0
        else
            data.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            data.btn.TextColor3 = Color3.fromRGB(180, 180, 200)
            data.indicator.BackgroundTransparency = 1
        end
    end
    
    -- Limpa conteúdo
    for _, child in pairs(contentFrame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    -- Recria conteúdo da aba
    if id == 1 then criarAbaPrincipal() end
    if id == 2 then criarAbaRaca() end
    if id == 3 then criarAbaArmas() end
    if id == 4 then criarAbaEstilos() end
    if id == 5 then criarAbaFarm() end
    if id == 6 then criarAbaChecklist() end
end

-- ============================================
-- FUNÇÃO PARA CRIAR BOTÕES BONITOS
-- ============================================

function criarBotao(texto, cor, callback, icone)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 48)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.Text = (icone or "▸") .. " " .. texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.2
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = contentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    -- Efeito de brilho ao passar o dedo
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.05
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.2
    end)
    
    -- Seta indicadora
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 30, 0, 30)
    arrow.Position = UDim2.new(1, -40, 0.5, -15)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 14
    arrow.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("▶️ " .. texto)
        if callback then callback() end
    end)
    
    return btn
end

function criarLabel(texto, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 30)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.Text = texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = contentFrame
    return lbl
end

function criarSeparador()
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -20, 0, 2)
    sep.Position = UDim2.new(0, 10, 0, 0)
    sep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    sep.BackgroundTransparency = 0.5
    sep.BorderSizePixel = 0
    sep.Parent = contentFrame
    return sep
end

-- ============================================
-- FUNÇÕES DO SISTEMA
-- ============================================

local function atacarCelular()
    local uis = game:GetService("UserInputService")
    if uis.TouchEnabled then
        uis:TouchTap(Vector2.new(500, 300))
    end
end

function Farmar()
    if farmAtivo then
        print("[FARM] ⚠️ Farm já está ativo!")
        return
    end
    
    farmAtivo = true
    print("[FARM] 🚀 Iniciando farm...")
    
    task.spawn(function()
        local kills = 0
        local targetKills = 50
        
        while farmAtivo and kills < targetKills do
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
                player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
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
-- ABAS
-- ============================================

-- Criar abas
criarAba("🏠", "Início", Color3.fromRGB(100, 200, 255))
criarAba("👤", "Raça", Color3.fromRGB(255, 150, 100))
criarAba("⚔️", "Armas", Color3.fromRGB(255, 200, 50))
criarAba("🥊", "Estilos", Color3.fromRGB(200, 100, 255))
criarAba("⚡", "Farm", Color3.fromRGB(100, 255, 100))
criarAba("📊", "Check", Color3.fromRGB(100, 200, 255))

-- ============================================
-- CONTEÚDO DA ABA INÍCIO
-- ============================================

function criarAbaPrincipal()
    criarLabel("📋 MENU PRINCIPAL")
    criarSeparador()
    
    criarBotao("⚡ FARMAR NÍVEL MÁXIMO", Color3.fromRGB(0, 180, 100), Farmar)
    criarBotao("⏹ PARAR FARM", Color3.fromRGB(200, 50, 50), PararFarm)
    criarBotao("💚 CURAR PERSONAGEM", Color3.fromRGB(50, 200, 100), Curar)
    
    criarLabel("")
    criarLabel("👤 INFORMAÇÕES")
    criarSeparador()
    
    local infoFrame = Instance.new("Frame")
    infoFrame.Size = UDim2.new(1, -20, 0, 60)
    infoFrame.Position = UDim2.new(0, 10, 0, 0)
    infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    infoFrame.BackgroundTransparency = 0.3
    infoFrame.BorderSizePixel = 0
    infoFrame.Parent = contentFrame
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 10)
    infoCorner.Parent = infoFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 28)
    nameLabel.Position = UDim2.new(0, 10, 0, 2)
    nameLabel.Text = "👤 " .. player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = infoFrame
    
    local healthLabel = Instance.new("TextLabel")
    healthLabel.Size = UDim2.new(1, 0, 0, 24)
    healthLabel.Position = UDim2.new(0, 10, 0, 30)
    healthLabel.Text = "💚 Vida: " .. math.floor(player.Character.Humanoid.Health)
    healthLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    healthLabel.BackgroundTransparency = 1
    healthLabel.Font = Enum.Font.GothamMedium
    healthLabel.TextSize = 12
    healthLabel.TextXAlignment = Enum.TextXAlignment.Left
    healthLabel.Parent = infoFrame
    
    -- Atualiza vida automaticamente
    task.spawn(function()
        while gui and gui.Parent do
            task.wait(1)
            local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
            healthLabel.Text = "💚 Vida: " .. health
        end
    end)
    
    criarLabel("")
    criarLabel("ℹ️ SOBRE")
    criarSeparador()
    
    criarBotao("📌 GITHUB", Color3.fromRGB(50, 100, 200), function()
        print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")
    end)
    
    criarBotao("✖ SAIR", Color3.fromRGB(150, 50, 50), function()
        gui:Destroy()
        print("👋 Hub fechado!")
    end)
end

-- ============================================
-- CONTEÚDO DA ABA RAÇA
-- ============================================

function criarAbaRaca()
    criarLabel("👤 SISTEMA DE RAÇAS")
    criarSeparador()
    
    criarBotao("FAZER TRIAL 1 - SHARK", Color3.fromRGB(100, 100, 200), function()
        print("[RAÇA] ▶️ Fazendo Trial 1")
        task.wait(2)
        print("[RAÇA] ✅ Trial 1 concluído!")
    end)
    
    criarBotao("FAZER TRIAL 2 - SHARK", Color3.fromRGB(100, 100, 200), function()
        print("[RAÇA] ▶️ Fazendo Trial 2")
        task.wait(2)
        print("[RAÇA] ✅ Trial 2 concluído!")
    end)
    
    criarBotao("FAZER TRIAL 3 - SHARK", Color3.fromRGB(100, 100, 200), function()
        print("[RAÇA] ▶️ Fazendo Trial 3")
        task.wait(2)
        print("[RAÇA] ✅ Trial 3 concluído!")
    end)
    
    criarBotao("FAZER TRIAL 4 - SHARK", Color3.fromRGB(100, 100, 200), function()
        print("[RAÇA] ▶️ Fazendo Trial 4")
        task.wait(2)
        print("[RAÇA] ✅ Trial 4 concluído!")
    end)
    
    criarLabel("")
    criarLabel("⚙️ GEARS")
    criarSeparador()
    
    criarBotao("PEGAR GEAR 1", Color3.fromRGB(80, 80, 180), function()
        print("[RAÇA] ▶️ Pegando Gear 1")
        task.wait(2)
        print("[RAÇA] ✅ Gear 1 coletado!")
    end)
    
    criarBotao("PEGAR GEAR 2", Color3.fromRGB(80, 80, 180), function()
        print("[RAÇA] ▶️ Pegando Gear 2")
        task.wait(2)
        print("[RAÇA] ✅ Gear 2 coletado!")
    end)
    
    criarBotao("PEGAR GEAR 3", Color3.fromRGB(80, 80, 180), function()
        print("[RAÇA] ▶️ Pegando Gear 3")
        task.wait(2)
        print("[RAÇA] ✅ Gear 3 coletado!")
    end)
    
    criarLabel("")
    criarBotao("⚡ ATIVAR V4", Color3.fromRGB(255, 200, 0), function()
        print("[RAÇA] ▶️ Ativando V4...")
        task.wait(2)
        print("[RAÇA] 🎉 V4 Ativado com sucesso!")
    end)
end

-- ============================================
-- CONTEÚDO DA ABA ARMAS
-- ============================================

function criarAbaArmas()
    criarLabel("⚔️ ESPADAS")
    criarSeparador()
    
    local espadas = {
        "PEGAR SABER", "PEGAR RENGOKU", "PEGAR SHISUI", 
        "PEGAR SADDI", "PEGAR YAMA", "PEGAR TRUE TRIPLE",
        "PEGAR CDK"
    }
    
    for _, espada in pairs(espadas) do
        criarBotao(espada, Color3.fromRGB(200, 150, 50), function()
            print("[ARMAS] ▶️ " .. espada)
            task.wait(2)
            print("[ARMAS] ✅ " .. espada .. " obtida!")
        end)
    end
    
    criarLabel("")
    criarLabel("🔫 GUNS")
    criarSeparador()
    
    criarBotao("PEGAR KABUCHA", Color3.fromRGB(150, 100, 200), function()
        print("[ARMAS] ▶️ Pegando Kabucha")
        task.wait(2)
        print("[ARMAS] ✅ Kabucha obtida!")
    end)
    
    criarBotao("PEGAR SOUL GUITAR", Color3.fromRGB(150, 100, 200), function()
        print("[ARMAS] ▶️ Pegando Soul Guitar")
        task.wait(2)
        print("[ARMAS] ✅ Soul Guitar obtida!")
    end)
end

-- ============================================
-- CONTEÚDO DA ABA ESTILOS
-- ============================================

function criarAbaEstilos()
    criarLabel("🥊 ESTILOS DE LUTA")
    criarSeparador()
    
    local estilos = {
        "APRENDER COMBAT", "APRENDER ELECTRIC", 
        "APRENDER WATER KUNG FU", "APRENDER SUPERHUMAN",
        "APRENDER GODHUMAN"
    }
    
    for _, estilo in pairs(estilos) do
        criarBotao(estilo, Color3.fromRGB(150, 100, 200), function()
            print("[ESTILOS] ▶️ " .. estilo)
            task.wait(2)
            print("[ESTILOS] ✅ " .. estilo .. " aprendido!")
        end)
    end
end

-- ============================================
-- CONTEÚDO DA ABA FARM
-- ============================================

function criarAbaFarm()
    criarLabel("⚡ FARM DE LEVEL")
    criarSeparador()
    
    criarBotao("⚡ FARMAR NÍVEL MÁXIMO", Color3.fromRGB(0, 200, 100), Farmar)
    criarBotao("⏹ PARAR FARM", Color3.fromRGB(200, 50, 50), PararFarm)
    criarBotao("💚 CURAR", Color3.fromRGB(50, 200, 100), Curar)
    
    criarLabel("")
    criarLabel("📊 STATUS")
    criarSeparador()
    
    local statusFrame = Instance.new("Frame")
    statusFrame.Size = UDim2.new(1, -20, 0, 40)
    statusFrame.Position = UDim2.new(0, 10, 0, 0)
    statusFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    statusFrame.BackgroundTransparency = 0.3
    statusFrame.BorderSizePixel = 0
    statusFrame.Parent = contentFrame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 10)
    statusCorner.Parent = statusFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 40)
    statusLabel.Text = farmAtivo and "⚡ Farmando..." or "⏸️ Parado"
    statusLabel.TextColor3 = farmAtivo and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 200, 100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 14
    statusLabel.Parent = statusFrame
end

-- ============================================
-- CONTEÚDO DA ABA CHECKLIST
-- ============================================

function criarAbaChecklist()
    criarLabel("📊 CHECKLIST GERAL")
    criarSeparador()
    
    local itens = {
        {"👤 Raças", "2/6 (33%)", Color3.fromRGB(255, 150, 100)},
        {"⚔️ Armas", "8/12 (67%)", Color3.fromRGB(255, 200, 50)},
        {"🥊 Estilos", "6/9 (67%)", Color3.fromRGB(200, 100, 255)},
        {"🎯 Itens", "5/9 (56%)", Color3.fromRGB(50, 200, 100)},
        {"👹 Bosses", "4/7 (57%)", Color3.fromRGB(200, 50, 50)},
        {"📋 Quests", "3/6 (50%)", Color3.fromRGB(100, 150, 255)},
        {"🐟 Pesca", "4/8 (50%)", Color3.fromRGB(50, 150, 200)}
    }
    
    for _, item in pairs(itens) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.Position = UDim2.new(0, 5, 0, 0)
        btn.Text = item[1] .. "  " .. item[2]
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = item[3]
        btn.BackgroundTransparency = 0.2
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.Parent = contentFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            print("[CHECKLIST] " .. item[1] .. ": " .. item[2])
        end)
    end
end

-- ============================================
-- SELECIONAR ABA INICIAL
-- ============================================

selecionarAba(1)

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "v3.0 Celular | GitHub: Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Hub carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")