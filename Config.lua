--[[
    CONFIGURAÇÕES GLOBAIS
]]

local Config = {}

Config.Versao = "12.0"
Config.Autor = "Marcileialves"
Config.GitHub = "https://github.com/Marcileialves/Blox-Fruits-Script-Hub"

-- Configurações do Farm
Config.Farm = {
    AutoTeleport = true,
    AutoCura = true,
    VidaMinimaCura = 30,
    TargetLevel = 3000,
}

-- Configurações do Anti-Ban
Config.AntiBan = {
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
}

-- Ilhas do jogo
Config.Ilhas = {
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

return Config