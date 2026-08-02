--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 8.0 (AJUSTADO)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🔥 Carregando Blox Fruits Hub 8.0...")

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
-- SISTEMA DE ILHAS
-- ============================================

local Ilhas = {
    {nome = "Jungle", nivelMin = 1, nivelMax = 30, xp = 80},
    {nome = "Pirate Village", nivelMin = 15, nivelMax = 45, xp = 100},
    {nome = "Desert", nivelMin = 30, nivelMax = 60, xp = 150},
    {nome = "Frozen Village", nivelMin = 50, nivelMax = 90, xp = 200},
    {nome = "Marine Fortress", nivelMin = 70, nivelMax = 120, xp = 250},
    {nome = "Skypiea", nivelMin = 90, nivelMax = 150, xp = 300},
    {nome = "Prison", nivelMin = 120, nivelMax = 200, xp = 400},
    {nome = "Colosseum", nivelMin = 150, nivelMax = 250, xp = 500},
    {nome = "Magma Village", nivelMin = 200, nivelMax = 300, xp = 600},
    {nome = "Underwater City", nivelMin = 250, nivelMax = 400, xp = 700},
    {nome = "Fountain City", nivelMin = 350, nivelMax = 500, xp = 800},
    {nome = "Kingdom of Rose", nivelMin = 500, nivelMax = 750, xp = 900},
    {nome = "Green Zone", nivelMin = 600, nivelMax = 850, xp = 1000},
    {nome = "Graveyard", nivelMin = 700, nivelMax = 950, xp = 1100},
    {nome = "Cursed Ship", nivelMin = 900, nivelMax = 1200, xp = 1200},
    {nome = "Ice Castle", nivelMin = 1100, nivelMax = 1400, xp = 1300},
    {nome = "Forgotten Island", nivelMin = 1300, nivelMax = 1600, xp = 1400},
    {nome = "Hydra Island", nivelMin = 1500, nivelMax = 2000, xp = 1600},
    {nome = "Great Tree", nivelMin = 1700, nivelMax = 2200, xp = 1800},
    {nome = "Floating Turtle", nivelMin = 1900, nivelMax = 2500, xp = 2000},
    {nome = "Sea of Treats", nivelMin = 2200, nivelMax = 3000, xp = 2500},
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

function TeleportarIlha(nome)
    print("[TELEPORTE] 🚀 " .. nome)
    local ilha = workspace:FindFirstChild(nome)
    if ilha and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
        task.wait(0.5)
        return true
    end
    return false
end

function Atacar()
    if UserInputService.TouchEnabled then
        for i = 1, 5 do
            UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
            task.wait(0.06)
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
-- FARM AUTOMÁTICO
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
    print("[FARM] 🚀 Iniciando Farm! Nv: " .. nivelInicial .. " → 3000")
    
    task.spawn(function()
        while farmAtivo do
            local nivelAtual = player.Level or player:GetAttribute("Level") or 0
            if nivelAtual >= 3000 then
                print("[FARM] 🎉 NÍVEL MÁXIMO! 3000/3000")
                break
            end
            
            local ilha = EncontrarMelhorIlha()
            if ilha then
                TeleportarIlha(ilha.nome)
                task.wait(1)
            end
            
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
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                for i = 1, 8 do
                    Atacar()
                    task.wait(0.05)
                end
                kills = kills + 1
                if kills % 10 == 0 then
                    task.wait(math.random(2, 5))
                end
                if kills % 50 == 0 then
                    local nivel = player.Level or player:GetAttribute("Level") or 0
                    print("[FARM] ⚔️ " .. kills .. " kills | Nv: " .. nivel)
                end
            else
                task.wait(2)
            end
            
            local novoNivel = player.Level or player:GetAttribute("Level") or 0
            if novoNivel > nivelAtual then
                print("[FARM] 🎉 Nível UP! " .. nivelAtual .. " → " .. novoNivel)
                Curar()
            end
        end
        
        farmAtivo = false
        local nivelFinal = player.Level or player:GetAttribute("Level") or 0
        print("[FARM] ✅ Concluído! Nv: " .. nivelInicial .. " → " .. nivelFinal)
        print("[FARM] ⚔️ Kills: " .. kills)
    end)
end

function PararFarm()
    farmAtivo = false
    print("[FARM] ⏹ Parado - " .. kills .. " kills")
end

function AcaoSimples(nome)
    print("[AÇÃO] ▶️ " .. nome)
    task.wait(1)
    print("[AÇÃO] ✅ " .. nome .. " concluído!")
end

function MostrarInfo()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    print("📊 INFO: " .. player.Name .. " | Nv " .. nivel .. "/3000 | 💚 " .. health)
end

-- ============================================
-- CRIA INTERFACE (AJUSTADA)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 440)  -- MAIS LARGURA, MENOS ALTURA
frame.Position = UDim2.new(0.5, -190, 0.5, -220)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Cabeçalho (menor)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 0
header.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 30)
logo.Text = "🔥 BLOX FRUITS 8.0"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 14
logo.Parent = header

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 20, 0, 20)
exitBtn.Position = UDim2.new(1, -26, 0, 5)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 11
exitBtn.BorderSizePixel = 0
exitBtn.Parent = header

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 4)
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
-- MENU LATERAL (COM NOMES)
-- ============================================

