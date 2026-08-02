--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 5.0 (ANTI-BAN AVANÇADO)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Segurança: Nível ALTO
]]

print("🛡️ Carregando Blox Fruits Hub 5.0 (Anti-Ban Avançado)...")

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
-- SISTEMA ANTI-BAN AVANÇADO
-- ============================================

local AntiBan = {
    -- Configurações
    Config = {
        Ativo = true,
        NivelSeguranca = "ALTO", -- BAIXO, MEDIO, ALTO, MAXIMO
        PausasAleatorias = true,
        ComportamentoHumano = true,
        RotacaoAcoes = true,
        DetectarAdmins = true,
        PausaMinima = 1.0,
        PausaMaxima = 8.0,
        DelayMinimo = 0.3,
        DelayMaximo = 1.8,
        PausaAPos = 15, -- Pausa a cada X kills
        VariacaoMovimento = true,
        SimularDigitacao = false, -- Desativado no celular
        SimularMouse = false, -- Desativado no celular
        TrocarAlvo = true,
        TempoMaximoSessao = 3600, -- 1 hora
    },
    
    -- Status
    Status = {
        KillCount = 0,
        SessaoAtiva = false,
        HoraInicio = 0,
        HoraUltimaPausa = 0,
        HoraUltimaRotacao = 0,
        AdminDetectado = false,
        PausaForcada = false,
        ModoOculto = false,
        AcaoAtual = "parado",
        InimigosMortos = {},
        UltimoMovimento = Vector3.new(0, 0, 0),
        PosicoesVisitadas = {},
    },
    
    -- Estatísticas
    Estatisticas = {
        TotalKills = 0,
        TotalPausas = 0,
        TotalRotacoes = 0,
        TotalAdminsDetectados = 0,
        TotalAlertas = 0,
        TempoJogado = 0,
    }
}

-- ============================================
-- FUNÇÕES ANTI-BAN
-- ============================================

-- 1. DETECÇÃO DE ADMINS
function AntiBan.DetectarAdmins()
    if not AntiBan.Config.DetectarAdmins then return false end
    
    local players = game.Players:GetPlayers()
    for _, p in pairs(players) do
        -- Verifica se é admin do Roblox
        if p:IsInGroup(1) or p.UserId == 1 then
            print("[ANTI-BAN] ⚠️ ADMIN DETECTADO: " .. p.Name)
            AntiBan.Status.AdminDetectado = true
            AntiBan.Estatisticas.TotalAdminsDetectados = AntiBan.Estatisticas.TotalAdminsDetectados + 1
            return true
        end
        
        -- Verifica se tem cargo de admin no jogo
        if p:FindFirstChild("Admin") then
            print("[ANTI-BAN] ⚠️ ADMIN DO JOGO DETECTADO: " .. p.Name)
            AntiBan.Status.AdminDetectado = true
            return true
        end
    end
    
    AntiBan.Status.AdminDetectado = false
    return false
end

-- 2. PAUSA ALEATÓRIA INTELIGENTE
function AntiBan.PausaAleatoria()
    if not AntiBan.Config.PausasAleatorias then return end
    if AntiBan.Status.AdminDetectado then return end
    
    -- Define duração da pausa baseada no nível de segurança
    local pausaMin, pausaMax
    if AntiBan.Config.NivelSeguranca == "BAIXO" then
        pausaMin, pausaMax = 0.5, 2.0
    elseif AntiBan.Config.NivelSeguranca == "MEDIO" then
        pausaMin, pausaMax = 1.0, 4.0
    elseif AntiBan.Config.NivelSeguranca == "ALTO" then
        pausaMin, pausaMax = 2.0, 6.0
    else -- MAXIMO
        pausaMin, pausaMax = 3.0, 10.0
    end
    
    local duracao = math.random(pausaMin * 10, pausaMax * 10) / 10
    AntiBan.Status.PausaForcada = true
    
    print("[ANTI-BAN] ⏸️ Pausa inteligente de " .. string.format("%.1f", duracao) .. "s")
    AntiBan.Estatisticas.TotalPausas = AntiBan.Estatisticas.TotalPausas + 1
    
    task.wait(duracao)
    AntiBan.Status.PausaForcada = false
end

-- 3. DELAY ENTRE AÇÕES (VARIÁVEL)
function AntiBan.DelayEntreAcoes()
    if not AntiBan.Config.ComportamentoHumano then return end
    
    local delayMin = AntiBan.Config.DelayMinimo
    local delayMax = AntiBan.Config.DelayMaximo
    
    -- Aumenta delay se admin estiver por perto
    if AntiBan.Status.AdminDetectado then
        delayMin = delayMin * 2
        delayMax = delayMax * 2
    end
    
    local delay = math.random(delayMin * 10, delayMax * 10) / 10
    task.wait(delay)
