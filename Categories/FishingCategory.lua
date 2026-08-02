--[[
    CATEGORIA PESCA
]]

local FishingCategory = {}

function FishingCategory.Criar(content)
    local function criarBotao(texto, cor)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.Text = texto
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = cor
        btn.BackgroundTransparency = 0.15
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 10
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.Parent = content
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            print("▶️ " .. texto)
            task.wait(2)
            print("✅ " .. texto .. " obtido!")
        end)
        
        return btn
    end
    
    -- Título
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.Text = "▸ 🐟 PESCA"
    lbl.TextColor3 = Color3.fromRGB(50, 150, 200)
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
    
    criarBotao("Pegar Fishing Rod", Color3.fromRGB(50, 150, 200))
    criarBotao("Pegar Gold Rod", Color3.fromRGB(50, 150, 200))
    criarBotao("Pescar Peixe Raro", Color3.fromRGB(50, 150, 200))
end

return FishingCategory