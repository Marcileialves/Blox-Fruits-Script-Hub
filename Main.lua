--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 8.0 (LIMITES QUEBRADOS)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Celular Otimizado | Anti-Ban Ultra | Farm Automático Completo
]]

print("🔥 Carregando Blox Fruits Hub 8.0 (Limites Quebrados)...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

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
-- SISTEMA DE DETECÇÃO AVANÇADA
-- ============================================

local Detector = {
    Nivel = 0,
    Vida = 0,
    FrutaEquipada = "",
    ArmaEquipada = "",
    IlhaAtual = "",
    Inimigos = {},
    JogadoresProximos = 0,
    TempoParado = 0,
    UltimoMovimento = Vector3.new(0, 0, 0),
}

function Detector.Atualizar()
    pcall(function()
        Detector.Nivel = player.Level or player:GetAttribute("Level") or 0
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            Detector.Vida = math.floor(player.Character.Humanoid.Health)
        end
        
        -- Detecta fruta equipada
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("Fruit") then
                Detector.FrutaEquipada = item.Name
                break
            end
        end
        
        -- Detecta arma equipada
        if player.Character then
            for _, item in pairs(player.Character:GetChildren()) do
                if item:IsA("Tool") then
                    Detector.ArmaEquipada = item.Name
                    break
                end
            end
        end
    end)
end

-- ============================================
-- SISTEMA ANTI-BAN ULTRA (MÁXIMO NÍVEL)
-- ============================================

local AntiBan = {
    Config = {
        Nivel = "ULTRA",
        PausaMin = 5.0,
        PausaMax = 20.0,
        DelayMin = 0.8,
        DelayMax = 3.5,
        PausaAPosKills = 5,
        PausaLongaMin = 180,
        PausaLongaMax = 600,
        TempoMaxSessao = 3600,
        VariacaoMovimento = true,
        DetectarAdmins = true,
        DetectarJogadores = true,
        ModoFurtivo = true,
    },
    
    Status = {
        KillCount = 0,
        SessaoAtiva = false,
        HoraInicio = 0,
        AdminDetectado = false,
        JogadoresProximos = 0,
        ModoFurtivoAtivo = false,
    },
    
    Stats = {
        TotalKills = 0,
        TotalPausas = 0,
        TotalAdminsDetectados = 0,
        TempoJogado = 0,
    }
}

function AntiBan.Iniciar()
    AntiBan.Status.HoraInicio = os.time()
    AntiBan.Status.SessaoAtiva = true
    print("[ANTI-BAN] 🛡️ Proteção ULTRA ativada!")
    print("[ANTI-BAN] ⚡ Modo Furtivo: " .. (AntiBan.Config.ModoFurtivo and "ATIVADO" or "DESATIVADO"))
end

function AntiBan.DetectarAdmins()
    if not AntiBan.Config.DetectarAdmins then return false end
    local admins = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p:IsInGroup(1) or p.UserId == 1 or p:FindFirstChild("Admin") then
            table.insert(admins, p.Name)
        end
    end
    if #admins > 0 then
        print("[ANTI-BAN] ⚠️ Admins detectados: " .. table.concat(admins, ", "))
        AntiBan.Status.AdminDetectado = true
        AntiBan.Stats.TotalAdminsDetectados = AntiBan.Stats.TotalAdminsDetectados + 1
        task.wait(90) -- Pausa longa
        return true
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

function AntiBan.ModoFurtivo()
    if not AntiBan.Config.ModoFurtivo then return end
    
    -- Se tiver jogadores próximos, ativa modo furtivo
    if AntiBan.Status.JogadoresProximos > 2 then
        AntiBan.Status.ModoFurtivoAtivo = true
        AntiBan.Config.DelayMin = 2.0
        AntiBan.Config.DelayMax = 5.0
        AntiBan.Config.PausaMin = 10.0
        AntiBan.Config.PausaMax = 30.0
        print("[ANTI-BAN] 🕵️ Modo Furtivo ATIVADO")
    else
        AntiBan.Status.ModoFurtivoAtivo = false
        AntiBan.Config.DelayMin = 0.8
        AntiBan.Config.DelayMax = 3.5
        AntiBan.Config.PausaMin = 5.0
        AntiBan.Config.PausaMax = 20.0
    end
end

function AntiBan.ComportamentoHumano()
    if math.random(1, 10) > 7 then
        local acoes = {"olhar", "mover", "esperar", "pular", "correr"}
        local acao = acoes[math.random(1, #acoes)]
        
        if acao == "mover" then
            local pos = player.Character.HumanoidRootPart.Position
            player.Character.HumanoidRootPart.CFrame = CFrame.new(
                pos.X + math.random(-15, 15),
                pos.Y,
                pos.Z + math.random(-15, 15)
            )
        elseif acao == "pular" then
            player.Character.Humanoid.Jump = true
            task.wait(0.1)
            player.Character.Humanoid.Jump = false
        elseif acao == "correr" then
            player.Character.Humanoid.WalkSpeed = 25
            task.wait(math.random(1, 3))
            player.Character.Humanoid.WalkSpeed = 16
        end
        
        task.wait(math.random(1, 4))
    end
end

function AntiBan.Relatorio()
    local tempo = os.time() - AntiBan.Status.HoraInicio
    print("[ANTI-BAN] 📊 Relatório Ultra:")
    print("  ⏱️ " .. math.floor(tempo/60) .. "m")
    print("  ⚔️ " .. AntiBan.Stats.TotalKills .. " kills")
    print("  ⏸️ " .. AntiBan.Stats.TotalPausas .. " pausas")
    print("  👤 " .. AntiBan.Stats.TotalAdminsDetectados .. " admins")
    print("  🛡️ Nível: ULTRA")
    print("  🕵️ Modo Furtivo: " .. (AntiBan.Status.ModoFurtivoAtivo and "ATIVADO" or "DESATIVADO"))
end

-- ============================================
-- SISTEMA DE ILHAS (COMPLETO + BONUS)
-- ============================================

local Ilhas = {
    -- 1º Mar (XP Progressivo)
    {nome = "Jungle", min = 1, max = 30, xp = 80, prioridade = 1, bonus = 5},
    {nome = "Pirate Village", min = 15, max = 45, xp = 100, prioridade = 2, bonus = 10},
    {nome = "Desert", min = 30, max = 60, xp = 150, prioridade = 3, bonus = 15},
    {nome = "Frozen Village", min = 50, max = 90, xp = 200, prioridade = 4, bonus = 20},
    {nome = "Marine Fortress", min = 70, max = 120, xp = 250, prioridade = 5, bonus = 25},
    {nome = "Skypiea", min = 90, max = 150, xp = 300, prioridade = 6, bonus = 30},
    {nome = "Prison", min = 120, max = 200, xp = 400, prioridade = 7, bonus = 35},
    {nome = "Colosseum", min = 150, max = 250, xp = 500, prioridade = 8, bonus = 40},
    {nome = "Magma Village", min = 200, max = 300, xp = 600, prioridade = 9, bonus = 45},
    {nome = "Underwater City", min = 250, max = 400, xp = 700, prioridade = 10, bonus = 50},
    {nome = "Fountain City", min = 350, max = 500, xp = 800, prioridade = 11, bonus = 55},
    -- 2º Mar
    {nome = "Kingdom of Rose", min = 500, max = 750, xp = 900, prioridade = 12, bonus = 60},
    {nome = "Green Zone", min = 600, max = 850, xp = 1000, prioridade = 13, bonus = 65},
    {nome = "Graveyard", min = 700, max = 950, xp = 1100, prioridade = 14, bonus = 70},
    {nome = "Cursed Ship", min = 900, max = 1200, xp = 1200, prioridade = 15, bonus = 75},
    {nome = "Ice Castle", min = 1100, max = 1400, xp = 1300, prioridade = 16, bonus = 80},
    {nome = "Forgotten Island", min = 1300, max = 1600, xp = 1400, prioridade = 17, bonus = 85},
    -- 3º Mar
    {nome = "Hydra Island", min = 1500, max = 2000, xp = 1600, prioridade = 18, bonus = 90},
    {nome = "Great Tree", min = 1700, max = 2200, xp = 1800, prioridade = 19, bonus = 95},
    {nome = "Floating Turtle", min = 1900, max = 2500, xp = 2000, prioridade = 20, bonus = 100},
    {nome = "Sea of Treats", min = 2200, max = 3000, xp = 2500, prioridade = 21, bonus = 110},
    -- Ilhas Bônus (Eventos)
    {nome = "Cake Island", min = 2000, max = 3000, xp = 3000, prioridade = 22, bonus = 120},
    {nome = "Turtle Shell", min = 2300, max = 3000, xp = 2800, prioridade = 23, bonus = 130},
}

function EncontrarIlha()
    Detector.Atualizar()
    local nivel = Detector.Nivel
    
    local melhor = nil
    local melhorScore = -1
    
    for _, ilha in pairs(Ilhas) do
        if nivel >= ilha.min and nivel <= ilha.max then
            local score = ilha.prioridade + (ilha.bonus or 0) / 10
            if score > melhorScore then
                melhorScore = score
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
-- SISTEMA DE TELEPORTE (MULTI-MÉTODO)
-- ============================================

function Teleportar(nomeIlha)
    print("[TELEPORTE] 🚀 " .. nomeIlha)
    
    local tentativas = 0
    local sucesso = false
    
    while tentativas < 5 and not sucesso do
        tentativas = tentativas + 1
        
        -- Método 1: Spawns
        pcall(function()
            local spawns = game.Workspace:FindFirstChild("Spawns")
            if spawns then
                for _, spawn in pairs(spawns:GetChildren()) do
                    if spawn.Name == nomeIlha then
                        player.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 10, 0)
                        sucesso = true
                        break
                    end
                end
            end
        end)
        
        -- Método 2: Ilha
        if not sucesso then
            pcall(function()
                local ilha = game.Workspace:FindFirstChild(nomeIlha)
                if ilha then
                    player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
                    sucesso = true
                end
            end)
        end
        
        -- Método 3: TeleportService
        if not sucesso then
            pcall(function()
                TeleportService:Teleport(game.PlaceId, player)
                sucesso = true
            end)
        end
        
        -- Método 4: Posição fixa
        if not sucesso then
            pcall(function()
                local posicoes = {
                    ["Jungle"] = Vector3.new(-1000, 50, 0),
                    ["Prison"] = Vector3.new(2000, 50, 0),
                    ["Skypiea"] = Vector3.new(3000, 100, 0),
                }
                if posicoes[nomeIlha] then
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(posicoes[nomeIlha])
                    sucesso = true
                end
            end)
        end
        
        if not sucesso then
            task.wait(1)
        end
    end
    
    if sucesso then
        task.wait(0.5)
        return true
    else
        print("[TELEPORTE] ⚠️ Falha após 5 tentativas")
        return false
    end
end

-- ============================================
-- SISTEMA DE ATAQUE (MULTI-MÉTODO AVANÇADO)
-- ============================================

function Atacar()
    local sucesso = false
    
    -- Método 1: Touch (Celular)
    if UserInputService.TouchEnabled then
        for i = 1, 5 do
            local x = 300 + math.random(-80, 80)
            local y = 400 + math.random(-80, 80)
            UserInputService:TouchTap(Vector2.new(x, y))
            task.wait(0.05)
            sucesso = true
        end
    end
    
    -- Método 2: VirtualInput
    if not sucesso and VirtualInput then
        for i = 1, 5 do
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, true, game, 0)
            task.wait(0.05)
            VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, false, game, 0)
            task.wait(0.05)
            sucesso = true
        end
    end
    
    -- Método 3: Mouse1Click (PC)
    if not sucesso and mouse1click then
        for i = 1, 5 do
            mouse1click()
            task.wait(0.1)
            sucesso = true
        end
    end
    
    -- Método 4: ContextActionService
    if not sucesso then
        pcall(function()
            local ctx = game:GetService("ContextActionService")
            ctx:FireAll("Attack", Enum.UserInputState.Begin, nil)
            task.wait(0.1)
            ctx:FireAll("Attack", Enum.UserInputState.End, nil)
            sucesso = true
        end)
    end
    
    return sucesso
