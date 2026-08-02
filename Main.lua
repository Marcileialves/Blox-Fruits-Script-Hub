--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 7.0 (MÁXIMO POTENCIAL)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Celular | Anti-Ban Avançado | Farm Completo
]]

print("🔥 Carregando Blox Fruits Hub 7.0 (Máximo Potencial)...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")

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
-- SISTEMA ANTI-BAN ULTRA (NÍVEL MÁXIMO)
-- ============================================

local AntiBan = {
    Config = {
        Ativo = true,
        Nivel = "MAXIMO",
        PausaMin = 4.0,
        PausaMax = 15.0,
        DelayMin = 0.5,
        DelayMax = 2.8,
        PausaAPosKills = 8,
        PausaLongaMin = 120,
        PausaLongaMax = 480,
        TempoMaxSessao = 5400, -- 1.5 horas
        VariacaoMovimento = true,
        DetectarAdmins = true,
        DetectarJogadores = true,
    },
    
    Status = {
        KillCount = 0,
        SessaoAtiva = false,
        HoraInicio = 0,
        AdminDetectado = false,
        PausaForcada = false,
    },
    
    Stats = {
        TotalKills = 0,
        TotalPausas = 0,
        TempoJogado = 0,
    }
}

-- FUNÇÕES ANTI-BAN
function AntiBan.Iniciar()
    AntiBan.Status.HoraInicio = os.time()
    AntiBan.Status.SessaoAtiva = true
    print("[ANTI-BAN] 🛡️ Proteção MAXIMA ativada!")
end

function AntiBan.DetectarAdmins()
    if not AntiBan.Config.DetectarAdmins then return false end
    for _, p in pairs(game.Players:GetPlayers()) do
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

