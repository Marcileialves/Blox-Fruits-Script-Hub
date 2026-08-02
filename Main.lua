--[[
    BLOX FRUITS SCRIPT - VERSÃO MOBILE COMPLETA
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Otimizado para Delta Executor (Celular)
]]

print("📱 Carregando Blox Fruits Script Mobile...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local ContextActionService = game:GetService("ContextActionService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

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
-- SISTEMA DE DETECÇÃO (COMPLETO)
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
    IlhaAtual = "",
    InimigosProximos = 0,
    JogadoresProximos = 0,
    TempoJogo = 0,
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
        Detector.InimigosProximos = 0
        local enemies = workspace:FindFirstChild("Enemies")
        if enemies then
            for _, e in pairs(enemies:GetChildren()) do
                if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                    local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 200 then
                        Detector.InimigosProximos = Detector.InimigosProximos + 1
                    end
                end
            end
        end
        Detector.JogadoresProximos = 0
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < 200 then
                    Detector.JogadoresProximos = Detector.JogadoresProximos + 1
                end
            end
        end
        Detector.TempoJogo = Detector.TempoJogo + 1
    end)
end

-- ============================================
-- SISTEMA DE CLIQUE AVANÇADO (MULTI-MÉTODO)
-- ============================================

function ClicarObjeto(objeto)
    if not objeto then return false end
    
    -- Método 1: ClickDetector
    local clickDetector = objeto:FindFirstChild("ClickDetector")
    if clickDetector then
        pcall(function()
            clickDetector:Click(player)
        end)
        return true
    end
    
    -- Método 2: Procurar ClickDetector nos filhos
    for _, child in pairs(objeto:GetChildren()) do
        if child:IsA("ClickDetector") then
            pcall(function()
                child:Click(player)
            end)
            return true
        end
    end
    
    -- Método 3: FireClickDetector
    for _, child in pairs(objeto:GetChildren()) do
        if child:IsA("ClickDetector") then
            pcall(function()
                child:FireClickDetector(player)
            end)
            return true
        end
    end
    
    -- Método 4: Touch (Celular)
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
        task.wait(0.1)
        UserInputService:TouchTap(Vector2.new(500, 300))
        return true
    end
    
    -- Método 5: Virtual Input (PC)
    if VirtualInput then
        VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, true, game, 0)
        task.wait(0.05)
        VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, false, game, 0)
        return true
    end
    
    return false
end

function ClicarPosicao(x, y)
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(x, y))
        task.wait(0.1)
        UserInputService:TouchTap(Vector2.new(x, y))
        return true
    end
    
    if VirtualInput then
        VirtualInput:SendMouseButtonEvent(Vector2.new(x, y), 1, true, game, 0)
        task.wait(0.05)
        VirtualInput:SendMouseButtonEvent(Vector2.new(x, y), 1, false, game, 0)
        return true
    end
    
    return false
end

function Teleportar(CFrame)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        pcall(function()
            player.Character.HumanoidRootPart.CFrame = CFrame
            task.wait(0.2)
        end)
        return true
    end
    return false
end

-- ============================================
-- SISTEMA DE ILHAS (COMPLETO)
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

function EncontrarMelhorIlha()
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

function TeleportarIlha(nomeIlha)
    print("[AÇÃO] 🚀 Teleportando para: " .. nomeIlha)
    
    local ilha = workspace:FindFirstChild(nomeIlha)
    if ilha then
        Teleportar(ilha.CFrame + Vector3.new(0, 50, 0))
        print("[AÇÃO] ✅ Teleportado para: " .. nomeIlha)
        return true
    end
    
    local spawns = workspace:FindFirstChild("Spawns")
    if spawns then
        for _, spawn in pairs(spawns:GetChildren()) do
            if string.find(spawn.Name, nomeIlha) then
                Teleportar(spawn.CFrame + Vector3.new(0, 10, 0))
                print("[AÇÃO] ✅ Teleportado para: " .. nomeIlha)
                return true
            end
        end
    end
    
    print("[AÇÃO] ❌ Ilha não encontrada: " .. nomeIlha)
    return false
end

-- ============================================
-- FUNÇÕES DE AÇÃO (COMPLETAS)
-- ============================================