end

-- ============================================
-- SISTEMA DE FARM (COMPLETO + OTIMIZADO)
-- ============================================

local Farm = {
    Ativo = false,
    Kills = 0,
    KillsTotal = 0,
    KillsPorMinuto = 0,
    XpGanho = 0,
    BeliGanho = 0,
    NivelInicio = 0,
    NivelAtual = 0,
    TempoInicio = 0,
    IlhaAtual = nil,
    StatusLabel = nil,
    InimigosProximos = 0,
    TempoUltimoKill = 0,
    MelhorKPM = 0,
    TotalSessoes = 0,
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
    Farm.TempoUltimoKill = os.time()
    Farm.TotalSessoes = Farm.TotalSessoes + 1
    Farm.NivelInicio = Detector.Nivel
    Farm.NivelAtual = Farm.NivelInicio
    Farm.MelhorKPM = 0
    
    print("[FARM] 🚀 INICIANDO FARM ULTRA!")
    print("[FARM] 🎯 Nível: " .. Farm.NivelInicio .. " → 3000")
    print("[FARM] 🛡️ Sessão #" .. Farm.TotalSessoes)
    
    AntiBan.Iniciar()
    
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "⚡ Farmando... 0 kills"
    end
    
    task.spawn(function()
        local semInimigos = 0
        local semKills = 0
        
        while Farm.Ativo do
            -- Atualiza detector
            Detector.Atualizar()
            
            -- Anti-Ban
            if AntiBan.DetectarAdmins() then
                task.wait(90)
                continue
            end
            
            AntiBan.VerificarTempo()
            
            -- Detecta jogadores próximos
            AntiBan.Status.JogadoresProximos = 0
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 200 then
                        AntiBan.Status.JogadoresProximos = AntiBan.Status.JogadoresProximos + 1
                    end
                end
            end
            AntiBan.ModoFurtivo()
            
            -- Encontra ilha
            local ilha = EncontrarIlha()
            if ilha and (not Farm.IlhaAtual or ilha.nome ~= Farm.IlhaAtual.nome) then
                Farm.IlhaAtual = ilha
                print("[FARM] 📍 " .. ilha.nome .. " (XP: " .. ilha.xp .. " | Bonus: " .. (ilha.bonus or 0) .. ")")
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
                        if dist < 180 then
                            Farm.InimigosProximos = Farm.InimigosProximos + 1
                            if not alvo then alvo = e end
                        end
                    end
                end
            end
            
            if alvo then
                semInimigos = 0
                semKills = 0
                
                -- Posiciona
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                -- Ataque (5 vezes)
                for i = 1, 5 do
                    Atacar()
                    task.wait(0.12)
                end
                
                -- Atualiza stats
                Farm.Kills = Farm.Kills + 1
                Farm.KillsTotal = Farm.KillsTotal + 1
                Farm.XpGanho = Farm.XpGanho + (Farm.IlhaAtual and Farm.IlhaAtual.xp or 100)
                Farm.BeliGanho = Farm.BeliGanho + 70
                AntiBan.Stats.TotalKills = AntiBan.Stats.TotalKills + 1
                Farm.TempoUltimoKill = os.time()
                
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
                    if Farm.KillsPorMinuto > Farm.MelhorKPM then
                        Farm.MelhorKPM = Farm.KillsPorMinuto
                    end
                    
                    print("[FARM] ⚔️ " .. Farm.Kills .. " kills | KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
                    print("[FARM] 📈 XP: " .. Farm.XpGanho .. " | 💰 Beli: " .. Farm.BeliGanho)
                    print("[FARM] 🎯 Nível: " .. Detector.Nivel .. " | 🕵️ Furtivo: " .. (AntiBan.Status.ModoFurtivoAtivo and "SIM" or "NÃO"))
                    
                    if Farm.StatusLabel then
                        Farm.StatusLabel.Text = "⚡ " .. Farm.Kills .. " kills | KPM: " .. string.format("%.1f", Farm.KillsPorMinuto) .. " | Nv " .. Detector.Nivel
                    end
                end
            else
                semInimigos = semInimigos + 1
                semKills = semKills + 1
                
                if semKills > 10 then
                    print("[FARM] ⚠️ " .. semKills .. " kills sem progresso!")
                    AntiBan.ComportamentoHumano()
                end
                
                if semInimigos > 5 then
                    print("[FARM] ⚠️ Sem inimigos! Teleportando...")
                    if Farm.IlhaAtual then
                        Teleportar(Farm.IlhaAtual.nome)
                    else
                        local ilha = EncontrarIlha()
                        if ilha then Teleportar(ilha.nome) end
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
    print("[FARM] ⏹ Parado")
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "⏹ Parado"
    end
end

function Farm.Finalizar()
    local tempo = os.time() - Farm.TempoInicio
    local horas = math.floor(tempo / 3600)
    local minutos = math.floor((tempo % 3600) / 60)
    local segundos = tempo % 60
    
    print("[FARM] ✅ FARM CONCLUÍDO!")
    print("  ⏱️ Tempo: " .. horas .. "h " .. minutos .. "m " .. segundos .. "s")
    print("  ⚔️ Kills: " .. Farm.KillsTotal)
    print("  📈 XP: " .. Farm.XpGanho)
    print("  💰 Beli: " .. Farm.BeliGanho)
    print("  🎯 Nível: " .. Farm.NivelInicio .. " → " .. Detector.Nivel)
    print("  ⚡ Melhor KPM: " .. string.format("%.1f", Farm.MelhorKPM))
    print("  📊 KPM Médio: " .. string.format("%.1f", Farm.KillsPorMinuto))
    
    AntiBan.Relatorio()
    
    if Farm.StatusLabel then
        Farm.StatusLabel.Text = "✅ " .. Farm.KillsTotal .. " kills | Nv " .. Detector.Nivel
    end
end

-- ============================================
-- FUNÇÕES AUXILIARES
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
    
    print("📊 INFORMAÇÕES COMPLETAS:")
    print("  👤 Jogador: " .. player.Name)
    print("  🎯 Nível: " .. Detector.Nivel)
    print("  💚 Vida: " .. Detector.Vida)
    print("  🍎 Fruta: " .. (Detector.FrutaEquipada ~= "" and Detector.FrutaEquipada or "Nenhuma"))
    print("  ⚔️ Arma: " .. (Detector.ArmaEquipada ~= "" and Detector.ArmaEquipada or "Nenhuma"))
    print("  📍 Ilha: " .. (ilha and ilha.nome or "Desconhecida"))
    print("  🕵️ Furtivo: " .. (AntiBan.Status.ModoFurtivoAtivo and "SIM" or "NÃO"))
    print("  👥 Jogadores próximos: " .. AntiBan.Status.JogadoresProximos)
    
    if Farm.Ativo then
        print("  ⚡ Farmando: SIM (" .. Farm.Kills .. " kills)")
        print("  ⚡ KPM: " .. string.format("%.1f", Farm.KillsPorMinuto))
    else
        print("  ⚡ Farmando: NÃO")
    end
end

-- ============================================
-- CRIA INTERFACE (ULTRA MODERNA)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- Fundo
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 440, 0, 660)
frame.Position = UDim2.new(0.5, -220, 0.5, -330)
frame.BackgroundColor3 = Color3.fromRGB(5, 5, 25)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 75)
header.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
header.BackgroundTransparency = 0.08
header.BorderSizePixel = 0
header.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 42)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🔥 BLOX FRUITS 8.0"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.Parent = header

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 48)
sub.Text = "⚡ Limites Quebrados | Anti-Ban Ultra"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.GothamMedium
sub.TextSize = 12
sub.Parent = header

