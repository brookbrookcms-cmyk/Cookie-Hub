-- Coco Hub Christmas loader
-- The filename stays the same so existing Delta loadstrings keep working.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
if not player then return end
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

local assetBase = "https://raw.githubusercontent.com/brookbrookcms-cmyk/Cookie-Hub/main/"
local assets = {
    landscape = {url = assetBase .. "CocoBackgroundLandscape.jpg", file = "coco_hub_landscape_v1.jpg", signature = "\255\216\255"},
    portrait = {url = assetBase .. "CocoBackgroundPortrait.jpg", file = "coco_hub_portrait_v1.jpg", signature = "\255\216\255"},
    logo = {url = assetBase .. "CocoLogo.png", file = "coco_hub_logo_v1.png", signature = "\137PNG"},
    audio = {url = assetBase .. "CocoLoaderAudio.mp3", file = "coco_hub_intro_audio_v1.mp3", signature = "ID3"},
    hubBackground = {url = assetBase .. "CocoMonoBackground.jpg", file = "coco_hub_mono_background_v1.jpg", signature = "\255\216\255"},
    hubLogo = {url = assetBase .. "CocoMonoLogo.png", file = "coco_hub_mono_logo_v1.png", signature = "\137PNG"},
}
local duration = 10.5

for _, parent in ipairs({CoreGui, playerGui}) do
    for _, name in ipairs({"PotassiumLoader", "CookieHubChristmas", "CookieHubGui", "CocoHubLoader"}) do
        pcall(function()
            local old = parent:FindFirstChild(name)
            if old then old:Destroy() end
        end)
    end
end

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties) do object[key] = value end
    object.Parent = parent
    return object
end

local function round(object, radius)
    make("UICorner", {CornerRadius = UDim.new(0, radius)}, object)
end

local function animate(object, seconds, properties)
    local tween = TweenService:Create(object, TweenInfo.new(seconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local white = Color3.fromRGB(248, 251, 255)
local night = Color3.fromRGB(3, 17, 36)
local gui = make("ScreenGui", {
    Name = "CocoHubLoader",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = 10000,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, nil)
if not pcall(function() gui.Parent = CoreGui end) then gui.Parent = playerGui end

local intro = make("Frame", {
    Name = "FullscreenIntro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = night,
    BorderSizePixel = 0,
}, gui)
local background = make("ImageLabel", {
    Name = "SnowyNight",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ImageTransparency = 1,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 1,
}, intro)

local snowLayer = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 2,
}, intro)
local flakes = {}
for i = 1, 23 do
    local diameter = 2 + (i % 3)
    local flake = make("Frame", {
        Position = UDim2.fromScale(((i * 79) % 97) / 100, ((i * 43) % 101) / 100),
        Size = UDim2.fromOffset(diameter, diameter),
        BackgroundColor3 = white,
        BackgroundTransparency = 0.55 + (i % 3) * 0.1,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, snowLayer)
    round(flake, 10)
    flakes[i] = {object = flake, speed = 0.03 + (i % 5) * 0.013}
end

local content = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.51),
    Size = UDim2.fromOffset(600, 315),
    BackgroundTransparency = 1,
    ZIndex = 3,
}, intro)
local scale = make("UIScale", {Scale = 1}, content)

local logoFallback = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromOffset(300, 76),
    Size = UDim2.fromOffset(78, 58),
    BackgroundColor3 = Color3.fromRGB(151, 75, 20),
    BorderSizePixel = 0,
    Rotation = -30,
    ZIndex = 4,
}, content)
round(logoFallback, 45)
local flesh = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.32),
    Size = UDim2.fromOffset(66, 32),
    BackgroundColor3 = white,
    BorderSizePixel = 0,
    ZIndex = 5,
}, logoFallback)
round(flesh, 30)

local logo = make("ImageLabel", {
    Name = "CoconutLogo",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromOffset(300, 76),
    Size = UDim2.fromOffset(240, 160),
    BackgroundTransparency = 1,
    ImageTransparency = 1,
    ZIndex = 6,
}, content)

local title = make("TextLabel", {
    Position = UDim2.fromOffset(0, 130),
    Size = UDim2.fromOffset(600, 58),
    BackgroundTransparency = 1,
    Text = "C O C O   H U B",
    TextColor3 = white,
    TextSize = 43,
    Font = Enum.Font.GothamMedium,
    ZIndex = 4,
}, content)

local subtitle = make("TextLabel", {
    Position = UDim2.fromOffset(160, 193),
    Size = UDim2.fromOffset(280, 19),
    BackgroundTransparency = 1,
    Text = "T H E   C H R I S T M A S   E D I T I O N",
    TextColor3 = white,
    TextTransparency = 0.17,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    ZIndex = 4,
}, content)
for _, x in ipairs({65, 444}) do
    make("Frame", {
        Position = UDim2.fromOffset(x, 202),
        Size = UDim2.fromOffset(90, 1),
        BackgroundColor3 = white,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        ZIndex = 4,
    }, content)
end

local track = make("Frame", {
    Position = UDim2.fromOffset(75, 241),
    Size = UDim2.fromOffset(450, 24),
    BackgroundColor3 = Color3.fromRGB(5, 22, 43),
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    ZIndex = 4,
}, content)
round(track, 20)
make("UIStroke", {Color = white, Thickness = 1.7, Transparency = 0.05}, track)
local fill = make("Frame", {
    Position = UDim2.fromOffset(3, 3),
    Size = UDim2.new(0, 0, 1, -6),
    BackgroundColor3 = white,
    BorderSizePixel = 0,
    ZIndex = 5,
}, track)
round(fill, 16)

local status = make("TextLabel", {
    Position = UDim2.fromOffset(75, 285),
    Size = UDim2.fromOffset(450, 20),
    BackgroundTransparency = 1,
    Text = "Starting Coco Hub",
    TextColor3 = white,
    TextTransparency = 0.2,
    TextSize = 14,
    Font = Enum.Font.Gotham,
    ZIndex = 4,
}, content)
local percent = make("TextLabel", {
    Position = UDim2.fromOffset(475, 285),
    Size = UDim2.fromOffset(50, 20),
    BackgroundTransparency = 1,
    Text = "0%",
    TextColor3 = white,
    TextTransparency = 0.2,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.Gotham,
    ZIndex = 5,
}, content)

