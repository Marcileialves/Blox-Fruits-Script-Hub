--[[
    CATEGORIA FARM
]]

local FarmCategory = {}

function FarmCategory.Criar(content, player, UserInputService, VirtualInput)
    -- Título
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.Text = "▸ ⚡ CONTROLES"
    lbl.TextColor3 = Color3.fromRGB(0, 200, 255)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = content
    
    -- Separador
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.Position = UDim2.new(0, 5, 0, 0)
    sep.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    sep.BackgroundTransparency = 0.5
    sep.BorderSizePixel = 0
    sep.Parent = content
    
    -- Botão Farm
    local btn1 = Instance.new("TextButton")
    btn1.Size = UDim2.new(1, 0, 0, 36)
    btn1.Text = "⚡ FARMAR NÍVEL MÁXIMO"
    btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn1.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    btn1.BackgroundTransparency = 0.15
    btn1.Font = Enum.Font.GothamBold
    btn1.TextSize = 12
    btn1.TextXAlignment = Enum.TextXAlignment.Left
    btn1.BorderSizePixel = 1
    btn1.BorderColor3 = Color3.fromRGB(0, 200, 100)
    btn1.Parent = content
    
    local btn1Corner = Instance.new("UICorner")
    btn1Corner.CornerRadius = UDim.new(0, 8)
    btn1Corner.Parent = btn1
    
    btn1.MouseButton1Click:Connect(function()
        Farm.Iniciar(player, UserInputService, VirtualInput)
    end)
    
    -- Botão Parar
    local btn2 = Instance.new("TextButton")
    btn2.Size = UDim2.new(1, 0, 0, 36)
    btn2.Text = "⏹ PARAR FARM"
    btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn2.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    btn2.BackgroundTransparency = 0.15
    btn2.Font = Enum.Font.GothamBold
    btn2.TextSize = 12
    btn2.TextXAlignment = Enum.TextXAlignment.Left
    btn2.BorderSizePixel = 1
    btn2.BorderColor3 = Color3.fromRGB(255, 80, 80)
    btn2.Parent = content
    
    local btn2Corner = Instance.new("UICorner")
    btn2Corner.CornerRadius = UDim.new(0, 8)
    btn2Corner.Parent = btn2
    
    btn2.MouseButton1Click:Connect(function()
        Farm.Parar()
    end)
    
    -- Botão Curar
    local btn3 = Instance.new("TextButton")
    btn3.Size = UDim2.new(1, 0, 0, 36)
    btn3.Text = "💚 CURAR"
    btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn3.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    btn3.BackgroundTransparency = 0.15
    btn3.Font = Enum.Font.GothamBold
    btn3.TextSize = 12
    btn3.TextXAlignment = Enum.TextXAlignment.Left
    btn3.BorderSizePixel = 1
    btn3.BorderColor3 = Color3.fromRGB(50, 200, 100)
    btn3.Parent = content
    
    local btn3Corner = Instance.new("UICorner")
    btn3Corner.CornerRadius = UDim.new(0, 8)
    btn3Corner.Parent = btn3
    
    btn3.MouseButton1Click:Connect(function()
        Utils.Curar(player)
    end)
    
    -- Botão Info
    local btn4 = Instance.new("TextButton")
    btn4.Size = UDim2.new(1, 0, 0, 36)
    btn4.Text = "📊 INFORMAÇÕES"
    btn4.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn4.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    btn4.BackgroundTransparency = 0.15
    btn4.Font = Enum.Font.GothamBold
    btn4.TextSize = 12
    btn4.TextXAlignment = Enum.TextXAlignment.Left
    btn4.BorderSizePixel = 1
    btn4.BorderColor3 = Color3.fromRGB(100, 150, 255)
    btn4.Parent = content
    
    local btn4Corner = Instance.new("UICorner")
    btn4Corner.CornerRadius = UDim.new(0, 8)
    btn4Corner.Parent = btn4
    
    btn4.MouseButton1Click:Connect(function()
        Utils.MostrarInfo(player)
    end)
end

return FarmCategory