function AntiBan.ComportamentoHumano()
    if math.random(1, 10) > 7 then
        local acoes = {"olhar", "mover", "esperar"}
        local acao = acoes[math.random(1, #acoes)]
        if acao == "mover" then
            local pos = player.Character.HumanoidRootPart.Position
            player.Character.HumanoidRootPart.CFrame = CFrame.new(
                pos.X + math.random(-8, 8),
                pos.Y,
                pos.Z + math.random(-8, 8)
            )
        end
        task.wait(math.random(1, 3))
    end
end

function AntiBan.Relatorio()
    local tempo = os.time() - AntiBan.Status.HoraInicio
    print("[ANTI-BAN] 📊 Relatório:")
    print("  ⏱️ " .. math.floor(tempo/60) .. "m")
    print("  ⚔️ " .. AntiBan.Stats.TotalKills .. " kills")
    print("  ⏸️ " .. AntiBan.Stats.TotalPausas .. " pausas")
    print("  🛡️ Nível: MAXIMO")
end

-- ============================================
-- SISTEMA DE ILHAS (COMPLETO)
-- ============================================

local Ilhas = {
    -- 1º Mar
    {nome = "Jungle", min = 1, max = 30, xp = 80, prioridade = 1},
    {nome = "Pirate Village", min = 15, max = 45, xp = 100, prioridade = 2},
    {nome = "Desert", min = 30, max = 60, xp = 150, prioridade = 3},
    {nome = "Frozen Village", min = 50, max = 90, xp = 200, prioridade = 4},
    {nome = "Marine Fortress", min = 70, max = 120, xp = 250, prioridade = 5},
    {nome = "Skypiea", min = 90, max = 150, xp = 300, prioridade = 6},
    {nome = "Prison", min = 120, max = 200, xp = 400, prioridade = 7},
    {nome = "Colosseum", min = 150, max = 250, xp = 500, prioridade = 8},
    {nome = "Magma Village", min = 200, max = 300, xp = 600, prioridade = 9},
    {nome = "Underwater City", min = 250, max = 400, xp = 700, prioridade = 10},
    {nome = "Fountain City", min = 350, max = 500, xp = 800, prioridade = 11},
    -- 2º Mar
    {nome = "Kingdom of Rose", min = 500, max = 750, xp = 900, prioridade = 12},
    {nome = "Green Zone", min = 600, max = 850, xp = 1000, prioridade = 13},
    {nome = "Graveyard", min = 700, max = 950, xp = 1100, prioridade = 14},
    {nome = "Cursed Ship", min = 900, max = 1200, xp = 1200, prioridade = 15},
    {nome = "Ice Castle", min = 1100, max = 1400, xp = 1300, prioridade = 16},
    {nome = "Forgotten Island", min = 1300, max = 1600, xp = 1400, prioridade = 17},
    -- 3º Mar
    {nome = "Hydra Island", min = 1500, max = 2000, xp = 1600, prioridade = 18},
    {nome = "Great Tree", min = 1700, max = 2200, xp = 1800, prioridade = 19},
    {nome = "Floating Turtle", min = 1900, max = 2500, xp = 2000, prioridade = 20},
    {nome = "Sea of Treats", min = 2200, max = 3000, xp = 2500, prioridade = 21},
}

function EncontrarIlha()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local melhor = nil
    local melhorPrioridade = -1
    
    for _, ilha in pairs(Ilhas) do
        if nivel >= ilha.min and nivel <= ilha.max then
            if ilha.prioridade > melhorPrioridade then
                melhorPrioridade = ilha.prioridade
                melhor = ilha
            end
        end
    end
    
    if not melhor then
        for _, ilha in pairs(Ilhas) do
            if nivel >= ilha.min then
                melhor = ilha
            end
        end
    end
    
    return melhor or Ilhas[#Ilhas]
end

-- ============================================
-- SISTEMA DE TELEPORTE (OTIMIZADO)
-- ============================================

function Teleportar(nomeIlha)
    print("[TELEPORTE] 🚀 " .. nomeIlha)
    
    local tentativas = 0
    while tentativas < 3 do
        tentativas = tentativas + 1
        
        -- Método 1: Spawns
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
        
        -- Método 2: Ilha
        local ilha = game.Workspace:FindFirstChild(nomeIlha)
        if ilha then
            player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
            task.wait(0.5)
            return true
        end
        
        -- Método 3: TeleportService
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, player)
        end)
        
        task.wait(1)
    end
    
    print("[TELEPORTE] ⚠️ Falha após 3 tentativas")
    return false
end

-- ============================================
-- SISTEMA DE ATAQUE (MULTI-MÉTODO)
-- ============================================

function Atacar()
    local sucesso = false
    
    -- Método 1: Touch (Celular)
    if UserInputService.TouchEnabled then
        for i = 1, 3 do
            UserInputService:TouchTap(Vector2.new(300 + math.random(-50, 50), 400 + math.random(-50, 50)))
            task.wait(0.05)
            sucesso = true
        end
    end
    
    -- Método 2: VirtualInput
    if not sucesso and VirtualInput then
        for i = 1, 3 do
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, true, game, 0)
            task.wait(0.05)
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, false, game, 0)
            task.wait(0.05)
            sucesso = true
        end
    end
    
    -- Método 3: Mouse1Click (PC)
    if not sucesso and mouse1click then
        for i = 1, 3 do
            mouse1click()
            task.wait(0.1)
            sucesso = true
        end
    end
    
    return sucesso
end

