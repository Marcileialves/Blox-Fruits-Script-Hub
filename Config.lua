--[[
    CONFIGURAÇÕES DO USUÁRIO
    GitHub: https://github.com/Marcileialves/Blox-Fruits-Script-Hub
]]

local Config = {}

Config.Settings = {
    -- Anti-Ban
    AntiBan = {
        Enabled = true,
        SecurityLevel = "ALTO", -- BAIXO, MÉDIO, ALTO
        RandomPauses = true,
        HumanBehavior = true,
        ActionRotation = true
    },
    
    -- Farm
    Farm = {
        AutoTeleport = true,
        UseBestFruit = true,
        Use2xExp = true,
        TargetLevel = 3000
    },
    
    -- Server
    Server = {
        AutoSwitch = true,
        Priority = "BR",
        TimeBetweenSwitches = 30,
        AutoReconnect = true
    },
    
    -- Interface
    Interface = {
        Theme = "ESCURO",
        MinimizeOnAction = true,
        Notifications = true
    }
}

return Config