local function viewport()
    return camera and camera.ViewportSize or Vector2.new(960, 540)
end
local function isPortrait()
    local size = viewport()
    return size.X / math.max(size.Y, 1) < 1.15
end
local function updateLayout()
    local size = viewport()
    scale.Scale = math.min(1, size.X / 670, size.Y / 390)
    local chosen = isPortrait() and assets.portrait or assets.landscape
    local available = chosen.asset or assets.landscape.asset or assets.portrait.asset
    if available and intro.Parent and background.Image ~= available then
        background.Image = available
        animate(background, 0.45, {ImageTransparency = 0})
    end
end
updateLayout()
local cameraConnection
if camera then cameraConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateLayout) end

local function downloadAsset(entry)
    local assetFn = getcustomasset or getsynasset
    if not (assetFn and writefile) then return end
    local function useFile()
        local ok, asset = pcall(function() return assetFn(entry.file) end)
        if ok and type(asset) == "string" and #asset > 0 then
            entry.asset = asset
            return true
        end
        return false
    end
    if isfile and isfile(entry.file) and useFile() then return end
    local data
    local requestFn = request or http_request or (syn and syn.request) or (http and http.request)
    if requestFn then
        local ok, response = pcall(function() return requestFn({Url = entry.url, Method = "GET"}) end)
        if ok and response and (response.StatusCode == 200 or response.Success) then data = response.Body end
    end
    if not data then
        local ok, response = pcall(function() return game:HttpGet(entry.url) end)
        if ok then data = response end
    end
    if type(data) == "string" and data:sub(1, #entry.signature) == entry.signature then
        local ok = pcall(function() writefile(entry.file, data) end)
        if ok then useFile() end
    end
end

local audioResolved = false
local soundStarted = false
local function startSound()
    if soundStarted or not assets.audio.asset or not intro.Parent then return end
    local sound = make("Sound", {
        Name = "CocoIntroAudio",
        SoundId = assets.audio.asset,
        Volume = 0.8,
        Looped = false,
    }, intro)
    local ok = pcall(function() SoundService:PlayLocalSound(sound) end)
    if not ok then ok = pcall(function() sound:Play() end) end
    if ok then soundStarted = true else sound:Destroy() end
end

for _, entry in pairs(assets) do
    task.spawn(function()
        downloadAsset(entry)
        if entry == assets.audio then
            audioResolved = true
            if soundStarted then return end
        end
        if not intro.Parent then return end
        if entry == assets.logo and entry.asset then
            logo.Image = entry.asset
            logoFallback.Visible = false
            animate(logo, 0.4, {ImageTransparency = 0})
        elseif entry == assets.audio then
            startSound()
        else
            updateLayout()
        end
    end)
end

local snowConnection
snowConnection = RunService.RenderStepped:Connect(function(dt)
    if not intro.Parent then snowConnection:Disconnect(); return end
    for _, entry in ipairs(flakes) do
        local p = entry.object.Position
        local y = p.Y.Scale + dt * entry.speed
        if y > 1.03 then y = -0.03 end
        entry.object.Position = UDim2.fromScale(p.X.Scale, y)
    end
end)

local audioWaitStarted = os.clock()
while gui.Parent and not audioResolved and os.clock() - audioWaitStarted < 3 do task.wait(0.05) end
if not gui.Parent then return end
startSound()
local started = os.clock()
while gui.Parent and os.clock() - started < duration do
    local progress = math.clamp((os.clock() - started) / duration, 0, 1)
    fill.Size = UDim2.new(0, math.floor(444 * progress), 1, -6)
    percent.Text = tostring(math.floor(progress * 100)) .. "%"
    if progress < 0.16 then
        status.Text = "Starting Coco Hub"
    elseif progress < 0.44 then
        status.Text = "Loading interface files"
    elseif progress < 0.54 then
        status.Text = "Detecting executor"
    elseif progress < 0.72 then
        status.Text = "Loading modules"
    else
        status.Text = "Finishing setup"
    end
    task.wait(0.03)
end
if not gui.Parent then return end
if snowConnection then snowConnection:Disconnect() end
if cameraConnection then cameraConnection:Disconnect() end
fill.Size = UDim2.new(0, 444, 1, -6)
percent.Text = "100%"
status.Text = "Ready"
task.wait(1.1)
if not gui.Parent then return end

local veil = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = night,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 20,
}, gui)
animate(veil, 0.4, {BackgroundTransparency = 0}).Completed:Wait()
intro:Destroy()

-- Main hub: monochrome interface modeled on the supplied reference.
local Stats = game:GetService("Stats")
local ivory = Color3.fromRGB(247, 247, 247)
local gray = Color3.fromRGB(171, 171, 171)
local black = Color3.fromRGB(5, 5, 5)
local charcoal = Color3.fromRGB(18, 18, 18)
local modules = {Game = {}, Combat = {}, Movement = {}, Visuals = {}}
local tabs = {"Home", "Game", "Combat", "Movement", "Visuals", "Configs", "More"}
local tabIcons = {Home = "⌂", Game = "✣", Combat = "⚔", Movement = "➤", Visuals = "◉", Configs = "⚙", More = "•••"}
local slotIdeas = {
    Game = {"Game profiles", "Place detection", "Game scripts"},
    Combat = {"Aim tools", "Target tools", "Combat presets"},
    Movement = {"Speed", "Jump", "Traversal"},
    Visuals = {"Player overlays", "World visuals", "Display presets"},
}
local tabDescriptions = {
    Game = "Scripts for the game you are playing.",
    Combat = "Combat modules will appear here.",
    Movement = "Movement modules will appear here.",
    Visuals = "Visual modules will appear here.",
    Configs = "Tune the hub to your preference.",
    More = "About Coco Hub and future additions.",
}
local activeTab = "Home"
local motionEnabled = true
local previewAssetId = 0 -- Set to a Roblox video asset ID when a preview is uploaded.
local executorName = "Executor"
for _, detector in ipairs({identifyexecutor, getexecutorname}) do
    if type(detector) == "function" then
        local ok, value = pcall(detector)
        if ok and type(value) == "string" and #value > 0 then executorName = value; break end
    end
