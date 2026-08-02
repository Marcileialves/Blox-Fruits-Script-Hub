--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO COMPLETA
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🔥 Carregando Blox Fruits Script Hub...")

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")

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
-- FUNÇÃO PARA CARREGAR MÓDULOS
-- ============================================

local baseUrl = "https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/"

local function carregarModulo(nome, caminho)
    print("📥 Carregando: " .. nome .. "...")
    local sucesso, modulo = pcall(function()
        return loadstring(game:HttpGet(caminho))()
    end)
    if sucesso and modulo then
        print("✅ " .. nome .. " carregado!")
        return modulo
    else
        print("❌ Falha ao carregar " .. nome)
        return nil
    end
end

-- ============================================
-- CARREGA OS MÓDULOS
-- ============================================

local Config = carregarModulo("Config", baseUrl .. "Config.lua")
local Detector = carregarModulo("Detector", baseUrl .. "Detector.lua")
local AntiBan = carregarModulo("AntiBan", baseUrl .. "AntiBan.lua")
local Farm = carregarModulo("Farm", baseUrl .. "Farm.lua")
local Utils = carregarModulo("Utils", baseUrl .. "Utils.lua")
local Interface = carregarModulo("Interface", baseUrl .. "Interface.lua")

-- Carrega as categorias
local FarmCategory = carregarModulo("FarmCategory", baseUrl .. "Categories/FarmCategory.lua")
local RaceCategory = carregarModulo("RaceCategory", baseUrl .. "Categories/RaceCategory.lua")
local WeaponsCategory = carregarModulo("WeaponsCategory", baseUrl .. "Categories/WeaponsCategory.lua")
local BossCategory = carregarModulo("BossCategory", baseUrl .. "Categories/BossCategory.lua")
local QuestCategory = carregarModulo("QuestCategory", baseUrl .. "Categories/QuestCategory.lua")
local FishingCategory = carregarModulo("FishingCategory", baseUrl .. "Categories/FishingCategory.lua")
local ConfigCategory = carregarModulo("ConfigCategory", baseUrl .. "Categories/ConfigCategory.lua")

-- Verifica se os módulos principais carregaram
if not Config or not Detector or not Farm or not Utils or not Interface then
    print("❌ Erro: Módulos principais não carregaram!")
    print("🔄 Usando modo de emergência...")
    loadstring(game:HttpGet(baseUrl .. "Main.lua"))()
    return
end

print("✅ Todos os módulos carregados com sucesso!")

-- ============================================
-- CRIA A INTERFACE
-- ============================================

local ui = Interface.Criar(player, Detector, Config)

-- ============================================
-- ADICIONA INFORMAÇÕES DO JOGADOR
-- ============================================

Detector.Atualizar(player)

-- Card do Jogador
local playerCard = Instance.new("Frame")
playerCard.Size = UDim2.new(1, 0, 0, 55)
playerCard.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
playerCard.BackgroundTransparency = 0.15
playerCard.BorderSizePixel = 1
playerCard.BorderColor3 = Color3.fromRGB(255, 215, 0)
playerCard.Parent = ui.content

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
infoLabel.Text = "🎯 Nível " .. (Detector.Nivel or 0) .. "  |  💚 " .. (Detector.Vida or 0) .. "/" .. (Detector.MaxVida or 100)
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.GothamMedium
infoLabel.TextSize = 10
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = playerCard

-- Status
local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(1, 0, 0, 34)
statusFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
statusFrame.BackgroundTransparency = 0.2
statusFrame.BorderSizePixel = 1
statusFrame.BorderColor3 = Color3.fromRGB(100, 255, 100)
statusFrame.Parent = ui.content

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.Text = "🟢 Pronto"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 12
statusLabel.Parent = statusFrame

-- Maestria
local maestriaLbl = Instance.new("TextLabel")
maestriaLbl.Size = UDim2.new(1, 0, 0, 24)
maestriaLbl.Text = "▸ 🥊 MAESTRIA & COMBATE"
maestriaLbl.TextColor3 = Color3.fromRGB(255, 150, 100)
maestriaLbl.BackgroundTransparency = 1
maestriaLbl.Font = Enum.Font.GothamBold
maestriaLbl.TextSize = 12
maestriaLbl.TextXAlignment = Enum.TextXAlignment.Left
maestriaLbl.Parent = ui.content

