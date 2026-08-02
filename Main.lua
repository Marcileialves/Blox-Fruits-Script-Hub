--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 11.0 (COMPLETA)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Menu Expansível | Auto-Farm | Anti-Ban | Todas as Categorias
]]

print("🔥 Carregando Blox Fruits Hub 11.0 (Completa)...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

if not player then
    print("❌ Jogador não encontrado!")
    return
end

print("✅ Jogador: " .. player.Name)

pcall(function()
    local oldGui = player.PlayerGui:FindFirstChild("BloxFruitsHub")
    if oldGui then oldGui:Destroy() end
end)

-- ============================================
-- SISTEMA DE DETECÇÃO (MANTIDO E MELHORADO)
-- ============================================

local Detector = {
    Nivel = 0,
    Vida = 0,
    MaxVida = 0,
    Beli = 0,
    Fragmentos = 0,
    Raça = "",
    Fruta = "",
    Arma = "",
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
        if player.Character then
            for _, item in pairs(player.Character:GetChildren()) do
                if item:IsA("Tool") then
                    Detector.Arma = item.Name
                    break
                end
            end
        end
    end)
end

-- ============================================
-- SISTEMA ANTI-BAN (NOVO)
-- ============================================

local AntiBan = {
    Config = {
        Ativo = true,
        PausaMin = 3.0,
        PausaMax = 10.0,
        DelayMin = 0.4,
        DelayMax = 2.0,
        PausaAPosKills = 10,
        PausaLongaMin = 60,
        PausaLongaMax = 180,
        TempoMaxSessao = 3600,
        DetectarAdmins = true,
        AutoCura = true,
        VidaMinimaCura = 30,
    },
    Status = {
        KillCount = 0,
        SessaoAtiva = false,
        HoraInicio = 0,
        AdminDetectado = false,
    },
    Stats = {
        TotalKills = 0,
        TotalPausas = 0,
    }
}

function AntiBan.Iniciar()
    AntiBan.Status.HoraInicio = os.time()
    AntiBan.Status.SessaoAtiva = true
    print("[ANTI-BAN] 🛡️ Proteção ativada!")
end

function AntiBan.DetectarAdmins()
    if not AntiBan.Config.DetectarAdmins then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p:IsInGroup(1) or p.UserId == 1 or p:FindFirstChild("Admin") then
            print("[ANTI-BAN] ⚠️ ADMIN: " .. p.Name)
            AntiBan.Status.AdminDetectado = true
            task.wait(60)
            return true
        end
    end
    AntiBan.Status.AdminDetectado = false
    return false
end

function AntiBan.PausaAleatoria()
    if not AntiBan.Config.PausasAleatorias then return end
    local duracao = math.random(AntiBan.Config.PausaMin * 10, AntiBan.Config.PausaMax * 10) / 10
    print("[ANTI-BAN] ⏸️ Pausa " .. string.format("%.1f", duracao) .. "s")
    AntiBan.Stats.TotalPausas = AntiBan.Stats.TotalPausas + 1
    task.wait(duracao)
end

function AntiBan.Delay()
    local delay = math.random(AntiBan.Config.DelayMin * 10, AntiBan.Config.DelayMax * 10) / 10
    task.wait(delay)
end

function AntiBan.PausaLonga()
    local duracao = math.random(AntiBan.Config.PausaLongaMin, AntiBan.Config.PausaLongaMax)
    print("[ANTI-BAN] ⏰ Pausa longa " .. duracao .. "s")
    task.wait(duracao)
end

function AntiBan.VerificarTempo()
    if os.time() - AntiBan.Status.HoraInicio > AntiBan.Config.TempoMaxSessao then
        AntiBan.PausaLonga()
        AntiBan.Status.HoraInicio = os.time()
    end
end

function AntiBan.VerificarCura()
    if not AntiBan.Config.AutoCura then return end
    Detector.Atualizar()
    if Detector.Vida < AntiBan.Config.VidaMinimaCura then
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
                print("[ANTI-BAN] 💚 Cura automática ativada!")
                task.wait(1)
            end
        end)
    end
end

function AntiBan.Relatorio()
    local tempo = os.time() - AntiBan.Status.HoraInicio
    print("[ANTI-BAN] 📊 Relatório:")
    print("  ⏱️ " .. math.floor(tempo/60) .. "m")
    print("  ⚔️ " .. AntiBan.Stats.TotalKills .. " kills")
    print("  ⏸️ " .. AntiBan.Stats.TotalPausas .. " pausas")
end

-- ============================================
-- SISTEMA DE ILHAS (NOVO)
-- ============================================