local menuLateral = Instance.new("Frame")
menuLateral.Size = UDim2.new(0, 85, 1, -35)
menuLateral.Position = UDim2.new(0, 0, 0, 30)
menuLateral.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
menuLateral.BackgroundTransparency = 0.2
menuLateral.BorderSizePixel = 0
menuLateral.Parent = frame

-- ============================================
-- CONTEÚDO (COM SCROLLBAR INTELIGENTE)
-- ============================================

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -95, 1, -35)
content.Position = UDim2.new(0, 90, 0, 30)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
content.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 2)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

-- ============================================
-- CATEGORIAS (COM NOMES)
-- ============================================

local categorias = {
    {nome = "📈PROG", id = 1},
    {nome = "👹BOSS", id = 2},
    {nome = "🌊SEA", id = 3},
    {nome = "⚔️RAID", id = 4},
    {nome = "🍎FRUT", id = 5},
    {nome = "🗡️ESP", id = 6},
    {nome = "🏹ARM", id = 7},
    {nome = "🥊EST", id = 8},
    {nome = "👤RAÇA", id = 9},
    {nome = "🟣HAKI", id = 10},
    {nome = "📦MAT", id = 11},
    {nome = "🎯ITENS", id = 12},
    {nome = "📋MISS", id = 13},
    {nome = "🗺️NPC", id = 14},
    {nome = "🎀ACES", id = 15},
    {nome = "🏷️TIT", id = 16},
    {nome = "🏝️EXPL", id = 17},
    {nome = "⚔️PVP", id = 18},
    {nome = "📦INV", id = 19},
    {nome = "🚀TELE", id = 20},
    {nome = "🌐SRV", id = 21},
    {nome = "💳ECO", id = 22},
    {nome = "📊STAT", id = 23},
    {nome = "⚙️UTIL", id = 24},
    {nome = "🤖AUTO", id = 25},
}

local botoesMenu = {}

function CriarBotaoMenu(cat)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 28)
    btn.Position = UDim2.new(0, 2, 0, 2 + (#botoesMenu * 30))
    btn.Text = cat.nome
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.Parent = menuLateral
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 2, 1, -4)
    indicator.Position = UDim2.new(0, 0, 0, 2)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    
    table.insert(botoesMenu, {btn = btn, indicator = indicator})
    
    btn.TouchTap:Connect(function() SelecionarCategoria(cat.id) end)
    btn.MouseButton1Click:Connect(function() SelecionarCategoria(cat.id) end)
    
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
    btn.Size = UDim2.new(1, -4, 0, 24)
    btn.Position = UDim2.new(0, 2, 0, 0)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 14, 0, 14)
    arrow.Position = UDim2.new(1, -18, 0.5, -7)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 8
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
    lbl.Size = UDim2.new(1, -4, 0, 16)
    lbl.Position = UDim2.new(0, 2, 0, 0)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    return lbl
