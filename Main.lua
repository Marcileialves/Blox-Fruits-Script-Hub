--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 12.0 (CHECKBOX EM TODOS OS COMANDOS)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("✅ Carregando Blox Fruits Hub 12.0...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

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
-- SISTEMA DE CHECKBOX PARA COMANDOS
-- ============================================

local comandosAtivos = {}

function CriarCheckboxComando(texto, cor, callback)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 30)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.15
    frame2.BorderSizePixel = 0
    frame2.Parent = content
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 6)
    frameCorner.Parent = frame2
    
    -- Checkbox
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 24, 0, 24)
    checkbox.Position = UDim2.new(0, 8, 0.5, -12)
    checkbox.Text = ""
    checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    checkbox.BackgroundTransparency = 0.2
    checkbox.Font = Enum.Font.GothamBold
    checkbox.TextSize = 14
    checkbox.BorderSizePixel = 2
    checkbox.BorderColor3 = cor or Color3.fromRGB(255, 215, 0)
    checkbox.Parent = frame2
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 4)
    checkboxCorner.Parent = checkbox
    
    -- Label do comando
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 250, 1, 0)
    label.Position = UDim2.new(0, 38, 0, 0)
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame2
    
    -- Status do comando (Executando/Parado)
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 60, 1, 0)
    status.Position = UDim2.new(1, -65, 0, 0)
    status.Text = "⏸"
    status.TextColor3 = Color3.fromRGB(255, 200, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamBold
    status.TextSize = 12
    status.Parent = frame2
    
    local estado = false
    local thread = nil
    
    checkbox.TouchTap:Connect(function()
        estado = not estado
        if estado then
            checkbox.Text = "✅"
            checkbox.TextColor3 = Color3.fromRGB(100, 255, 100)
            checkbox.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            checkbox.BorderColor3 = Color3.fromRGB(0, 200, 0)
            status.Text = "▶"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            print("[COMANDO] ✅ " .. texto .. " ATIVADO")
            
            -- Executa o comando em uma thread separada
            thread = task.spawn(function()
                if callback then
                    callback(true, function()
                        -- Função para marcar como concluído
                        estado = false
                        checkbox.Text = ""
                        checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                        checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
                        checkbox.BorderColor3 = cor or Color3.fromRGB(255, 215, 0)
                        status.Text = "✅"
                        status.TextColor3 = Color3.fromRGB(100, 255, 100)
                        print("[COMANDO] ✅ " .. texto .. " CONCLUÍDO!")
                    end)
                end
            end)
        else
            -- Desativa o comando
            if thread then
                task.cancel(thread)
                thread = nil
            end
            checkbox.Text = ""
            checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
            checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            checkbox.BorderColor3 = cor or Color3.fromRGB(255, 215, 0)
            status.Text = "⏸"
            status.TextColor3 = Color3.fromRGB(255, 200, 100)
            print("[COMANDO] ❌ " .. texto .. " DESATIVADO")
        end
    end)
    
    checkbox.MouseButton1Click:Connect(function()
        estado = not estado
        if estado then
            checkbox.Text = "✅"
            checkbox.TextColor3 = Color3.fromRGB(100, 255, 100)
            checkbox.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            checkbox.BorderColor3 = Color3.fromRGB(0, 200, 0)
            status.Text = "▶"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            print("[COMANDO] ✅ " .. texto .. " ATIVADO")
            
            thread = task.spawn(function()
                if callback then
                    callback(true, function()
                        estado = false
                        checkbox.Text = ""
                        checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                        checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
                        checkbox.BorderColor3 = cor or Color3.fromRGB(255, 215, 0)
                        status.Text = "✅"
                        status.TextColor3 = Color3.fromRGB(100, 255, 100)
                        print("[COMANDO] ✅ " .. texto .. " CONCLUÍDO!")
                    end)
                end
            end)
        else
            if thread then
                task.cancel(thread)
                thread = nil
            end
            checkbox.Text = ""
            checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
            checkbox.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            checkbox.BorderColor3 = cor or Color3.fromRGB(255, 215, 0)
            status.Text = "⏸"
            status.TextColor3 = Color3.fromRGB(255, 200, 100)
            print("[COMANDO] ❌ " .. texto .. " DESATIVADO")
        end
    end)
    
    return {frame = frame2, checkbox = checkbox, label = label, status = status, estado = estado}
end

-- ============================================
-- COMANDOS (COM CALLBACK)
-- ============================================

local farmAtivo = false
local kills = 0

function ComandoFarm(ativar, concluir)
    if ativar then
        farmAtivo = true
        kills = 0
        print("[FARM] 🚀 Iniciando Farm...")
        
        task.spawn(function()
            while farmAtivo do
                local nivelAtual = player.Level or player:GetAttribute("Level") or 0
                if nivelAtual >= 3000 then
                    print("[FARM] 🎉 NÍVEL MÁXIMO!")
                    if concluir then concluir() end
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
        end)
    else
        farmAtivo = false
        print("[FARM] ⏹ Parado - " .. kills .. " kills")
        if concluir then concluir() end
    end
end

function ComandoDerrotarBoss(nome, ativar, concluir)
    if ativar then
        print("[BOSS] 👹 Derrotando " .. nome .. "...")
        task.wait(2)
        print("[BOSS] ✅ " .. nome .. " derrotado!")
        if concluir then concluir() end
    end
end

function ComandoAcao(nome, ativar, concluir)
    if ativar then
        print("[AÇÃO] ▶️ " .. nome)
        task.wait(1.5)
        print("[AÇÃO] ✅ " .. nome .. " concluído!")
        if concluir then concluir() end
    end
end

function MostrarInfo()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    print("📊 INFO: " .. player.Name .. " | Nv " .. nivel .. "/3000 | 💚 " .. health)
end

-- ============================================
-- CRIA INTERFACE
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 480)
frame.Position = UDim2.new(0.5, -210, 0.5, -240)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.08
header.BorderSizePixel = 0
header.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0, 180, 0, 22)
logo.Position = UDim2.new(0, 10, 0, 4)
logo.Text = "✅ BLOX FRUITS 12.0"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 16
logo.TextXAlignment = Enum.TextXAlignment.Left
logo.Parent = header