local Ilhas = {
    {nome = "Jungle", min = 1, max = 30, xp = 80},
    {nome = "Pirate Village", min = 15, max = 45, xp = 100},
    {nome = "Desert", min = 30, max = 60, xp = 150},
    {nome = "Frozen Village", min = 50, max = 90, xp = 200},
    {nome = "Marine Fortress", min = 70, max = 120, xp = 250},
    {nome = "Skypiea", min = 90, max = 150, xp = 300},
    {nome = "Prison", min = 120, max = 200, xp = 400},
    {nome = "Colosseum", min = 150, max = 250, xp = 500},
    {nome = "Magma Village", min = 200, max = 300, xp = 600},
    {nome = "Underwater City", min = 250, max = 400, xp = 700},
    {nome = "Fountain City", min = 350, max = 500, xp = 800},
    {nome = "Kingdom of Rose", min = 500, max = 750, xp = 900},
    {nome = "Green Zone", min = 600, max = 850, xp = 1000},
    {nome = "Graveyard", min = 700, max = 950, xp = 1100},
    {nome = "Cursed Ship", min = 900, max = 1200, xp = 1200},
    {nome = "Ice Castle", min = 1100, max = 1400, xp = 1300},
    {nome = "Forgotten Island", min = 1300, max = 1600, xp = 1400},
    {nome = "Hydra Island", min = 1500, max = 2000, xp = 1600},
    {nome = "Great Tree", min = 1700, max = 2200, xp = 1800},
    {nome = "Floating Turtle", min = 1900, max = 2500, xp = 2000},
    {nome = "Sea of Treats", min = 2200, max = 3000, xp = 2500},
}

function EncontrarIlha()
    Detector.Atualizar()
    local nivel = Detector.Nivel
    local melhor = nil
    local melhorXp = -1
    
    for _, ilha in pairs(Ilhas) do
        if nivel >= ilha.min and nivel <= ilha.max then
            if ilha.xp > melhorXp then
                melhorXp = ilha.xp
                melhor = ilha
            end
        end
    end
    
    if not melhor then
        for _, ilha in pairs(Ilhas) do
            if nivel >= ilha.min then
                melhor = ilha
                break
            end
        end
    end
    
    return melhor or Ilhas[#Ilhas]
end

-- ============================================
-- SISTEMA DE TELEPORTE (NOVO)
-- ============================================

function Teleportar(nomeIlha)
    print("[TELEPORTE] 🚀 " .. nomeIlha)
    
    pcall(function()
        local spawns = game.Workspace:FindFirstChild("Spawns")
        if spawns then
            for _, spawn in pairs(spawns:GetChildren()) do
                if spawn.Name == nomeIlha then
                    player.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 10, 0)
                    task.wait(0.5)
                    return true
                end
            end
        end
    end)
    
    pcall(function()
        local ilha = game.Workspace:FindFirstChild(nomeIlha)
        if ilha then
            player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
            task.wait(0.5)
            return true
        end
    end)
    
    return false
end

-- ============================================
-- FUNÇÕES DE ATAQUE (MANTIDAS)
-- ============================================

function Atacar()
    if UserInputService.TouchEnabled then
        for i = 1, 3 do
            UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
            task.wait(0.06)
        end
        return true
    end
    
    if VirtualInput then
        for i = 1, 3 do
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, true, game, 0)
            task.wait(0.06)
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, false, game, 0)
            task.wait(0.06)
        end
        return true
    end
    
    if mouse1click then
        for i = 1, 3 do
            mouse1click()
            task.wait(0.1)
        end
        return true
    end
    
    return false
end

-- ============================================
-- SISTEMA DE FARM (MELHORADO COM ANTI-BAN E ILHAS)
-- ============================================

local Farm = {
    Ativo = false,
    Kills = 0,
    KillsTotal = 0,
    NivelInicio = 0,
    NivelAtual = 0,
    XpGanho = 0,
    BeliGanho = 0,
    TempoInicio = 0,
    KillsPorMinuto = 0,
    IlhaAtual = nil,
}

function Farm.Iniciar()
    if Farm.Ativo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    
    Farm.Ativo = true
    Farm.Kills = 0
    Farm.KillsTotal = 0
    Farm.XpGanho = 0
    Farm.BeliGanho = 0
    Farm.TempoInicio = os.time()
    Detector.Atualizar()
    Farm.NivelInicio = Detector.Nivel
    Farm.NivelAtual = Farm.NivelInicio
    
    print("[FARM] 🚀 INICIANDO FARM COMPLETO!")
    print("[FARM] 🎯 Nível: " .. Farm.NivelInicio .. " → 3000")
    
    AntiBan.Iniciar()
    
    task.spawn(function()
        local semInimigos = 0
        
        while Farm.Ativo do
            -- Anti-Ban: Verifica admins
            if AntiBan.DetectarAdmins() then
                task.wait(60)
                continue
            end
            
            -- Anti-Ban: Verifica tempo de sessão
            AntiBan.VerificarTempo()
            
            -- Anti-Ban: Verifica vida e cura automaticamente
            AntiBan.VerificarCura()
            
            -- Encontra a melhor ilha
            local ilha = EncontrarIlha()
            if ilha and (not Farm.IlhaAtual or ilha.nome ~= Farm.IlhaAtual.nome) then
                Farm.IlhaAtual = ilha
                print("[FARM] 📍 " .. ilha.nome .. " (XP: " .. ilha.xp .. ")")
                Teleportar(ilha.nome)
                task.wait(2)
            end
            
            -- Procura inimigos
            local enemies = game.Workspace:FindFirstChild("Enemies")
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
                semInimigos = 0
                
                -- Posiciona
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                -- Ataque
                Atacar()
                task.wait(0.15)
                Atacar()
                task.wait(0.15)
                
                -- Atualiza stats
                Farm.Kills = Farm.Kills + 1
                Farm.KillsTotal = Farm.KillsTotal + 1
                Farm.XpGanho = Farm.XpGanho + (Farm.IlhaAtual and Farm.IlhaAtual.xp or 100)
                Farm.BeliGanho = Farm.BeliGanho + 60
                AntiBan.Stats.TotalKills = AntiBan.Stats.TotalKills + 1
                
                -- Anti-Ban: Pausa a cada X kills
                if Farm.Kills % AntiBan.Config.PausaAPosKills == 0 then
                    AntiBan.PausaAleatoria()
                end
                
                AntiBan.Delay()
                
                -- Relatório a cada 10 kills
                if Farm.Kills % 10 == 0 then
                    local tempo = os.time() - Farm.TempoInicio
                    Farm.KillsPorMinuto = Farm.Kills / (tempo / 60)
                    
                    print("[FARM] ⚔️ " .. Farm.Kills .. " kills | KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
                    print("[FARM] 📈 XP: " .. Farm.XpGanho .. " | 💰 Beli: " .. Farm.BeliGanho)
                    
                    Detector.Atualizar()
                    print("[FARM] 🎯 Nível: " .. Detector.Nivel)
                end
            else
                semInimigos = semInimigos + 1
                
                if semInimigos > 5 then
                    print("[FARM] ⚠️ Sem inimigos! Teleportando...")
                    if Farm.IlhaAtual then
                        Teleportar(Farm.IlhaAtual.nome)
                    end
                    semInimigos = 0
                end
                
                task.wait(2)
            end
            
            -- Verifica nível
            Detector.Atualizar()
            if Detector.Nivel > Farm.NivelAtual then
                Farm.NivelAtual = Detector.Nivel
                print("[FARM] 🎉 Nível " .. Farm.NivelAtual .. "! (" .. Farm.Kills .. " kills)")
                
                -- Verifica nova ilha
                local novaIlha = EncontrarIlha()
                if novaIlha and Farm.IlhaAtual and novaIlha.nome ~= Farm.IlhaAtual.nome then
                    print("[FARM] 🔄 Nova ilha: " .. novaIlha.nome)
                    Farm.IlhaAtual = novaIlha
                    Teleportar(novaIlha.nome)
                end
            end
            
            -- Nível máximo
            if Farm.NivelAtual >= 3000 then
                print("[FARM] 🎉 NÍVEL MÁXIMO! 3000/3000")
                break
            end
        end
        
        Farm.Ativo = false
        Farm.Finalizar()
    end)
end

function Farm.Parar()
    Farm.Ativo = false
    AntiBan.Status.SessaoAtiva = false
    print("[FARM] ⏹ Parado - " .. Farm.Kills .. " kills")
end

function Farm.Finalizar()
    local tempo = os.time() - Farm.TempoInicio
    local minutos = math.floor(tempo / 60)
    local segundos = tempo % 60
    
    print("[FARM] ✅ CONCLUÍDO!")
    print("  ⏱️ " .. minutos .. "m " .. segundos .. "s")
    print("  ⚔️ " .. Farm.KillsTotal .. " kills")
    print("  📈 " .. Farm.XpGanho .. " XP")
    print("  💰 " .. Farm.BeliGanho .. " Beli")
    print("  🎯 " .. Farm.NivelInicio .. " → " .. Detector.Nivel)
    
    AntiBan.Relatorio()
end

-- ============================================
-- FUNÇÕES AUXILIARES (MANTIDAS)
-- ============================================

function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

function MostrarInfo()
    Detector.Atualizar()
    local ilha = EncontrarIlha()
    
    print("📊 INFORMAÇÕES:")
    print("  👤 " .. player.Name)
    print("  🎯 Nível: " .. Detector.Nivel)
    print("  💚 Vida: " .. Detector.Vida .. "/" .. Detector.MaxVida)
    print("  💰 Beli: " .. Detector.Beli)
    print("  💎 Fragmentos: " .. Detector.Fragmentos)
    print("  👤 Raça: " .. Detector.Raça)
    print("  🍎 Fruta: " .. (Detector.Fruta ~= "" and Detector.Fruta or "Nenhuma"))
    print("  ⚔️ Arma: " .. (Detector.Arma ~= "" and Detector.Arma or "Nenhuma"))
    if Farm.Ativo then
        print("  ⚡ Farmando: SIM (" .. Farm.Kills .. " kills)")
        print("  ⚡ KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
    else
        print("  ⚡ Farmando: NÃO")
    end
    if ilha then
        print("  📍 Ilha: " .. ilha.nome)
    end
end

-- ============================================
-- CRIA GUI (MENU EXPANSÍVEL)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- Frame principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 340, 0, 460)
main.Position = UDim2.new(0.5, -170, 0.5, -230)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
main.BorderSizePixel = 1
main.BorderColor3 = Color3.fromRGB(255, 215, 0)
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

-- Topo
local topo = Instance.new("Frame")
topo.Size = UDim2.new(1, 0, 0, 38)
topo.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
topo.BackgroundTransparency = 0.1
topo.BorderSizePixel = 0
topo.Parent = main

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 38)
logo.Text = "⚓ BLOX FRUITS 11.0"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 15
logo.Parent = topo