-- 1. PEGAR ITEM
function PegarItem(nomeItem)
    print("[AÇÃO] 🔍 Procurando item: " .. nomeItem)
    
    local item = nil
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and (v.Name == nomeItem or string.find(v.Name, nomeItem)) then
            item = v
            break
        end
    end
    
    if not item then
        print("[AÇÃO] ❌ Item não encontrado: " .. nomeItem)
        return false
    end
    
    local handle = item:FindFirstChild("Handle")
    if handle then
        Teleportar(handle.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(item:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    ClicarObjeto(item)
    print("[AÇÃO] ✅ Item coletado: " .. nomeItem)
    return true
end

-- 2. PEGAR ARMA
function PegarArma(nomeArma)
    print("[AÇÃO] ⚔️ Procurando arma: " .. nomeArma)
    
    local arma = nil
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and (v.Name == nomeArma or string.find(v.Name, nomeArma)) then
            arma = v
            break
        end
    end
    
    if not arma then
        print("[AÇÃO] ❌ Arma não encontrada: " .. nomeArma)
        return false
    end
    
    local handle = arma:FindFirstChild("Handle")
    if handle then
        Teleportar(handle.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(arma:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    ClicarObjeto(arma)
    print("[AÇÃO] ✅ Arma pegada: " .. nomeArma)
    return true
end

-- 3. COLETAR FRUTA
function ColetarFruta()
    print("[AÇÃO] 🍎 Procurando frutas no chão...")
    
    local frutas = {}
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and (v:FindFirstChild("Fruit") or string.find(v.Name, "Fruit") or string.find(v.Name, "Fruta")) then
            table.insert(frutas, v)
        end
    end
    
    if #frutas == 0 then
        print("[AÇÃO] ❌ Nenhuma fruta encontrada!")
        return false
    end
    
    local fruta = frutas[1]
    print("[AÇÃO] 🍎 Fruta encontrada: " .. fruta.Name)
    
    local handle = fruta:FindFirstChild("Handle")
    if handle then
        Teleportar(handle.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(fruta:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    ClicarObjeto(fruta)
    print("[AÇÃO] ✅ Fruta coletada: " .. fruta.Name)
    return true
end

-- 4. INTERAGIR NPC
function InteragirNPC(nomeNPC)
    print("[AÇÃO] 🔍 Procurando NPC: " .. nomeNPC)
    
    local npc = nil
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and (v.Name == nomeNPC or string.find(v.Name, nomeNPC) or string.find(v.Name, "NPC")) then
            npc = v
            break
        end
    end
    
    if not npc then
        print("[AÇÃO] ❌ NPC não encontrado: " .. nomeNPC)
        return false
    end
    
    local root = npc:FindFirstChild("HumanoidRootPart")
    if root then
        Teleportar(root.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(npc:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    ClicarObjeto(npc)
    print("[AÇÃO] ✅ Interagiu com: " .. nomeNPC)
    return true
end

-- 5. ATACAR INIMIGO
function AtacarInimigo()
    print("[AÇÃO] ⚔️ Procurando inimigo...")
    
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then
        print("[AÇÃO] ❌ Nenhum inimigo encontrado!")
        return false
    end
    
    local alvo = nil
    local menorDistancia = 999
    
    for _, e in pairs(enemies:GetChildren()) do
        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
            local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if dist < menorDistancia then
                menorDistancia = dist
                alvo = e
            end
        end
    end
    
    if not alvo then
        print("[AÇÃO] ❌ Nenhum inimigo próximo!")
        return false
    end
    
    Teleportar(alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5))
    task.wait(0.2)
    
    for i = 1, 5 do
        if UserInputService.TouchEnabled then
            UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
        elseif mouse1click then
            mouse1click()
        end
        task.wait(0.15)
    end
    
    print("[AÇÃO] ✅ Inimigo atacado!")
    return true
end

-- 6. FARMAR INIMIGOS (CONTÍNUO)
local farmAtivo = false
local kills = 0

function FarmarInimigos()
    if farmAtivo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    
    farmAtivo = true
    kills = 0
    print("[FARM] 🚀 Iniciando farm contínuo...")
    
    task.spawn(function()
        while farmAtivo do
            local enemies = workspace:FindFirstChild("Enemies")
            local alvo = nil
            local menorDistancia = 999
            
            if enemies then
                for _, e in pairs(enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        local dist = (e.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if dist < menorDistancia then
                            menorDistancia = dist
                            alvo = e
                        end
                    end
                end
            end
            
            if alvo then
                Teleportar(alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5))
                task.wait(0.1)
                
                for i = 1, 3 do
                    if UserInputService.TouchEnabled then
                        UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
                    elseif mouse1click then
                        mouse1click()
                    end
                    task.wait(0.12)
                end
                
                kills = kills + 1
                if kills % 10 == 0 then
                    print("[FARM] ⚔️ " .. kills .. " kills")
                end
            else
                print("[FARM] ⚠️ Procurando inimigos...")
                task.wait(2)
                
                -- Tenta teleportar para uma ilha com inimigos
                local ilhas = {"Jungle", "Prison", "Skypiea", "Magma Village"}
                for _, ilha in pairs(ilhas) do
                    TeleportarIlha(ilha)
                    task.wait(2)
                    break
                end
            end
        end
    end)
end

function PararFarm()
    farmAtivo = false
    print("[FARM] ⏹ Parado - " .. kills .. " kills")
end

-- 7. CURAR
function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

-- 8. MOSTRAR INFORMAÇÕES
function MostrarInfo()
    Detector.Atualizar()
    print("📊 INFORMAÇÕES DO JOGADOR:")
    print("  👤 Nome: " .. player.Name)
    print("  🎯 Nível: " .. Detector.Nivel)
    print("  💚 Vida: " .. Detector.Vida .. "/" .. Detector.MaxVida)
    print("  💰 Beli: " .. Detector.Beli)
    print("  💎 Fragmentos: " .. Detector.Fragmentos)
    print("  👤 Raça: " .. Detector.Raça)
    print("  🍎 Fruta: " .. Detector.Fruta)
    print("  ⚔️ Arma: " .. Detector.Arma)
    print("  👥 Inimigos próximos: " .. Detector.InimigosProximos)
    print("  👤 Jogadores próximos: " .. Detector.JogadoresProximos)
    if farmAtivo then
        print("  ⚔️ Kills: " .. kills)
    end
end

-- 9. USAR FRUTA
function UsarFruta(nomeFruta)
    print("[AÇÃO] 🍎 Usando fruta: " .. nomeFruta)
    
    local fruta = nil
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v:IsA("Tool") and (v.Name == nomeFruta or string.find(v.Name, nomeFruta)) then
            fruta = v
            break
        end
    end
    
    if not fruta then
        print("[AÇÃO] ❌ Fruta não encontrada no inventário: " .. nomeFruta)
        return false
    end
    
    pcall(function()
        player.Character.Humanoid:EquipTool(fruta)
        task.wait(0.5)
    end)
    
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
        task.wait(0.2)
        UserInputService:TouchTap(Vector2.new(500, 300))
    elseif mouse1click then
        mouse1click()
    end
    
    print("[AÇÃO] ✅ Fruta usada: " .. nomeFruta)
    return true
end

-- 10. FAZER QUEST
function FazerQuest(nomeNPC)
    print("[AÇÃO] 📋 Indo fazer quest com: " .. nomeNPC)
    return InteragirNPC(nomeNPC)
end

-- 11. COMPRAR ITEM
function ComprarItem(nomeNPC)
    print("[AÇÃO] 🛒 Indo comprar com: " .. nomeNPC)
    return InteragirNPC(nomeNPC)
end

-- 12. ABRIR LOJA
function AbrirLoja()
    print("[AÇÃO] 🛒 Abrindo loja...")
    return InteragirNPC("Shop")
end

-- 13. FAZER RAID
function FazerRaid()
    print("[AÇÃO] ⚔️ Iniciando Raid...")
    return InteragirNPC("Raid")
end

-- ============================================
-- CRIA INTERFACE (OTIMIZADA PARA CELULAR)
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 520)
frame.Position = UDim2.new(0.5, -180, 0.5, -260)
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
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 0
header.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Text = "⚓ BLOX FRUITS"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Parent = header

local versao = Instance.new("TextLabel")
versao.Size = UDim2.new(0, 60, 0, 20)
versao.Position = UDim2.new(1, -65, 0, 4)
versao.Text = "Mobile"
versao.TextColor3 = Color3.fromRGB(180, 180, 220)
versao.BackgroundTransparency = 1
versao.Font = Enum.Font.GothamMedium
versao.TextSize = 10
versao.TextXAlignment = Enum.TextXAlignment.Right
versao.Parent = header

-- Botão Sair
local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 30, 0, 30)
exitBtn.Position = UDim2.new(1, -36, 0, 10)
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
scroll.Size = UDim2.new(1, -10, 1, -105)
scroll.Position = UDim2.new(0, 5, 0, 55)
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
-- FUNÇÕES DE CRIAÇÃO
-- ============================================

function criarBotao(texto, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 1
    btn.BorderColor3 = cor
    btn.Parent = scroll
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 25, 0, 25)
    arrow.Position = UDim2.new(1, -32, 0.5, -12)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 12
    arrow.Parent = btn
    
    btn.TouchTap:Connect(function()
        if callback then pcall(callback) end
        btn.BackgroundTransparency = 0.3
        task.wait(0.1)
        btn.BackgroundTransparency = 0.15
    end)
    
    btn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
        btn.BackgroundTransparency = 0.3
        task.wait(0.1)
        btn.BackgroundTransparency = 0.15
    end)
    
    return btn
end

function criarSecao(texto, cor)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 28)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scroll
    return lbl
end

function criarInfo(texto, valor, cor)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 24)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.1
    frame2.BorderSizePixel = 0
    frame2.Parent = scroll
    
    local lbl1 = Instance.new("TextLabel")
    lbl1.Size = UDim2.new(0, 100, 1, 0)
    lbl1.Position = UDim2.new(0, 8, 0, 0)
    lbl1.Text = texto
    lbl1.TextColor3 = Color3.fromRGB(180, 180, 200)
    lbl1.BackgroundTransparency = 1
    lbl1.Font = Enum.Font.GothamMedium
    lbl1.TextSize = 11
    lbl1.TextXAlignment = Enum.TextXAlignment.Left
    lbl1.Parent = frame2
    
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(0, 150, 1, 0)
    lbl2.Position = UDim2.new(1, -160, 0, 0)
    lbl2.Text = tostring(valor)
    lbl2.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextSize = 11
    lbl2.TextXAlignment = Enum.TextXAlignment.Right
    lbl2.Parent = frame2
end

-- ============================================
-- INTERFACE COMPLETA
-- ============================================

-- Card do Jogador
local playerCard = Instance.new("Frame")
playerCard.Size = UDim2.new(1, 0, 0, 55)
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
Detector.Atualizar()
infoLabel.Text = "🎯 Nível " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida .. "/" .. Detector.MaxVida
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
        Detector.Atualizar()
        infoLabel.Text = "🎯 Nível " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida .. "/" .. Detector.MaxVida
    end
end)

-- ============================================
-- CATEGORIAS (EXPANSÍVEIS)
-- ============================================

function criarCategoria(icone, nome, cor)
    local catFrame = Instance.new("Frame")
    catFrame.Size = UDim2.new(1, 0, 0, 36)
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
    
    local actionsContainer = Instance.new("Frame")
    actionsContainer.Size = UDim2.new(1, 0, 0, 0)
    actionsContainer.BackgroundTransparency = 1
    actionsContainer.BorderSizePixel = 0
    actionsContainer.Visible = false
    actionsContainer.Parent = scroll
    
    local actionsLayout = Instance.new("UIListLayout")
    actionsLayout.Padding = UDim.new(0, 2)
    actionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    actionsLayout.Parent = actionsContainer
    
    local expandido = false
    
    local function adicionarAcao(texto, corAcao, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 34)
        btn.Position = UDim2.new(0, 5, 0, 0)
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
            if callback then pcall(callback) end
            arrow2.Text = "✅"
            arrow2.TextColor3 = Color3.fromRGB(100, 255, 100)
            btn.TextColor3 = Color3.fromRGB(150, 255, 150)
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            btn.BackgroundTransparency = 0.3
        end)
        
        btn.MouseButton1Click:Connect(function()
            if callback then pcall(callback) end
            arrow2.Text = "✅"
            arrow2.TextColor3 = Color3.fromRGB(100, 255, 100)
            btn.TextColor3 = Color3.fromRGB(150, 255, 150)
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            btn.BackgroundTransparency = 0.3
        end)
        
        local totalAltura = 0
        for _, child in pairs(actionsContainer:GetChildren()) do
            if child:IsA("TextButton") then
                totalAltura = totalAltura + 36
            end
        end
        actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
    end
    
    catBtn.TouchTap:Connect(function()
        expandido = not expandido
        if expandido then
            actionsContainer.Visible = true
            indicator.Text = "▾"
            catFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            local totalAltura = 0
            for _, child in pairs(actionsContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    totalAltura = totalAltura + 36
                end
            end
            actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
        else
            actionsContainer.Visible = false
            indicator.Text = "▸"
            catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            actionsContainer.Size = UDim2.new(1, 0, 0, 0)
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
                    totalAltura = totalAltura + 36
                end
            end
            actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
        else
            actionsContainer.Visible = false
            indicator.Text = "▸"
            catFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
            actionsContainer.Size = UDim2.new(1, 0, 0, 0)
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
                    totalAltura = totalAltura + 36
                end
            end
            actionsContainer.Size = UDim2.new(1, 0, 0, totalAltura)
        end
    }
end

-- ============================================
-- CRIA TODAS AS CATEGORIAS
-- ============================================

-- 1. FARM
local catFarm = criarCategoria("⚡", "FARM", Color3.fromRGB(0, 200, 100))
catFarm.adicionarAcao("Farmar Nível Máximo", Color3.fromRGB(0, 180, 100), FarmarInimigos)
catFarm.adicionarAcao("Parar Farm", Color3.fromRGB(200, 50, 50), PararFarm)
catFarm.adicionarAcao("Curar", Color3.fromRGB(50, 200, 100), Curar)

-- 2. MOVIMENTO
local catMov = criarCategoria("🚀", "MOVIMENTO", Color3.fromRGB(50, 200, 255))
catMov.adicionarAcao("Teleportar Jungle", Color3.fromRGB(50, 200, 100), function() TeleportarIlha("Jungle") end)
catMov.adicionarAcao("Teleportar Prison", Color3.fromRGB(50, 200, 100), function() TeleportarIlha("Prison") end)
catMov.adicionarAcao("Teleportar Skypiea", Color3.fromRGB(50, 200, 100), function() TeleportarIlha("Skypiea") end)
catMov.adicionarAcao("Teleportar Magma", Color3.fromRGB(50, 200, 100), function() TeleportarIlha("Magma Village") end)

-- 3. COMBATE
local catComb = criarCategoria("⚔️", "COMBATE", Color3.fromRGB(200, 50, 50))
catComb.adicionarAcao("Atacar Inimigo", Color3.fromRGB(200, 50, 50), AtacarInimigo)

-- 4. COLETAR
local catCol = criarCategoria("🎯", "COLETAR", Color3.fromRGB(255, 200, 50))
catCol.adicionarAcao("Coletar Fruta", Color3.fromRGB(255, 200, 50), ColetarFruta)
catCol.adicionarAcao("Pegar Arma", Color3.fromRGB(255, 200, 50), function() PegarArma("Saber") end)
catCol.adicionarAcao("Pegar Item", Color3.fromRGB(255, 200, 50), function() PegarItem("Item") end)

-- 5. NPC
local catNPC = criarCategoria("🤝", "NPC", Color3.fromRGB(100, 150, 255))
catNPC.adicionarAcao("Interagir NPC", Color3.fromRGB(100, 150, 255), function() InteragirNPC("NPC") end)
catNPC.adicionarAcao("Fazer Quest", Color3.fromRGB(100, 150, 255), function() FazerQuest("Quest NPC") end)
catNPC.adicionarAcao("Comprar Item", Color3.fromRGB(100, 150, 255), function() ComprarItem("Shop NPC") end)
catNPC.adicionarAcao("Abrir Loja", Color3.fromRGB(100, 150, 255), AbrirLoja)
catNPC.adicionarAcao("Fazer Raid", Color3.fromRGB(100, 150, 255), FazerRaid)

-- 6. INFORMAÇÕES
local catInfo = criarCategoria("📊", "INFORMAÇÕES", Color3.fromRGB(100, 255, 100))
catInfo.adicionarAcao("Mostrar Informações", Color3.fromRGB(100, 255, 100), MostrarInfo)

-- 7. FRUTAS
local catFruta = criarCategoria("🍎", "FRUTAS", Color3.fromRGB(255, 200, 100))
catFruta.adicionarAcao("Usar Buddha", Color3.fromRGB(255, 200, 100), function() UsarFruta("Buddha") end)
catFruta.adicionarAcao("Usar Magma", Color3.fromRGB(255, 200, 100), function() UsarFruta("Magma") end)
catFruta.adicionarAcao("Usar Light", Color3.fromRGB(255, 200, 100), function() UsarFruta("Light") end)

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
footer.Text = "⭐ Mobile Completo | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Script Mobile Completo carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")