end

local function outline(parent, transparency, thickness)
    return make("UIStroke", {Color = ivory, Transparency = transparency or 0.35, Thickness = thickness or 1.3}, parent)
end
local function text(parent, value, size, font, align, z)
    return make("TextLabel", {
        BackgroundTransparency = 1,
        Text = value,
        TextColor3 = ivory,
        TextSize = size,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = align or Enum.TextXAlignment.Center,
        ZIndex = z or 6,
    }, parent)
end
local function roundedButton(parent, value, size, z)
    local button = make("TextButton", {
        Size = size,
        BackgroundColor3 = charcoal,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Text = value,
        TextColor3 = ivory,
        TextSize = 23,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
        ZIndex = z or 7,
    }, parent)
    round(button, 12)
    outline(button, 0.45, 1)
    return button
end

local hub = make("Frame", {
    Name = "MainHub",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = black,
    BorderSizePixel = 0,
    ZIndex = 2,
}, gui)
local hubBackground = make("ImageLabel", {
    Name = "MonochromeWaves",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = assets.hubBackground.asset or "",
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 2,
}, hub)
local shade = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = black,
    BackgroundTransparency = 0.7,
    BorderSizePixel = 0,
    ZIndex = 3,
}, hub)
local rail = make("Frame", {
    Name = "NavigationRail",
    BackgroundColor3 = black,
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
    ZIndex = 4,
}, hub)
round(rail, 18)
outline(rail, 0.8, 1)
local railLogo = make("ImageLabel", {
    BackgroundTransparency = 1,
    Image = assets.hubLogo.asset or "",
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 5,
}, rail)
local railFallback = text(rail, "◒", 42, Enum.Font.GothamBold, Enum.TextXAlignment.Center, 5)
railFallback.Visible = not assets.hubLogo.asset
local railTitle = text(rail, "COCO HUB", 23, Enum.Font.GothamBold, Enum.TextXAlignment.Center, 5)
local railSubtitle = text(rail, "—  U N I V E R S A L   H U B  —", 10, Enum.Font.GothamMedium, Enum.TextXAlignment.Center, 5)
railSubtitle.TextColor3 = gray
local railLine = make("Frame", {BackgroundColor3 = ivory, BackgroundTransparency = 0.7, BorderSizePixel = 0, ZIndex = 5}, rail)
local nav = make("ScrollingFrame", {
    Name = "Sections",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.fromOffset(0, 0),
    ZIndex = 5,
}, rail)
local navLayout = make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, nav)
local navItems = {}
for index, tab in ipairs(tabs) do
    local section = tab
    local button = make("TextButton", {
        Name = section,
        BackgroundColor3 = ivory,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        LayoutOrder = index,
        AutoButtonColor = false,
        ZIndex = 6,
    }, nav)
    round(button, 20)
    local edge = outline(button, 1, 1)
    local icon = text(button, tabIcons[section], 23, Enum.Font.GothamBold, Enum.TextXAlignment.Center, 7)
    local label = text(button, section, 18, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, 7)
    navItems[section] = {button = button, edge = edge, icon = icon, label = label}
end

local minimize = roundedButton(hub, "−", UDim2.fromOffset(44, 44), 12)
local close = roundedButton(hub, "×", UDim2.fromOffset(44, 44), 12)
local bubble = roundedButton(gui, "◒", UDim2.fromOffset(54, 54), 15)
bubble.Name = "ReopenCocoHub"
bubble.Visible = false
bubble.AnchorPoint = Vector2.new(1, 1)
bubble.Position = UDim2.new(1, -18, 1, -18)

local home = make("ScrollingFrame", {
    Name = "HomePage",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.fromOffset(0, 0),
    ZIndex = 5,
}, hub)
local previewGlow = make("Frame", {BackgroundColor3 = ivory, BackgroundTransparency = 0.9, BorderSizePixel = 0, ZIndex = 5}, home)
round(previewGlow, 22)
local preview = make("Frame", {
    Name = "VideoPreview",
    BackgroundColor3 = Color3.fromRGB(13, 13, 13),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 6,
}, home)
round(preview, 20)
outline(preview, 0.05, 1.7)
make("UIGradient", {Color = ColorSequence.new(Color3.fromRGB(24, 24, 24), Color3.fromRGB(8, 8, 8)), Rotation = 90}, preview)
local previewVideo = make("VideoFrame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    Looped = false,
    Volume = 0.75,
    ZIndex = 7,
}, preview)
local previewButton = roundedButton(preview, "▶", UDim2.fromOffset(78, 62), 8)
previewButton.AnchorPoint = Vector2.new(0.5, 0.5)
previewButton.Position = UDim2.fromScale(0.5, 0.47)
previewButton.TextSize = 28
local previewLabel = text(preview, "Video Preview", 18, Enum.Font.Gotham, Enum.TextXAlignment.Center, 8)
previewLabel.TextColor3 = gray
previewLabel.AnchorPoint = Vector2.new(0.5, 0.5)
previewLabel.Position = UDim2.fromScale(0.5, 0.7)
previewLabel.Size = UDim2.new(0.8, 0, 0, 27)

local brand = make("Frame", {BackgroundTransparency = 1, ZIndex = 5}, home)
local bigLogo = make("ImageLabel", {
    BackgroundTransparency = 1,
    Image = assets.hubLogo.asset or "",
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 6,
}, brand)
local bigFallback = text(brand, "◒", 90, Enum.Font.GothamBold, Enum.TextXAlignment.Center, 6)
bigFallback.Visible = not assets.hubLogo.asset
local bigTitle = text(brand, "COCO HUB", 58, Enum.Font.GothamBlack, Enum.TextXAlignment.Center, 6)
bigTitle.TextScaled = true
make("UITextSizeConstraint", {MaxTextSize = 68}, bigTitle)
local bigSubtitle = text(brand, "—   U N I V E R S A L   S C R I P T   H U B   —", 15, Enum.Font.GothamMedium, Enum.TextXAlignment.Center, 6)
bigSubtitle.TextColor3 = gray
bigSubtitle.TextScaled = true
make("UITextSizeConstraint", {MaxTextSize = 17}, bigSubtitle)

