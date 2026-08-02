--[[
    CATEGORIA QUEST
]]

local QuestCategory = {}

function QuestCategory.Criar(content)
    local function criarBotao(texto, cor)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 320, 0, 30)
        btn.Text = texto
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = cor
        btn.BackgroundTransparency = 0.15
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        btn.Parent = content
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            print("▶️ " .. texto)
            task.wait(2)
            print("✅ " .. texto .. " completada!")
        end)
        
        return btn
    end
    
    local function criarSecao(texto)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 24)
        lbl.Text = "▸ " .. texto
        lbl.TextColor3 = Color3.fromRGB(100, 150, 255)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = content
        return lbl
    end
    
    criarSecao("📋 QUEST")
    
    criarBotao("Fazer Quest CDK", Color3.fromRGB(100, 150, 255))
    criarBotao("Fazer Quest Godhuman", Color3.fromRGB(100, 150, 255))
    criarBotao("Fazer Quest Soul Guitar", Color3.fromRGB(100, 150, 255))
end

return QuestCategory