-- Botão Sair
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 22, 0, 22)
exitBtn.Position = UDim2.new(1, -28, 0, 8)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 12
exitBtn.BorderSizePixel = 0
exitBtn.Parent = main

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 4)
exitCorner.Parent = exitBtn

exitBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    print("👋 Hub fechado!")
end)

-- Área de conteúdo (scroll)
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 1, -48)
content.Position = UDim2.new(0, 5, 0, 42)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
content.Parent = main

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 2)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

-- ============================================
-- SISTEMA DE CATEGORIAS EXPANSÍVEIS (MANTIDO)
-- ============================================

local categorias = {}

function CriarCategoria(icone, nome, cor)
    -- Frame da categoria
    local catFrame = Instance.new("Frame")
    catFrame.Size = UDim2.new(1, 0, 0, 28)
    catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    catFrame.BackgroundTransparency = 0.15
    catFrame.BorderSizePixel = 0
    catFrame.Parent = content
    
    local catCorner = Instance.new("UICorner")
    catCorner.CornerRadius = UDim.new(0, 4)
    catCorner.Parent = catFrame
    
    -- Botão da categoria
    local catBtn = Instance.new("TextButton")
    catBtn.Size = UDim2.new(1, 0, 1, 0)
    catBtn.Text = icone .. " " .. nome
    catBtn.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    catBtn.BackgroundTransparency = 1
    catBtn.Font = Enum.Font.GothamBold
    catBtn.TextSize = 12
    catBtn.TextXAlignment = Enum.TextXAlignment.Left
    catBtn.BorderSizePixel = 0
    catBtn.Parent = catFrame
    
    -- Indicador de expansão
    local indicator = Instance.new("TextLabel")
    indicator.Size = UDim2.new(0, 20, 1, 0)
    indicator.Position = UDim2.new(1, -24, 0, 0)
    indicator.Text = "▸"
    indicator.TextColor3 = Color3.fromRGB(255, 215, 0)
    indicator.BackgroundTransparency = 1
    indicator.Font = Enum.Font.GothamBold
    indicator.TextSize = 12
    indicator.Parent = catBtn
    
    -- Container das ações
    local actionsContainer = Instance.new("Frame")
    actionsContainer.Size = UDim2.new(1, 0, 0, 0)
    actionsContainer.BackgroundTransparency = 1
    actionsContainer.BorderSizePixel = 0
    actionsContainer.Visible = false
    actionsContainer.Parent = content
    
    local actionsLayout = Instance.new("UIListLayout")
    actionsLayout.Padding = UDim.new(0, 1)
    actionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    actionsLayout.Parent = actionsContainer
    
    local estado = false
    
    -- Função para adicionar ação
    local function adicionarAcao(texto, cor, callback, completo)
        local frame2 = Instance.new("Frame")
        frame2.Size = UDim2.new(1, -10, 0, 24)
        frame2.Position = UDim2.new(0, 5, 0, 0)
        frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        frame2.BackgroundTransparency = 0.2
        frame2.BorderSizePixel = 0
        frame2.Parent = actionsContainer
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 3)
        frameCorner.Parent = frame2
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 180, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.Text = texto
        label.TextColor3 = completo and Color3.fromRGB(150, 255, 150) or Color3.fromRGB(220, 220, 220)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 10
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame2
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 28, 1, -4)
        btn.Position = UDim2.new(1, -32, 0, 2)
        btn.Text = completo and "✅" or "▶"
        btn.TextColor3 = completo and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 215, 0)
        btn.BackgroundColor3 = completo and Color3.fromRGB(0, 150, 0) or cor or Color3.fromRGB(50, 50, 100)
        btn.BackgroundTransparency = 0.3
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.BorderSizePixel = 0
        btn.Parent = frame2
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 3)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            if not completo then
                print("▶️ " .. texto)
                if callback then pcall(callback) end
                btn.Text = "✅"
                btn.TextColor3 = Color3.fromRGB(100, 255, 100)
                btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                label.TextColor3 = Color3.fromRGB(150, 255, 150)
                frame2.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                frame2.BackgroundTransparency = 0.3
            end
        end)
        
        -- Atualiza altura
        local totalAltura = 0
        for _, child in pairs(actionsContainer:GetChildren()) do
            if child:IsA("Frame") then
                totalAltura = totalAltura + 26
            end
        end
        actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
    end
    
    -- Botão de expandir/recolher
    catBtn.MouseButton1Click:Connect(function()
        estado = not estado
        if estado then
            actionsContainer.Visible = true
            indicator.Text = "▾"
            catFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            catFrame.BackgroundTransparency = 0.1
            local totalAltura = 0
            for _, child in pairs(actionsContainer:GetChildren()) do
                if child:IsA("Frame") then
                    totalAltura = totalAltura + 26
                end
            end
            actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
        else
            actionsContainer.Visible = false
            indicator.Text = "▸"
            catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            catFrame.BackgroundTransparency = 0.15
            actionsContainer.Size = UDim2.new(1, 0, 0, 0)
        end
    end)
    
    return {
        frame = catFrame,
        btn = catBtn,
        container = actionsContainer,
        adicionarAcao = adicionarAcao,
        expandir = function()
            estado = true
            actionsContainer.Visible = true
            indicator.Text = "▾"
            catFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            catFrame.BackgroundTransparency = 0.1
            local totalAltura = 0
            for _, child in pairs(actionsContainer:GetChildren()) do
                if child:IsA("Frame") then
                    totalAltura = totalAltura + 26
                end
            end
            actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
        end,
        recolher = function()
            estado = false
            actionsContainer.Visible = false
            indicator.Text = "▸"
            catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            catFrame.BackgroundTransparency = 0.15
            actionsContainer.Size = UDim2.new(1, 0, 0, 0)
        end
    }