-- Área de conteúdo
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 1, -155)
content.Position = UDim2.new(0, 5, 0, 80)
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
    btn.Size = UDim2.new(1, 0, 0, 52)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor or Color3.fromRGB(50, 50, 100)
    btn.BackgroundTransparency = 0.12
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
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
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Text = texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 15
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    return lbl
end

function CriarStatus(texto)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 48)
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
    lbl.TextSize = 14
    lbl.Parent = frame2
    
    return lbl
end

-- Interface
CriarLabel("⚡ CONTROLES PRINCIPAIS")

CriarBotao("⚡ FARMAR NÍVEL MÁXIMO", Color3.fromRGB(0, 180, 100), Farm.Iniciar)
CriarBotao("⏹ PARAR FARM", Color3.fromRGB(200, 50, 50), Farm.Parar)
CriarBotao("💚 CURAR PERSONAGEM", Color3.fromRGB(50, 200, 100), Curar)
CriarBotao("📊 INFORMAÇÕES", Color3.fromRGB(100, 150, 255), MostrarInfo)

CriarLabel("📊 STATUS EM TEMPO REAL")
Farm.StatusLabel = CriarStatus("⏸️ Pronto")

CriarLabel("👤 JOGADOR")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 75)
infoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
infoFrame.BackgroundTransparency = 0.3
infoFrame.BorderSizePixel = 0
infoFrame.Parent = content

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 10)
infoCorner.Parent = infoFrame

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 32)
nameLabel.Position = UDim2.new(0, 10, 0, 2)
nameLabel.Text = "👤 " .. player.Name
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 16
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = infoFrame

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 28)
infoLabel.Position = UDim2.new(0, 10, 0, 38)
infoLabel.Text = "💚 Vida: " .. Detector.Vida .. " | 🎯 Nível: " .. Detector.Nivel
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
        Detector.Atualizar()
        infoLabel.Text = "💚 Vida: " .. Detector.Vida .. " | 🎯 Nível: " .. Detector.Nivel
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
footer.Text = "v8.0 Limites Quebrados | GitHub: Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Hub 8.0 carregado com sucesso!")
print("📌 https://github.com/Marcileialves/Blox-Fruits-Script-Hub")