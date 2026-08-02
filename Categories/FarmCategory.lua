--[[
    CATEGORIA FARM
]]

local FarmCategory = {}

function FarmCategory.Criar(content, player, Farm, AntiBan, Utils)
    local function criarBotao(texto, cor, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 320, 0, 36)
        btn.Text = texto
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = cor
        btn.BackgroundTransparency = 0.15
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.BorderSizePixel = 1
        btn.BorderColor3 = cor
        btn.Parent = content
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            print("▶️ " .. texto)
            if callback then pcall(callback) end
        end)
        
        return btn
    end
    
    local function criarSecao(texto)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 24)
        lbl.Text = "▸ " .. texto
        lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = content
        return lbl
    end
    
    criarSecao("⚡ CONTROLES")
    
    criarBotao("⚡ FARMAR NÍVEL MÁXIMO", Color3.fromRGB(0, 200, 100), function()
        Farm.Iniciar(player, require(script.Parent.Parent.Detector), require(script.Parent.Parent.AntiBan), require(script.Parent.Parent.Config))
    end)
    criarBotao("⏹ PARAR FARM", Color3.fromRGB(255, 80, 80), Farm.Parar)
    criarBotao("💚 CURAR", Color3.fromRGB(50, 200, 100), function()
        Utils.Curar(player)
    end)
    criarBotao("📊 INFORMAÇÕES", Color3.fromRGB(100, 150, 255), function()
        Utils.MostrarInfo(player, require(script.Parent.Parent.Detector), Farm)
    end)
end

return FarmCategory