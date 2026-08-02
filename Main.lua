--[[
    BLOX FRUITS SCRIPT - AÇÕES REAIS
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🔥 Carregando Blox Fruits Script (Ações Reais)...")

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
-- FUNÇÕES DE MOVIMENTO E AÇÃO
-- ============================================

-- 1. TELEPORTAR PARA UMA ILHA
function TeleportarIlha(nomeIlha)
    print("[AÇÃO] 🚀 Teleportando para: " .. nomeIlha)
    
    local ilha = workspace:FindFirstChild(nomeIlha)
    if not ilha then
        print("[AÇÃO] ❌ Ilha não encontrada: " .. nomeIlha)
        return false
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = ilha.CFrame + Vector3.new(0, 50, 0)
        task.wait(1)
        print("[AÇÃO] ✅ Teleportado para: " .. nomeIlha)
        return true
    end
    
    return false
end

-- 2. IR ATÉ UM NPC E INTERAGIR
function InteragirNPC(nomeNPC)
    print("[AÇÃO] 🔍 Procurando NPC: " .. nomeNPC)
    
    local npc = nil
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v.Name == nomeNPC then
            npc = v
            break
        end
    end
    
    if not npc then
        print("[AÇÃO] ❌ NPC não encontrado: " .. nomeNPC)
        return false
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = npc:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 0, 5)
        task.wait(0.5)
    end
    
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
    elseif mouse1click then
        mouse1click()
    end
    
    print("[AÇÃO] ✅ Interagiu com: " .. nomeNPC)
    return true
end

-- 3. COLETAR ITEM DO CHÃO
function ColetarItem(nomeItem)
    print("[AÇÃO] 🔍 Procurando item: " .. nomeItem)
    
    local item = nil
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name == nomeItem then
            item = v
            break
        end
    end
    
    if not item then
        print("[AÇÃO] ❌ Item não encontrado: " .. nomeItem)
        return false
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local handle = item:FindFirstChild("Handle")
        if handle then
            player.Character.HumanoidRootPart.CFrame = handle.CFrame + Vector3.new(0, 0, 5)
        else
            player.Character.HumanoidRootPart.CFrame = item:GetPivot() + Vector3.new(0, 0, 5)
        end
        task.wait(0.5)
    end
    
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
    elseif mouse1click then
        mouse1click()
    end
    
    print("[AÇÃO] ✅ Item coletado: " .. nomeItem)
    return true
end

-- 4. ATACAR INIMIGO MAIS PRÓXIMO
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
    
    player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
    task.wait(0.2)
    
    for i = 1, 3 do
        if UserInputService.TouchEnabled then
            UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
        elseif mouse1click then
            mouse1click()
        end
        task.wait(0.2)
    end
    
    print("[AÇÃO] ✅ Inimigo atacado!")
    return true
end

-- 5. FARMAR INIMIGOS (CONTÍNUO)
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
                player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                task.wait(0.1)
                
                for i = 1, 3 do
                    if UserInputService.TouchEnabled then
                        UserInputService:TouchTap(Vector2.new(300 + math.random(-40, 40), 400 + math.random(-40, 40)))
                    elseif mouse1click then
                        mouse1click()
                    end
                    task.wait(0.15)
                end
                
                kills = kills + 1
                if kills % 10 == 0 then
                    print("[FARM] ⚔️ " .. kills .. " kills")
                end
            else
                print("[FARM] ⚠️ Procurando inimigos...")
                task.wait(2)
            end
        end
    end)
end

function PararFarm()
    farmAtivo = false
    print("[FARM] ⏹ Parado - " .. kills .. " kills")
end

-- 6. CURAR PERSONAGEM
function Curar()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            print("💚 Curado!")
        end
    end)
end

