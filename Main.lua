--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO 12.0
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
    Projeto dividido em arquivos
]]

print("🎨 Carregando Blox Fruits Hub 12.0...")

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
-- CARREGA OS MÓDULOS
-- ============================================

-- Carrega os arquivos (todos no mesmo diretório)
local Config = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Config.lua'))()
local Detector = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Detector.lua'))()
local AntiBan = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/AntiBan.lua'))()
local Farm = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Farm.lua'))()
local Utils = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Utils.lua'))()
local Interface = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Interface.lua'))()

-- Carrega as categorias
local FarmCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/FarmCategory.lua'))()
local RaceCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/RaceCategory.lua'))()
local WeaponsCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/WeaponsCategory.lua'))()
local BossCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/BossCategory.lua'))()
local QuestCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/QuestCategory.lua'))()
local FishingCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/FishingCategory.lua'))()
local ConfigCategory = loadstring(game:HttpGet('https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/Categories/ConfigCategory.lua'))()

if not Config or not Detector or not AntiBan or not Farm or not Utils or not Interface then
    print("❌ Erro ao carregar módulos principais!")
    return
end

print("✅ Módulos carregados com sucesso!")

-- ============================================
-- CRIA A INTERFACE
-- ============================================

local ui = Interface.Criar(player)

-- ============================================
-- CARREGA AS CATEGORIAS
-- ============================================

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
infoLabel.Text = "🎯 Nível " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida .. "/" .. Detector.MaxVida
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

-- Atualiza Detector
Detector.Atualizar(player)
criarInfo("Maestria", Detector.Maestria .. "/600", Color3.fromRGB(255, 200, 100))
criarInfo("Nível", "Lv. " .. Detector.Nivel, Color3.fromRGB(100, 255, 100))
criarInfo("Estilo", "Combat", Color3.fromRGB(200, 150, 255))

-- Carrega as categorias
FarmCategory.Criar(ui.content, player, UserInputService, VirtualInput)
RaceCategory.Criar(ui.content)
WeaponsCategory.Criar(ui.content)
BossCategory.Criar(ui.content)
QuestCategory.Criar(ui.content)
FishingCategory.Criar(ui.content)
ConfigCategory.Criar(ui.content)

-- ============================================
-- ATUALIZA STATUS EM TEMPO REAL
-- ============================================

task.spawn(function()
    while ui.gui and ui.gui.Parent do
        task.wait(1)
        Detector.Atualizar(player)
        infoLabel.Text = "🎯 Nível " .. Detector.Nivel .. "  |  💚 " .. Detector.Vida .. "/" .. Detector.MaxVida
        
        if Farm.Ativo then
            statusLabel.Text = "⚡ Farmando... (" .. Farm.Kills .. " kills)"
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
footer.Text = "⭐ v12.0 Dividido | Marcileialves"
footer.TextColor3 = Color3.fromRGB(150, 150, 180)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.GothamMedium
footer.TextSize = 8
footer.Parent = ui.main

print("✅ Hub 12.0 carregado!")
print("📌 https://github.com/Marcileialves/Blox-Fruits-Script-Hub")