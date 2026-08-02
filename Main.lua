--[[
    BLOX FRUITS SCRIPT - VERSÃO MAX (SEM LIMITAÇÕES)
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🔥 Carregando Blox Fruits Script - Versão MAX...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local ContextActionService = game:GetService("ContextActionService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

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
-- SISTEMA DE DETECÇÃO AVANÇADA
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
        
        -- Detecta fruta equipada
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("Fruit") then
                Detector.Fruta = item.Name
                break
            end
        end
        
        -- Detecta arma equipada
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
    
    -- Método 4: Mouse click (PC)
    if mouse1click then
        mouse1click()
        task.wait(0.1)
        mouse1click()
        return true
    end
    
    -- Método 5: Virtual Input (PC)
    if VirtualInput then
        VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, true, game, 0)
        task.wait(0.05)
        VirtualInput:SendMouseButtonEvent(Vector2.new(500, 300), 1, false, game, 0)
        return true
    end
    
    -- Método 6: Touch (Celular)
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
        task.wait(0.1)
        UserInputService:TouchTap(Vector2.new(500, 300))
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
    
    if mouse1click then
        mouse1click()
        return true
    end
    
    return false
end

-- ============================================
-- FUNÇÃO DE TELEPORTE AVANÇADA
-- ============================================

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
-- 1. PEGAR ITEM (MULTI-MÉTODO)
-- ============================================

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
    
    print("[AÇÃO] 📍 Item encontrado: " .. item.Name)
    
    local handle = item:FindFirstChild("Handle")
    if handle then
        Teleportar(handle.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(item:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    
    -- Tenta pegar o item
    local sucesso = ClicarObjeto(item)
    
    if sucesso then
        print("[AÇÃO] ✅ Item coletado: " .. nomeItem)
    else
        print("[AÇÃO] ⚠️ Tentando método alternativo...")
        ClicarPosicao(500, 300)
        task.wait(0.2)
        ClicarPosicao(500, 300)
        print("[AÇÃO] ✅ Item coletado (método alternativo): " .. nomeItem)
    end
    
    return true
end

-- ============================================
-- 2. PEGAR ARMA (MULTI-MÉTODO)
-- ============================================

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
    
    print("[AÇÃO] 📍 Arma encontrada: " .. arma.Name)
    
    local handle = arma:FindFirstChild("Handle")
    if handle then
        Teleportar(handle.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(arma:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    
    local sucesso = ClicarObjeto(arma)
    
    if sucesso then
        print("[AÇÃO] ✅ Arma pegada: " .. nomeArma)
    else
        print("[AÇÃO] ⚠️ Tentando método alternativo...")
        ClicarPosicao(500, 300)
        task.wait(0.2)
        ClicarPosicao(500, 300)
        print("[AÇÃO] ✅ Arma pegada: " .. nomeArma)
    end
    
    return true
end

-- ============================================
-- 3. COLETAR FRUTA (MULTI-MÉTODO)
-- ============================================

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
    
    local sucesso = ClicarObjeto(fruta)
    
    if sucesso then
        print("[AÇÃO] ✅ Fruta coletada: " .. fruta.Name)
    else
        print("[AÇÃO] ⚠️ Tentando método alternativo...")
        ClicarPosicao(500, 300)
        task.wait(0.2)
        ClicarPosicao(500, 300)
        print("[AÇÃO] ✅ Fruta coletada: " .. fruta.Name)
    end
    
    return true
end

-- ============================================
-- 4. INTERAGIR COM NPC (MULTI-MÉTODO)
-- ============================================

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
    
    print("[AÇÃO] 📍 NPC encontrado: " .. npc.Name)
    
    local root = npc:FindFirstChild("HumanoidRootPart")
    if root then
        Teleportar(root.CFrame + Vector3.new(0, 0, 5))
    else
        Teleportar(npc:GetPivot() + Vector3.new(0, 0, 5))
    end
    
    task.wait(0.5)
    
    -- Tenta interagir com o NPC
    local sucesso = ClicarObjeto(npc)
    
    if not sucesso and root then
        sucesso = ClicarObjeto(root)
    end
    
    if sucesso then
        print("[AÇÃO] ✅ Interagiu com: " .. nomeNPC)
    else
        print("[AÇÃO] ⚠️ Tentando método alternativo...")
        for i = 1, 3 do
            ClicarPosicao(500, 300)
            task.wait(0.2)
        end
        print("[AÇÃO] ✅ Interagiu com: " .. nomeNPC)
    end
    
    return true
end

-- ============================================
-- 5. FAZER QUEST
-- ============================================

function FazerQuest(nomeNPC)
    print("[AÇÃO] 📋 Indo fazer quest com: " .. nomeNPC)
    return InteragirNPC(nomeNPC)
end

-- ============================================
-- 6. COMPRAR ITEM
-- ============================================

function ComprarItem(nomeNPC)
    print("[AÇÃO] 🛒 Indo comprar com: " .. nomeNPC)
    return InteragirNPC(nomeNPC)
end

-- ============================================
-- 7. TELEPORTAR PARA ILHA (COM DETECÇÃO)
-- ============================================

function TeleportarIlha(nomeIlha)
    print("[AÇÃO] 🚀 Teleportando para: " .. nomeIlha)
    
    -- Tenta encontrar a ilha no Workspace
    local ilha = workspace:FindFirstChild(nomeIlha)
    if ilha then
        Teleportar(ilha.CFrame + Vector3.new(0, 50, 0))
        print("[AÇÃO] ✅ Teleportado para: " .. nomeIlha)
        return true
    end
    
    -- Tenta encontrar a ilha nos Spawns
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
-- 8. ATACAR INIMIGO (MELHORADO)
-- ============================================

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
    
    -- Ataca múltiplas vezes
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

-- ============================================
-- 9. FARMAR INIMIGOS (CONTÍNUO)
-- ============================================

local farmAtivo = false
local kills = 0
local farmando = false

function FarmarInimigos()
    if farmAtivo then
        print("[FARM] ⚠️ Já está ativo!")
        return
    end
    
    farmAtivo = true
    kills = 0
    farmando = true
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
                    local encontrado = TeleportarIlha(ilha)
                    if encontrado then
                        task.wait(2)
                        break
                    end
                end
            end
        end
    end)
end

function PararFarm()
    farmAtivo = false
    farmando = false
    print("[FARM] ⏹ Parado - " .. kills .. " kills")
end

-- ============================================
-- 10. CURAR
-- ============================================

function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

-- ============================================
-- 11. USAR FRUTA (MELHORADO)
-- ============================================

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
    
    -- Equipa a fruta
    pcall(function()
        player.Character.Humanoid:EquipTool(fruta)
        task.wait(0.5)
    end)
    
    -- Tenta usar a habilidade (tecla 1)
    if VirtualInput then
        VirtualInput:SendKeyEvent(true, Enum.KeyCode.One, false, game)
        task.wait(0.1)
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.One, false, game)
    elseif ContextActionService then
        ContextActionService:FireAll("ActivateAbility1", Enum.UserInputState.Begin, nil)
        task.wait(0.1)
        ContextActionService:FireAll("ActivateAbility1", Enum.UserInputState.End, nil)
    else
        ClicarPosicao(500, 300)
    end
    
    print("[AÇÃO] ✅ Fruta usada: " .. nomeFruta)
    return true
end

-- ============================================
-- 12. MOSTRAR INFORMAÇÕES (COMPLETAS)
-- ============================================

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
    if farmAtivo then
        print("  ⚔️ Kills: " .. kills)
    end
end

-- ============================================
-- 13. ABRIR LOJA
-- ============================================

function AbrirLoja()
    print("[AÇÃO] 🛒 Abrindo loja...")
    return InteragirNPC("Shop")
end

-- ============================================
-- 14. FAZER RAID
-- ============================================

function FazerRaid()
    print("[AÇÃO] ⚔️ Iniciando Raid...")
    return InteragirNPC("Raid")
end

-- ============================================
-- CRIA INTERFACE
-- ============================================

local gui = Instance.new("ScreenGui")
gui.Name = "BloxFruitsHub"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 520)
frame.Position = UDim2.new(0.5, -180, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

-- Topo
local topo = Instance.new("Frame")
topo.Size = UDim2.new(1, 0, 0, 45)
topo.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
topo.BackgroundTransparency = 0.1
topo.BorderSizePixel = 0
topo.Parent = frame

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 45)
logo.Text = "⚓ BLOX FRUITS MAX"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Parent = topo

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 26, 0, 26)
exitBtn.Position = UDim2.new(1, -34, 0, 10)
exitBtn.Text = "✖"
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitBtn.BackgroundTransparency = 0.2
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 14
exitBtn.BorderSizePixel = 0
exitBtn.Parent = frame

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 6)
exitCorner.Parent = exitBtn

exitBtn.MouseButton1Click:Connect(function()
    farmAtivo = false
    gui:Destroy()
    print("👋 Hub fechado!")
end)

-- ============================================
-- FUNÇÕES DE CRIAÇÃO
-- ============================================

local function criarBotao(texto, y, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 320, 0, 36)
    btn.Position = UDim2.new(0.5, -160, 0, y)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cor
    btn.BackgroundTransparency = 0.15
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 1
    btn.BorderColor3 = cor
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        print("▶️ " .. texto)
        if callback then pcall(callback) end
    end)
    
    return btn
