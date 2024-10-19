local EuphoriaUI = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

local accentColor1 = Color3.fromRGB(255,255,255)
local accentColor2 = Color3.fromRGB(59,61,67)
local backgroundColor1 = Color3.fromRGB(25,26,28)
local backgroundColor2 = Color3.fromRGB(42,44,47)
local activeColor = Color3.fromRGB(144,90,237)
local inactiveColor = Color3.fromRGB(25,26,28)
local fontWeightTitle = Enum.FontWeight.Bold
local fontWeightDefault = Enum.FontWeight.Medium
local fontSizeTitle = 36
local fontSizeButton = 20
local fontSizeDefault = 22
local fontSizeSection = 24
local baseName = "EuphoriaUILib"


function EuphoriaUI:DraggingEnabled(frame, parent) 
    parent = parent or frame
    
    -- stolen from wally or kiriot, kek
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end


local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function EuphoriaUI:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

function EuphoriaUI:Destroy()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:FindFirstChild(baseName .. "DestroyTag") then
            v:Destroy()
            break
        end
    end
end

function EuphoriaUI.CreateLib(Title)
    sizeX = 800 
    sizeY = 620
    EuphoriaUI:Destroy()
    local ScreenGuiMainButton = Instance.new("ScreenGui")
    local MainButton = Instance.new("Frame")
    local ImgButton = Instance.new("ImageButton")
    ScreenGuiMainButton.Parent = game.CoreGui
    ScreenGuiMainButton.Name = LibName .. "Btn"
    ScreenGuiMainButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGuiMainButton.ResetOnSpawn = false
    
    MainButton.Name = "LibOpenMenu"
    MainButton.Parent = ScreenGuiMainButton
    MainButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
    MainButton.BackgroundTransparency = 1
    MainButton.ClipsDescendants = false
    MainButton.Position = UDim2.new(0.15, 0, 0.15, 0)
    MainButton.Size = UDim2.new(0, 60, 0, 60)
    
    EuphoriaUI:DraggingEnabled(ImgButton, MainButton)
    ImgButton.Name = "ImButtonLib"
    ImgButton.Parent = MainButton
    ImgButton.BackgroundTransparency = 0
    ImgButton.BorderSizePixel = 5
    ImgButton.BorderColor3 = Color3.fromRGB(131,131,131)
    ImgButton.BorderMode = Enum.BorderMode.Outline
    ImgButton.Position = UDim2.new(0.1,0.1)
    ImgButton.Size = UDim2.new(0, 50, 0, 50)
    ImgButton.ZIndex = -1
    ImgButton.Image = "rbxassetid://17375678788"
    ImgButton.ImageRectOffset = Vector2.new(0)
    ImgButton.ImageRectSize = Vector2.new(50,50)
    ImgButton.MouseButton1Click:Connect(function()
        EuphoriaUI:ToggleUI()
    end)

    local ImBUICorner = Instance.new("UICorner")
    ImBUICorner.Parent = MainButton
    ImBUICorner.CornerRadius = UDim.new(30,40)

    local ImBUICorner2 = Instance.new("UICorner")
    ImBUICorner2.Parent = ImgButton
    ImBUICorner2.CornerRadius = UDim.new(30,40)

    local ScreenGui = Instance.new("ScreenGui")

    local UserInputService = game:GetService("UserInputService")
    

    local DestroyTag = Instance.new("Frame")
    local FrameMain = Instance.new("Frame")
    
    local FrameBody = Instance.new("Frame")
    local FrameBodyLine = Instance.new("Frame")
    local FrameTabs = Instance.new("ScrollingFrame")
    local FrameTabsListing = Instance.new("UIListLayout")
    local FramePage = Instance.new("Frame")
    local FrameTitle = Instance.new("TextLabel")
    local FrameTitleLine = Instance.new("Frame")
    local FrameTitleHideButton = Instance.new("TextButton")

    local FramePages = Instance.new("Frame")
    local FramePagesFolder = Instance.new("Folder")
    
    
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    DestroyTag.Name = baseName .. "DestroyTag"
    DestroyTag.Parent = ScreenGui
    DestroyTag.BackgroundTransparency = 1

    FrameMain.Name = baseName .. "Main"
    FrameMain.Parent = ScreenGui
    FrameMain.BackgroundTransparency = 0
    FrameMain.BackgroundColor3 = backgroundColor2
    FrameMain.ClipsDescendants = true
    FrameMain.Position = UDim2.new(0.5, (sizeX/2) - sizeX, 0.5, (sizeY/2) - sizeY)
    FrameMain.Size = UDim2.new(0, sizeX, 0, sizeY)
    EuphoriaUI:DraggingEnabled(FrameMain, FrameMain)

    local FrameMainCorner = Instance.new("UICorner")
    FrameMainCorner.CornerRadius = UDim.new(0,10)
    FrameMainCorner.Parent = FrameMain

    FrameTitle.Text = Title
    FrameTitle.Position = UDim2.new(0, 10, 0, 10)
    FrameTitle.FontFace = Font.fromName("Montserrat", fontWeightTitle)
    FrameTitle.RichText = false
    FrameTitle.Parent = FrameMain
    FrameTitle.BackgroundTransparency = 1
    FrameTitle.TextColor3 = accentColor1
    FrameTitle.Size = UDim2.new(0,730,0,44)
    FrameTitle.TextSize = fontSizeTitle
    FrameTitle.TextXAlignment = Enum.TextXAlignment.Left

    FrameTitleHideButton.Size = UDim2.new(0,40,0,40)
    FrameTitleHideButton.Text = "X"
    FrameTitleHideButton.Position = UDim2.new(0,747,0,9)
    FrameTitleHideButton.Parent = FrameMain
    FrameTitleHideButton.FontFace = Font.fromName("Arimo", fontWeightTitle)
    FrameTitleHideButton.RichText = false
    FrameTitleHideButton.TextSize = fontSizeTitle
    FrameTitleHideButton.TextColor3 = accentColor1
    FrameTitleHideButton.BackgroundColor3 = accentColor2
    FrameTitleHideButton.TextXAlignment = Enum.TextXAlignment.Center
    local FrameTitleHideButtonCorner = Instance.new("UICorner")
    FrameTitleHideButtonCorner.Parent = FrameTitleHideButton
    FrameTitleHideButtonCorner.CornerRadius = UDim.new(0,10)
    FrameTitleHideButton.MouseButton1Click:Connect(function()
        -- game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        --     ImageTransparency = 1
        -- }):Play()
        -- wait()
        -- game.TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		-- 	Size = UDim2.new(0,0,0,0),
		-- 	Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2))
		-- }):Play()
        -- wait(1)
        EuphoriaUI:ToggleUI()
    end)

    FrameTitleLine.Parent = FrameMain
    FrameTitleLine.BackgroundTransparency = 0
    FrameTitleLine.BackgroundColor3 = accentColor1
    FrameTitleLine.Size = UDim2.new(0,780,0,1)
    FrameTitleLine.Position = UDim2.new(0, 10, 0, 58)

    FrameBody.Size = UDim2.new(0,800,0,530)
    FrameBody.Parent = FrameMain
    FrameBody.BorderSizePixel = 0
    FrameBody.BackgroundColor3 = backgroundColor1
    FrameBody.ClipsDescendants = true
    FrameBody.Position = UDim2.new(0,0,0,70)

    FrameBodyLine.Parent = FrameBody
    FrameBodyLine.BackgroundTransparency = 0
    FrameBodyLine.BackgroundColor3 = accentColor1
    FrameBodyLine.Size = UDim2.new(0,1,0,514)
    FrameBodyLine.Position = UDim2.new(0, 230, 0, 7)

    FrameTabs.Parent = FrameBody
    FrameTabs.Size = UDim2.new(0,230,0,525)
    FrameTabs.Position = UDim2.new(0, 5, 0, 5)
    FrameTabs.BackgroundTransparency = 1
    FrameTabs.ScrollBarThickness = 5
    FrameTabs.ScrollBarImageColor3 = accentColor2
    
    FrameTabsListing.Name = "tabListing"
    FrameTabsListing.Parent = FrameTabs
    FrameTabsListing.SortOrder = Enum.SortOrder.LayoutOrder
    FrameTabsListing.Padding = UDim.new(0,5)

    FramePages.Name = "pages"
    FramePages.Parent = FrameBody
    FramePages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FramePages.BackgroundTransparency = 1.000
    FramePages.BorderSizePixel = 0
    FramePages.Position = UDim2.new(0, 245, 0, 8)
    FramePages.Size = UDim2.new(0, 550, 0, 507)


    FramePagesFolder.Name = "Pages"
    FramePagesFolder.Parent = FramePages

    local Tabs = {}

    local first = true

        function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local tabButtonUICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize
            game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
            }):Play()
            local cS = FrameTabsListing.AbsoluteContentSize
            game.TweenService:Create(FrameTabs, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
            }):Play()
        end
                
        page.Name = "Page"
        page.Parent = FramePagesFolder
        page.Active = true
        page.BackgroundColor3 = backgroundColor1
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.Position = UDim2.new(0, 0, 0, 0)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        page.ScrollBarImageColor3 = accentColor2

        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)

        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = FrameTabs
        tabButton.BackgroundColor3 = backgroundColor2
        tabButton.Size = UDim2.new(0, 220, 0, 38)
        tabButton.AutoButtonColor = false
        tabButton.FontFace = Font.fromName("Montserrat", fontWeightDefault)
        tabButton.RichText = false
        tabButton.Text = tabName
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.TextColor3 = accentColor1
        tabButton.TextSize = fontSizeButton
        tabButton.BackgroundTransparency = 0
        tabButtonUICorner.CornerRadius = UDim.new(0, 5.83)
        tabButtonUICorner.Parent = tabButton
        table.insert(Tabs, tabName)


        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 20) -- ÐžÑ‚ÑÑ‚ÑƒÐ¿ ÑÐ»ÐµÐ²Ð° Ð½Ð° 10 Ð¿Ð¸ÐºÑÐµÐ»ÐµÐ¹
        padding.Parent = tabButton

        local highlightActive = Instance.new("Frame")
        highlightActive.Name = "highlightActive"
        highlightActive.Size = UDim2.new(0, 10, 0, 25) -- Ð£Ð¼ÐµÐ½ÑŒÑˆÐ°ÐµÐ¼ Ð²Ñ‹ÑÐ¾Ñ‚Ñƒ highlight 
        highlightActive.Position = UDim2.new(0, -15, 0, 7.67) -- Ð¡Ñ‚Ð°Ð²Ð¸Ð¼ Ð¿Ð¾ÑÐµÑ€ÐµÐ´Ð¸Ð½Ðµ Ð¿Ð¾ Ð²Ñ‹ÑÐ¾Ñ‚Ðµ ÐºÐ½Ð¾Ð¿ÐºÐ¸
        highlightActive.BackgroundColor3 = activeColor
        highlightActive.BackgroundTransparency = 0
        highlightActive.Visible = false
        highlightActive.Parent = tabButton
        highlightActive.BorderSizePixel = 0

        local highlightInactive = Instance.new("Frame")
        highlightInactive.Name = "highlightInactive"
        highlightInactive.Size = UDim2.new(0, 10, 0, 25) -- Ð£Ð¼ÐµÐ½ÑŒÑˆÐ°ÐµÐ¼ Ð²Ñ‹ÑÐ¾Ñ‚Ñƒ highlight
        highlightInactive.Position = UDim2.new(0, -15, 0, 7.67) -- Ð¡Ñ‚Ð°Ð²Ð¸Ð¼ Ð¿Ð¾ÑÐµÑ€ÐµÐ´Ð¸Ð½Ðµ Ð¿Ð¾ Ð²Ñ‹ÑÐ¾Ñ‚Ðµ ÐºÐ½Ð¾Ð¿ÐºÐ¸
        highlightInactive.BackgroundColor3 = inactiveColor
        highlightInactive.BackgroundTransparency = 0
        highlightInactive.Visible = false
        highlightInactive.Parent = tabButton
        highlightInactive.BorderSizePixel = 0

        local highlightActiveCorner = Instance.new("UICorner")
        highlightActiveCorner.CornerRadius = UDim.new(0, 3.5) -- Ð Ð°Ð´Ð¸ÑƒÑ ÑƒÐ³Ð»Ð¾Ð² Ð² 45 Ð¿Ð¸ÐºÑÐµÐ»ÐµÐ¹
        highlightActiveCorner.Parent = highlightActive

        local highlightInactiveCorner = Instance.new("UICorner")
        highlightInactiveCorner.CornerRadius = UDim.new(0, 3.5) -- Ð Ð°Ð´Ð¸ÑƒÑ ÑƒÐ³Ð»Ð¾Ð² Ð² 45 Ð¿Ð¸ÐºÑÐµÐ»ÐµÐ¹
        highlightInactiveCorner.Parent = highlightInactive

        if first then
            first = false
            page.Visible = true
            highlightActive.Visible = true
            tabButton.BackgroundColor3 = accentColor2
            UpdateSize()
        else
            page.Visible = false
            highlightActive.Visible = false
            highlightInactive.Visible = true
            UpdateSize()
        end
        
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for i, v in next, FramePagesFolder:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            -- Ð£Ð±Ð¸Ñ€Ð°ÐµÐ¼ Ð²Ñ‹Ð´ÐµÐ»ÐµÐ½Ð¸Ðµ ÑÐ¾ Ð²ÑÐµÑ… ÐºÐ½Ð¾Ð¿Ð¾Ðº
            for _, sibling in ipairs(FrameTabs:GetChildren()) do
                if sibling:IsA("TextButton") then
                    if sibling:FindFirstChild("highlightActive") and sibling:FindFirstChild("highlightInactive") then
                        sibling:FindFirstChild("highlightActive").Visible = false
                        sibling:FindFirstChild("highlightInactive").Visible = true
                    end
                    sibling.BackgroundColor3 = backgroundColor2
                end
            end
            -- Ð’ÐºÐ»ÑŽÑ‡Ð°ÐµÐ¼ Ð²Ñ‹Ð´ÐµÐ»ÐµÐ½Ð¸Ðµ Ð´Ð»Ñ Ð½Ð°Ð¶Ð°Ñ‚Ð¾Ð¹ ÐºÐ½Ð¾Ð¿ÐºÐ¸
            highlightActive.Visible = true
            highlightInactive.Visible = false
            tabButton.BackgroundColor3 = accentColor2
        end)

        local Sections = {}
        local focusing = false
        local viewDe = false
    
        function Sections:NewSection(secName)
            secName = secName or "Section"
            local sectionFunctions = {}
            local modules = {}
            local sectionFrame = Instance.new("Frame")
            local sectionlistoknvm = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sHeadCorner = Instance.new("UICorner")
            local sectionName = Instance.new("TextLabel")
            local sectionInners = Instance.new("Frame")
            local sectionElListing = Instance.new("UIListLayout")

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.BorderSizePixel = 0
            sectionFrame.Size = UDim2.new(0,535,1,0)
            sectionInners.Position = UDim2.new(0, 5, 0, 10)

            
            sectionlistoknvm.Name = "sectionlistoknvm"
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0, 5)

            for i,v in pairs(sectionInners:GetChildren()) do
                while wait() do
                    if v:IsA("Frame") or v:IsA("TextButton") then
                        function size(pro)
                            if pro == "Size" then
                                UpdateSize()
                                updateSectionFrame()
                            end
                        end
                        v.Changed:Connect(size)
                    end
                end
            end
            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundTransparency = 1
            sectionHead.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionHead.Size = UDim2.new(0, 450, 0, 37)

            sHeadCorner.CornerRadius = UDim.new(0, 4)
            sHeadCorner.Name = "sHeadCorner"
            sHeadCorner.Parent = sectionHead

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BackgroundTransparency = 1
            sectionName.BorderSizePixel = 0
            sectionName.Position = UDim2.new(0, 2, 0, 0)
            sectionName.Size = UDim2.new(1, 0, 1, 0)
            sectionName.FontFace = Font.fromName("Montserrat", Enum.FontWeight.ExtraBold)
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = accentColor1
            sectionName.TextSize = fontSizeSection
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
               
            sectionInners.Name = "sectionInners"
            sectionInners.BorderSizePixel = 0
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
            sectionInners.BackgroundTransparency = 1
            sectionInners.Position = UDim2.new(0, 5, 0, 45)

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 5)


            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, frameSc.X, 0, frameSc.Y)
            end
            updateSectionFrame()
            UpdateSize()
            local Elements = {}
            function Elements:NewButton(bname,callback)
                showLogo = showLogo or true
                local ButtonFunction = {}
                tipINf = tipINf or "Tip: Clicking this nothing will happen!"
                bname = bname or "Click Me!"
                callback = callback or function() end
            
                local buttonElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local btnInfo = Instance.new("TextLabel")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")
            
                table.insert(modules, bname)
            
                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.BackgroundColor3 = accentColor2
                buttonElement.BackgroundTransparency = 0.2
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(0, 530, 0, 45)
                buttonElement.AutoButtonColor = false
                buttonElement.Font = Enum.Font.SourceSans
                buttonElement.Text = ""
                buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                buttonElement.TextSize = fontSizeDefault
                buttonElement.BorderSizePixel = 0

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = buttonElement

                Sample.Name = "Sample"
                Sample.Parent = buttonElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = accentColor2
                Sample.ImageTransparency = 0.600
            
                touch.Name = "touch"
                touch.Parent = buttonElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                -- touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.BorderSizePixel = 0
                touch.Position = UDim2.new(0, 12, 0, 8)
                touch.Size = UDim2.new(0, 30, 0, 30)
                touch.Image = "rbxassetid://115757494252972"
                touch.ImageColor3 = activeColor
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)
                touch.ImageTransparency = 0
            
                btnInfo.Name = "btnInfo"
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btnInfo.BackgroundTransparency = 1.000
                btnInfo.Position = UDim2.new(0, 57, 0, 3)
                btnInfo.Size = UDim2.new(0, 473, 0, 41)
                btnInfo.Text = bname
                btnInfo.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                btnInfo.RichText = true
                btnInfo.TextColor3 = accentColor1
                btnInfo.TextSize = fontSizeDefault
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left
            
                updateSectionFrame()
                UpdateSize()
            
                local ms = game.Players.LocalPlayer:GetMouse()
            
                local btn = buttonElement
                local sample = Sample
            
                btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        callback()
                        local c = sample:Clone()
                        c.Parent = btn
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                            size = (btn.AbsoluteSize.X * 1.5)
                        else
                            size = (btn.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                            c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                        c:Destroy()
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = backgroundColor2
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = accentColor2
                        }):Play()
                        hovering = false
                    end
                end)
                
                function ButtonFunction:UpdateButton(newTitle)
                    btnInfo.Text = newTitle
                end
                return ButtonFunction
            end
            function Elements:NewTextBox(tname, callback)
                tname = tname or "Textbox"
                callback = callback or function() end
                local textboxElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local UICorner_2 = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")

                textboxElement.Name = "textboxElement"
                textboxElement.Parent = sectionInners
                textboxElement.BackgroundColor3 = accentColor2
                textboxElement.BackgroundTransparency = 0
                textboxElement.ClipsDescendants = true
                textboxElement.Size = UDim2.new(0, 530, 0, 45)
                textboxElement.AutoButtonColor = false
                textboxElement.Font = Enum.Font.SourceSans
                textboxElement.Text = ""
                textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                textboxElement.TextSize = 14.000

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = textboxElement

                TextBox.Parent = textboxElement
                TextBox.BackgroundColor3 = backgroundColor1
                TextBox.BorderSizePixel = 0
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(0, 262, 0, 6)
                TextBox.CursorPosition = 2
                TextBox.Size = UDim2.new(0, 260, 0, 33)
                TextBox.ZIndex = 99
                TextBox.ClearTextOnFocus = false
                TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                TextBox.PlaceholderText = "Type here..."
                TextBox.Text = ""
                TextBox.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                TextBox.RichText = true
                TextBox.TextColor3 = accentColor1
                TextBox.TextSize = fontSizeButton
                TextBox.TextXAlignment = Enum.TextXAlignment.Center

                UICorner_2.CornerRadius = UDim.new(0, 6)
                UICorner_2.Parent = TextBox

                togName.Name = "togName"
                togName.Parent = textboxElement
                togName.BackgroundColor3 = accentColor1
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0,7,0,2)
                togName.Size = UDim2.new(0, 199, 0, 41)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = tname
                togName.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                togName.RichText = true
                togName.TextColor3 = accentColor1
                togName.TextSize = fontSizeDefault
                togName.TextXAlignment = Enum.TextXAlignment.Left

                updateSectionFrame()
                UpdateSize()
            
                local btn = textboxElement
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = backgroundColor2
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = accentColor2
                        }):Play()
                        hovering = false
                    end
                end)
                
                TextBox.Focused:Connect(function()
                    TextBox.Text = ""
                end)

                TextBox.FocusLost:Connect(function(EnterPressed)
                    if focusing then
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end

                    callback(TextBox.Text)
                    wait(.2)
                end)
            end 

            function Elements:NewToggle(tname, callback)
                local TogFunction = {}
                tname = tname or "Toggle"
                callback = callback or function() end
                local toggled = false

                local toggleElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local Sample = Instance.new("ImageLabel")

                local ToggleStateEnabled = Instance.new("Frame")
                local ToggleStateEnabledSwitch = Instance.new("Frame")
                local ToggleStateEnabledStroke = Instance.new("UIStroke")
                local ToggleStateEnabledCorner = Instance.new("UICorner")
                local ToggleStateEnabledSwitchCorner = Instance.new("UICorner")

                ToggleStateEnabled.Size = UDim2.new(0,40,0,18)
                ToggleStateEnabled.Position = UDim2.new(0,5,0,9)
                ToggleStateEnabled.Parent = toggleElement
                ToggleStateEnabled.BackgroundColor3 = activeColor
                ToggleStateEnabled.ClipsDescendants = false
                ToggleStateEnabled.BackgroundTransparency = 0
                ToggleStateEnabled.Visible = false

                ToggleStateEnabledCorner.Parent = ToggleStateEnabled
                ToggleStateEnabledCorner.CornerRadius = UDim.new(0, 6)

                ToggleStateEnabledStroke.Parent = ToggleStateEnabled
                ToggleStateEnabledStroke.Enabled = true
                ToggleStateEnabledStroke.Color = backgroundColor1
                ToggleStateEnabledStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                ToggleStateEnabledStroke.Thickness = 1

                ToggleStateEnabledSwitch.Size = UDim2.new(0,10,0,22)
                ToggleStateEnabledSwitch.Position = UDim2.new(0,30,0,-2)
                ToggleStateEnabledSwitch.BackgroundColor3 = accentColor1
                ToggleStateEnabledSwitch.Parent = ToggleStateEnabled

                ToggleStateEnabledSwitchCorner.Parent = ToggleStateEnabledSwitch
                ToggleStateEnabledSwitchCorner.CornerRadius = UDim.new(0, 4)

                local ToggleStateDisabled = Instance.new("Frame")
                local ToggleStateDisabledSwitch = Instance.new("Frame")
                local ToggleStateDisabledCorner = Instance.new("UICorner")
                local ToggleStateDisabledSwitchCorner = Instance.new("UICorner")

                ToggleStateDisabled.Size = UDim2.new(0,40,0,18)
                ToggleStateDisabled.Position = UDim2.new(0,5,0,9)
                ToggleStateDisabled.Parent = toggleElement
                ToggleStateDisabled.BackgroundColor3 = inactiveColor
                ToggleStateDisabled.ClipsDescendants = false
                ToggleStateDisabled.BackgroundTransparency = 0
                ToggleStateDisabled.Visible = true

                ToggleStateDisabledCorner.Parent = ToggleStateDisabled
                ToggleStateDisabledCorner.CornerRadius = UDim.new(0, 6)

                ToggleStateDisabledSwitch.Size = UDim2.new(0,10,0,22)
                ToggleStateDisabledSwitch.Position = UDim2.new(0,0,0,-2)
                ToggleStateDisabledSwitch.BackgroundColor3 = accentColor1
                ToggleStateDisabledSwitch.Parent = ToggleStateDisabled

                ToggleStateDisabledSwitchCorner.Parent = ToggleStateDisabledSwitch
                ToggleStateDisabledSwitchCorner.CornerRadius = UDim.new(0, 4)


                toggleElement.Name = "toggleElement"
                toggleElement.Parent = sectionInners
                toggleElement.BackgroundColor3 = accentColor2
                toggleElement.BackgroundTransparency = 0.2
                toggleElement.ClipsDescendants = true
                toggleElement.Size = UDim2.new(0, 530, 0, 38)
                toggleElement.AutoButtonColor = false
                toggleElement.Font = Enum.Font.SourceSans
                toggleElement.Text = ""
                toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                toggleElement.TextSize = 14.000

                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = toggleElement

                togName.Name = "togName"
                togName.Parent = toggleElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0, 57, 0, 0)
                togName.Size = UDim2.new(0, 473, 0, 35)
                togName.Text = tname
                togName.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                togName.RichText = true
                togName.TextColor3 = accentColor1
                togName.TextSize = fontSizeDefault
                togName.TextXAlignment = Enum.TextXAlignment.Left

                Sample.Name = "Sample"
                Sample.Parent = toggleElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = accentColor2
                Sample.ImageTransparency = 0.600

                local ms = game.Players.LocalPlayer:GetMouse()
                local btn = toggleElement
                local sample = Sample
                local infBtn = viewInfo

                updateSectionFrame()
                UpdateSize()

                btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        if toggled == false then
                            ToggleStateDisabled.Visible = false
                            ToggleStateEnabled.Visible = true
                        else
                            ToggleStateDisabled.Visible = true
                            ToggleStateEnabled.Visible = false
                        end
                        toggled = not toggled
                        pcall(callback, toggled)
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = backgroundColor2
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = accentColor2
                        }):Play()
                        hovering = false
                    end
                end)

                function TogFunction:UpdateToggle(newText, isTogOn)
                    isTogOn = isTogOn or toggle
                    if newText ~= nil then 
                        togName.Text = newText
                    end
                    if isTogOn then
                        toggled = true
                        ToggleStateDisabled.Visible = false
                        ToggleStateEnabled.Visible = true
                        -- game.TweenService:Create(img, TweenInfo.new(0.05, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                        --     ImageTransparency = 0
                        -- }):Play()
                        pcall(callback, toggled)
                    else
                        toggled = false
                        ToggleStateDisabled.Visible = true
                        ToggleStateEnabled.Visible = false
                        -- game.TweenService:Create(img, TweenInfo.new(0.05, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                        --     ImageTransparency = 1
                        -- }):Play()
                        pcall(callback, toggled)
                    end
                end
                return TogFunction
            end

            function Elements:NewSlider(slidInf, minvalue, maxvalue, callback)
                sliderFunctions = {}
                slidInf = slidInf or "Slider"
                maxvalue = maxvalue or 500
                minvalue = minvalue or 16
                startVal = startVal or 0
                callback = callback or function() end
            
                local sliderElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local sliderName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local sliderBtn = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local sliderDrag = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local val = Instance.new("TextLabel")
            
                sliderElement.Name = "sliderElement"
                sliderElement.Parent = sectionInners
                sliderElement.BackgroundColor3 = accentColor2
                sliderElement.ClipsDescendants = true
                sliderElement.Size = UDim2.new(0, 530, 0, 38)
                sliderElement.AutoButtonColor = false
                sliderElement.Font = Enum.Font.SourceSans
                sliderElement.Text = ""
                sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderElement.TextSize = 14.000
            
                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = sliderElement
            
                sliderName.Name = "togName"
                sliderName.Parent = sliderElement
                sliderName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sliderName.BackgroundTransparency = 1.000
                sliderName.Position = UDim2.new(0, 10, 0, 2)
                sliderName.Size = UDim2.new(0, 221, 0, 35)
                sliderName.Text = slidInf
                sliderName.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                sliderName.RichText = true
                sliderName.TextColor3 = accentColor1
                sliderName.TextSize = fontSizeDefault
                sliderName.TextXAlignment = Enum.TextXAlignment.Left
            
                sliderBtn.Name = "sliderBtn"
                sliderBtn.Parent = sliderElement
                sliderBtn.BackgroundColor3 = backgroundColor1
                sliderBtn.BackgroundTransparency = 0
                sliderBtn.BorderSizePixel = 0
                sliderBtn.Position = UDim2.new(0, 333, 0, 9)
                sliderBtnHeight = 20
                sliderBtnWidth = 185
                sliderBtn.Size = UDim2.new(0, sliderBtnWidth, 0, sliderBtnHeight)
                sliderBtn.AutoButtonColor = false
                sliderBtn.Font = Enum.Font.SourceSans
                sliderBtn.Text = ""
                sliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderBtn.TextSize = 14.000
            
                UICorner_2.CornerRadius = UDim.new(0, 6)
                UICorner_2.Parent = sliderBtn
            
                UIListLayout.Parent = sliderBtn
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            
                sliderDrag.Name = "sliderDrag"
                sliderDrag.Parent = sliderBtn
                sliderDrag.BackgroundColor3 = activeColor
                sliderDrag.Size = UDim2.new(0, 0, 1, 0)

                local sliderDragSwitch = Instance.new("Frame")
                local sliderDragSwitchCorner = Instance.new("UICorner")
                sliderDragSwitch.Visible = true
                sliderDragSwitch.Size = UDim2.new(0,10,0,22)
                sliderDragSwitch.Position = UDim2.new(0.97,0,0,-1)
                sliderDragSwitch.BackgroundColor3 = accentColor1
                sliderDragSwitch.Parent = sliderDrag
                sliderDragSwitchCorner.Parent = sliderDragSwitch
                sliderDragSwitchCorner.CornerRadius = UDim.new(0, 4)
            
                UICorner_3.CornerRadius = UDim.new(0, 6)
                UICorner_3.Parent = sliderDrag
            
                val.Name = "val"
                val.Parent = sliderElement
                val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                val.BackgroundTransparency = 1.000
                val.Position = UDim2.new(0, 291, 0, 2)
                val.Size = UDim2.new(0, 39, 0, 35)
                val.Text = minvalue
                val.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                val.RichText = true
                val.TextColor3 = accentColor1
                val.TextSize = fontSizeDefault
                val.TextXAlignment = Enum.TextXAlignment.Right
            
                updateSectionFrame()
                UpdateSize()
                local mouse = game:GetService("Players").LocalPlayer:GetMouse();
            
                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local btn = sliderElement
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = backgroundColor2
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = accentColor2
                        }):Play()
                        hovering = false
                    end
                end)       
                local Value
                local function updateSlider(inputPosition)
                    local relativePosition = (inputPosition - sliderBtn.AbsolutePosition.X) / sliderBtn.AbsoluteSize.X
                    local clampedPosition = math.clamp(relativePosition, 0, 1)
                    Value = math.floor(minvalue + (maxvalue - minvalue) * clampedPosition)
                
                    sliderDrag.Size = UDim2.new(clampedPosition, 0, 1, 0)
                    sliderDragSwitch.Position = UDim2.new(0.95, 0, 0, -1)
                    val.Text = Value
                end

                sliderDrag.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        local moveConnection
                        local releaseConnection
                
                        moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(moveInput)
                            if moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                                updateSlider(moveInput.Position.X)
                                pcall(function()
                                    callback(Value)
                                end)
                            end
                        end)
                
                        releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(releaseInput)
                            if releaseInput.UserInputType == Enum.UserInputType.MouseButton1 or releaseInput.UserInputType == Enum.UserInputType.Touch then
                                moveConnection:Disconnect()
                                releaseConnection:Disconnect()
                                pcall(function()
                                    callback(Value)
                                end)
                            end
                        end)
                    end
                end)
                
                sliderBtn.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        updateSlider(input.Position.X)
                        pcall(function()
                            callback(Value)
                        end)

                        moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(moveInput)
                            if moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                                updateSlider(moveInput.Position.X)
                                pcall(function()
                                    callback(Value)
                                end)
                            end
                        end)
                
                        releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(releaseInput)
                            if releaseInput.UserInputType == Enum.UserInputType.MouseButton1 or releaseInput.UserInputType == Enum.UserInputType.Touch then
                                moveConnection:Disconnect()
                                releaseConnection:Disconnect()
                                pcall(function()
                                    callback(Value)
                                end)
                            end
                        end)
                    end
                end)

                function sliderFunctions:UpdateValue(newValue)
                    sliderDrag:TweenSize(UDim2.new(0, math.clamp(sliderBtnWidth * (newValue / maxvalue), 0, sliderBtnWidth), 0, sliderBtnHeight), "InOut", "Linear", 0.05, true)
                    val.Text = newValue
                    pcall(function()
                        callback(newValue)
                    end)  
                end	
                return sliderFunctions
            end

            function Elements:NewDropdown(dropname, list, callback)
                local DropFunction = {}
                local baseDropName = dropname
                local dropname = dropname or "Dropdown"
                local list = list or {}
                local callback = callback or function() end   
            
                local opened = false
                local DropYSize = 33
            
                local dropFrame = Instance.new("Frame")
                local dropOpen = Instance.new("TextButton")
                local itemTextbox = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local Sample = Instance.new("ImageLabel")
                local ActiveVerticalLine = Instance.new("Frame")
                local ActiveHorizontalLine = Instance.new("Frame")

                local DropdownIconBar1 = Instance.new("Frame")
                local DropdownIconBar1Corner = Instance.new("UICorner")
                local DropdownIconBar1Stroke = Instance.new("UIStroke")
                local DropdownIconBar2 = Instance.new("Frame")
                local DropdownIconBar2Corner = Instance.new("UICorner")
                local DropdownIconBar2Stroke = Instance.new("UIStroke")
                local DropdownIconBar3 = Instance.new("Frame")
                local DropdownIconBar3Corner = Instance.new("UICorner")
                local DropdownIconBar3Stroke = Instance.new("UIStroke")

                DropdownIconBar1.Size = UDim2.new(0,30,0,5)
                DropdownIconBar1.Position = UDim2.new(0,10,0,10)
                DropdownIconBar1.Parent = dropOpen
                DropdownIconBar1.BackgroundColor3 = activeColor
                DropdownIconBar1Corner.Parent = DropdownIconBar1
                DropdownIconBar1Corner.CornerRadius = UDim.new(0,6)
                DropdownIconBar1Stroke.Parent = DropdownIconBar1
                DropdownIconBar1Stroke.Enabled = true
                DropdownIconBar1Stroke.Color = backgroundColor1
                DropdownIconBar1Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                DropdownIconBar1Stroke.Thickness = 1

                DropdownIconBar2.Size = UDim2.new(0,30,0,5)
                DropdownIconBar2.Position = UDim2.new(0,10,0,20)
                DropdownIconBar2.Parent = dropOpen
                DropdownIconBar2.BackgroundColor3 = activeColor
                DropdownIconBar2Corner.Parent = DropdownIconBar2
                DropdownIconBar2Corner.CornerRadius = UDim.new(0,6)
                DropdownIconBar2Stroke.Parent = DropdownIconBar2
                DropdownIconBar2Stroke.Enabled = true
                DropdownIconBar2Stroke.Color = backgroundColor1
                DropdownIconBar2Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                DropdownIconBar2Stroke.Thickness = 1

                DropdownIconBar3.Size = UDim2.new(0,30,0,5)
                DropdownIconBar3.Position = UDim2.new(0,10,0,30)
                DropdownIconBar3.Parent = dropOpen
                DropdownIconBar3.BackgroundColor3 = activeColor
                DropdownIconBar3Corner.Parent = DropdownIconBar3
                DropdownIconBar3Corner.CornerRadius = UDim.new(0,6)
                DropdownIconBar3Stroke.Parent = DropdownIconBar3
                DropdownIconBar3Stroke.Enabled = true
                DropdownIconBar3Stroke.Color = backgroundColor1
                DropdownIconBar3Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                DropdownIconBar3Stroke.Thickness = 1
                


                ActiveVerticalLine.Visible = false
                ActiveVerticalLine.Parent = dropOpen
                ActiveVerticalLine.Size = UDim2.new(0,1,0,49)
                ActiveVerticalLine.Position = UDim2.new(0,13,0,48)
                ActiveVerticalLine.BackgroundColor3 = activeColor
                ActiveVerticalLine.BorderSizePixel = 0
                ActiveHorizontalLine.Parent = ActiveVerticalLine
                ActiveHorizontalLine.Size = UDim2.new(0,19,0,1)
                ActiveHorizontalLine.Position = UDim2.new(0.99,0,1,0)
                ActiveHorizontalLine.BackgroundColor3 = activeColor
                ActiveHorizontalLine.BorderSizePixel = 0

                
            
                local ms = game.Players.LocalPlayer:GetMouse()

                Sample.Name = "Sample"
                Sample.Parent = dropOpen
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = accentColor2
                Sample.ImageTransparency = 0.600
                
                dropFrame.Name = "dropFrame"
                dropFrame.Parent = sectionInners
                dropFrame.BackgroundColor3 = accentColor2
                dropFrame.BackgroundTransparency = 1
                dropFrame.BorderSizePixel = 0
                dropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
                dropFrame.Size = UDim2.new(0, 530, 0, 45)
                dropFrame.ClipsDescendants = true
                local sample = Sample
                local btn = dropOpen
                dropOpen.Name = "dropOpen"
                dropOpen.Parent = dropFrame
                dropOpen.BackgroundColor3 = accentColor2
                dropOpen.BackgroundTransparency = 0
                dropOpen.Size = UDim2.new(0, 530, 0, 45)
                dropOpen.AutoButtonColor = false
                dropOpen.Font = Enum.Font.SourceSans
                dropOpen.Text = ""
                dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
                dropOpen.TextSize = 14.000
                dropOpen.ClipsDescendants = false
                dropOpen.MouseButton1Click:Connect(function()
                    if not focusing then
                        if opened then
                            opened = false
                            dropFrame.Size = UDim2.new(0, 530, 0, 45)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', 0.04, true, nil)
                            wait(0.01)
                            c:Destroy()
                            ActiveVerticalLine.Visible = false
                            ActiveVerticalLine.Size = UDim2.new(0,1,0,49)
                        else
                            ActiveVerticalLine.Visible = true
                            ActiveVerticalLine.Size = UDim2.new(0,1,0,UIListLayout.AbsoluteContentSize.Y - 49)
                            opened = true
                            dropFrame.Size = UDim2.new(0, 530, 0, UIListLayout.AbsoluteContentSize.Y)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', 0.04, true, nil)
                            wait(0.01)
                            c:Destroy()
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
            
                itemTextbox.Name = "itemTextbox"
                itemTextbox.Parent = dropOpen
                itemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                itemTextbox.BackgroundTransparency = 1.000
                itemTextbox.Position = UDim2.new(0, 57, 0, 2)
                itemTextbox.Size = UDim2.new(0, 473, 0, 41)
                itemTextbox.Text = dropname .. ": None"
                itemTextbox.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                itemTextbox.RichText = true
                itemTextbox.TextColor3 = accentColor1
                itemTextbox.TextSize = fontSizeDefault
                itemTextbox.TextXAlignment = Enum.TextXAlignment.Left
            
                UICorner.CornerRadius = UDim.new(0, 8)
                UICorner.Parent = dropOpen
            
                local Sample = Instance.new("ImageLabel")
            
                Sample.Name = "Sample"
                Sample.Parent = dropOpen
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = accentColor2
                Sample.ImageTransparency = 0.600
            
                UIListLayout.Parent = dropFrame
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            
                updateSectionFrame() 
                UpdateSize()
            
                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
            
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = backgroundColor2
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = accentColor2
                        }):Play()
                        hovering = false
                    end
                end)    
            
                for i,v in next, list do
                    local optionSelect = Instance.new("TextButton")
                    local UICorner_2 = Instance.new("UICorner")
                    local Sample1 = Instance.new("ImageLabel")
            
                    local ms = game.Players.LocalPlayer:GetMouse()
                    Sample1.Name = "Sample"
                    Sample1.Parent = dropOpen
                    Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sample1.BackgroundTransparency = 1.000
                    Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample1.ImageColor3 = accentColor2
                    Sample1.ImageTransparency = 0.600
            
                    local sample1 = Sample1
                    DropYSize = DropYSize + 33
                    optionSelect.Name = "optionSelect"
                    optionSelect.Parent = dropFrame
                    optionSelect.BackgroundColor3 = accentColor2
                    optionSelect.BackgroundTransparency = 0
                    optionSelect.Position = UDim2.new(0, 32, 0, 48)
                    optionSelect.Size = UDim2.new(0, 497, 0, 37)
                    optionSelect.AutoButtonColor = false
                    optionSelect.Text = "  "..v
                    optionSelect.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                    optionSelect.RichText = true
                    optionSelect.TextColor3 = accentColor1
                    optionSelect.TextSize = fontSizeDefault
                    optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                    optionSelect.ClipsDescendants = true
                    optionSelect.MouseButton1Click:Connect(function()
                        if not focusing then
                            opened = false
                            callback(v)
                            opened = false
                            itemTextbox.Text = baseDropName .. ": " .. v
                            dropFrame.Size = UDim2.new(0, 530, 0, 45)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', 0.04, true, nil)
                            wait(0.01)
                            c:Destroy()     
                        else
                            for i,v in next, infoContainer:GetChildren() do
                                Utility:TweenObject(Fv, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        end
                    end)
            
                    UICorner_2.CornerRadius = UDim.new(0, 8)
                    UICorner_2.Parent = optionSelect
            
                    local oHover = false
                    optionSelect.MouseEnter:Connect(function()
                        if not focusing then
                            game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = backgroundColor2
                            }):Play()
                            hovering = true
                        end
                    end)
                    optionSelect.MouseLeave:Connect(function()
                        if not focusing then 
                            game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = accentColor2
                            }):Play()
                            hovering = false
                        end
                    end)  
                end
            
                function DropFunction:Refresh(newList)
                    newList = newList or {}
                    for i,v in next, dropFrame:GetChildren() do
                        if v.Name == "optionSelect" then
                            v:Destroy()
                        end
                    end
                    for i,v in next, newList do
                        local optionSelect = Instance.new("TextButton")
                        local UICorner_2 = Instance.new("UICorner")
                        local Sample1 = Instance.new("ImageLabel")
                
                        local ms = game.Players.LocalPlayer:GetMouse()
                        Sample1.Name = "Sample"
                        Sample1.Parent = dropOpen
                        Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Sample1.BackgroundTransparency = 1.000
                        Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
                        Sample1.ImageColor3 = accentColor2
                        Sample1.ImageTransparency = 0.600
                
                        local sample1 = Sample1
                        DropYSize = DropYSize + 33
                        optionSelect.Name = "optionSelect"
                        optionSelect.Parent = dropFrame
                        optionSelect.BackgroundColor3 = accentColor2
                        optionSelect.BackgroundTransparency = 0
                        optionSelect.Position = UDim2.new(0, 32, 0, 48)
                        optionSelect.Size = UDim2.new(0, 497, 0, 37)
                        optionSelect.AutoButtonColor = false
                        optionSelect.Text = "  "..v
                        optionSelect.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                        optionSelect.RichText = true
                        optionSelect.TextColor3 = accentColor1
                        optionSelect.TextSize = fontSizeDefault
                        optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                        optionSelect.ClipsDescendants = true
                        optionSelect.MouseButton1Click:Connect(function()
                            if not focusing then
                                opened = false
                                callback(v)
                                opened = false
                                itemTextbox.Text = baseDropName .. ": " .. v
                                dropFrame.Size = UDim2.new(0, 530, 0, 45)
                                updateSectionFrame()
                                UpdateSize()
                                local c = sample:Clone()
                                c.Parent = btn
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                    size = (btn.AbsoluteSize.X * 1.5)
                                else
                                    size = (btn.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', 0.04, true, nil)
                                wait(0.01)
                                c:Destroy()     
                            else
                                for i,v in next, infoContainer:GetChildren() do
                                    Utility:TweenObject(Fv, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                    focusing = false
                                end
                                Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                            end
                        end)
                
                        UICorner_2.CornerRadius = UDim.new(0, 8)
                        UICorner_2.Parent = optionSelect
                
                        local oHover = false
                        optionSelect.MouseEnter:Connect(function()
                            if not focusing then
                                game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    BackgroundColor3 = backgroundColor2
                                }):Play()
                                hovering = true
                            end
                        end)
                        optionSelect.MouseLeave:Connect(function()
                            if not focusing then 
                                game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    BackgroundColor3 = accentColor2
                                }):Play()
                                hovering = false
                            end
                        end)  
                    end
                    if opened then 
                        ActiveVerticalLine.Visible = true
                        ActiveVerticalLine.Size = UDim2.new(0,1,0,UIListLayout.AbsoluteContentSize.Y)
                        dropFrame:TweenSize(UDim2.new(0, 530, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
                        updateSectionFrame()
                        UpdateSize()
                    else
                        dropFrame:TweenSize(UDim2.new(0, 530, 0, 45), "InOut", "Linear", 0.08)
                        updateSectionFrame()
                        UpdateSize()
                    end
                end
                function DropFunction:UpdateSelect(selectValue)
                    local isInList = false
                    for i,v in ipairs(list) do
                        if selectValue == v then
                            isInList = true
                        end
                    end
                    if isInList then 
                        itemTextbox.Text = baseDropName .. ": " .. selectValue
                        callback(selectValue)
                    end
                end
                return DropFunction
            end

            function Elements:NewKeybind(keytext, first, callback)
                keytext = keytext or "KeybindText"
                keyinf = "KebindInfo"
                callback = callback or function() end
                local oldKey = first.Name
                local keybindElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local Sample = Instance.new("ImageLabel")
                local togName_2 = Instance.new("TextLabel")

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local UICorner1 = Instance.new("UICorner")

                local sample = Sample

                keybindElement.Name = "keybindElement"
                keybindElement.Parent = sectionInners
                keybindElement.BackgroundColor3 = accentColor2
                keybindElement.ClipsDescendants = true
                keybindElement.Size = UDim2.new(0, 530, 0, 38)
                keybindElement.AutoButtonColor = false
                keybindElement.Font = Enum.Font.SourceSans
                keybindElement.Text = ""
                keybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                keybindElement.TextSize = 14.000
                keybindElement.MouseButton1Click:connect(function(e) 
                    if not focusing then
                        togName_2.Text = ". . ."
                        local a, b = game:GetService('UserInputService').InputBegan:wait();
                        if a.KeyCode.Name ~= "Unknown" then
                            togName_2.Text = a.KeyCode.Name
                            oldKey = a.KeyCode.Name;
                        end
                        local c = sample:Clone()
                        c.Parent = keybindElement
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if keybindElement.AbsoluteSize.X >= keybindElement.AbsoluteSize.Y then
                            size = (keybindElement.AbsoluteSize.X * 1.5)
                        else
                            size = (keybindElement.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
        
                game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
                    if not ok then 
                        if current.KeyCode.Name == oldKey then 
                            callback(current.KeyCode)
                        end
                    end
                end)

                Sample.Name = "Sample"
                Sample.Parent = keybindElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = accentColor2
                Sample.ImageTransparency = 0.600

                
                togName.Name = "togName"
                togName.Parent = keybindElement
                togName.BackgroundColor3 = accentColor2
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0, 10, 0, 2)
                togName.Size = UDim2.new(0, 222, 0, 35)
                togName.Text = keytext
                togName.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                togName.RichText = true
                togName.TextColor3 = accentColor1
                togName.TextSize = fontSizeDefault
                togName.TextXAlignment = Enum.TextXAlignment.Left

                updateSectionFrame()
                UpdateSize()
                local oHover = false
                keybindElement.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = backgroundColor2
                        }):Play()
                        oHover = true
                    end 
                end)
                keybindElement.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = accentColor2
                        }):Play()
                        oHover = false
                    end
                end)        

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = keybindElement

                togName_2.Name = "togName"
                togName_2.Parent = keybindElement
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.727386296, 0, 0, 2)
                togName_2.Size = UDim2.new(0, 70, 0, 35)
                togName_2.Text = oldKey
                togName_2.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium)
                togName_2.RichText = true
                togName_2.TextColor3 = accentColor1
                togName_2.TextSize = fontSizeDefault
                togName_2.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            function Elements:NewLabel(title)
            	local labelFunctions = {}
            	local label = Instance.new("TextLabel")
            	label.Name = "label"
            	label.Parent = sectionInners
            	label.BackgroundColor3 = backgroundColor1
            	label.BackgroundTransparency = 1
            	label.BorderSizePixel = 0
				label.ClipsDescendants = true
            	label.Text = " "..title
           		label.Size = UDim2.new(0, 473, 0, 24)
                label.Position = UDim2.new(0,5,0,0)
                label.FontFace = Font.fromName("Montserrat", fontWeightDefault)
                label.RichText = true
	            label.TextColor3 = accentColor1
	            label.TextSize = fontSizeButton
	            label.TextXAlignment = Enum.TextXAlignment.Left


                updateSectionFrame()
                UpdateSize()
                function labelFunctions:UpdateLabel(newText)
                	if label.Text ~= " "..newText then
                		label.Text = " "..newText
                	end
                end	
                return labelFunctions
            end	
            return Elements
        end
        return Sections
    end  
    return Tabs
end

return EuphoriaUI