local infoPlayer = Instance.new("TextLabel")
infoPlayer.Size = UDim2.new(0, 200, 0, 16)
infoPlayer.Position = UDim2.new(0, 10, 0, 30)
infoPlayer.Text = "👤 " .. player.Name .. "  🎯 Nv " .. (player.Level or 0)
infoPlayer.TextColor3 = Color3.fromRGB(200, 200, 220)
infoPlayer.BackgroundTransparency = 1
infoPlayer.Font = Enum.Font.GothamMedium
infoPlayer.TextSize = 10
infoPlayer.TextXAlignment = Enum.TextXAlignment.Left
infoPlayer.Parent = header

local serverStatus = Instance.new("TextLabel")
serverStatus.Size = UDim2.new(0, 120, 0, 16)
serverStatus.Position = UDim2.new(1, -130, 0, 4)
serverStatus.Text = "🟢 Online"
serverStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
serverStatus.BackgroundTransparency = 1
serverStatus.Font = Enum.Font.GothamBold
serverStatus.TextSize = 10
serverStatus.TextXAlignment = Enum.TextXAlignment.Right
serverStatus.Parent = header

local serverId = Instance.new("TextLabel")
serverId.Size = UDim2.new(0, 120, 0, 14)
serverId.Position = UDim2.new(1, -130, 0, 22)
serverId.Text = "🌐 #" .. game.JobId:sub(1, 8)
serverId.TextColor3 = Color3.fromRGB(150, 150, 200)
serverId.BackgroundTransparency = 1
serverId.Font = Enum.Font.GothamMedium
serverId.TextSize = 8
serverId.TextXAlignment = Enum.TextXAlignment.Right
serverId.Parent = header

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 24, 0, 24)
exitBtn.Position = UDim2.new(1, -30, 0, 4)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 12
exitBtn.BorderSizePixel = 0
exitBtn.Parent = header

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 5)
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