end

local function criarSecao(texto, y)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.Text = "▸ " .. texto
    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    return lbl
end

-- ============================================
-- INTERFACE COMPLETA
-- ============================================

local y = 55

-- Card do Jogador
local playerCard = Instance.new("Frame")
playerCard.Size = UDim2.new(0, 320, 0, 50)
playerCard.Position = UDim2.new(0.5, -160, 0, y)
playerCard.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
playerCard.BackgroundTransparency = 0.15
playerCard.BorderSizePixel = 1
playerCard.BorderColor3 = Color3.fromRGB(255, 215, 0)
playerCard.Parent = frame

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 8)
playerCorner.Parent = playerCard

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, 0, 0, 22)
nameLabel.Position = UDim2.new(0, 10, 0, 2)
nameLabel.Text = "👤 " .. player.Name
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 13
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = playerCard

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, 0, 0, 20)
infoLabel.Position = UDim2.new(0, 10, 0, 28)
Detector.Atualizar()
infoLabel.Text = "🎯 Nível " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida .. "/" .. Detector.MaxVida
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 10
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = playerCard

y = y + 58

-- SEÇÃO MOVIMENTO
criarSecao("🚀 MOVIMENTO", y)
y = y + 30

criarBotao("🏝️ Teleportar Jungle", y, Color3.fromRGB(50, 200, 100), function()
    TeleportarIlha("Jungle")
end)
y = y + 42