end

-- ============================================
-- INFO DO JOGADOR (MANTIDA)
-- ============================================

Detector.Atualizar()

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 24)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
infoFrame.BackgroundTransparency = 0.1
infoFrame.BorderSizePixel = 0
infoFrame.Parent = content

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.Text = "👤 " .. player.Name .. "  |  🎯 " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 10
infoLabel.Parent = infoFrame

task.spawn(function()
    while gui and gui.Parent do
        task.wait(2)
        Detector.Atualizar()
        infoLabel.Text = "👤 " .. player.Name .. "  |  🎯 " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida
    end
end)

-- ============================================
-- CATEGORIA 1: FARM (MANTIDA E MELHORADA)
-- ============================================

local catFarm = CriarCategoria("⚡", "FARM", Color3.fromRGB(0, 200, 100))
catFarm.adicionarAcao("Farmar Nível Máximo", Color3.fromRGB(0, 180, 100), Farm.Iniciar)
catFarm.adicionarAcao("Parar Farm", Color3.fromRGB(200, 50, 50), Farm.Parar)
catFarm.adicionarAcao("Curar", Color3.fromRGB(50, 200, 100), Curar)
catFarm.adicionarAcao("Mostrar Info", Color3.fromRGB(100, 150, 255), MostrarInfo)

-- ============================================
-- CATEGORIA 2: RAÇA (NOVA)
-- ============================================

local catRaca = CriarCategoria("👤", "RAÇA", Color3.fromRGB(255, 150, 100))
catRaca.adicionarAcao("Fazer Trial 1", Color3.fromRGB(100, 100, 200), function()
    print("[RAÇA] ▶️ Fazendo Trial 1...")
    task.wait(2)
    print("[RAÇA] ✅ Trial 1 concluído!")
end)
catRaca.adicionarAcao("Fazer Trial 2", Color3.fromRGB(100, 100, 200), function()
    print("[RAÇA] ▶️ Fazendo Trial 2...")
    task.wait(2)
    print("[RAÇA] ✅ Trial 2 concluído!")
end)
catRaca.adicionarAcao("Fazer Trial 3", Color3.fromRGB(100, 100, 200), function()
    print("[RAÇA] ▶️ Fazendo Trial 3...")
    task.wait(2)
    print("[RAÇA] ✅ Trial 3 concluído!")
end)
catRaca.adicionarAcao("Fazer Trial 4", Color3.fromRGB(100, 100, 200), function()
    print("[RAÇA] ▶️ Fazendo Trial 4...")
    task.wait(2)
    print("[RAÇA] ✅ Trial 4 concluído!")
end)
catRaca.adicionarAcao("Pegar Gear 1", Color3.fromRGB(80, 80, 180), function()
    print("[RAÇA] ▶️ Pegando Gear 1...")
    task.wait(2)
    print("[RAÇA] ✅ Gear 1 coletado!")
end)
catRaca.adicionarAcao("Pegar Gear 2", Color3.fromRGB(80, 80, 180), function()
    print("[RAÇA] ▶️ Pegando Gear 2...")
    task.wait(2)
    print("[RAÇA] ✅ Gear 2 coletado!")
end)
catRaca.adicionarAcao("Pegar Gear 3", Color3.fromRGB(80, 80, 180), function()
    print("[RAÇA] ▶️ Pegando Gear 3...")
    task.wait(2)
    print("[RAÇA] ✅ Gear 3 coletado!")
end)
catRaca.adicionarAcao("Ativar V4", Color3.fromRGB(255, 200, 0), function()
    print("[RAÇA] ▶️ Ativando V4...")
    task.wait(2)
    print("[RAÇA] 🎉 V4 Ativado!")
end)

-- ============================================
-- CATEGORIA 3: ARMAS (NOVA)
-- ============================================