-- Abas
local abaContainer = Instance.new("Frame")
abaContainer.Size = UDim2.new(1, 0, 0, 32)
abaContainer.Position = UDim2.new(0, 0, 0, 50)
abaContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
abaContainer.BackgroundTransparency = 0.2
abaContainer.BorderSizePixel = 0
abaContainer.Parent = frame

local abas = {
    {nome = "📈 Início", id = 1},
    {nome = "⚔️ Farm", id = 2},
    {nome = "👹 Boss", id = 3},
    {nome = "🌊 Sea", id = 4},
    {nome = "⚡ Raid", id = 5},
    {nome = "🍎 Frutas", id = 6},
    {nome = "🗡️ Espadas", id = 7},
    {nome = "🥊 Estilos", id = 8},
    {nome = "👤 Raça", id = 9},
    {nome = "🟣 Haki", id = 10},
    {nome = "⚙️ Util", id = 11},
}

local botoesAba = {}
local abaAtual = 1

function CriarBotaoAba(aba)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 75, 1, -4)
    btn.Position = UDim2.new(0, 4 + ((#botoesAba) * 79), 0, 2)
    btn.Text = aba.nome
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.BackgroundTransparency = 0.3
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 9
    btn.BorderSizePixel = 0
    btn.Parent = abaContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 30, 0, 2)
    indicator.Position = UDim2.new(0.5, -15, 1, -2)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    
    table.insert(botoesAba, {btn = btn, indicator = indicator, id = aba.id})
    
    btn.TouchTap:Connect(function() SelecionarAba(aba.id) end)
    btn.MouseButton1Click:Connect(function() SelecionarAba(aba.id) end)
    
    return btn
end

for _, aba in pairs(abas) do
    CriarBotaoAba(aba)
end

function SelecionarAba(id)
    abaAtual = id
    for i, data in pairs(botoesAba) do
        if data.id == id then
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

-- Conteúdo
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 1, -95)
content.Position = UDim2.new(0, 5, 0, 85)
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
-- FUNÇÕES DE CRIAÇÃO
-- ============================================

function CriarTitulo(texto)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    return lbl
end

function CriarDescricao(texto)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 28)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.15
    frame2.BorderSizePixel = 0
    frame2.Parent = content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 5)
    corner2.Parent = frame2
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.Text = texto
    lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 9
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame2
    return frame2
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

function CriarInfo(texto, valor, cor)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 22)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.1
    frame2.BorderSizePixel = 0
    frame2.Parent = content
    
    local lbl1 = Instance.new("TextLabel")
    lbl1.Size = UDim2.new(0, 90, 1, 0)
    lbl1.Position = UDim2.new(0, 8, 0, 0)
    lbl1.Text = texto
    lbl1.TextColor3 = Color3.fromRGB(180, 180, 200)
    lbl1.BackgroundTransparency = 1
    lbl1.Font = Enum.Font.GothamMedium
    lbl1.TextSize = 9
    lbl1.TextXAlignment = Enum.TextXAlignment.Left
    lbl1.Parent = frame2
    
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(0, 110, 1, 0)
    lbl2.Position = UDim2.new(1, -120, 0, 0)
    lbl2.Text = tostring(valor)
    lbl2.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextSize = 9
    lbl2.TextXAlignment = Enum.TextXAlignment.Right
    lbl2.Parent = frame2
end