local info = make("Frame", {
    Name = "IdentityStrip",
    BackgroundColor3 = Color3.fromRGB(10, 10, 10),
    BackgroundTransparency = 0.17,
    BorderSizePixel = 0,
    ZIndex = 6,
}, home)
round(info, 19)
outline(info, 0.25, 1.2)
local profile = make("Frame", {BackgroundTransparency = 1, ZIndex = 7}, info)
local avatar = make("ImageLabel", {
    BackgroundColor3 = Color3.fromRGB(43, 43, 43),
    BorderSizePixel = 0,
    Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(player.UserId) .. "&w=150&h=150",
    ZIndex = 8,
}, profile)
round(avatar, 11)
local playerName = text(profile, player.DisplayName, 19, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 8)
playerName.TextTruncate = Enum.TextTruncate.AtEnd
local playerId = text(profile, "ID: " .. tostring(player.UserId), 14, Enum.Font.Gotham, Enum.TextXAlignment.Left, 8)
playerId.TextColor3 = gray
local executorPanel = make("Frame", {BackgroundTransparency = 1, ZIndex = 7}, info)
local executorIcon = text(executorPanel, "△", 46, Enum.Font.GothamBold, Enum.TextXAlignment.Center, 8)
local executorText = text(executorPanel, executorName, 19, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 8)
executorText.TextTruncate = Enum.TextTruncate.AtEnd
local executorSub = text(executorPanel, "Executor", 14, Enum.Font.Gotham, Enum.TextXAlignment.Left, 8)
executorSub.TextColor3 = gray
local gamePanel = make("Frame", {BackgroundTransparency = 1, ZIndex = 7}, info)
local gameIcon = make("ImageLabel", {
    BackgroundColor3 = Color3.fromRGB(44, 44, 44),
    BorderSizePixel = 0,
    Image = "rbxthumb://type=GameIcon&id=" .. tostring(game.GameId) .. "&w=150&h=150",
    ZIndex = 8,
}, gamePanel)
round(gameIcon, 11)
local gameName = text(gamePanel, game.Name, 18, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 8)
gameName.TextTruncate = Enum.TextTruncate.AtEnd
local gameSub = text(gamePanel, "Playing on Roblox", 14, Enum.Font.Gotham, Enum.TextXAlignment.Left, 8)
gameSub.TextColor3 = gray
local separator1 = make("Frame", {BackgroundColor3 = ivory, BackgroundTransparency = 0.65, BorderSizePixel = 0, ZIndex = 8}, info)
local separator2 = make("Frame", {BackgroundColor3 = ivory, BackgroundTransparency = 0.65, BorderSizePixel = 0, ZIndex = 8}, info)

local performance = make("Frame", {BackgroundTransparency = 1, ZIndex = 5}, home)
local fpsPill = make("Frame", {BackgroundColor3 = charcoal, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 6}, performance)
round(fpsPill, 30)
outline(fpsPill, 0.18, 1.2)
local fpsText = text(fpsPill, "FPS  --", 22, Enum.Font.GothamMedium, Enum.TextXAlignment.Center, 7)
local pingPill = make("Frame", {BackgroundColor3 = charcoal, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 6}, performance)
round(pingPill, 30)
outline(pingPill, 0.18, 1.2)
local pingText = text(pingPill, "Ping  --", 22, Enum.Font.GothamMedium, Enum.TextXAlignment.Center, 7)

local sectionHeader = make("Frame", {BackgroundTransparency = 1, Visible = false, ZIndex = 5}, hub)
local sectionTitle = text(sectionHeader, "", 34, Enum.Font.GothamBlack, Enum.TextXAlignment.Left, 6)
local sectionSubtitle = text(sectionHeader, "", 16, Enum.Font.Gotham, Enum.TextXAlignment.Left, 6)
sectionSubtitle.TextColor3 = gray
local sections = make("ScrollingFrame", {
    Name = "SectionPage",
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = gray,
    CanvasSize = UDim2.fromOffset(0, 0),
    Visible = false,
    ZIndex = 5,
}, hub)
local sectionLayout = make("UIListLayout", {
    Padding = UDim.new(0, 13),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sections)
sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    sections.CanvasSize = UDim2.fromOffset(0, sectionLayout.AbsoluteContentSize.Y + 20)
end)

local toast = text(hub, "", 14, Enum.Font.GothamMedium, Enum.TextXAlignment.Center, 20)
toast.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
toast.BackgroundTransparency = 1
toast.TextTransparency = 1
toast.Visible = false
round(toast, 12)
outline(toast, 0.3, 1)
local toastSerial = 0
local function notify(message)
    toastSerial = toastSerial + 1
    local id = toastSerial
    toast.Text = message
    toast.Visible = true
    animate(toast, 0.2, {BackgroundTransparency = 0.08, TextTransparency = 0})
    task.delay(2.3, function()
        if id ~= toastSerial or not toast.Parent then return end
        animate(toast, 0.25, {BackgroundTransparency = 1, TextTransparency = 1}).Completed:Wait()
        if id == toastSerial then toast.Visible = false end
    end)
end

local function viewSize()
    return camera and camera.ViewportSize or Vector2.new(1280, 720)