end

-- 4. SIMULA COMPORTAMENTO HUMANO
function AntiBan.SimularHumano()
    if not AntiBan.Config.ComportamentoHumano then return end
    if AntiBan.Status.AdminDetectado then return end
    
    local comportamentos = {
        "parado_olhando",
        "movendo_aleatorio",
        "pausa_curta",
        "olhando_ao_redor",
        "mudando_posicao"
    }
    
    local comportamento = comportamentos[math.random(1, #comportamentos)]
    
    if comportamento == "movendo_aleatorio" then
        -- Move em uma direção aleatória
        local x = math.random(-10, 10)
        local z = math.random(-10, 10)
        local pos = player.Character.HumanoidRootPart.Position + Vector3.new(x, 0, z)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        print("[ANTI-BAN] 👤 Movimento humano simulado")
    elseif comportamento == "pausa_curta" then
        task.wait(math.random(2, 5) / 10)
    elseif comportamento == "olhando_ao_redor" then
        -- Simula olhar ao redor (no celular é limitado)
        print("[ANTI-BAN] 👀 Olhando ao redor...")
        task.wait(math.random(1, 3) / 10)
    end
end

-- 5. ROTAÇÃO DE AÇÕES
function AntiBan.RotacionarAcoes()
    if not AntiBan.Config.RotacaoAcoes then return end
    
    local rotacoes = {
        "atacar_normal",
        "atacar_forte",
        "pular_esquivar",
        "mudar_alvo",
        "esperar_passivamente"
    }
    
    local rotacao = rotacoes[math.random(1, #rotacoes)]
    AntiBan.Status.AcaoAtual = rotacao
    AntiBan.Estatisticas.TotalRotacoes = AntiBan.Estatisticas.TotalRotacoes + 1
    
    if rotacao == "esperar_passivamente" then
        task.wait(math.random(1, 3))
    end
    
    print("[ANTI-BAN] 🔄 Rotação: " .. rotacao)
end

-- 6. VERIFICA TEMPO DE SESSÃO
function AntiBan.VerificarTempoSessao()
    if not AntiBan.Config.TempoMaximoSessao then return end
    
    local tempoDecorrido = os.time() - AntiBan.Status.HoraInicio
    if tempoDecorrido > AntiBan.Config.TempoMaximoSessao then
        print("[ANTI-BAN] ⏰ Tempo máximo de sessão atingido! Pausa longa...")
        local pausaLonga = math.random(60, 300) -- 1-5 minutos
        task.wait(pausaLonga)
        AntiBan.Status.HoraInicio = os.time()
    end
end

-- 7. MONITORAMENTO DE MOVIMENTO
function AntiBan.MonitorarMovimento()
    if not AntiBan.Config.VariacaoMovimento then return end
    
    local posAtual = player.Character.HumanoidRootPart.Position
    local distancia = (posAtual - AntiBan.Status.UltimoMovimento).Magnitude
    
    -- Se ficou parado por muito tempo, faz um movimento
    if distancia < 1 and AntiBan.Status.UltimoMovimento ~= Vector3.new(0, 0, 0) then
        if math.random(1, 10) > 7 then
            local x = math.random(-5, 5)
            local z = math.random(-5, 5)
            local novaPos = posAtual + Vector3.new(x, 0, z)
            player.Character.HumanoidRootPart.CFrame = CFrame.new(novaPos)
            print("[ANTI-BAN] 🚶 Movimento anti-farm detectado")
        end
    end
    
    AntiBan.Status.UltimoMovimento = posAtual
end

-- 8. PAUSA APÓS KILLS
function AntiBan.PausarAposKills()
    local kills = AntiBan.Status.KillCount
    local pausaApos = AntiBan.Config.PausaAPos
    
    if kills % pausaApos == 0 and kills > 0 then
        print("[ANTI-BAN] 📊 " .. kills .. " kills completas! Pausa estratégica...")
        AntiBan.PausaAleatoria()
        
        -- Simula comportamento humano após pausa
        AntiBan.SimularHumano()
    end
end

-- 9. VERIFICAR JOGADORES PRÓXIMOS
function AntiBan.VerificarJogadoresProximos()
    local jogadores = game.Players:GetPlayers()
    local jogadoresProximos = 0
    
    for _, p in pairs(jogadores) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if dist < 200 then
                jogadoresProximos = jogadoresProximos + 1
            end
        end
    end
    
    -- Se tiver muitos jogadores próximos, comportamento mais lento
    if jogadoresProximos > 3 then
        print("[ANTI-BAN] 👥 " .. jogadoresProximos .. " jogadores próximos - Modo cauteloso")
        AntiBan.Config.DelayMinimo = 1.0
        AntiBan.Config.DelayMaximo = 2.5
    else
        AntiBan.Config.DelayMinimo = 0.3
        AntiBan.Config.DelayMaximo = 1.8
    end
    
    return jogadoresProximos
end

-- 10. RELATÓRIO DE SEGURANÇA
function AntiBan.RelatorioSeguranca()
    local tempo = os.time() - AntiBan.Status.HoraInicio
    local horas = math.floor(tempo / 3600)
    local minutos = math.floor((tempo % 3600) / 60)
    
    print("[ANTI-BAN] 📊 RELATÓRIO DE SEGURANÇA:")
    print("  ⏱️ Sessão: " .. horas .. "h " .. minutos .. "m")
    print("  ⚔️ Kills: " .. AntiBan.Estatisticas.TotalKills)
    print("  ⏸️ Pausas: " .. AntiBan.Estatisticas.TotalPausas)
    print("  🔄 Rotações: " .. AntiBan.Estatisticas.TotalRotacoes)
    print("  👤 Admins detectados: " .. AntiBan.Estatisticas.TotalAdminsDetectados)
    print("  ⚠️ Alertas: " .. AntiBan.Estatisticas.TotalAlertas)
    print("  🛡️ Nível segurança: " .. AntiBan.Config.NivelSeguranca)
    print("  ✅ Status: " .. (AntiBan.Status.AdminDetectado and "⚠️ CUIDADO" or "🟢 SEGURO"))
end

-- 11. INICIAR ANTI-BAN
function AntiBan.Iniciar()
    AntiBan.Status.HoraInicio = os.time()
    AntiBan.Status.HoraUltimaPausa = os.time()
    AntiBan.Status.HoraUltimaRotacao = os.time()
    AntiBan.Status.SessaoAtiva = true
    
    print("[ANTI-BAN] 🛡️ Sistema Anti-Ban Iniciado!")
    print("[ANTI-BAN] ⚡ Nível de segurança: " .. AntiBan.Config.NivelSeguranca)
    
    -- Loop de monitoramento
    task.spawn(function()
        while AntiBan.Status.SessaoAtiva do
            task.wait(30) -- Verifica a cada 30 segundos
            
            -- Verifica admins
            AntiBan.DetectarAdmins()
            
            -- Verifica jogadores próximos
            AntiBan.VerificarJogadoresProximos()
            
            -- Verifica tempo de sessão
            AntiBan.VerificarTempoSessao()
            
            -- Monitora movimento
            AntiBan.MonitorarMovimento()
            
            -- Relatório periódico
            if math.random(1, 10) > 8 then
                AntiBan.RelatorioSeguranca()
            end
        end
    end)
end

-- ============================================
-- SISTEMA DE FARM MELHORADO COM ANTI-BAN
-- ============================================

local farmAtivo = false
local kills = 0
local nivelAtual = 0
local xpGanho = 0
local beliGanho = 0
local tempoInicio = 0
local statusLabel = nil

-- Lista de ilhas
local ilhas = {
    {nome = "Jungle", nivelMin = 1, nivelMax = 30},
    {nome = "Pirate Village", nivelMin = 15, nivelMax = 45},
    {nome = "Desert", nivelMin = 30, nivelMax = 60},
    {nome = "Frozen Village", nivelMin = 50, nivelMax = 90},
    {nome = "Marine Fortress", nivelMin = 70, nivelMax = 120},
    {nome = "Skypiea", nivelMin = 90, nivelMax = 150},
    {nome = "Prison", nivelMin = 120, nivelMax = 200},
    {nome = "Colosseum", nivelMin = 150, nivelMax = 250},
    {nome = "Magma Village", nivelMin = 200, nivelMax = 300},
    {nome = "Underwater City", nivelMin = 250, nivelMax = 400},
    {nome = "Fountain City", nivelMin = 350, nivelMax = 500},
    {nome = "Kingdom of Rose", nivelMin = 500, nivelMax = 750},
    {nome = "Green Zone", nivelMin = 600, nivelMax = 850},
    {nome = "Graveyard", nivelMin = 700, nivelMax = 950},
    {nome = "Cursed Ship", nivelMin = 900, nivelMax = 1200},
    {nome = "Ice Castle", nivelMin = 1100, nivelMax = 1400},
    {nome = "Forgotten Island", nivelMin = 1300, nivelMax = 1600},
    {nome = "Hydra Island", nivelMin = 1500, nivelMax = 2000},
    {nome = "Great Tree", nivelMin = 1700, nivelMax = 2200},
    {nome = "Floating Turtle", nivelMin = 1900, nivelMax = 2500},
    {nome = "Sea of Treats", nivelMin = 2200, nivelMax = 3000},
}

function encontrarMelhorIlha()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local melhor = nil
    local melhorPrioridade = -1
    
    for _, ilha in pairs(ilhas) do
        if nivel >= ilha.nivelMin and nivel <= ilha.nivelMax then
            local prioridade = ilha.nivelMax - nivel
            if prioridade > melhorPrioridade then
                melhorPrioridade = prioridade
                melhor = ilha
            end
        end
    end
    
    if not melhor then
        melhor = ilhas[#ilhas]
    end
    
    return melhor
end

-- Função de ataque com Anti-Ban
local function atacarCelular()
    -- Anti-Ban: Delay entre ataques
    AntiBan.DelayEntreAcoes()
    
    -- Anti-Ban: Simula comportamento humano
    if math.random(1, 10) > 7 then
        AntiBan.SimularHumano()
    end
    
    -- Método 1: Toque na tela
    local uis = game:GetService("UserInputService")
    if uis.TouchEnabled then
        uis:TouchTap(Vector2.new(500, 300))
        task.wait(0.1)
        uis:TouchTap(Vector2.new(500, 400))
        return
    end
    
    -- Método 2: Simular clique
    if mouse1click then
        mouse1click()
        return
    end
end

-- Função principal de Farm com Anti-Ban
function Farmar()
    if farmAtivo then
        print("[FARM] ⚠️ Farm já está ativo!")
        return
    end
    
    farmAtivo = true
    kills = 0
    xpGanho = 0
    beliGanho = 0
    tempoInicio = os.time()
    nivelAtual = player.Level or player:GetAttribute("Level") or 0
    
    print("[FARM] 🚀 Iniciando farm com Anti-Ban avançado...")
    print("[FARM] 🛡️ Segurança nível: " .. AntiBan.Config.NivelSeguranca)
    
    -- Inicia sistema Anti-Ban
    AntiBan.Iniciar()
    
    if statusLabel then
        statusLabel.Text = "⚡ Farmando (Anti-Ban Ativo)..."
    end
    
    task.spawn(function()
        local semInimigos = 0
        
        while farmAtivo do
            -- ANTI-BAN: Verifica admins
            if AntiBan.DetectarAdmins() then
                print("[ANTI-BAN] 🛑 Admin detectado! Pausando farm...")
                task.wait(30)
                continue
            end
            
            -- ANTI-BAN: Verifica jogadores próximos
            AntiBan.VerificarJogadoresProximos()
            
            -- ANTI-BAN: Verifica tempo de sessão
            AntiBan.VerificarTempoSessao()
            
            -- Encontra melhor ilha
            local ilha = encontrarMelhorIlha()
            if ilha then
                print("[FARM] 📍 Farmando em: " .. ilha.nome)
            end
            
            -- Procura inimigos
            local enemies = game.Workspace:FindFirstChild("Enemies")
            local enemy = nil
            
            if enemies then
                for _, child in pairs(enemies:GetChildren()) do
                    if child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
                        local dist = (child.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 150 then
                            enemy = child
                            break
                        end
                    end
                end
            end
            
            if enemy then
                semInimigos = 0
                
                -- Teleporta perto do inimigo
                player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                -- Ataca (com Anti-Ban)
                atacarCelular()
                task.wait(0.3)
                atacarCelular()
                task.wait(0.3)
                
                kills = kills + 1
                xpGanho = xpGanho + 100
                beliGanho = beliGanho + 50
                AntiBan.Status.KillCount = AntiBan.Status.KillCount + 1
                AntiBan.Estatisticas.TotalKills = AntiBan.Estatisticas.TotalKills + 1
                
                -- ANTI-BAN: Pausa a cada X kills
                AntiBan.PausarAposKills()
                
                -- ANTI-BAN: Rotação de ações
                if math.random(1, 10) > 7 then
                    AntiBan.RotacionarAcoes()
                end
                
                -- ANTI-BAN: Monitora movimento
                AntiBan.MonitorarMovimento()
                
                -- Atualiza status
                if kills % 5 == 0 then
                    local tempoDecorrido = os.time() - tempoInicio
                    local killsPorMinuto = kills / (tempoDecorrido / 60)
                    
                    print("[FARM] 📊 " .. kills .. " kills | Kills/min: " .. string.format("%.1f", killsPorMinuto))
                    
                    if statusLabel then
                        local nivel = player.Level or player:GetAttribute("Level") or 0
                        statusLabel.Text = "⚡ Farmando (" .. kills .. " kills | Nv " .. nivel .. ")"
                    end
                end
            else
                semInimigos = semInimigos + 1
                print("[FARM] ⚠️ Procurando inimigos...")
                
                -- ANTI-BAN: Se não encontrar inimigos, simula humano
                if semInimigos > 3 then
                    AntiBan.SimularHumano()
                    semInimigos = 0
                end
                
                task.wait(2)
            end
            
            -- Verifica se nivelou
            local nivel = player.Level or player:GetAttribute("Level") or 0
            if nivel > nivelAtual then
                nivelAtual = nivel
                print("[FARM] 🎉 Nível up! Nível " .. nivelAtual)
            end
            
            -- Verifica nível máximo
            if nivelAtual >= 3000 then
                print("[FARM] 🎉 Nível máximo atingido! 3000/3000")
                break
            end
        end
        
        farmAtivo = false
        
        -- Relatório final Anti-Ban
        AntiBan.RelatorioSeguranca()
        
        if statusLabel then
            statusLabel.Text = "✅ Farm concluído! (" .. kills .. " kills)"
        end
        
        print("[FARM] ✅ Farm concluído!")
        print("[FARM] ⚔️ Total kills: " .. kills)
        print("[FARM] 🎯 Nível final: " .. nivelAtual)
    end)
end

function PararFarm()
    farmAtivo = false
    AntiBan.Status.SessaoAtiva = false
    print("[FARM] ⏹ Parando farm...")
    print("[ANTI-BAN] 🛡️ Sistema Anti-Ban desativado")
    if statusLabel then
        statusLabel.Text = "⏹ Parado"
    end
end

function Curar()
    player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
    print("💚 Curado!")
    
    -- Anti-Ban: Pausa após curar
    AntiBan.DelayEntreAcoes()
end

-- ============================================
-- CRIAR INTERFACE
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 600)
frame.Position = UDim2.new(0.5, -190, 0.5, -300)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 35)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.15
header.BorderSizePixel = 0
header.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🛡️ BLOX FRUITS 5.0"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = header

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 38)
sub.Text = "Anti-Ban Avançado | Segurança Nível ALTO"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.GothamMedium
sub.TextSize = 11
sub.Parent = header

-- Área de conteúdo
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 1, -135)
content.Position = UDim2.new(0, 5, 0, 65)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
content.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

function criarBotao(texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.2
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("▶️ " .. texto)
        if callback then callback() end
    end)
    
    return btn
end

function criarLabel(texto, cor)
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

function criarStatus(texto)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 40)
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

-- Criar interface
criarLabel("🛡️ CONTROLES ANTI-BAN")

criarBotao("⚡ FARMAR NÍVEL MÁXIMO", Color3.fromRGB(0, 180, 100), Farmar)
criarBotao("⏹ PARAR FARM", Color3.fromRGB(200, 50, 50), PararFarm)
criarBotao("💚 CURAR", Color3.fromRGB(50, 200, 100), Curar)

criarLabel("📊 STATUS")
statusLabel = criarStatus("⏸️ Parado")

criarLabel("👤 INFORMAÇÕES")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 60)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
infoFrame.BackgroundTransparency = 0.3
infoFrame.BorderSizePixel = 0
infoFrame.Parent = content

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

-- Atualiza vida
task.spawn(function()
    while gui and gui.Parent do
        task.wait(2)
        local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
        local nivel = player.Level or player:GetAttribute("Level") or 0
        healthLabel.Text = "💚 Vida: " .. health .. "  |  🎯 Nível: " .. nivel
    end
end)

-- Botão Sair
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(1, -20, 0, 40)
exitBtn.Position = UDim2.new(0, 10, 0, 0)
exitBtn.Text = "✖ SAIR DO SCRIPT"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 14
exitBtn.BorderSizePixel = 0
exitBtn.Parent = content

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 10)
exitCorner.Parent = exitBtn

exitBtn.MouseButton1Click:Connect(function()
    AntiBan.Status.SessaoAtiva = false
    gui:Destroy()
    print("👋 Hub fechado!")
    print("[ANTI-BAN] 🛡️ Sistema Anti-Ban desativado")
end)

-- Rodapé
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "v5.0 Anti-Ban | GitHub: Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Hub 5.0 carregado com sucesso!")
print("🛡️ Anti-Ban avançado ativado!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")