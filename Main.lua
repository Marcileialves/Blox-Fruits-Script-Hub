--[[
    BLOX FRUITS SCRIPT - VERSÃO CELULAR
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("📱 Carregando Blox Fruits Script para Celular...")

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
-- TESTE RÁPIDO: VERIFICAR TOQUE
-- ============================================

local testGui = Instance.new("ScreenGui")
testGui.Name = "TesteToque"
testGui.Parent = player.PlayerGui

local testBtn = Instance.new("TextButton")
testBtn.Size = UDim2.new(0, 150, 0, 50)
testBtn.Position = UDim2.new(0.5, -75, 0.5, -25)
testBtn.Text = "✅ TESTE"
testBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
testBtn.Font = Enum.Font.GothamBold
testBtn.TextSize = 18
testBtn.Parent = testGui

local testCorner = Instance.new("UICorner")
testCorner.CornerRadius = UDim.new(0, 10)
testCorner.Parent = testBtn

-- Evento de toque (celular)
testBtn.TouchTap:Connect(function()
    print("✅ TOQUE FUNCIONOU!")
    testBtn.Text = "✅ FUNCIONOU!"
    testBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    task.wait(1)
    testBtn.Visible = false
end)

-- Evento de clique (alternativo)
testBtn.MouseButton1Click:Connect(function()
    print("✅ CLIQUE FUNCIONOU!")
    testBtn.Text = "✅ FUNCIONOU!"
    testBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    task.wait(1)
    testBtn.Visible = false
end)

print("🔘 Toque no botão verde para testar!")

-- Aguarda o teste
task.wait(2)
testBtn.Visible = false
testGui:Destroy()

-- ============================================
-- CRIA INTERFACE PRINCIPAL
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ============================================
-- FUNDO PRINCIPAL
-- ============================================

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 500)
frame.Position = UDim2.new(0.5, -170, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

-- ============================================
-- CABEÇALHO
-- ============================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 0
header.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 45)
logo.Text = "⚓ BLOX FRUITS"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Parent = header

-- Botão Sair
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 30, 0, 30)
exitBtn.Position = UDim2.new(1, -36, 0, 8)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 16
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
-- ÁREA DE ROLAGEM
-- ============================================

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, -50)
scroll.Position = UDim2.new(0, 0, 0, 45)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
scroll.Parent = frame

local scrollLayout = Instance.new("UIListLayout")
scrollLayout.Padding = UDim.new(0, 4)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Parent = scroll

-- ============================================
-- FUNÇÕES DE CRIAÇÃO (COM TOQUE)
-- ============================================

-- Função para criar botões que funcionam no celular
function criarBotao(texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 1
    btn.BorderColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.Parent = scroll
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Ícone de seta
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 25, 0, 25)
    arrow.Position = UDim2.new(1, -32, 0.5, -12)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 12
    arrow.Parent = btn
    
    -- EVENTO PARA CELULAR (TouchTap)
    btn.TouchTap:Connect(function()
        print("📱 ▶️ " .. texto)
        if callback then pcall(callback) end
        -- Efeito visual
        btn.BackgroundTransparency = 0.3
        task.wait(0.1)
        btn.BackgroundTransparency = 0.15
    end)
    
    -- EVENTO PARA PC (MouseButton1Click)
    btn.MouseButton1Click:Connect(function()
        print("🖱️ ▶️ " .. texto)
        if callback then pcall(callback) end
        btn.BackgroundTransparency = 0.3
        task.wait(0.1)
        btn.BackgroundTransparency = 0.15
    end)
    
    return btn
end

function criarSecao(texto, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 26)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scroll
    return lbl
end

function criarSeparador()
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -20, 0, 1)
    sep.Position = UDim2.new(0, 10, 0, 0)
    sep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    sep.BackgroundTransparency = 0.5
    sep.BorderSizePixel = 0
    sep.Parent = scroll
    return sep
end

-- ============================================
-- FUNÇÕES DE AÇÃO (PARA CELULAR)
-- ============================================