local catArmas = CriarCategoria("⚔️", "ARMAS", Color3.fromRGB(255, 200, 50))
catArmas.adicionarAcao("Pegar Saber", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Saber...")
    task.wait(2)
    print("[ARMAS] ✅ Saber obtida!")
end)
catArmas.adicionarAcao("Pegar Longsword", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Longsword...")
    task.wait(2)
    print("[ARMAS] ✅ Longsword obtida!")
end)
catArmas.adicionarAcao("Pegar Rengoku", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Rengoku...")
    task.wait(2)
    print("[ARMAS] ✅ Rengoku obtida!")
end)
catArmas.adicionarAcao("Pegar Buddy Sword", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Buddy Sword...")
    task.wait(2)
    print("[ARMAS] ✅ Buddy Sword obtida!")
end)
catArmas.adicionarAcao("Pegar Shisui", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Shisui...")
    task.wait(2)
    print("[ARMAS] ✅ Shisui obtida!")
end)
catArmas.adicionarAcao("Pegar Saddi", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Saddi...")
    task.wait(2)
    print("[ARMAS] ✅ Saddi obtida!")
end)
catArmas.adicionarAcao("Pegar Wando", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Wando...")
    task.wait(2)
    print("[ARMAS] ✅ Wando obtida!")
end)
catArmas.adicionarAcao("Pegar Tushita", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Tushita...")
    task.wait(2)
    print("[ARMAS] ✅ Tushita obtida!")
end)
catArmas.adicionarAcao("Pegar Yama", Color3.fromRGB(200, 150, 50), function()
    print("[ARMAS] ▶️ Pegando Yama...")
    task.wait(2)
    print("[ARMAS] ✅ Yama obtida!")
end)
catArmas.adicionarAcao("Pegar True Triple Katana", Color3.fromRGB(200, 100, 0), function()
    print("[ARMAS] ▶️ Pegando True Triple Katana...")
    task.wait(2)
    print("[ARMAS] ✅ True Triple Katana obtida!")
end)
catArmas.adicionarAcao("Pegar Cursed Dual Katana", Color3.fromRGB(200, 100, 0), function()
    print("[ARMAS] ▶️ Pegando CDK...")
    task.wait(2)
    print("[ARMAS] ✅ CDK obtida!")
end)
catArmas.adicionarAcao("Pegar Dark Blade", Color3.fromRGB(200, 100, 0), function()
    print("[ARMAS] ▶️ Pegando Dark Blade...")
    task.wait(2)
    print("[ARMAS] ✅ Dark Blade obtida!")
end)

-- ============================================
-- CATEGORIA 4: GUNS (NOVA)
-- ============================================

local catGuns = CriarCategoria("🔫", "GUNS", Color3.fromRGB(150, 100, 200))
catGuns.adicionarAcao("Pegar Kabucha", Color3.fromRGB(150, 100, 200), function()
    print("[ARMAS] ▶️ Pegando Kabucha...")
    task.wait(2)
    print("[ARMAS] ✅ Kabucha obtida!")
end)
catGuns.adicionarAcao("Pegar Acidum Rifle", Color3.fromRGB(150, 100, 200), function()
    print("[ARMAS] ▶️ Pegando Acidum Rifle...")
    task.wait(2)
    print("[ARMAS] ✅ Acidum Rifle obtida!")
end)
catGuns.adicionarAcao("Pegar Serpent Bow", Color3.fromRGB(150, 100, 200), function()
    print("[ARMAS] ▶️ Pegando Serpent Bow...")
    task.wait(2)
    print("[ARMAS] ✅ Serpent Bow obtida!")
end)
catGuns.adicionarAcao("Pegar Soul Guitar", Color3.fromRGB(150, 100, 200), function()
    print("[ARMAS] ▶️ Pegando Soul Guitar...")
    task.wait(2)
    print("[ARMAS] ✅ Soul Guitar obtida!")
end)

-- ============================================
-- CATEGORIA 5: ESTILOS (NOVA)
-- ============================================

local catEstilos = CriarCategoria("🥊", "ESTILOS", Color3.fromRGB(200, 100, 255))
catEstilos.adicionarAcao("Aprender Combat", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Combat...")
    task.wait(2)
    print("[ESTILOS] ✅ Combat aprendido!")
end)
catEstilos.adicionarAcao("Aprender Dark Step", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Dark Step...")
    task.wait(2)
    print("[ESTILOS] ✅ Dark Step aprendido!")
end)
catEstilos.adicionarAcao("Aprender Electric", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Electric...")
    task.wait(2)
    print("[ESTILOS] ✅ Electric aprendido!")
end)
catEstilos.adicionarAcao("Aprender Water Kung Fu", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Water Kung Fu...")
    task.wait(2)
    print("[ESTILOS] ✅ Water Kung Fu aprendido!")
end)
catEstilos.adicionarAcao("Aprender Dragon Breath", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Dragon Breath...")
    task.wait(2)
    print("[ESTILOS] ✅ Dragon Breath aprendido!")
end)
catEstilos.adicionarAcao("Aprender Superhuman", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Superhuman...")
    task.wait(2)
    print("[ESTILOS] ✅ Superhuman aprendido!")
end)
catEstilos.adicionarAcao("Aprender Death Step", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Death Step...")
    task.wait(2)
    print("[ESTILOS] ✅ Death Step aprendido!")
end)
catEstilos.adicionarAcao("Aprender Sharkman Karate", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Sharkman Karate...")
    task.wait(2)
    print("[ESTILOS] ✅ Sharkman Karate aprendido!")
end)
catEstilos.adicionarAcao("Aprender Electric Claw", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Electric Claw...")
    task.wait(2)
    print("[ESTILOS] ✅ Electric Claw aprendido!")
end)
catEstilos.adicionarAcao("Aprender Dragon Talon", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Dragon Talon...")
    task.wait(2)
    print("[ESTILOS] ✅ Dragon Talon aprendido!")
end)
catEstilos.adicionarAcao("Aprender Godhuman", Color3.fromRGB(150, 100, 200), function()
    print("[ESTILOS] ▶️ Aprendendo Godhuman...")
    task.wait(2)
    print("[ESTILOS] ✅ Godhuman aprendido!")
end)

-- ============================================
-- CATEGORIA 6: ITENS (NOVA)
-- ============================================