local maestriaSep = Instance.new("Frame")
maestriaSep.Size = UDim2.new(1, -10, 0, 1)
maestriaSep.Position = UDim2.new(0, 5, 0, 0)
maestriaSep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
maestriaSep.BackgroundTransparency = 0.5
maestriaSep.BorderSizePixel = 0
maestriaSep.Parent = ui.content

-- Info Maestria
local function criarInfo(texto, valor, cor)
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(1, 0, 0, 22)
    frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    frame2.BackgroundTransparency = 0.1
    frame2.BorderSizePixel = 0
    frame2.Parent = ui.content
    
    local lbl1 = Instance.new("TextLabel")
    lbl1.Size = UDim2.new(0, 100, 1, 0)
    lbl1.Position = UDim2.new(0, 8, 0, 0)
    lbl1.Text = texto
    lbl1.TextColor3 = Color3.fromRGB(180, 180, 200)
    lbl1.BackgroundTransparency = 1
    lbl1.Font = Enum.Font.GothamMedium
    lbl1.TextSize = 10
    lbl1.TextXAlignment = Enum.TextXAlignment.Left
    lbl1.Parent = frame2
    
    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(0, 150, 1, 0)
    lbl2.Position = UDim2.new(1, -160, 0, 0)
    lbl2.Text = tostring(valor)
    lbl2.TextColor3 = cor or Color3.fromRGB(255, 215, 0)
    lbl2.BackgroundTransparency = 1
    lbl2.Font = Enum.Font.GothamBold
    lbl2.TextSize = 10
    lbl2.TextXAlignment = Enum.TextXAlignment.Right
    lbl2.Parent = frame2
end

criarInfo("Maestria", (Detector.Maestria or 0) .. "/600", Color3.fromRGB(255, 200, 100))
criarInfo("Nível", "Lv. " .. (Detector.Nivel or 0), Color3.fromRGB(100, 255, 100))
criarInfo("Estilo", "Combat", Color3.fromRGB(200, 150, 255))

-- ============================================
-- CARREGA AS CATEGORIAS
-- ============================================

if FarmCategory then
    FarmCategory.Criar(ui.content, player, Farm, AntiBan, Utils, Config)
end

if RaceCategory then
    RaceCategory.Criar(ui.content)
end

if WeaponsCategory then
    WeaponsCategory.Criar(ui.content)
end

if BossCategory then
    BossCategory.Criar(ui.content)
end

if QuestCategory then
    QuestCategory.Criar(ui.content)
end

if FishingCategory then
    FishingCategory.Criar(ui.content)
end

if ConfigCategory then
    ConfigCategory.Criar(ui.content, Config)
end

-- ============================================
-- ATUALIZA STATUS EM TEMPO REAL
-- ============================================

task.spawn(function()
    while ui.gui and ui.gui.Parent do
        task.wait(1)
        Detector.Atualizar(player)
        infoLabel.Text = "🎯 Nível " .. (Detector.Nivel or 0) .. "  |  💚 " .. (Detector.Vida or 0) .. "/" .. (Detector.MaxVida or 100)
        
        if Farm and Farm.Ativo then
            statusLabel.Text = "⚡ Farmando... (" .. (Farm.Kills or 0) .. " kills)"
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            statusFrame.BorderColor3 = Color3.fromRGB(255, 200, 100)
        else
            statusLabel.Text = "🟢 Pronto"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            statusFrame.BorderColor3 = Color3.fromRGB(100, 255, 100)
        end
    end
end)

-- ============================================
-- RODAPÉ
-- ============================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 16)
footer.Position = UDim2.new(0, 0, 1, -5)
footer.Text = "⭐ v12.0 Completo | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 8
footer.Parent = ui.main

print("✅ Hub completo carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")