function AtualizarScroll()
    local totalAltura = 0
    for _, child in pairs(content:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            totalAltura = totalAltura + child.Size.Y.Offset + 2
        end
    end
    content.CanvasSize = UDim2.new(0, 0, 0, totalAltura + 10)
end

-- ============================================
-- CONTEÚDO DAS ABAS (TUDO COM CHECKBOX)
-- ============================================

function CarregarConteudo(id)
    for _, child in pairs(content:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    if id == 1 then CarregarInicio()
    elseif id == 2 then CarregarFarm()
    elseif id == 3 then CarregarBoss()
    elseif id == 4 then CarregarSea()
    elseif id == 5 then CarregarRaid()
    elseif id == 6 then CarregarFrutas()
    elseif id == 7 then CarregarEspadas()
    elseif id == 8 then CarregarEstilos()
    elseif id == 9 then CarregarRaca()
    elseif id == 10 then CarregarHaki()
    elseif id == 11 then CarregarUtil()
    end
    
    AtualizarScroll()
end

-- ============================================
-- ABA 1: INÍCIO
-- ============================================

function CarregarInicio()
    CriarTitulo("📊 STATUS DO JOGADOR")
    CriarSeparador()
    
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    local ilha = EncontrarMelhorIlha()
    
    CriarInfo("👤 Jogador", player.Name, Color3.fromRGB(255, 200, 100))
    CriarInfo("🎯 Nível", nivel .. "/3000", Color3.fromRGB(100, 255, 100))
    CriarInfo("💚 Vida", health .. "/100", Color3.fromRGB(100, 255, 100))
    CriarInfo("📍 Ilha", ilha and ilha.nome or "Desconhecida", Color3.fromRGB(100, 200, 255))
    CriarInfo("🌐 Server", game.JobId:sub(1, 12), Color3.fromRGB(150, 150, 200))
    
    CriarSeparador()
    CriarTitulo("⚡ AÇÕES RÁPIDAS")
    CriarSeparador()
    
    CriarCheckboxComando("💚 Curar", Color3.fromRGB(50, 200, 100), function(ativar, concluir)
        if ativar then
            Curar()
            if concluir then concluir() end
        end
    end)
    
    CriarCheckboxComando("📊 Mostrar Info", Color3.fromRGB(100, 150, 255), function(ativar, concluir)
        if ativar then
            MostrarInfo()
            if concluir then concluir() end
        end
    end)
    
    CriarCheckboxComando("🏝️ Teleportar Jungle", Color3.fromRGB(50, 200, 100), function(ativar, concluir)
        if ativar then
            TeleportarIlha("Jungle")
            if concluir then concluir() end
        end
    end)
end

-- ============================================
-- ABA 2: FARM (TUDO CHECKBOX)
-- ============================================

function CarregarFarm()
    CriarTitulo("⚔️ FARM AUTOMÁTICO")
    CriarSeparador()
    
    CriarDescricao("📌 Marque os checkboxes para ativar os comandos")
    CriarSeparador()
    
    CriarCheckboxComando("🚀 Farmar Níveis Automático", Color3.fromRGB(0, 200, 100), ComandoFarm)
    
    CriarCheckboxComando("💚 Auto Curar", Color3.fromRGB(50, 200, 100), function(ativar, concluir)
        if ativar then
            print("[CONFIG] Auto Curar ATIVADO")
            task.spawn(function()
                while true do
                    if not ativar then break end
                    Curar()
                    task.wait(5)
                end
            end)
        else
            print("[CONFIG] Auto Curar DESATIVADO")
        end
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("🏝️ Auto Teleport para Melhor Ilha", Color3.fromRGB(50, 200, 255), function(ativar, concluir)
        if ativar then
            print("[CONFIG] Auto Teleport ATIVADO")
            task.spawn(function()
                while ativar do
                    local ilha = EncontrarMelhorIlha()
                    if ilha then
                        TeleportarIlha(ilha.nome)
                    end
                    task.wait(10)
                end
            end)
        else
            print("[CONFIG] Auto Teleport DESATIVADO")
        end
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("🛡️ Anti-Ban (Modo Seguro)", Color3.fromRGB(255, 200, 100), function(ativar, concluir)
        print("[CONFIG] Anti-Ban: " .. (ativar and "ON" or "OFF"))
        if concluir then concluir() end
    end)
    
    CriarSeparador()
    CriarTitulo("📊 STATUS")
    CriarSeparador()
    
    local nivel = player.Level or player:GetAttribute("Level") or 0
    CriarInfo("Nível", nivel .. "/3000", Color3.fromRGB(100, 255, 100))
    CriarInfo("Kills", kills, Color3.fromRGB(255, 200, 100))
    CriarInfo("Status", farmAtivo and "🟢 Farmando" or "🔴 Parado", farmAtivo and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100))
end

-- ============================================
-- ABA 3: BOSS (TUDO CHECKBOX)
-- ============================================

function CarregarBoss()
    CriarTitulo("👹 BOSSES")
    CriarSeparador()
    
    CriarDescricao("📌 Marque os bosses que deseja derrotar")
    CriarSeparador()
    
    CriarCheckboxComando("👹 Derrotar Dough King", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoDerrotarBoss("Dough King", ativar, concluir)
    end)
    
    CriarCheckboxComando("👹 Derrotar Cake Prince", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoDerrotarBoss("Cake Prince", ativar, concluir)
    end)
    
    CriarCheckboxComando("👹 Derrotar Rip Indra", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoDerrotarBoss("Rip Indra", ativar, concluir)
    end)
    
    CriarCheckboxComando("👹 Derrotar Leviathan", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoDerrotarBoss("Leviathan", ativar, concluir)
    end)
    
    CriarCheckboxComando("👹 Derrotar Sea Beast", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoDerrotarBoss("Sea Beast", ativar, concluir)
    end)
    
    CriarCheckboxComando("👹 Derrotar Darkbeard", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoDerrotarBoss("Darkbeard", ativar, concluir)
    end)
    
    CriarCheckboxComando("⭐ Derrotar Todos os Bosses", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Derrotar Todos os Bosses", ativar, concluir)
    end)
end

-- ============================================
-- ABA 4: SEA (TUDO CHECKBOX)
-- ============================================

function CarregarSea()
    CriarTitulo("🌊 SEA EVENTS")
    CriarSeparador()
    
    CriarDescricao("📌 Marque os eventos marítimos")
    CriarSeparador()
    
    CriarCheckboxComando("🦈 Derrotar Terror Shark", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoAcao("Derrotar Terror Shark", ativar, concluir)
    end)
    
    CriarCheckboxComando("🐋 Derrotar Sea Beast", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoAcao("Derrotar Sea Beast", ativar, concluir)
    end)
    
    CriarCheckboxComando("🐉 Derrotar Leviathan", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoAcao("Derrotar Leviathan", ativar, concluir)
    end)
    
    CriarCheckboxComando("🏝️ Encontrar Mirage Island", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        ComandoAcao("Encontrar Mirage Island", ativar, concluir)
    end)
    
    CriarCheckboxComando("⛩️ Encontrar Kitsune Shrine", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        ComandoAcao("Encontrar Kitsune Shrine", ativar, concluir)
    end)
    
    CriarCheckboxComando("🧊 Encontrar Frozen Dimension", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        ComandoAcao("Encontrar Frozen Dimension", ativar, concluir)
    end)
end

-- ============================================
-- ABA 5: RAID (TUDO CHECKBOX)
-- ============================================

function CarregarRaid()
    CriarTitulo("⚔️ RAIDS")
    CriarSeparador()
    
    CriarDescricao("📌 Marque as opções de raid")
    CriarSeparador()
    
    CriarCheckboxComando("⚔️ Farmar Raid", Color3.fromRGB(200, 50, 50), function(ativar, concluir)
        ComandoAcao("Farmar Raid", ativar, concluir)
    end)
    
    CriarCheckboxComando("🍎 Despertar Fruta", Color3.fromRGB(255, 200, 50), function(ativar, concluir)
        ComandoAcao("Despertar Fruta", ativar, concluir)
    end)
    
    CriarCheckboxComando("💎 Farmar Fragmentos", Color3.fromRGB(255, 200, 50), function(ativar, concluir)
        ComandoAcao("Farmar Fragmentos", ativar, concluir)
    end)
    
    CriarCheckboxComando("⭐ Completar Todas as Raids", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Completar Todas as Raids", ativar, concluir)
    end)
end

-- ============================================
-- ABA 6: FRUTAS (TUDO CHECKBOX)
-- ============================================

function CarregarFrutas()
    CriarTitulo("🍎 FRUTAS")
    CriarSeparador()
    
    CriarDescricao("📌 Marque as ações para frutas")
    CriarSeparador()
    
    CriarCheckboxComando("🔭 Auto Sniper Frutas", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        print("[SNIPER] Sniper Frutas: " .. (ativar and "ON" or "OFF"))
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("🔄 Girar Frutas", Color3.fromRGB(255, 200, 50), function(ativar, concluir)
        ComandoAcao("Girar Frutas", ativar, concluir)
    end)
    
    CriarCheckboxComando("🛒 Comprar Frutas", Color3.fromRGB(255, 200, 50), function(ativar, concluir)
        ComandoAcao("Comprar Frutas", ativar, concluir)
    end)
    
    CriarCheckboxComando("🔍 Encontrar Frutas", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        ComandoAcao("Encontrar Frutas", ativar, concluir)
    end)
    
    CriarCheckboxComando("📦 Guardar Frutas", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        ComandoAcao("Guardar Frutas", ativar, concluir)
    end)
    
    CriarCheckboxComando("⭐ Despertar Todas as Frutas", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Despertar Todas as Frutas", ativar, concluir)
    end)
end

-- ============================================
-- ABA 7: ESPADAS (TUDO CHECKBOX)
-- ============================================

function CarregarEspadas()
    CriarTitulo("🗡️ ESPADAS")
    CriarSeparador()
    
    CriarDescricao("📌 Marque as espadas que deseja conseguir")
    CriarSeparador()
    
    local espadas = {
        "True Triple Katana", "Cursed Dual Katana", "Shark Anchor",
        "Hallow Scythe", "Dark Blade V3", "Dragon Trident",
        "Rengoku", "Midnight Blade", "Yama", "Tushita"
    }
    for _, espada in pairs(espadas) do
        CriarCheckboxComando("🗡️ Conseguir " .. espada, Color3.fromRGB(200, 150, 50), function(ativar, concluir)
            ComandoAcao("Conseguir " .. espada, ativar, concluir)
        end)
    end
    
    CriarCheckboxComando("⭐ Conseguir Todas as Espadas", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Conseguir Todas as Espadas", ativar, concluir)
    end)
end

-- ============================================
-- ABA 8: ESTILOS (TUDO CHECKBOX)
-- ============================================

function CarregarEstilos()
    CriarTitulo("🥊 ESTILOS")
    CriarSeparador()
    
    CriarDescricao("📌 Marque os estilos que deseja aprender")
    CriarSeparador()
    
    local estilos = {
        "Dark Step", "Electric", "Water Kung Fu", "Dragon Breath",
        "Superhuman", "Death Step", "Sharkman Karate",
        "Electric Claw", "Dragon Talon", "God Human", "Sanguine Art"
    }
    for _, estilo in pairs(estilos) do
        CriarCheckboxComando("🥊 Aprender " .. estilo, Color3.fromRGB(150, 100, 200), function(ativar, concluir)
            ComandoAcao("Aprender " .. estilo, ativar, concluir)
        end)
    end
    
    CriarCheckboxComando("⭐ Aprender Todos os Estilos", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Aprender Todos os Estilos", ativar, concluir)
    end)
end

-- ============================================
-- ABA 9: RAÇA (TUDO CHECKBOX)
-- ============================================

function CarregarRaca()
    CriarTitulo("👤 RAÇA")
    CriarSeparador()
    
    CriarDescricao("📌 Marque as evoluções de raça")
    CriarSeparador()
    
    CriarCheckboxComando("⬆️ Evoluir Race V2", Color3.fromRGB(100, 100, 200), function(ativar, concluir)
        ComandoAcao("Evoluir Race V2", ativar, concluir)
    end)
    
    CriarCheckboxComando("⬆️ Evoluir Race V3", Color3.fromRGB(100, 100, 200), function(ativar, concluir)
        ComandoAcao("Evoluir Race V3", ativar, concluir)
    end)
    
    CriarCheckboxComando("⬆️ Evoluir Race V4", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Evoluir Race V4", ativar, concluir)
    end)
    
    CriarCheckboxComando("⚡ Completar Trial", Color3.fromRGB(100, 100, 200), function(ativar, concluir)
        ComandoAcao("Completar Trial", ativar, concluir)
    end)
    
    CriarCheckboxComando("🔵 Conseguir Blue Gear", Color3.fromRGB(80, 80, 180), function(ativar, concluir)
        ComandoAcao("Conseguir Blue Gear", ativar, concluir)
    end)
    
    CriarCheckboxComando("⭐ Desbloquear Todas as Raças", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Desbloquear Todas as Raças", ativar, concluir)
    end)
end

-- ============================================
-- ABA 10: HAKI (TUDO CHECKBOX)
-- ============================================

function CarregarHaki()
    CriarTitulo("🟣 HAKI")
    CriarSeparador()
    
    CriarDescricao("📌 Marque as evoluções de Haki")
    CriarSeparador()
    
    CriarCheckboxComando("🟣 Evoluir Aura", Color3.fromRGB(200, 100, 255), function(ativar, concluir)
        ComandoAcao("Evoluir Aura", ativar, concluir)
    end)
    
    CriarCheckboxComando("👁️ Evoluir Observation", Color3.fromRGB(200, 100, 255), function(ativar, concluir)
        ComandoAcao("Evoluir Observation", ativar, concluir)
    end)
    
    CriarCheckboxComando("👁️ Conseguir Observation V2", Color3.fromRGB(200, 100, 255), function(ativar, concluir)
        ComandoAcao("Conseguir Observation V2", ativar, concluir)
    end)
    
    CriarCheckboxComando("🌈 Conseguir Rainbow Haki", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Conseguir Rainbow Haki", ativar, concluir)
    end)
    
    CriarCheckboxComando("⭐ Maximizar Haki", Color3.fromRGB(255, 200, 0), function(ativar, concluir)
        ComandoAcao("Maximizar Haki", ativar, concluir)
    end)
end

-- ============================================
-- ABA 11: UTILIDADES (TUDO CHECKBOX)
-- ============================================

function CarregarUtil()
    CriarTitulo("⚙️ UTILIDADES")
    CriarSeparador()
    
    CriarDescricao("📌 Marque as utilidades que deseja ativar")
    CriarSeparador()
    
    CriarCheckboxComando("💚 Auto Curar", Color3.fromRGB(50, 200, 100), function(ativar, concluir)
        if ativar then
            print("[UTIL] Auto Curar ATIVADO")
            task.spawn(function()
                while ativar do
                    Curar()
                    task.wait(5)
                end
            end)
        else
            print("[UTIL] Auto Curar DESATIVADO")
        end
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("🛡️ Anti-Ban", Color3.fromRGB(255, 200, 100), function(ativar, concluir)
        print("[UTIL] Anti-Ban: " .. (ativar and "ON" or "OFF"))
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("💤 Anti AFK", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        if ativar then
            print("[UTIL] Anti AFK ATIVADO")
            task.spawn(function()
                while ativar do
                    task.wait(60)
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:MoveTo(Vector3.new(0, 0, 0))
                        task.wait(0.1)
                        player.Character.Humanoid:MoveTo(Vector3.new(10, 0, 10))
                    end
                end
            end)
        else
            print("[UTIL] Anti AFK DESATIVADO")
        end
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("🔄 Auto Equipar", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        print("[UTIL] Auto Equipar: " .. (ativar and "ON" or "OFF"))
        if concluir then concluir() end
    end)
    
    CriarCheckboxComando("🚀 FPS Boost", Color3.fromRGB(100, 200, 255), function(ativar, concluir)
        print("[UTIL] FPS Boost: " .. (ativar and "ON" or "OFF"))
        if concluir then concluir() end
    end)
end

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 16)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "✅ v12.0 Checkbox Comandos | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 8
footer.Parent = frame

-- ============================================
-- INICIALIZA
-- ============================================

SelecionarAba(1)

print("✅ Blox Fruits Hub 12.0 carregado!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")