-- Teleportar
function TeleportarIlha(nome)
    print("[AÇÃO] 🚀 Teleportando para: " .. nome)
    local ilha = workspace:FindFirstChild(nome)
    if ilha and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
        print("[AÇÃO] ✅ Teleportado!")
        return true
    end
    print("[AÇÃO] ❌ Ilha não encontrada")
    return false
end

-- Atacar
function AtacarInimigo()
    print("[AÇÃO] ⚔️ Atacando inimigo...")
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, e in pairs(enemies:GetChildren()) do
            if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < 150 then
                    player.Character.HumanoidRootPart.CFrame = e.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                    task.wait(0.2)
                    if UserInputService.TouchEnabled then
                        UserInputService:TouchTap(Vector2.new(500, 300))
                    end
                    print("[AÇÃO] ✅ Inimigo atacado!")
                    return true
                end
            end
        end
    end
    print("[AÇÃO] ❌ Nenhum inimigo encontrado!")
    return false
end

-- Farm
local farmAtivo = false
local kills = 0

function Farmar()
    if farmAtivo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    farmAtivo = true
    kills = 0
    print("[FARM] 🚀 Iniciando farm...")
    
    task.spawn(function()
        while farmAtivo do
            local enemies = workspace:FindFirstChild("Enemies")
            local alvo = nil
            if enemies then
                for _, e in pairs(enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 150 then
                            alvo = e
                            break
                        end
                    end
                end
            end
            if alvo then
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                if UserInputService.TouchEnabled then
                    for i = 1, 3 do
                        UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
                        task.wait(0.1)
                    end
                end
                kills = kills + 1
                if kills % 10 == 0 then
                    print("[FARM] ⚔️ " .. kills .. " kills")
                end
            else
                task.wait(2)
            end
        end
    end)
end

function PararFarm()
    farmAtivo = false
    print("[FARM] ⏹ Parado - " .. kills .. " kills")
end

-- Curar
function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

-- Info
function MostrarInfo()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    print("📊 INFORMAÇÕES:")
    print("  👤 " .. player.Name)
    print("  🎯 Nível: " .. nivel)
    print("  💚 Vida: " .. health)
    if farmAtivo then
        print("  ⚔️ Kills: " .. kills)
    end
end

-- Pegar Item (simples)
function PegarItem(nome)
    print("[AÇÃO] 🔍 Procurando: " .. nome)
    local item = workspace:FindFirstChild(nome)
    if item then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = item:GetPivot() + Vector3.new(0, 0, 5)
            task.wait(0.5)
            if UserInputService.TouchEnabled then
                UserInputService:TouchTap(Vector2.new(500, 300))
            end
            print("[AÇÃO] ✅ Item coletado!")
            return true
        end
    end
    print("[AÇÃO] ❌ Item não encontrado")
    return false
end

-- ============================================
-- INFORMAÇÕES DO JOGADOR (CARD)
-- ============================================

local playerCard = Instance.new("Frame")
playerCard.Size = UDim2.new(1, -10, 0, 55)
playerCard.Position = UDim2.new(0, 5, 0, 0)
playerCard.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
playerCard.BackgroundTransparency = 0.15
playerCard.BorderSizePixel = 1
playerCard.BorderColor3 = Color3.fromRGB(255, 215, 0)
playerCard.Parent = scroll

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 8)
playerCorner.Parent = playerCard

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 24)
nameLabel.Position = UDim2.new(0, 10, 0, 2)
nameLabel.Text = "👤 " .. player.Name
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 14
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = playerCard

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 22)
infoLabel.Position = UDim2.new(0, 10, 0, 28)
local nivel = player.Level or player:GetAttribute("Level") or 0
local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
infoLabel.Text = "🎯 Nível " .. nivel .. "  |  💚 " .. health .. "/100"
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 11
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = playerCard