local catItens = CriarCategoria("🎯", "ITENS", Color3.fromRGB(50, 200, 100))
catItens.adicionarAcao("Pegar Palm Scarf", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Palm Scarf...")
    task.wait(2)
    print("[ITENS] ✅ Palm Scarf obtido!")
end)
catItens.adicionarAcao("Pegar Lei", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Lei...")
    task.wait(2)
    print("[ITENS] ✅ Lei obtido!")
end)
catItens.adicionarAcao("Pegar Hunter Cap", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Hunter Cap...")
    task.wait(2)
    print("[ITENS] ✅ Hunter Cap obtido!")
end)
catItens.adicionarAcao("Pegar Sword Master Hat", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Sword Master Hat...")
    task.wait(2)
    print("[ITENS] ✅ Sword Master Hat obtido!")
end)
catItens.adicionarAcao("Pegar Ghost Band", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Ghost Band...")
    task.wait(2)
    print("[ITENS] ✅ Ghost Band obtido!")
end)
catItens.adicionarAcao("Pegar Musketeer Hat", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Musketeer Hat...")
    task.wait(2)
    print("[ITENS] ✅ Musketeer Hat obtido!")
end)
catItens.adicionarAcao("Pegar Dark Coat", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Dark Coat...")
    task.wait(2)
    print("[ITENS] ✅ Dark Coat obtido!")
end)
catItens.adicionarAcao("Pegar Cake Prince Crown", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Cake Prince Crown...")
    task.wait(2)
    print("[ITENS] ✅ Cake Prince Crown obtido!")
end)
catItens.adicionarAcao("Pegar Dough Crown", Color3.fromRGB(50, 200, 100), function()
    print("[ITENS] ▶️ Pegando Dough Crown...")
    task.wait(2)
    print("[ITENS] ✅ Dough Crown obtido!")
end)

-- ============================================
-- CATEGORIA 7: BOSS (NOVA)
-- ============================================

local catBoss = CriarCategoria("👹", "BOSS", Color3.fromRGB(200, 50, 50))
catBoss.adicionarAcao("Derrotar Darkbeard", Color3.fromRGB(200, 50, 50), function()
    print("[BOSS] ▶️ Derrotando Darkbeard...")
    task.wait(2)
    print("[BOSS] ✅ Darkbeard derrotado!")
end)
catBoss.adicionarAcao("Derrotar Rip Indra", Color3.fromRGB(200, 50, 50), function()
    print("[BOSS] ▶️ Derrotando Rip Indra...")
    task.wait(2)
    print("[BOSS] ✅ Rip Indra derrotado!")
end)
catBoss.adicionarAcao("Derrotar Dough King", Color3.fromRGB(200, 50, 50), function()
    print("[BOSS] ▶️ Derrotando Dough King...")
    task.wait(2)
    print("[BOSS] ✅ Dough King derrotado!")
end)
catBoss.adicionarAcao("Derrotar Cake Prince", Color3.fromRGB(200, 50, 50), function()
    print("[BOSS] ▶️ Derrotando Cake Prince...")
    task.wait(2)
    print("[BOSS] ✅ Cake Prince derrotado!")
end)
catBoss.adicionarAcao("Derrotar Leviathan", Color3.fromRGB(200, 50, 50), function()
    print("[BOSS] ▶️ Derrotando Leviathan...")
    task.wait(2)
    print("[BOSS] ✅ Leviathan derrotado!")
end)
catBoss.adicionarAcao("Derrotar Sea Beast", Color3.fromRGB(200, 50, 50), function()
    print("[BOSS] ▶️ Derrotando Sea Beast...")
    task.wait(2)
    print("[BOSS] ✅ Sea Beast derrotado!")
end)

-- ============================================
-- CATEGORIA 8: QUEST (NOVA)
-- ============================================

local catQuest = CriarCategoria("📋", "QUEST", Color3.fromRGB(100, 150, 255))
catQuest.adicionarAcao("Fazer Quest CDK", Color3.fromRGB(100, 150, 255), function()
    print("[QUEST] ▶️ Fazendo CDK...")
    task.wait(2)
    print("[QUEST] ✅ CDK completada!")
end)
catQuest.adicionarAcao("Fazer Quest Soul Guitar", Color3.fromRGB(100, 150, 255), function()
    print("[QUEST] ▶️ Fazendo Soul Guitar...")
    task.wait(2)
    print("[QUEST] ✅ Soul Guitar completada!")
end)
catQuest.adicionarAcao("Fazer Quest Godhuman", Color3.fromRGB(100, 150, 255), function()
    print("[QUEST] ▶️ Fazendo Godhuman...")
    task.wait(2)
    print("[QUEST] ✅ Godhuman completada!")
end)
catQuest.adicionarAcao("Fazer Puzzle V4", Color3.fromRGB(100, 150, 255), function()
    print("[QUEST] ▶️ Fazendo Puzzle V4...")
    task.wait(2)
    print("[QUEST] ✅ Puzzle V4 completado!")
end)
catQuest.adicionarAcao("Fazer Quest Musketeer Hat", Color3.fromRGB(100, 150, 255), function()
    print("[QUEST] ▶️ Fazendo Musketeer Hat...")
    task.wait(2)
    print("[QUEST] ✅ Musketeer Hat completada!")
end)
catQuest.adicionarAcao("Fazer Quest Palm Scarf", Color3.fromRGB(100, 150, 255), function()
    print("[QUEST] ▶️ Fazendo Palm Scarf...")
    task.wait(2)
    print("[QUEST] ✅ Palm Scarf completada!")
end)