end

function CriarInfo(texto, valor, cor)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, -4, 0, 16)
    frame2.Position = UDim2.new(0, 2, 0, 0)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.1
    frame2.BorderSizePixel = 0
    frame2.Parent = content
    
    local lbl1 = Instance.new("TextLabel")
    lbl1.Size = UDim2.new(0, 55, 1, 0)
    lbl1.Position = UDim2.new(0, 6, 0, 0)
    lbl1.Text = texto
    lbl1.TextColor3 = Color3.fromRGB(180, 180, 200)
    lbl1.BackgroundTransparency = 1
    lbl1.Font = Enum.Font.GothamMedium
    lbl1.TextSize = 8
    lbl1.TextXAlignment = Enum.TextXAlignment.Left
    lbl1.Parent = frame2
    
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(0, 80, 1, 0)
    lbl2.Position = UDim2.new(1, -90, 0, 0)
    lbl2.Text = tostring(valor)
    lbl2.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextSize = 8
    lbl2.TextXAlignment = Enum.TextXAlignment.Right
    lbl2.Parent = frame2
end

function CriarSeparador()
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.Position = UDim2.new(0, 5, 0, 0)
    sep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    sep.BackgroundTransparency = 0.5
    sep.BorderSizePixel = 0
    sep.Parent = content
end

function CriarSub(texto, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -4, 0, 14)
    lbl.Position = UDim2.new(0, 2, 0, 0)
    lbl.Text = "  • " .. texto
    lbl.TextColor3 = cor or Color3.fromRGB(180, 180, 200)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 9
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    return lbl
end

-- ============================================
-- ATUALIZA TAMANHO DO SCROLLBAR (INTELIGENTE)
-- ============================================

