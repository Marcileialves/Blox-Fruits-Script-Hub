--[[
    BLOX FRUITS SCRIPT HUB - VERSÃO MODULAR
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

print("🔥 Carregando Blox Fruits Hub (Modular)...")

local player = game.Players.LocalPlayer

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
-- CARREGA OS MÓDULOS
-- ============================================

local baseUrl = "https://raw.githubusercontent.com/Marcileialves/Blox-Fruits-Script-Hub/main/"

local function carregar(nome, url)
    print("📥 Carregando: " .. nome .. "...")
    local sucesso, modulo = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if sucesso and modulo then
        print("✅ " .. nome .. " carregado!")
        return modulo
    else
        print("❌ Falha ao carregar " .. nome)
        return nil
    end
end

-- Carrega os módulos
local Config = carregar("Config", baseUrl .. "Config.lua")
local Detector = carregar("Detector", baseUrl .. "Detector.lua")
local AntiBan = carregar("AntiBan", baseUrl .. "AntiBan.lua")
local Farm = carregar("Farm", baseUrl .. "Farm.lua")
local Utils = carregar("Utils", baseUrl .. "Utils.lua")
local Interface = carregar("Interface", baseUrl .. "Interface.lua")

-- Carrega as categorias
local FarmCategory = carregar("FarmCategory", baseUrl .. "Categories/FarmCategory.lua")
local RaceCategory = carregar("RaceCategory", baseUrl .. "Categories/RaceCategory.lua")
local WeaponsCategory = carregar("WeaponsCategory", baseUrl .. "Categories/WeaponsCategory.lua")
local BossCategory = carregar("BossCategory", baseUrl .. "Categories/BossCategory.lua")
local QuestCategory = carregar("QuestCategory", baseUrl .. "Categories/QuestCategory.lua")
local FishingCategory = carregar("FishingCategory", baseUrl .. "Categories/FishingCategory.lua")
local ConfigCategory = carregar("ConfigCategory", baseUrl .. "Categories/ConfigCategory.lua")

if not Config or not Detector or not Farm or not Utils or not Interface then
    print("❌ Erro: Módulos principais não carregaram!")
    return
end

print("✅ Todos os módulos carregados!")

-- ============================================
-- CRIA A INTERFACE
-- ============================================

local ui = Interface.Criar(player, Detector, Config)

-- ============================================
-- CARREGA AS CATEGORIAS
-- ============================================

if FarmCategory then FarmCategory.Criar(ui.content, player, Farm, AntiBan, Utils) end
if RaceCategory then RaceCategory.Criar(ui.content) end
if WeaponsCategory then WeaponsCategory.Criar(ui.content) end
if BossCategory then BossCategory.Criar(ui.content) end
if QuestCategory then QuestCategory.Criar(ui.content) end
if FishingCategory then FishingCategory.Criar(ui.content) end
if ConfigCategory then ConfigCategory.Criar(ui.content, Config) end

print("✅ Hub carregado com sucesso!")
print("📌 GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub")