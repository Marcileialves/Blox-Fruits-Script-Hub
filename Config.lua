--[[
    CONFIGURAÇÕES GLOBAIS
]]

local Config = {}

Config.Versao = "12.0"
Config.Autor = "Marcileialves"
Config.GitHub = "https://github.com/Marcileialves/Blox-Fruits-Script-Hub"

Config.Farm = {
    AutoTeleport = true,
    AutoCura = true,
    VidaMinimaCura = 30,
    TargetLevel = 3000,
}

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

return Config