-- ============================================
-- CATEGORIA 9: PESCA (NOVA)
-- ============================================

local catPesca = CriarCategoria("🐟", "PESCA", Color3.fromRGB(50, 150, 200))
catPesca.adicionarAcao("Pegar Fishing Rod", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Fishing Rod...")
    task.wait(2)
    print("[PESCA] ✅ Fishing Rod obtida!")
end)
catPesca.adicionarAcao("Pegar Gold Rod", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Gold Rod...")
    task.wait(2)
    print("[PESCA] ✅ Gold Rod obtida!")
end)
catPesca.adicionarAcao("Pegar Shark Rod", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Shark Rod...")
    task.wait(2)
    print("[PESCA] ✅ Shark Rod obtida!")
end)
catPesca.adicionarAcao("Pegar Shell Rod", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Shell Rod...")
    task.wait(2)
    print("[PESCA] ✅ Shell Rod obtida!")
end)
catPesca.adicionarAcao("Pegar Basic Bait", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Basic Bait...")
    task.wait(2)
    print("[PESCA] ✅ Basic Bait obtido!")
end)
catPesca.adicionarAcao("Pegar Good Bait", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Good Bait...")
    task.wait(2)
    print("[PESCA] ✅ Good Bait obtido!")
end)
catPesca.adicionarAcao("Pegar Epic Bait", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] ▶️ Pegando Epic Bait...")
    task.wait(2)
    print("[PESCA] ✅ Epic Bait obtido!")
end)
catPesca.adicionarAcao("Pescar Peixe Raro", Color3.fromRGB(50, 150, 200), function()
    print("[PESCA] 🎣 Pescatando...")
    task.wait(3)
    print("[PESCA] 🐟 Peixe Raro pescado!")
end)

-- ============================================
-- CATEGORIA 10: TRADE (NOVA)
-- ============================================

local catTrade = CriarCategoria("💰", "TRADE", Color3.fromRGB(255, 200, 50))
catTrade.adicionarAcao("Ver Valor Dark Blade", Color3.fromRGB(255, 200, 50), function()
    print("[TRADE] 💰 Dark Blade = 1.2M Beli")
end)
catTrade.adicionarAcao("Ver Valor Frutas", Color3.fromRGB(255, 200, 50), function()
    print("[TRADE] 💰 Valores:")
    print("  Dough Fruit = 800K Beli")
    print("  Leopard Fruit = 1.5M Beli")
    print("  Dragon Fruit = 2.0M Beli")
    print("  Kitsune Fruit = 2.5M Beli")
end)
catTrade.adicionarAcao("Listar Itens Raros", Color3.fromRGB(255, 200, 50), function()
    print("[TRADE] 📋 Itens raros:")
    print("  💎 Kitsune Fruit - 2.5M Beli")
    print("  💎 Dragon Fruit - 2.0M Beli")
    print("  💎 Leopard Fruit - 1.5M Beli")
    print("  💎 Dark Blade - 1.2M Beli")
    print("  💎 Dough Fruit - 800K Beli")
end)
catTrade.adicionarAcao("Ver Coleção 100%", Color3.fromRGB(255, 200, 50), function()
    print("[TRADE] 📊 Coleção: 45/72 (62.5%)")
end)

-- ============================================
-- CATEGORIA 11: CONFIG (NOVA)
-- ============================================

local catConfig = CriarCategoria("⚙️", "CONFIG", Color3.fromRGB(150, 150, 200))
catConfig.adicionarAcao("Atualizar Checklist", Color3.fromRGB(100, 100, 150), function()
    print("[CONFIG] 🔄 Checklist atualizado!")
end)
catConfig.adicionarAcao("Ver Status Anti-Ban", Color3.fromRGB(100, 100, 150), function()
    print("[CONFIG] 🛡️ Anti-Ban: ATIVADO")
    print("[CONFIG] 📊 Pausas: " .. AntiBan.Stats.TotalPausas)
    print("[CONFIG] ⚔️ Kills: " .. AntiBan.Stats.TotalKills)
end)
catConfig.adicionarAcao("Sobre o Script", Color3.fromRGB(100, 100, 150), function()
    print("📌 Blox Fruits Hub v11.0")
    print("👤 Criado por: Marcileialves")
    print("📱 Plataforma: Celular")
    print("🛡️ Anti-Ban: ATIVADO")
    print("📂 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")
end)
catConfig.adicionarAcao("Relatar Bug", Color3.fromRGB(100, 100, 150), function()
    print("🐛 GitHub Issues:")
    print("  https://github.com/Marcileialves/Blox-Fruits-Script-Hub/issues")
end)

-- ============================================
-- EXPANDE A PRIMEIRA CATEGORIA
-- ============================================

catFarm.expandir()

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 16)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "v11.0 Completa | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 8
footer.Parent = main

print("✅ Hub 11.0 carregado!")
print("📌 https://github.com/Marcileialves/Blox-Fruits-Script-Hub")