-- Atualiza informações
task.spawn(function()
    while gui and gui.Parent do
        task.wait(1)
        local nivel = player.Level or player:GetAttribute("Level") or 0
        local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
        infoLabel.Text = "🎯 Nível " .. nivel .. "  |  💚 " .. health .. "/100"
    end
end)

-- ============================================
-- INTERFACE (CATEGORIAS EXPANSÍVEIS)
-- ============================================

-- Função para criar categoria expansível
function criarCategoria(icone, nome, cor)
    local catFrame = Instance.new("Frame")
    catFrame.Size = UDim2.new(1, -10, 0, 34)
    catFrame.Position = UDim2.new(0, 5, 0, 0)
    catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    catFrame.BackgroundTransparency = 0.15
    catFrame.BorderSizePixel = 0
    catFrame.Parent = scroll
    
    local catCorner = Instance.new("UICorner")
    catCorner.CornerRadius = UDim.new(0, 8)
    catCorner.Parent = catFrame
    
    local catBtn = Instance.new("TextButton")
    catBtn.Size = UDim2.new(1, 0, 1, 0)
    catBtn.Text = icone .. " " .. nome
    catBtn.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    catBtn.BackgroundTransparency = 1
    catBtn.Font = Enum.Font.GothamBold
    catBtn.TextSize = 13
    catBtn.TextXAlignment = Enum.TextXAlignment.Left
    catBtn.BorderSizePixel = 0
    catBtn.Parent = catFrame
    
    local indicator = Instance.new("TextLabel")
    indicator.Size = UDim2.new(0, 25, 1, 0)
    indicator.Position = UDim2.new(1, -30, 0, 0)
    indicator.Text = "▸"
    indicator.TextColor3 = Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.Font = Enum.Font.GothamBold
    indicator.TextSize = 14
    indicator.Parent = catBtn
    
    -- Container das ações
    local actionsContainer = Instance.new("Frame")
    actionsContainer.Size = UDim2.new(1, -10, 0, 0)
    actionsContainer.Position = UDim2.new(0, 5, 0, 0)
    actionsContainer.BackgroundTransparency = 1
    actionsContainer.BorderSizePixel = 0
    actionsContainer.Visible = false
    actionsContainer.Parent = scroll
    
    local actionsLayout = Instance.new("UIListLayout")
    actionsLayout.Padding = UDim.new(0, 2)
    actionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    actionsLayout.Parent = actionsContainer
    
    local expandido = false
    
    -- Função para adicionar ação à categoria
    local function adicionarAcao(texto, corAcao, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.Text = texto
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        btn.BackgroundTransparency = 0.2
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 11
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.Parent = actionsContainer
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        -- Seta pequena
        local arrow2 = Instance.new("TextLabel")
        arrow2.Size = UDim2.new(0, 20, 0, 20)
        arrow2.Position = UDim2.new(1, -25, 0.5, -10)
        arrow2.Text = "▶"
        arrow2.TextColor3 = Color3.fromRGB(255, 215, 0)
        arrow2.BackgroundTransparency = 1
        arrow2.Font = Enum.Font.GothamBold
        arrow2.TextSize = 10
        arrow2.Parent = btn
        
        btn.TouchTap:Connect(function()
            print("📱 ▶️ " .. texto)
            if callback then pcall(callback) end
            arrow2.Text = "✅"
            arrow2.TextColor3 = Color3.fromRGB(100, 255, 100)
            btn.TextColor3 = Color3.fromRGB(150, 255, 150)
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            btn.BackgroundTransparency = 0.3
        end)
        
        btn.MouseButton1Click:Connect(function()
            print("🖱️ ▶️ " .. texto)
            if callback then pcall(callback) end
            arrow2.Text = "✅"
            arrow2.TextColor3 = Color3.fromRGB(100, 255, 100)
            btn.TextColor3 = Color3.fromRGB(150, 255, 150)
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            btn.BackgroundTransparency = 0.3
        end)
        
        -- Atualiza altura do container
        local totalAltura = 0
        for _, child in pairs(actionsContainer:GetChildren()) do
            if child:IsA("TextButton") then
                totalAltura = totalAltura + 34
            end
        end
        actionsContainer.Size = UDim2.new(1, -10, 0, totalAltura)
    end
    
    -- Evento de toque para expandir/recolher
    catBtn.TouchTap:Connect(function()
        expandido = not expandido
        if expandido then
            actionsContainer.Visible = true
            indicator.Text = "▾"
            catFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            local totalAltura = 0
            for _, child in pairs(actionsContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    totalAltura = totalAltura + 34
                end
            end
            actionsContainer.Size = UDim2.new(1, -10, 0, totalAltura)
        else
            actionsContainer.Visible = false
            indicator.Text = "▸"
            catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            actionsContainer.Size = UDim2.new(1, -10, 0, 0)
        end
    end)
    
    catBtn.MouseButton1Click:Connect(function()
        expandido = not expandido
        if expandido then
            actionsContainer.Visible = true
            indicator.Text = "▾"
            catFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            local totalAltura = 0
            for _, child in pairs(actionsContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    totalAltura = totalAltura + 34
                end
            end
            actionsContainer.Size = UDim2.new(1, -10, 0, totalAltura)
        else
            actionsContainer.Visible = false
            indicator.Text = "▸"
            catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            actionsContainer.Size = UDim2.new(1, -10, 0, 0)
        end
    end)
    
    return {
        frame = catFrame,
        container = actionsContainer,
        adicionarAcao = adicionarAcao,
        expandir = function()
            expandido = true
            actionsContainer.Visible = true
            indicator.Text = "▾"
            catFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            local totalAltura = 0
            for _, child in pairs(actionsContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    totalAltura = totalAltura + 34
                end
            end
            actionsContainer.Size = UDim2.new(1, -10, 0, totalAltura)
        end
    }
end

-- ============================================
-- CRIA AS CATEGORIAS
-- ============================================

-- 1. FARM
local catFarm = criarCategoria("⚡", "FARM", Color3.fromRGB(0, 200, 100))
catFarm.adicionarAcao("Farmar Nível Máximo", Color3.fromRGB(0, 180, 100), Farmar)
catFarm.adicionarAcao("Parar Farm", Color3.fromRGB(200, 50, 50), PararFarm)
catFarm.adicionarAcao("Curar", Color3.fromRGB(50, 200, 100), Curar)

-- 2. MOVIMENTO
local catMov = criarCategoria("🚀", "MOVIMENTO", Color3.fromRGB(50, 200, 255))
catMov.adicionarAcao("Teleportar Jungle", Color3.fromRGB(50, 200, 100), function()
    TeleportarIlha("Jungle")
end)
catMov.adicionarAcao("Teleportar Prison", Color3.fromRGB(50, 200, 100), function()
    TeleportarIlha("Prison")
end)
catMov.adicionarAcao("Teleportar Skypiea", Color3.fromRGB(50, 200, 100), function()
    TeleportarIlha("Skypiea")
end)

-- 3. COMBATE
local catComb = criarCategoria("⚔️", "COMBATE", Color3.fromRGB(200, 50, 50))
catComb.adicionarAcao("Atacar Inimigo", Color3.fromRGB(200, 50, 50), AtacarInimigo)

-- 4. COLETAR
local catCol = criarCategoria("🎯", "COLETAR", Color3.fromRGB(255, 200, 50))
catCol.adicionarAcao("Coletar Item", Color3.fromRGB(255, 200, 50), function()
    PegarItem("Item")
end)

-- 5. INFO
local catInfo = criarCategoria("📊", "INFORMAÇÕES", Color3.fromRGB(100, 150, 255))
catInfo.adicionarAcao("Mostrar Informações", Color3.fromRGB(100, 150, 255), MostrarInfo)

-- ============================================
-- EXPANDE A PRIMEIRA CATEGORIA
-- ============================================

catFarm.expandir()

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 18)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "⭐ Versão Celular | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Script Celular carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")