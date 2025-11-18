local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

function Library:CreateLib(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "exploit_ui"
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local window = Instance.new("Frame")
    window.Name = "window"
    window.Parent = ScreenGui
    window.BackgroundColor3 = Color3.fromRGB(25,25,25)
    window.Size = UDim2.new(0, 760, 0, 500)
    window.Position = UDim2.new(0.2, 0, 0.15, 0)
    window.BorderSizePixel = 0
    Instance.new("UICorner", window).CornerRadius = UDim.new(0,4)

    local drag = Instance.new("Frame")
    drag.Size = UDim2.new(1,0,0,30)
    drag.BackgroundTransparency = 1
    drag.Parent = window

    local dragging, startPos, dragInput
    drag.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = window.Position
            dragInput = input
        end
    end)
    drag.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragInput.Position
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local topbar = Instance.new("Frame")
    topbar.Name = "topbar"
    topbar.Parent = window
    topbar.BackgroundColor3 = Color3.fromRGB(35,35,35)
    topbar.Size = UDim2.new(1, -16, 0, 30)
    topbar.Position = UDim2.new(0,8,0,8)
    Instance.new("UICorner", topbar).CornerRadius = UDim.new(0,3)

    local tabsfolder = Instance.new("Folder")
    tabsfolder.Name = "tabsfolder"
    tabsfolder.Parent = window

    local tabs = {}

    local function selectTab(tab)
        for _, v in pairs(tabsfolder:GetChildren()) do
            v.Visible = false
        end
        tab.Visible = true
    end

    function tabs:NewTab(name)
        local tabbtn = Instance.new("TextButton")
        tabbtn.Parent = topbar
        tabbtn.BackgroundColor3 = Color3.fromRGB(41,41,41)
        tabbtn.Size = UDim2.new(0, 110, 1, 0)
        tabbtn.Position = UDim2.new(0, (#topbar:GetChildren()-1)*115, 0, 0)
        tabbtn.Text = name
        tabbtn.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
        tabbtn.TextColor3 = Color3.fromRGB(255,255,255)
        tabbtn.TextSize = 32
        tabbtn.BorderSizePixel = 0
        Instance.new("UICorner", tabbtn).CornerRadius = UDim.new(0,3)
        local stroke = Instance.new("UIStroke", tabbtn)
        stroke.Thickness = 2

        local content = Instance.new("ScrollingFrame")
        content.Parent = tabsfolder
        content.Size = UDim2.new(1, -30, 1, -60)
        content.Position = UDim2.new(0,15,0,45)
        content.BackgroundTransparency = 1
        content.ScrollBarThickness = 4
        content.CanvasSize = UDim2.new(0,0,0,0)
        content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        content.Visible = false

        local layout = Instance.new("UIListLayout")
        layout.Parent = content
        layout.Padding = UDim.new(0,8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        tabbtn.MouseButton1Click:Connect(function()
            selectTab(content)
        end)

        if #tabsfolder:GetChildren() == 0 then
            content.Visible = true
        end

        local tab = {}

        function tab:NewSection(sectionname)
            local section = Instance.new("Frame")
            section.Parent = content
            section.BackgroundColor3 = Color3.fromRGB(35,35,35)
            section.Size = UDim2.new(1, -10, 0, 40)
            section.AutomaticSize = Enum.AutomaticSize.Y

            local corner = Instance.new("UICorner", section)
            corner.CornerRadius = UDim.new(0,3)

            local title = Instance.new("TextLabel")
            title.Parent = section
            title.BackgroundTransparency = 1
            title.Size = UDim2.new(1,0,0,35)
            title.Position = UDim2.new(0,10,0,0)
            title.Text = " " .. sectionname
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
            title.TextColor3 = Color3.fromRGB(255,255,255)
            title.TextSize = 30

            local stroke2 = Instance.new("UIStroke", title)
            stroke2.Thickness = 1.5

            local container = Instance.new("Frame")
            container.Parent = section
            container.BackgroundTransparency = 1
            container.Position = UDim2.new(0,5,0,40)
            container.Size = UDim2.new(1,-10,0,0)
            container.AutomaticSize = Enum.AutomaticSize.Y

            local list = Instance.new("UIListLayout", container)
            list.Padding = UDim.new(0,6)

            local sec = {}

            function sec:NewButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Parent = container
                btn.BackgroundColor3 = Color3.fromRGB(41,41,41)
                btn.Size = UDim2.new(1,0,0,45)
                btn.Text = text
                btn.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.TextSize = 32
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0,3)
                local st = Instance.new("UIStroke", btn)
                st.Thickness = 2
                btn.MouseButton1Click:Connect(callback or function() end)
            end

            function sec:NewToggle(text, default, callback)
                local toggle = Instance.new("TextButton")
                toggle.Parent = container
                toggle.BackgroundColor3 = Color3.fromRGB(41,41,41)
                toggle.Size = UDim2.new(1,0,0,45)
                toggle.Text = text .. (default and " [ON]" or " [OFF]")
                toggle.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                toggle.TextColor3 = Color3.fromRGB(255,255,255)
                toggle.TextSize = 32
                Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,3)
                local st = Instance.new("UIStroke", toggle)
                st.Thickness = 2

                local state = default or false
                toggle.MouseButton1Click:Connect(function()
                    state = not state
                    toggle.Text = text .. (state and " [ON]" or " [OFF]")
                    if callback then callback(state) end
                end)
            end

            function sec:NewSlider(text, min, max, default, callback)
                local sliderframe = Instance.new("Frame")
                sliderframe.Parent = container
                sliderframe.BackgroundColor3 = Color3.fromRGB(41,41,41)
                sliderframe.Size = UDim2.new(1,0,0,60)
                Instance.new("UICorner", sliderframe).CornerRadius = UDim.new(0,3)
                Instance.new("UIStroke", sliderframe).Thickness = 2

                local label = Instance.new("TextLabel")
                label.Parent = sliderframe
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1,0,0,30)
                label.Text = text .. ": " .. (default or min)
                label.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                label.TextColor3 = Color3.fromRGB(255,255,255)
                label.TextSize = 30

                local slider = Instance.new("TextButton")
                slider.Parent = sliderframe
                slider.Position = UDim2.new(0,10,0,30)
                slider.Size = UDim2.new(1,-20,0,20)
                slider.BackgroundColor3 = Color3.fromRGB(60,60,60)
                slider.Text = ""
                Instance.new("UICorner", slider).CornerRadius = UDim.new(0,10)

                local fill = Instance.new("Frame")
                fill.Parent = slider
                fill.BackgroundColor3 = Color3.fromRGB(100,100,255)
                fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
                Instance.new("UICorner", fill).CornerRadius = UDim.new(0,10)

                local dragging = false
                slider.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
                slider.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
                UserInputService.InputChanged:Connect(function(i)
                    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                        local percent = math.clamp((i.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                        fill.Size = UDim2.new(percent,0,1,0)
                        local value = math.floor(min + (max - min) * percent)
                        label.Text = text .. ": " .. value
                        if callback then callback(value) end
                    end
                end)
            end

            function sec:NewTextBox(text, callback)
                local box = Instance.new("TextBox")
                box.Parent = container
                box.BackgroundColor3 = Color3.fromRGB(41,41,41)
                box.Size = UDim2.new(1,0,0,45)
                box.PlaceholderText = text
                box.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                box.TextColor3 = Color3.fromRGB(255,255,255)
                box.TextSize = 32
                Instance.new("UICorner", box).CornerRadius = UDim.new(0,3)
                Instance.new("UIStroke", box).Thickness = 2
                box.FocusLost:Connect(function(enter)
                    if enter and callback then callback(box.Text) end
                end)
            end

            function sec:NewKeybind(text, defaultkey, callback)
                local bind = Instance.new("TextButton")
                bind.Parent = container
                bind.BackgroundColor3 = Color3.fromRGB(41,41,41)
                bind.Size = UDim2.new(1,0,0,45)
                bind.Text = text .. " [" .. tostring(defaultkey or "None"):sub(14) .. "]"
                bind.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                bind.TextColor3 = Color3.fromRGB(255,255,255)
                bind.TextSize = 32
                Instance.new("UICorner", bind).CornerRadius = UDim.new(0,3)
                Instance.new("UIStroke", bind).Thickness = 2

                local listening = false
                bind.MouseButton1Click:Connect(function()
                    listening = true
                    bind.Text = text .. " [ ... ]"
                end)

                UserInputService.InputBegan:Connect(function(input)
                    if listening and input.KeyCode ~= Enum.KeyCode.Unknown then
                        listening = false
                        bind.Text = text .. " [" .. input.KeyCode.Name .. "]"
                        if callback then callback(input.KeyCode) end
                    end
                end)
            end

            function sec:NewDropdown(text, options, callback)
                local drop = Instance.new("TextButton")
                drop.Parent = container
                drop.BackgroundColor3 = Color3.fromRGB(41,41,41)
                drop.Size = UDim2.new(1,0,0,45)
                drop.Text = text .. " >"
                drop.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                drop.TextColor3 = Color3.fromRGB(255,255,255)
                drop.TextSize = 32
                Instance.new("UICorner", drop).CornerRadius = UDim.new(0,3)
                Instance.new("UIStroke", drop).Thickness = 2

                local list = Instance.new("Frame")
                list.Parent = drop
                list.BackgroundColor3 = Color3.fromRGB(35,35,35)
                list.Size = UDim2.new(1,0,0,0)
                list.Position = UDim2.new(0,0,1,5)
                list.Visible = false
                list.ZIndex = 10
                Instance.new("UICorner", list).CornerRadius = UDim.new(0,3)

                local uilist = Instance.new("UIListLayout", list)

                drop.MouseButton1Click:Connect(function()
                    list.Visible = not list.Visible
                    list.Size = UDim2.new(1,0,0, #options*40)
                end)

                for _, opt in pairs(options) do
                    local optbtn = Instance.new("TextButton")
                    optbtn.Parent = list
                    optbtn.BackgroundColor3 = Color3.fromRGB(41,41,41)
                    optbtn.Size = UDim2.new(1,0,0,40)
                    optbtn.Text = opt
                    optbtn.FontFace = Font.new("rbxasset://fonts/families/Oswald.json")
                    optbtn.TextColor3 = Color3.fromRGB(255,255,255)
                    optbtn.TextSize = 30
                    Instance.new("UICorner", optbtn).CornerRadius = UDim.new(0,3)
                    optbtn.MouseButton1Click:Connect(function()
                        drop.Text = text .. " > " .. opt
                        list.Visible = false
                        if callback then callback(opt) end
                    end)
                end
            end

            return sec
        end

        return tab
    end

    return tabs
end

return Library