end
local function layout()
    local view = viewSize()
    local w, h = view.X, view.Y
    local portrait = w < h
    local railWidth = math.max(150, math.min(230, math.floor(w * 0.18)))
    if portrait then
        rail.Position = UDim2.fromOffset(6, 5)
        rail.Size = UDim2.new(1, -12, 0, 105)
        railLogo.Position = UDim2.fromOffset(12, 4)
        railLogo.Size = UDim2.fromOffset(65, 50)
        railFallback.Position = railLogo.Position
        railFallback.Size = railLogo.Size
        railTitle.Position = UDim2.fromOffset(76, 10)
        railTitle.Size = UDim2.fromOffset(155, 26)
        railTitle.TextXAlignment = Enum.TextXAlignment.Left
        railTitle.TextSize = 19
        railSubtitle.Visible = false
        railLine.Visible = false
        nav.Position = UDim2.fromOffset(9, 59)
        nav.Size = UDim2.new(1, -18, 0, 42)
        nav.ScrollingDirection = Enum.ScrollingDirection.X
        nav.CanvasSize = UDim2.fromOffset(#tabs * 108, 0)
        navLayout.FillDirection = Enum.FillDirection.Horizontal
        for _, item in pairs(navItems) do
            item.button.Size = UDim2.fromOffset(101, 37)
            item.icon.Position = UDim2.fromOffset(8, 2)
            item.icon.Size = UDim2.fromOffset(27, 33)
            item.icon.TextSize = 19
            item.label.Position = UDim2.fromOffset(38, 2)
            item.label.Size = UDim2.fromOffset(60, 33)
            item.label.TextSize = 13
        end
        minimize.Position = UDim2.new(1, -90, 0, 9)
        close.Position = UDim2.new(1, -48, 0, 9)
        minimize.Size = UDim2.fromOffset(35, 35)
        close.Size = UDim2.fromOffset(35, 35)
        home.Position = UDim2.fromOffset(0, 110)
        home.Size = UDim2.new(1, 0, 1, -110)
        local area = w - 32
        local previewHeight = math.min(190, math.max(150, math.floor(h * 0.22)))
        preview.Position = UDim2.fromOffset(16, 18)
        preview.Size = UDim2.fromOffset(area, previewHeight)
        previewGlow.Position = UDim2.fromOffset(13, 15)
        previewGlow.Size = UDim2.fromOffset(area + 6, previewHeight + 6)
        previewButton.Size = UDim2.fromOffset(64, 50)
        brand.Position = UDim2.fromOffset(16, 18 + previewHeight + 14)
        brand.Size = UDim2.fromOffset(area, 158)
        bigLogo.Position = UDim2.new(0.5, -55, 0, 0)
        bigLogo.Size = UDim2.fromOffset(110, 95)
        bigFallback.Position = bigLogo.Position
        bigFallback.Size = bigLogo.Size
        bigTitle.Position = UDim2.new(0, 0, 0, 95)
        bigTitle.Size = UDim2.new(1, 0, 0, 42)
        bigSubtitle.Position = UDim2.new(0, 0, 0, 137)
        bigSubtitle.Size = UDim2.new(1, 0, 0, 18)
        local infoY = 18 + previewHeight + 186
        info.Position = UDim2.fromOffset(16, infoY)
        info.Size = UDim2.fromOffset(area, 174)
        local rowW = area - 24
        profile.Position = UDim2.fromOffset(12, 10)
        profile.Size = UDim2.fromOffset(rowW, 49)
        executorPanel.Position = UDim2.fromOffset(12, 62)
        executorPanel.Size = UDim2.fromOffset(rowW, 49)
        gamePanel.Position = UDim2.fromOffset(12, 114)
        gamePanel.Size = UDim2.fromOffset(rowW, 49)
        separator1.Position = UDim2.fromOffset(12, 59)
        separator1.Size = UDim2.fromOffset(rowW, 1)
        separator2.Position = UDim2.fromOffset(12, 111)
        separator2.Size = UDim2.fromOffset(rowW, 1)
        for _, thumbnail in ipairs({avatar, gameIcon}) do thumbnail.Position = UDim2.fromOffset(0, 2); thumbnail.Size = UDim2.fromOffset(44, 44) end
        playerName.Position = UDim2.fromOffset(54, 2); playerName.Size = UDim2.new(1, -60, 0, 24)
        playerId.Position = UDim2.fromOffset(54, 26); playerId.Size = UDim2.new(1, -60, 0, 19)
        executorIcon.Position = UDim2.fromOffset(0, 0); executorIcon.Size = UDim2.fromOffset(44, 46)
        executorText.Position = UDim2.fromOffset(54, 2); executorText.Size = UDim2.new(1, -60, 0, 24)
        executorSub.Position = UDim2.fromOffset(54, 26); executorSub.Size = UDim2.new(1, -60, 0, 19)
        gameName.Position = UDim2.fromOffset(54, 2); gameName.Size = UDim2.new(1, -60, 0, 24)
        gameSub.Position = UDim2.fromOffset(54, 26); gameSub.Size = UDim2.new(1, -60, 0, 19)
        performance.Position = UDim2.fromOffset(16, infoY + 191)
        performance.Size = UDim2.fromOffset(area, 54)
        local pillWidth = math.floor((area - 10) / 2)
        fpsPill.Position = UDim2.fromOffset(0, 0); fpsPill.Size = UDim2.fromOffset(pillWidth, 50)
        pingPill.Position = UDim2.fromOffset(pillWidth + 10, 0); pingPill.Size = UDim2.fromOffset(pillWidth, 50)
        home.CanvasSize = UDim2.fromOffset(0, infoY + 260)
        sectionHeader.Position = UDim2.fromOffset(18, 121)
        sectionHeader.Size = UDim2.new(1, -36, 0, 76)
        sections.Position = UDim2.fromOffset(16, 201)
        sections.Size = UDim2.new(1, -32, 1, -212)
    else
        rail.Position = UDim2.fromOffset(6, 5)
        rail.Size = UDim2.fromOffset(railWidth, h - 10)
        local brandHeight = math.min(160, math.max(93, math.floor(h * 0.23)))
        railLogo.Position = UDim2.fromOffset(math.floor((railWidth - 90) / 2), 9)
        railLogo.Size = UDim2.fromOffset(90, math.floor(brandHeight * 0.49))
        railFallback.Position = railLogo.Position
        railFallback.Size = railLogo.Size
        railTitle.Position = UDim2.fromOffset(8, math.floor(brandHeight * 0.53))
        railTitle.Size = UDim2.fromOffset(railWidth - 16, 34)
        railTitle.TextXAlignment = Enum.TextXAlignment.Center
        railTitle.TextSize = math.min(24, math.max(18, math.floor(h * 0.035)))
        railSubtitle.Visible = true
        railSubtitle.Position = UDim2.fromOffset(6, math.floor(brandHeight * 0.53) + 37)
        railSubtitle.Size = UDim2.fromOffset(railWidth - 12, 15)
        railLine.Visible = true
        railLine.Position = UDim2.fromOffset(20, brandHeight)
        railLine.Size = UDim2.fromOffset(railWidth - 40, 1)
        nav.Position = UDim2.fromOffset(9, brandHeight + 17)
        nav.Size = UDim2.new(1, -18, 1, -(brandHeight + 28))
        nav.ScrollingDirection = Enum.ScrollingDirection.Y
        navLayout.FillDirection = Enum.FillDirection.Vertical
        local navHeight = math.min(49, math.max(34, math.floor((h - brandHeight - 55) / 7)))
        nav.CanvasSize = UDim2.fromOffset(0, #tabs * (navHeight + 7))
        for _, item in pairs(navItems) do
            item.button.Size = UDim2.new(1, -2, 0, navHeight)
            item.icon.Position = UDim2.fromOffset(12, 0)
            item.icon.Size = UDim2.fromOffset(29, navHeight)
            item.icon.TextSize = math.min(23, navHeight - 9)
            item.label.Position = UDim2.fromOffset(50, 0)
            item.label.Size = UDim2.new(1, -55, 1, 0)
            item.label.TextSize = math.min(18, math.max(13, math.floor(navHeight * 0.4)))
        end
        minimize.Position = UDim2.new(1, -104, 0, 14)
        close.Position = UDim2.new(1, -52, 0, 14)
        minimize.Size = UDim2.fromOffset(42, 42)
        close.Size = UDim2.fromOffset(42, 42)
        local left = railWidth + 36
        local area = w - left - 28
        home.Position = UDim2.fromOffset(left, 0)
        home.Size = UDim2.fromOffset(area, h)
        local top = math.floor(h * 0.16)
        local upper = math.floor(h * 0.39)
        local gap = math.max(16, math.floor(area * 0.025))
        local previewWidth = math.floor((area - gap) * 0.48)
        preview.Position = UDim2.fromOffset(0, top)
        preview.Size = UDim2.fromOffset(previewWidth, upper)
        previewGlow.Position = UDim2.fromOffset(-3, top - 3)
        previewGlow.Size = UDim2.fromOffset(previewWidth + 6, upper + 6)
        previewButton.Size = UDim2.fromOffset(math.min(78, math.floor(upper * 0.3)), math.min(62, math.floor(upper * 0.25)))
        brand.Position = UDim2.fromOffset(previewWidth + gap, top - 45)
        brand.Size = UDim2.fromOffset(area - previewWidth - gap, upper + 45)
        local logoHeight = math.floor(brand.AbsoluteSize.Y * 0.53)
        if logoHeight == 0 then logoHeight = math.floor((upper + 45) * 0.53) end
        bigLogo.Position = UDim2.new(0.5, -logoHeight * 0.58, 0, 0)
        bigLogo.Size = UDim2.fromOffset(math.floor(logoHeight * 1.16), logoHeight)
        bigFallback.Position = bigLogo.Position
        bigFallback.Size = bigLogo.Size
        bigTitle.Position = UDim2.new(0, 0, 0, logoHeight)
        bigTitle.Size = UDim2.new(1, 0, 0, math.floor(upper * 0.28))
        bigSubtitle.Position = UDim2.new(0, 0, 0, logoHeight + math.floor(upper * 0.28))
        bigSubtitle.Size = UDim2.new(1, 0, 0, 24)
        local infoY = top + upper + math.max(18, math.floor(h * 0.04))
        local infoHeight = math.max(66, math.min(98, math.floor(h * 0.135)))
        info.Position = UDim2.fromOffset(0, infoY)
        info.Size = UDim2.fromOffset(area, infoHeight)
        local profileWidth = math.floor(area * 0.36)
        local executorWidth = math.floor(area * 0.22)
        profile.Position = UDim2.fromOffset(11, 0)
        profile.Size = UDim2.fromOffset(profileWidth - 17, infoHeight)
        executorPanel.Position = UDim2.fromOffset(profileWidth + 9, 0)
        executorPanel.Size = UDim2.fromOffset(executorWidth - 15, infoHeight)
        gamePanel.Position = UDim2.fromOffset(profileWidth + executorWidth + 9, 0)
        gamePanel.Size = UDim2.fromOffset(area - profileWidth - executorWidth - 20, infoHeight)
        separator1.Position = UDim2.fromOffset(profileWidth, 19)
        separator1.Size = UDim2.fromOffset(1, infoHeight - 38)
        separator2.Position = UDim2.fromOffset(profileWidth + executorWidth, 19)
        separator2.Size = UDim2.fromOffset(1, infoHeight - 38)
        local iconSize = math.min(68, infoHeight - 17)
        avatar.Position = UDim2.fromOffset(5, math.floor((infoHeight - iconSize) / 2))
        avatar.Size = UDim2.fromOffset(iconSize, iconSize)
        gameIcon.Position = UDim2.fromOffset(5, math.floor((infoHeight - iconSize) / 2))
        gameIcon.Size = UDim2.fromOffset(iconSize, iconSize)
        playerName.Position = UDim2.fromOffset(iconSize + 15, math.floor(infoHeight * 0.23))
        playerName.Size = UDim2.new(1, -(iconSize + 18), 0, 25)
        playerId.Position = UDim2.fromOffset(iconSize + 15, math.floor(infoHeight * 0.55))
        playerId.Size = UDim2.new(1, -(iconSize + 18), 0, 20)
        executorIcon.Position = UDim2.fromOffset(3, math.floor((infoHeight - 52) / 2))
        executorIcon.Size = UDim2.fromOffset(50, 52)
        executorText.Position = UDim2.fromOffset(56, math.floor(infoHeight * 0.23))
        executorText.Size = UDim2.new(1, -60, 0, 25)
        executorSub.Position = UDim2.fromOffset(56, math.floor(infoHeight * 0.55))
        executorSub.Size = UDim2.new(1, -60, 0, 20)
        gameName.Position = UDim2.fromOffset(iconSize + 15, math.floor(infoHeight * 0.23))
        gameName.Size = UDim2.new(1, -(iconSize + 18), 0, 25)
        gameSub.Position = UDim2.fromOffset(iconSize + 15, math.floor(infoHeight * 0.55))
        gameSub.Size = UDim2.new(1, -(iconSize + 18), 0, 20)
        performance.Position = UDim2.fromOffset(math.max(0, math.floor((area - 610) / 2)), infoY + infoHeight + 26)
        performance.Size = UDim2.fromOffset(math.min(610, area), 68)
        local pillWidth = math.floor((performance.Size.X.Offset - 24) / 2)
        fpsPill.Position = UDim2.fromOffset(0, 0)
        fpsPill.Size = UDim2.fromOffset(pillWidth, 62)
        pingPill.Position = UDim2.fromOffset(pillWidth + 24, 0)
        pingPill.Size = UDim2.fromOffset(pillWidth, 62)
        home.CanvasSize = UDim2.fromOffset(0, math.max(h, infoY + infoHeight + 115))
        sectionHeader.Position = UDim2.fromOffset(left, math.max(75, math.floor(h * 0.13)))
        sectionHeader.Size = UDim2.fromOffset(area, 84)
        sections.Position = UDim2.fromOffset(left, math.max(168, math.floor(h * 0.25)))
        sections.Size = UDim2.fromOffset(area, h - sections.Position.Y.Offset - 24)
    end
    previewLabel.Visible = true
    fpsText.Size = UDim2.fromScale(1, 1)
    pingText.Size = UDim2.fromScale(1, 1)
    sectionTitle.Position = UDim2.fromOffset(0, 0)
    sectionTitle.Size = UDim2.new(1, 0, 0, 46)
    sectionSubtitle.Position = UDim2.fromOffset(1, 48)
    sectionSubtitle.Size = UDim2.new(1, -2, 0, 27)
    toast.AnchorPoint = Vector2.new(0.5, 1)
    toast.Position = UDim2.new(0.5, 0, 1, -22)
    toast.Size = UDim2.fromOffset(math.min(400, w - 30), 42)
end

local sectionOrder = 0
local function clearSection()
    for _, child in ipairs(sections:GetChildren()) do if child ~= sectionLayout then child:Destroy() end end
    sectionOrder = 0
    sections.CanvasPosition = Vector2.new(0, 0)
end
local function sectionCard(height)
    sectionOrder = sectionOrder + 1
    local card = make("Frame", {
        Size = UDim2.new(1, -8, 0, height),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        LayoutOrder = sectionOrder,
        ZIndex = 6,
    }, sections)
    round(card, 18)
    outline(card, 0.42, 1)
    return card
end
local function slotCard(titleValue, detail)
    local card = sectionCard(95)
    local icon = text(card, "+", 29, Enum.Font.GothamMedium, Enum.TextXAlignment.Center, 7)
    icon.Position = UDim2.fromOffset(16, 20)
    icon.Size = UDim2.fromOffset(52, 52)
    icon.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    round(icon, 15)
    outline(icon, 0.6, 1)
    local name = text(card, titleValue, 19, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 7)
    name.Position = UDim2.fromOffset(82, 19)
    name.Size = UDim2.new(1, -98, 0, 28)
    local sub = text(card, detail, 13, Enum.Font.Gotham, Enum.TextXAlignment.Left, 7)
    sub.TextColor3 = gray
    sub.Position = UDim2.fromOffset(83, 53)
    sub.Size = UDim2.new(1, -100, 0, 24)
    sub.TextWrapped = true
end
local function moduleCard(module)
    local card = sectionCard(105)
    local name = text(card, module.title, 20, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 7)
    name.Position = UDim2.fromOffset(18, 17)
    name.Size = UDim2.new(1, -135, 0, 32)
    local detail = text(card, module.description or "", 13, Enum.Font.Gotham, Enum.TextXAlignment.Left, 7)
    detail.TextColor3 = gray
    detail.Position = UDim2.fromOffset(19, 55)
    detail.Size = UDim2.new(1, -138, 0, 34)
    detail.TextWrapped = true
    local run = roundedButton(card, "RUN", UDim2.fromOffset(90, 39), 8)
    run.AnchorPoint = Vector2.new(1, 0.5)
    run.Position = UDim2.new(1, -17, 0.5, 0)
    run.TextSize = 14
    run.MouseButton1Click:Connect(function()
        local ok, err = pcall(module.run)
        notify(ok and (module.title .. " launched") or ("Module error: " .. tostring(err)))
    end)
end
local renderSection
local function settingCard(nameValue, detail, value, action)
    local card = sectionCard(92)
    local name = text(card, nameValue, 19, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 7)
    name.Position = UDim2.fromOffset(18, 17)
    name.Size = UDim2.new(1, -145, 0, 27)
    local sub = text(card, detail, 13, Enum.Font.Gotham, Enum.TextXAlignment.Left, 7)
    sub.TextColor3 = gray
    sub.Position = UDim2.fromOffset(18, 51)
    sub.Size = UDim2.new(1, -145, 0, 28)
    local button = roundedButton(card, value, UDim2.fromOffset(102, 36), 8)
    button.AnchorPoint = Vector2.new(1, 0.5)
    button.Position = UDim2.new(1, -18, 0.5, 0)
    button.TextSize = 13
    button.MouseButton1Click:Connect(action)
    return button
end
renderSection = function()
    clearSection()
    sectionTitle.Text = string.upper(activeTab)
    sectionSubtitle.Text = tabDescriptions[activeTab] or ""
    if activeTab == "Game" then
        local card = sectionCard(105)
        local name = text(card, game.Name, 21, Enum.Font.GothamBold, Enum.TextXAlignment.Left, 7)
        name.Position = UDim2.fromOffset(18, 16)
        name.Size = UDim2.new(1, -36, 0, 32)
        name.TextTruncate = Enum.TextTruncate.AtEnd
        local id = text(card, "Place ID: " .. tostring(game.PlaceId), 14, Enum.Font.Gotham, Enum.TextXAlignment.Left, 7)
        id.TextColor3 = gray
        id.Position = UDim2.fromOffset(19, 55)
        id.Size = UDim2.new(1, -38, 0, 25)
    end
    if modules[activeTab] then
        if #modules[activeTab] == 0 then
            for _, idea in ipairs(slotIdeas[activeTab]) do slotCard(idea, "Ready for a future universal module") end
        else
            for _, module in ipairs(modules[activeTab]) do moduleCard(module) end
        end
    elseif activeTab == "Configs" then
        settingCard("UI animations", "Transitions and glow effects", motionEnabled and "ON" or "OFF", function()
            motionEnabled = not motionEnabled
            renderSection()
            notify("Animations " .. (motionEnabled and "enabled" or "reduced"))
        end)
        settingCard("Preview video", "Requires a Roblox video asset ID", previewAssetId ~= 0 and "SET" or "NONE", function()
            notify("Set a Roblox video asset ID in the script to enable preview")
        end)
    elseif activeTab == "More" then
        slotCard("Coco Hub prototype", "The home for universal scripts and future modules")
        slotCard("Module registry", "Register scripts into Game, Combat, Movement, or Visuals")
    end
end
local function selectTab(tab)
    if not table.find(tabs, tab) then return end
    activeTab = tab
    home.Visible = tab == "Home"
    sectionHeader.Visible = tab ~= "Home"
    sections.Visible = tab ~= "Home"
    for name, item in pairs(navItems) do
        local chosen = name == tab
        if motionEnabled then animate(item.button, 0.18, {BackgroundTransparency = chosen and 0.85 or 1})
        else item.button.BackgroundTransparency = chosen and 0.85 or 1 end
        item.edge.Transparency = chosen and 0.18 or 1
        item.label.TextColor3 = chosen and ivory or gray
    end
    if tab ~= "Home" then renderSection() end
end
for name, item in pairs(navItems) do
    local target = name
    item.button.MouseButton1Click:Connect(function() selectTab(target) end)
    item.button.MouseEnter:Connect(function()
        if target ~= activeTab and motionEnabled then animate(item.button, 0.15, {BackgroundTransparency = 0.93}) end
    end)
    item.button.MouseLeave:Connect(function()
        if target ~= activeTab and motionEnabled then animate(item.button, 0.15, {BackgroundTransparency = 1}) end
    end)
end

previewButton.MouseButton1Click:Connect(function()
    if previewAssetId == 0 then
        notify("Video preview needs a Roblox video asset ID")
        return
    end
    previewVideo.Video = "rbxassetid://" .. tostring(previewAssetId)
    previewVideo.Visible = true
    previewButton.Visible = false
    previewLabel.Visible = false
    local ok = pcall(function() previewVideo:Play() end)
    if not ok then
        previewVideo.Visible = false
        previewButton.Visible = true
        previewLabel.Visible = true
        notify("Video could not play")
    end
end)
minimize.MouseButton1Click:Connect(function()
    hub.Visible = false
    bubble.Visible = true
end)
bubble.MouseButton1Click:Connect(function()
    hub.Visible = true
    bubble.Visible = false
end)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local fpsCount, fpsElapsed = 0, 0
local perfConnection
perfConnection = RunService.RenderStepped:Connect(function(dt)
    if not gui.Parent then perfConnection:Disconnect(); return end
    fpsCount = fpsCount + 1
    fpsElapsed = fpsElapsed + dt
    if fpsElapsed >= 1 then
        fpsText.Text = "▣  FPS  " .. tostring(math.floor(fpsCount / fpsElapsed + 0.5))
        fpsCount, fpsElapsed = 0, 0
        local ping = "--"
        pcall(function()
            local raw = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
            ping = string.match(raw, "[%d%.]+") or "--"
        end)
        pingText.Text = "◉  Ping  " .. ping .. " ms"
    end
end)

local hubApi = {}
function hubApi:RegisterModule(info)
    if type(info) ~= "table" or not modules[info.section] or type(info.title) ~= "string" or type(info.run) ~= "function" then
        return false, "Expected {section, title, run, description?}"
    end
    for _, previous in ipairs(modules[info.section]) do
        if previous.title == info.title then return false, "Module already registered" end
    end
    table.insert(modules[info.section], info)
    if activeTab == info.section then renderSection() end
    notify(info.title .. " added to " .. info.section)
    return true
end
function hubApi:OpenTab(tab)
    if not table.find(tabs, tab) then return false end
    hub.Visible = true
    bubble.Visible = false
    selectTab(tab)
    return true
end
function hubApi:SetPreviewAssetId(id)
    if type(id) ~= "number" or id <= 0 then return false end
    previewAssetId = id
    return true
end
function hubApi:Destroy()
    gui:Destroy()
end
local environment = (getgenv and getgenv()) or _G
environment.CocoHub = hubApi

layout()
if camera then camera:GetPropertyChangedSignal("ViewportSize"):Connect(layout) end
for _, entry in ipairs({assets.hubBackground, assets.hubLogo}) do
    task.spawn(function()
        local waited = 0
        while not entry.asset and gui.Parent and waited < 10 do task.wait(0.2); waited = waited + 0.2 end
        if not gui.Parent then return end
        if entry == assets.hubBackground and entry.asset then hubBackground.Image = entry.asset end
        if entry == assets.hubLogo and entry.asset then
            railLogo.Image = entry.asset
            bigLogo.Image = entry.asset
            railFallback.Visible = false
            bigFallback.Visible = false
        end
    end)
end
selectTab("Home")
animate(veil, 0.4, {BackgroundTransparency = 1}).Completed:Wait()
veil:Destroy()