-- ============================================
-- SISTEMA DE FARM (COMPLETO)
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
    StatusLabel = nil,
    InimigosProximos = 0,
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
    Farm.NivelInicio = player.Level or player:GetAttribute("Level") or 0
    Farm.NivelAtual = Farm.NivelInicio
    
    print("[FARM] 🚀 INICIANDO FARM COMPLETO!")
    print("[FARM] 🎯 Nível: " .. Farm.NivelInicio .. " → 3000")
    
    AntiBan.Iniciar()
    
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "⚡ Farmando... 0 kills"
    end
    
    task.spawn(function()
        local semInimigos = 0
        
        while Farm.Ativo do
            -- Anti-Ban
            if AntiBan.DetectarAdmins() then
                task.wait(60)
                continue
            end
            
            AntiBan.VerificarTempo()
            
            -- Encontra ilha
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
            Farm.InimigosProximos = 0
            
            if enemies then
                for _, e in pairs(enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 150 then
                            Farm.InimigosProximos = Farm.InimigosProximos + 1
                            if not alvo then alvo = e end
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
                for i = 1, 4 do
                    Atacar()
                    task.wait(0.15)
                end
                
                -- Atualiza stats
                Farm.Kills = Farm.Kills + 1
                Farm.KillsTotal = Farm.KillsTotal + 1
                Farm.XpGanho = Farm.XpGanho + (Farm.IlhaAtual and Farm.IlhaAtual.xp or 100)
                Farm.BeliGanho = Farm.BeliGanho + 60
                AntiBan.Stats.TotalKills = AntiBan.Stats.TotalKills + 1
                
                -- Anti-Ban
                if Farm.Kills % AntiBan.Config.PausaAPosKills == 0 then
                    AntiBan.PausaAleatoria()
                end
                
                AntiBan.Delay()
                AntiBan.ComportamentoHumano()
                
                -- Relatório
                if Farm.Kills % 5 == 0 then
                    local tempo = os.time() - Farm.TempoInicio
                    Farm.KillsPorMinuto = Farm.Kills / (tempo / 60)
                    
                    print("[FARM] ⚔️ " .. Farm.Kills .. " kills | KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
                    print("[FARM] 📈 XP: " .. Farm.XpGanho .. " | 💰 Beli: " .. Farm.BeliGanho)
                    
                    if Farm.StatusLabel then
                        local nivel = player.Level or player:GetAttribute("Level") or 0
                        Farm.StatusLabel.Text = "⚡ " .. Farm.Kills .. " kills | KPM: " .. string.format("%.1f", Farm.KillsPorMinuto) .. " | Nv " .. nivel
                    end
                end
            else
                semInimigos = semInimigos + 1
                
                if semInimigos > 5 then
                    print("[FARM] ⚠️ Sem inimigos! Teleportando...")
                    if Farm.IlhaAtual then
                        Teleportar(Farm.IlhaAtual.nome)
                    else
                        Teleportar("Jungle")
                    end
                    semInimigos = 0
                end
                
                task.wait(2)
            end
            
            -- Verifica nível
            local nivel = player.Level or player:GetAttribute("Level") or 0
            if nivel > Farm.NivelAtual then
                Farm.NivelAtual = nivel
                print("[FARM] 🎉 Nível " .. nivel .. "! (" .. Farm.Kills .. " kills)")
                
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
    print("[FARM] ⏹ Parado")
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "⏹ Parado"
    end
end

function Farm.Finalizar()
    local tempo = os.time() - Farm.TempoInicio
    local horas = math.floor(tempo / 3600)
    local minutos = math.floor((tempo % 3600) / 60)
    
    print("[FARM] ✅ CONCLUÍDO!")
    print("  ⏱️ " .. horas .. "h " .. minutos .. "m")
    print("  ⚔️ " .. Farm.KillsTotal .. " kills")
    print("  📈 " .. Farm.XpGanho .. " XP")
    print("  💰 " .. Farm.BeliGanho .. " Beli")
    print("  🎯 " .. Farm.NivelAtual .. " → " .. (player.Level or player:GetAttribute("Level") or 0))
    print("  ⚡ KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
    
    AntiBan.Relatorio()
    
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "✅ " .. Farm.KillsTotal .. " kills | Nv " .. Farm.NivelAtual
    end
end

-- ============================================
-- FUNÇÕES AUXILIARES
-- ============================================

function Curar()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
        print("💚 Curado!")
    end
end

function MostrarInfo()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    local ilha = EncontrarIlha()
    
    print("📊 INFORMAÇÕES:")
    print("  👤 " .. player.Name)
    print("  🎯 Nível: " .. nivel)
    print("  💚 Vida: " .. health)
    if Farm.Ativo then
        print("  ⚡ Farmando: SIM (" .. Farm.Kills .. " kills)")
    else
        print("  ⚡ Farmando: NÃO")
    end
    if ilha then
        print("  📍 Ilha: " .. ilha.nome .. " (XP: " .. ilha.xp .. ")")
    end
end

-- ============================================
-- CRIA INTERFACE (MODERNA)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- Fundo com gradiente
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 640)
frame.Position = UDim2.new(0.5, -210, 0.5, -320)
frame.BackgroundColor3 = Color3.fromRGB(5, 5, 25)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 0
header.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🔥 BLOX FRUITS 7.0"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Parent = header

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 45)
sub.Text = "⚡ Máximo Potencial | Anti-Ban Ultra"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.GothamMedium
sub.TextSize = 12
sub.Parent = header

-- Área de conteúdo
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 1, -150)
content.Position = UDim2.new(0, 5, 0, 75)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
content.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

-- Criar elementos UI
function CriarBotao(texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("▶️ " .. texto)
        if callback then pcall(callback) end
    end)
    
    return btn
end

function CriarLabel(texto, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 28)
    lbl.Text = texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    return lbl
end

function CriarStatus(texto)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 45)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.3
    frame2.BorderSizePixel = 0
    frame2.Parent = content
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 10)
    corner2.Parent = frame2
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.Text = texto
    lbl.TextColor3 = Color3.fromRGB(100, 255, 100)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.Parent = frame2
    
    return lbl