-- 7. COLETAR FRUTA DO CHÃO
function ColetarFruta()
    print("[AÇÃO] 🍎 Procurando frutas no chão...")
    
    local frutas = {}
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Fruit") then
            table.insert(frutas, v)
        end
    end
    
    if #frutas == 0 then
        print("[AÇÃO] ❌ Nenhuma fruta encontrada!")
        return false
    end
    
    local fruta = frutas[1]
    print("[AÇÃO] 🍎 Fruta encontrada: " .. fruta.Name)
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local handle = fruta:FindFirstChild("Handle")
        if handle then
            player.Character.HumanoidRootPart.CFrame = handle.CFrame + Vector3.new(0, 0, 5)
        else
            player.Character.HumanoidRootPart.CFrame = fruta:GetPivot() + Vector3.new(0, 0, 5)
        end
        task.wait(0.5)
    end
    
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
    elseif mouse1click then
        mouse1click()
    end
    
    print("[AÇÃO] ✅ Fruta coletada: " .. fruta.Name)
    return true
end

-- 8. PEGAR ARMA DO CHÃO
function PegarArma(nomeArma)
    print("[AÇÃO] ⚔️ Procurando arma: " .. nomeArma)
    
    local arma = nil
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name == nomeArma then
            arma = v
            break
        end
    end
    
    if not arma then
        print("[AÇÃO] ❌ Arma não encontrada: " .. nomeArma)
        return false
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local handle = arma:FindFirstChild("Handle")
        if handle then
            player.Character.HumanoidRootPart.CFrame = handle.CFrame + Vector3.new(0, 0, 5)
        else
            player.Character.HumanoidRootPart.CFrame = arma:GetPivot() + Vector3.new(0, 0, 5)
        end
        task.wait(0.5)
    end
    
    if UserInputService.TouchEnabled then
        UserInputService:TouchTap(Vector2.new(500, 300))
    elseif mouse1click then
        mouse1click()
    end
    
    print("[AÇÃO] ✅ Arma pegada: " .. nomeArma)
    return true
end

-- 9. MOSTRAR INFORMAÇÕES
function MostrarInfo()
    local nivel = player.Level or player:GetAttribute("Level") or 0
    local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
    local maxHealth = player.Character and player.Character.Humanoid and player.Character.Humanoid.MaxHealth or 100
    
    print("📊 INFORMAÇÕES DO JOGADOR:")
    print("  👤 Nome: " .. player.Name)
    print("  🎯 Nível: " .. nivel)
    print("  💚 Vida: " .. health .. "/" .. maxHealth)
    if farmAtivo then
        print("  ⚔️ Kills: " .. kills)
    end
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
logo.Text = "⚓ BLOX FRUITS"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 18
logo.Parent = topo

-- Botão Sair
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
-- CRIA BOTÕES
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
local nivel = player.Level or player:GetAttribute("Level") or 0
local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
infoLabel.Text = "🎯 Nível " .. nivel .. "  |  💚 " .. health .. "/100"
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

-- SEÇÃO COMBATE
criarSecao("⚔️ COMBATE", y)
y = y + 30

criarBotao("⚔️ Atacar Inimigo", y, Color3.fromRGB(200, 50, 50), AtacarInimigo)
y = y + 42

criarBotao("⚡ Farmar Contínuo", y, Color3.fromRGB(0, 200, 100), FarmarInimigos)
y = y + 42

criarBotao("⏹ Parar Farm", y, Color3.fromRGB(255, 80, 80), PararFarm)
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

criarBotao("📦 Coletar Item", y, Color3.fromRGB(255, 200, 50), function()
    ColetarItem("Item")
end)
y = y + 42

-- SEÇÃO UTILIDADES
criarSecao("💚 UTILIDADES", y)
y = y + 30

criarBotao("💚 Curar", y, Color3.fromRGB(50, 200, 100), Curar)
y = y + 42

criarBotao("📊 Informações", y, Color3.fromRGB(100, 150, 255), MostrarInfo)
y = y + 42

criarBotao("🤝 Interagir NPC", y, Color3.fromRGB(100, 150, 255), function()
    InteragirNPC("NPC")
end)

-- ============================================
-- ATUALIZA STATUS EM TEMPO REAL
-- ============================================

task.spawn(function()
    while gui and gui.Parent do
        task.wait(1)
        local nivel = player.Level or player:GetAttribute("Level") or 0
        local health = player.Character and player.Character.Humanoid and math.floor(player.Character.Humanoid.Health) or 0
        infoLabel.Text = "🎯 Nível " .. nivel .. "  |  💚 " .. health .. "/100"
    end
end)

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 18)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "⭐ Ações Reais | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 9
footer.Parent = frame

print("✅ Script de Ações Reais carregado!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")