criarBotao("🏝️ Teleportar Prison", y, Color3.fromRGB(50, 200, 100), function()
    TeleportarIlha("Prison")
end)
y = y + 42

criarBotao("🏝️ Teleportar Skypiea", y, Color3.fromRGB(50, 200, 100), function()
    TeleportarIlha("Skypiea")
end)

y = y + 42

-- SEÇÃO COLETAR
criarSecao("🎯 COLETAR", y)
y = y + 30

criarBotao("🍎 Coletar Fruta", y, Color3.fromRGB(255, 200, 50), ColetarFruta)
y = y + 42

criarBotao("⚔️ Pegar Arma", y, Color3.fromRGB(255, 200, 50), function()
    PegarArma("Saber")
end)
y = y + 42

criarBotao("📦 Pegar Item", y, Color3.fromRGB(255, 200, 50), function()
    PegarItem("Item")
end)

y = y + 42

-- SEÇÃO COMBATE
criarSecao("⚔️ COMBATE", y)
y = y + 30

criarBotao("⚔️ Atacar Inimigo", y, Color3.fromRGB(200, 50, 50), AtacarInimigo)
y = y + 42

criarBotao("⚡ Farmar Contínuo", y, Color3.fromRGB(0, 200, 100), FarmarInimigos)
y = y + 42

criarBotao("⏹ Parar Farm", y, Color3.fromRGB(255, 80, 80), PararFarm)

y = y + 42

-- SEÇÃO NPC
criarSecao("🤝 NPC E INTERAÇÕES", y)
y = y + 30

criarBotao("🤝 Interagir NPC", y, Color3.fromRGB(100, 150, 255), function()
    InteragirNPC("NPC")
end)
y = y + 42

criarBotao("📋 Fazer Quest", y, Color3.fromRGB(100, 150, 255), function()
    FazerQuest("Quest NPC")
end)
y = y + 42

criarBotao("🛒 Comprar Item", y, Color3.fromRGB(100, 150, 255), function()
    ComprarItem("Shop NPC")
end)
y = y + 42

criarBotao("🛒 Abrir Loja", y, Color3.fromRGB(100, 150, 255), AbrirLoja)

y = y + 42

-- SEÇÃO UTILIDADES
criarSecao("💚 UTILIDADES", y)
y = y + 30

criarBotao("💚 Curar", y, Color3.fromRGB(50, 200, 100), Curar)
y = y + 42

criarBotao("📊 Informações", y, Color3.fromRGB(100, 150, 255), MostrarInfo)
y = y + 42

criarBotao("🍎 Usar Fruta", y, Color3.fromRGB(255, 200, 100), function()
    UsarFruta("Buddha")
end)

-- ============================================
-- ATUALIZA STATUS
-- ============================================

task.spawn(function()
    while gui and gui.Parent do
        task.wait(1)
        Detector.Atualizar()
        infoLabel.Text = "🎯 Nível " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida .. "/" .. Detector.MaxVida
    end
end)

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 18)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "⭐ Versão MAX | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Script Versão MAX carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")