end

-- Interface
CriarLabel("⚡ CONTROLES")

CriarBotao("⚡ FARMAR NÍVEL MÁXIMO", Color3.fromRGB(0, 180, 100), Farm.Iniciar)
CriarBotao("⏹ PARAR FARM", Color3.fromRGB(200, 50, 50), Farm.Parar)
CriarBotao("💚 CURAR", Color3.fromRGB(50, 200, 100), Curar)
CriarBotao("📊 INFORMAÇÕES", Color3.fromRGB(100, 150, 255), MostrarInfo)

CriarLabel("📊 STATUS")
Farm.StatusLabel = CriarStatus("⏸️ Pronto")

CriarLabel("👤 JOGADOR")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 70)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
infoFrame.BackgroundTransparency = 0.3
infoFrame.BorderSizePixel = 0
infoFrame.Parent = content

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 10)
infoCorner.Parent = infoFrame

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 30)
nameLabel.Position = UDim2.new(0, 10, 0, 2)
nameLabel.Text = "👤 " .. player.Name
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 15
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = infoFrame

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 28)
infoLabel.Position = UDim2.new(0, 10, 0, 35)
infoLabel.Text = "💚 Vida: 100 | 🎯 Nível: " .. (player.Level or player:GetAttribute("Level") or 0)
infoLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 13
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = infoFrame

-- Atualiza informações
task.spawn(function()
    while gui and gui.Parent do
        task.wait(1)
        local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
        local nivel = player.Level or player:GetAttribute("Level") or 0
        infoLabel.Text = "💚 Vida: " .. health .. " | 🎯 Nível: " .. nivel
    end
end)

-- Botão Sair
CriarBotao("✖ SAIR DO SCRIPT", Color3.fromRGB(150, 50, 50), function()
    AntiBan.Status.SessaoAtiva = false
    Farm.Ativo = false
    gui:Destroy()
    print("👋 Hub fechado!")
end)

-- Rodapé
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "v7.0 Máximo | GitHub: Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Hub 7.0 carregado!")
print("📌 https://github.com/Marcileialves/Blox-Fruits-Script-Hub")