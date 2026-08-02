--[[
    CRIAÇÃO DA INTERFACE
]]

local Interface = {}

function Interface.Criar(player, Detector, Config)
    Detector.Atualizar(player)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "BloxFruitsHub"
    gui.Parent = player.PlayerGui
    gui.ResetOnSpawn = false
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 360, 0, 520)
    main.Position = UDim2.new(0.5, -180, 0.5, -260)
    main.BackgroundColor3 = Color3.fromRGB(8, 8, 28)
    main.BorderSizePixel = 2
    main.BorderColor3 = Color3.fromRGB(255, 215, 0)
    main.Parent = gui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 14)
    mainCorner.Parent = main
    
    -- Topo
    local topo = Instance.new("Frame")
    topo.Size = UDim2.new(1, 0, 0, 45)
    topo.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    topo.BackgroundTransparency = 0.1
    topo.BorderSizePixel = 0
    topo.Parent = main
    
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(1, 0, 0, 45)
    logo.Text = "⚓ BLOX FRUITS"
    logo.TextColor3 = Color3.fromRGB(255, 215, 0)
    logo.BackgroundTransparency = 1
    logo.Font = Enum.Font.GothamBold
    logo.TextSize = 18
    logo.Parent = topo
    
    local versao = Instance.new("TextLabel")
    versao.Size = UDim2.new(0, 60, 0, 20)
    versao.Position = UDim2.new(1, -65, 0, 4)
    versao.Text = "v" .. Config.Versao
    versao.TextColor3 = Color3.fromRGB(180, 180, 220)
    versao.BackgroundTransparency = 1
    versao.Font = Enum.Font.GothamMedium
    versao.TextSize = 10
    versao.TextXAlignment = Enum.TextXAlignment.Right
    versao.Parent = topo
    
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
    exitBtn.Parent = main
    
    local exitCorner = Instance.new("UICorner")
    exitCorner.CornerRadius = UDim.new(0, 6)
    exitCorner.Parent = exitBtn
    
    exitBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
        print("👋 Hub fechado!")
    end)
    
    -- Área de conteúdo
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -10, 1, -95)
    content.Position = UDim2.new(0, 5, 0, 50)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 2
    content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
    content.Parent = main
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 4)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content
    
    return {
        gui = gui,
        main = main,
        content = content,
        topo = topo,
        logo = logo,
        exitBtn = exitBtn,
    }
end

return Interface