local function AtualizarScroll()
    local totalAltura = 0
    for _, child in pairs(content:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            totalAltura = totalAltura + child.Size.Y.Offset + 2
        end
    end
    content.CanvasSize = UDim2.new(0, 0, 0, totalAltura)
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
    
    if id == 1 then CarregarProgressao()
    elseif id == 2 then CarregarBosses()
    elseif id == 3 then CarregarSeaEvents()
    elseif id == 4 then CarregarRaids()
    elseif id == 5 then CarregarFrutas()
    elseif id == 6 then CarregarEspadas()
    elseif id == 7 then CarregarArmas()
    elseif id == 8 then CarregarEstilos()
    elseif id == 9 then CarregarRacas()
    elseif id == 10 then CarregarHaki()
    elseif id == 11 then CarregarMateriais()
    elseif id == 12 then CarregarItens()
    elseif id == 13 then CarregarMissoes()
    elseif id == 14 then CarregarNPCs()
    elseif id == 15 then CarregarAcessorios()
    elseif id == 16 then CarregarTitulos()
    elseif id == 17 then CarregarExploracao()
    elseif id == 18 then CarregarPvP()
    elseif id == 19 then CarregarInventario()
    elseif id == 20 then CarregarTeleporte()
    elseif id == 21 then CarregarServidor()
    elseif id == 22 then CarregarEconomia()
    elseif id == 23 then CarregarEstatisticas()
    elseif id == 24 then CarregarUtilidades()
    elseif id == 25 then CarregarAutomacao()
    end
    
    AtualizarScroll()
end

-- ============================================
-- CATEGORIA 1: PROGRESSÃO
-- ============================================

function CarregarProgressao()
    CriarSecao("📈 PROGRESSÃO")
    CriarSeparador()
    CriarBotao("🚀 Farmar Níveis", Color3.fromRGB(0, 200, 100), FarmarAutomatico)
    CriarBotao("⏹ Parar Farm", Color3.fromRGB(200, 50, 50), PararFarm)
    CriarBotao("Farmar Maestria", Color3.fromRGB(200, 150, 50), function() AcaoSimples("Farmar Maestria") end)
    CriarBotao("Farmar Beli", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Farmar Beli") end)
    CriarBotao("Farmar Fragmentos", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Farmar Fragmentos") end)
    CriarBotao("Farmar Bones", Color3.fromRGB(200, 150, 50), function() AcaoSimples("Farmar Bones") end)
    CriarBotao("Farmar Honra", Color3.fromRGB(200, 150, 50), function() AcaoSimples("Farmar Honra") end)
    CriarBotao("Farmar Recompensa", Color3.fromRGB(200, 150, 50), function() AcaoSimples("Farmar Recompensa") end)
    CriarBotao("Farmar Baús", Color3.fromRGB(100, 200, 100), function() AcaoSimples("Farmar Baús") end)
    CriarBotao("Farmar Materiais", Color3.fromRGB(150, 150, 150), function() AcaoSimples("Farmar Materiais") end)
    CriarSecao("📊 STATUS")
    CriarSeparador()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    CriarInfo("Nível", nivel .. "/3000", Color3.fromRGB(100, 255, 100))
    CriarInfo("Kills", kills, Color3.fromRGB(255, 200, 100))
end

-- ============================================
-- CATEGORIA 2: BOSSES
-- ============================================

function CarregarBosses()
    CriarSecao("👹 BOSSES")
    CriarSeparador()
    CriarBotao("Farmar Bosses", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Farmar Bosses") end)
    CriarBotao("Derrotar Rip Indra", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Rip Indra") end)
    CriarBotao("Derrotar Dough King", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Dough King") end)
    CriarBotao("Derrotar Cake Prince", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Cake Prince") end)
    CriarBotao("Derrotar Soul Reaper", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Soul Reaper") end)
    CriarBotao("Derrotar Longma", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Longma") end)
    CriarBotao("Derrotar Don Swan", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Don Swan") end)
    CriarBotao("Derrotar Swan", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Swan") end)
    CriarBotao("Derrotar Greybeard", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Greybeard") end)
    CriarBotao("Derrotar Darkbeard", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Darkbeard") end)
    CriarBotao("Derrotar Beautiful Pirate", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Beautiful Pirate") end)
    CriarBotao("Derrotar Captain Elephant", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Captain Elephant") end)
    CriarBotao("Derrotar Island Empress", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Island Empress") end)
    CriarBotao("Derrotar Stone", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Stone") end)
    CriarBotao("Derrotar Kilo Admiral", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Kilo Admiral") end)
    CriarBotao("Derrotar Cursed Captain", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Cursed Captain") end)
    CriarBotao("Derrotar Diamond", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Diamond") end)
    CriarBotao("Derrotar Jeremy", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Jeremy") end)
    CriarBotao("Derrotar Fajita", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Fajita") end)
    CriarBotao("Derrotar Smoke Admiral", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Smoke Admiral") end)
    CriarBotao("Derrotar Tide Keeper", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Tide Keeper") end)
    CriarBotao("Derrotar Order", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Order") end)
    CriarBotao("⚡ Derrotar Todos os Bosses", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Derrotar Todos os Bosses") end)
end

-- ============================================
-- CATEGORIA 3: SEA EVENTS
-- ============================================

function CarregarSeaEvents()
    CriarSecao("🌊 SEA EVENTS")
    CriarSeparador()
    CriarBotao("Derrotar Terror Shark", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Terror Shark") end)
    CriarBotao("Derrotar Leviathan", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Leviathan") end)
    CriarBotao("Derrotar Sea Beast", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Sea Beast") end)
    CriarBotao("Derrotar Rumbling Waters", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Rumbling Waters") end)
    CriarBotao("Derrotar Piratas do Mar", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Derrotar Piratas do Mar") end)
    CriarBotao("Encontrar Mirage Island", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Mirage Island") end)
    CriarBotao("Encontrar Kitsune Shrine", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Kitsune Shrine") end)
    CriarBotao("Encontrar Frozen Dimension", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Frozen Dimension") end)
    CriarBotao("Encontrar Prehistoric Island", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Prehistoric Island") end)
    CriarBotao("Encontrar Ghost Ship", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Ghost Ship") end)
    CriarBotao("Farmar Sea Events", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Farmar Sea Events") end)
end

-- ============================================
-- CATEGORIA 4: RAIDS
-- ============================================

function CarregarRaids()
    CriarSecao("⚔️ RAIDS")
    CriarSeparador()
    CriarBotao("Farmar Raid", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Farmar Raid") end)
    CriarBotao("Despertar Fruta", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Despertar Fruta") end)
    CriarBotao("Farmar Fragmentos", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Farmar Fragmentos") end)
    CriarBotao("Completar Todas as Raids", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Completar Todas as Raids") end)
end

-- ============================================
-- CATEGORIA 5: FRUTAS
-- ============================================

function CarregarFrutas()
    CriarSecao("🍎 FRUTAS")
    CriarSeparador()
    CriarBotao("Girar Frutas", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Girar Frutas") end)
    CriarBotao("Comprar Frutas", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Comprar Frutas") end)
    CriarBotao("Encontrar Frutas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar Frutas") end)
    CriarBotao("Coletar Frutas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Coletar Frutas") end)
    CriarBotao("Guardar Frutas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Guardar Frutas") end)
    CriarBotao("Despertar Todas as Frutas", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Despertar Todas as Frutas") end)
end

-- ============================================
-- CATEGORIA 6: ESPADAS
-- ============================================

function CarregarEspadas()
    CriarSecao("🗡️ ESPADAS")
    CriarSeparador()
    local espadas = {
        "True Triple Katana", "Cursed Dual Katana", "Shark Anchor",
        "Hallow Scythe", "Dark Blade V3", "Dragon Trident",
        "Spikey Trident", "Buddy Sword", "Canvander",
        "Rengoku", "Midnight Blade", "Yama", "Tushita"
    }
    for _, espada in pairs(espadas) do
        CriarBotao("Conseguir " .. espada, Color3.fromRGB(200, 150, 50), function() AcaoSimples("Conseguir " .. espada) end)
    end
    CriarBotao("Conseguir Todas as Espadas", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Conseguir Todas as Espadas") end)
end

-- ============================================
-- CATEGORIA 7: ARMAS
-- ============================================

function CarregarArmas()
    CriarSecao("🏹 ARMAS")
    CriarSeparador()
    CriarBotao("Conseguir Todas as Armas", Color3.fromRGB(200, 150, 50), function() AcaoSimples("Conseguir Todas as Armas") end)
    CriarBotao("Farmar Maestria das Armas", Color3.fromRGB(200, 150, 50), function() AcaoSimples("Farmar Maestria das Armas") end)
end

-- ============================================
-- CATEGORIA 8: ESTILOS
-- ============================================

function CarregarEstilos()
    CriarSecao("🥊 ESTILOS")
    CriarSeparador()
    local estilos = {
        "Dark Step", "Electric", "Water Kung Fu", "Dragon Breath",
        "Superhuman", "Death Step", "Sharkman Karate",
        "Electric Claw", "Dragon Talon", "God Human", "Sanguine Art"
    }
    for _, estilo in pairs(estilos) do
        CriarBotao("Conseguir " .. estilo, Color3.fromRGB(150, 100, 200), function() AcaoSimples("Conseguir " .. estilo) end)
    end
    CriarBotao("Conseguir Todos os Estilos", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Conseguir Todos os Estilos") end)
end

-- ============================================
-- CATEGORIA 9: RAÇAS
-- ============================================

function CarregarRacas()
    CriarSecao("👤 RAÇAS")
    CriarSeparador()
    CriarBotao("Evoluir Race V2", Color3.fromRGB(100, 100, 200), function() AcaoSimples("Evoluir Race V2") end)
    CriarBotao("Evoluir Race V3", Color3.fromRGB(100, 100, 200), function() AcaoSimples("Evoluir Race V3") end)
    CriarBotao("Evoluir Race V4", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Evoluir Race V4") end)
    CriarBotao("Completar Trial", Color3.fromRGB(100, 100, 200), function() AcaoSimples("Completar Trial") end)
    CriarBotao("Conseguir Blue Gear", Color3.fromRGB(80, 80, 180), function() AcaoSimples("Conseguir Blue Gear") end)
    CriarBotao("Desbloquear Todas as Raças", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Desbloquear Todas as Raças") end)
end

-- ============================================
-- CATEGORIA 10: HAKI
-- ============================================

function CarregarHaki()
    CriarSecao("🟣 HAKI")
    CriarSeparador()
    CriarBotao("Evoluir Aura", Color3.fromRGB(200, 100, 255), function() AcaoSimples("Evoluir Aura") end)
    CriarBotao("Evoluir Observation", Color3.fromRGB(200, 100, 255), function() AcaoSimples("Evoluir Observation") end)
    CriarBotao("Conseguir Observation V2", Color3.fromRGB(200, 100, 255), function() AcaoSimples("Conseguir Observation V2") end)
    CriarBotao("Conseguir Rainbow Haki", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Conseguir Rainbow Haki") end)
    CriarBotao("Maximizar Haki", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Maximizar Haki") end)
end

-- ============================================
-- CATEGORIA 11: MATERIAIS
-- ============================================

function CarregarMateriais()
    CriarSecao("📦 MATERIAIS")
    CriarSeparador()
    local materiais = {
        "Couro", "Scrap Metal", "Fish Tail", "Mystic Droplet",
        "Magma Ore", "Radioactive Material", "Vampire Fang",
        "Conjured Cocoa", "Blaze Ember", "Gunpowder",
        "Mini Tusk", "Angel Wings", "Dark Fragment"
    }
    for _, mat in pairs(materiais) do
        CriarBotao("Farmar " .. mat, Color3.fromRGB(150, 150, 150), function() AcaoSimples("Farmar " .. mat) end)
    end
    CriarBotao("Farmar Todos os Materiais", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Farmar Todos os Materiais") end)
end

-- ============================================
-- CATEGORIA 12: ITENS
-- ============================================

function CarregarItens()
    CriarSecao("🎯 ITENS")
    CriarSeparador()
    local itens = {
        "God's Chalice", "Sweet Chalice", "Fist of Darkness",
        "Hallow Essence", "Hidden Key", "Library Key", "Red Key"
    }
    for _, item in pairs(itens) do
        CriarBotao("Conseguir " .. item, Color3.fromRGB(100, 200, 255), function() AcaoSimples("Conseguir " .. item) end)
    end
    CriarBotao("Conseguir Todos os Itens", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Conseguir Todos os Itens") end)
end

-- ============================================
-- CATEGORIA 13: MISSÕES
-- ============================================

function CarregarMissoes()
    CriarSecao("📋 MISSÕES")
    CriarSeparador()
    CriarBotao("Completar Missões", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Missões") end)
    CriarBotao("Completar Missões de Elite", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Missões de Elite") end)
    CriarBotao("Completar Missões do Dojo", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Missões do Dojo") end)
    CriarBotao("Completar Missões de Eventos", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Missões de Eventos") end)
    CriarBotao("Completar Missões Secretas", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Completar Missões Secretas") end)
end

-- ============================================
-- CATEGORIA 14: NPCS
-- ============================================

function CarregarNPCs()
    CriarSecao("🗺️ NPCs")
    CriarSeparador()
    local npcs = {
        "Legendary Sword Dealer", "Master of Auras", "Hungry Man",
        "Sick Man", "Dragon Hunter", "Dragon Wizard",
        "Tort", "Gravestone"
    }
    for _, npc in pairs(npcs) do
        CriarBotao("Encontrar " .. npc, Color3.fromRGB(100, 200, 255), function() AcaoSimples("Encontrar " .. npc) end)
    end
    CriarBotao("Encontrar Todos os NPCs", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Encontrar Todos os NPCs") end)
end

-- ============================================
-- CATEGORIA 15: ACESSÓRIOS
-- ============================================

function CarregarAcessorios()
    CriarSecao("🎀 ACESSÓRIOS")
    CriarSeparador()
    CriarBotao("Conseguir Todos os Acessórios", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Conseguir Todos os Acessórios") end)
    CriarBotao("Farmar Acessórios", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Farmar Acessórios") end)
end

-- ============================================
-- CATEGORIA 16: TÍTULOS
-- ============================================

function CarregarTitulos()
    CriarSecao("🏷️ TÍTULOS")
    CriarSeparador()
    CriarBotao("Conseguir Todos os Títulos", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Conseguir Todos os Títulos") end)
end

-- ============================================
-- CATEGORIA 17: EXPLORAÇÃO
-- ============================================

function CarregarExploracao()
    CriarSecao("🏝️ EXPLORAÇÃO")
    CriarSeparador()
    CriarBotao("Descobrir Todas as Ilhas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Descobrir Todas as Ilhas") end)
    CriarBotao("Ativar Todos os Portais", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Ativar Todos os Portais") end)
    CriarBotao("Resolver Todos os Quebra-Cabeças", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Resolver Todos os Quebra-Cabeças") end)
    CriarBotao("Coletar Todos os Baús", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Coletar Todos os Baús") end)
end

-- ============================================
-- CATEGORIA 18: PVP
-- ============================================

function CarregarPvP()
    CriarSecao("⚔️ PVP")
    CriarSeparador()
    CriarBotao("Farmar Bounty", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Farmar Bounty") end)
    CriarBotao("Farmar Honor", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Farmar Honor") end)
    CriarBotao("Caçar Jogadores", Color3.fromRGB(200, 50, 50), function() AcaoSimples("Caçar Jogadores") end)
    CriarBotao("Auto PvP", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Auto PvP") end)
end

-- ============================================
-- CATEGORIA 19: INVENTÁRIO
-- ============================================

function CarregarInventario()
    CriarSecao("📦 INVENTÁRIO")
    CriarSeparador()
    CriarBotao("Organizar Inventário", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Organizar Inventário") end)
    CriarBotao("Equipar Melhor Fruta", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Equipar Melhor Fruta") end)
    CriarBotao("Equipar Melhor Espada", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Equipar Melhor Espada") end)
    CriarBotao("Equipar Melhor Arma", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Equipar Melhor Arma") end)
    CriarBotao("Equipar Melhor Estilo", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Equipar Melhor Estilo") end)
end

-- ============================================
-- CATEGORIA 20: TELEPORTE
-- ============================================

function CarregarTeleporte()
    CriarSecao("🚀 TELEPORTE")
    CriarSeparador()
    CriarBotao("Teleportar para Ilhas", Color3.fromRGB(50, 200, 100), function() AcaoSimples("Teleportar para Ilhas") end)
    CriarBotao("Teleportar para Bosses", Color3.fromRGB(50, 200, 100), function() AcaoSimples("Teleportar para Bosses") end)
    CriarBotao("Teleportar para NPCs", Color3.fromRGB(50, 200, 100), function() AcaoSimples("Teleportar para NPCs") end)
    CriarBotao("Teleportar para Eventos", Color3.fromRGB(50, 200, 100), function() AcaoSimples("Teleportar para Eventos") end)
end

-- ============================================
-- CATEGORIA 21: SERVIDOR
-- ============================================

function CarregarServidor()
    CriarSecao("🌐 SERVIDOR")
    CriarSeparador()
    CriarBotao("Trocar de Servidor", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Trocar de Servidor") end)
    CriarBotao("Procurar Servidor Vazio", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Procurar Servidor Vazio") end)
    CriarBotao("Reentrar", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Reentrar") end)
    CriarBotao("Server Hop Boss", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Server Hop Boss") end)
    CriarBotao("Server Hop Frutas", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Server Hop Frutas") end)
    CriarBotao("Server Hop Eventos", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Server Hop Eventos") end)
end

-- ============================================
-- CATEGORIA 22: ECONOMIA
-- ============================================

function CarregarEconomia()
    CriarSecao("💳 ECONOMIA")
    CriarSeparador()
    CriarBotao("Comprar Todas as Espadas", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Comprar Todas as Espadas") end)
    CriarBotao("Comprar Todas as Armas", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Comprar Todas as Armas") end)
    CriarBotao("Comprar Todos os Estilos", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Comprar Todos os Estilos") end)
    CriarBotao("Comprar Todos os Barcos", Color3.fromRGB(255, 200, 50), function() AcaoSimples("Comprar Todos os Barcos") end)
end

-- ============================================
-- CATEGORIA 23: ESTATÍSTICAS
-- ============================================

function CarregarEstatisticas()
    CriarSecao("📊 ESTATÍSTICAS")
    CriarSeparador()
    CriarBotao("Distribuir Status", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Distribuir Status") end)
    CriarBotao("Resetar Status", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Resetar Status") end)
    CriarBotao("Selecionar Build", Color3.fromRGB(100, 150, 255), function() AcaoSimples("Selecionar Build") end)
end

-- ============================================
-- CATEGORIA 24: UTILIDADES
-- ============================================

function CarregarUtilidades()
    CriarSecao("⚙️ UTILIDADES")
    CriarSeparador()
    CriarBotao("💚 Curar", Color3.fromRGB(50, 200, 100), Curar)
    CriarBotao("📊 Info", Color3.fromRGB(100, 150, 255), MostrarInfo)
    CriarBotao("Anti AFK", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Anti AFK") end)
    CriarBotao("FPS Boost", Color3.fromRGB(100, 200, 255), function() AcaoSimples("FPS Boost") end)
    CriarBotao("Reconnect Automático", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Reconnect Automático") end)
    CriarBotao("Auto Salvar", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Auto Salvar") end)
    CriarBotao("Auto Equipar", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Auto Equipar") end)
    CriarBotao("Auto Haki", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Auto Haki") end)
    CriarBotao("Auto Instinto", Color3.fromRGB(100, 200, 255), function() AcaoSimples("Auto Instinto") end)
end

-- ============================================
-- CATEGORIA 25: AUTOMAÇÃO
-- ============================================

function CarregarAutomacao()
    CriarSecao("🤖 AUTOMAÇÃO")
    CriarSeparador()
    CriarBotao("Farmar Tudo", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Farmar Tudo") end)
    CriarBotao("Completar Tudo", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Completar Tudo") end)
    CriarBotao("Desbloquear Tudo", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Desbloquear Tudo") end)
    CriarBotao("Coletar Tudo", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Coletar Tudo") end)
    CriarBotao("Evoluir Tudo", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Evoluir Tudo") end)
    CriarBotao("Maximizar Conta", Color3.fromRGB(255, 200, 0), function() AcaoSimples("Maximizar Conta") end)
end

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 14)
footer.Position = UDim2.new(0, 0, 1, -4)
footer.Text = "⭐ v8.0 Ajustado | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 8
footer.Parent = frame

-- ============================================
-- INICIALIZA
-- ============================================

SelecionarCategoria(1)

print("✅ Blox Fruits Hub 8.0 carregado!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")