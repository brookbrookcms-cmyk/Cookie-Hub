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

-- Main hub prototype. Sections are containers for future universal modules.
local UserInputService = game:GetService("UserInputService")
local ice = Color3.fromRGB(115, 213, 255)
local softText = Color3.fromRGB(173, 194, 215)
local panel = Color3.fromRGB(10, 27, 49)
local surface = Color3.fromRGB(17, 40, 68)
local gold = Color3.fromRGB(255, 211, 143)
local violet = Color3.fromRGB(178, 147, 255)
local coral = Color3.fromRGB(255, 151, 157)
local accent = ice
local motion = true
local selected = "Home"
local query = ""
local tabs = {"Home", "Game", "Combat", "Movement", "Visuals", "Configs", "More"}
local descriptions = {
    Game = "Game-specific scripts and automatic place detection.",
    Combat = "A home for future combat tools and presets.",
    Movement = "Movement modules, routes, and traversal tools.",
    Visuals = "Visual modules and display controls.",
}
local ideas = {
    Game = {"Game profiles", "Place-aware modules", "Quick launch"},
    Combat = {"Aim tools", "Target information", "Combat presets"},
    Movement = {"Speed controls", "Jump controls", "Traversal"},
    Visuals = {"Player overlays", "World controls", "Display presets"},
}
local modules = {Game = {}, Combat = {}, Movement = {}, Visuals = {}}

local dimmer = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(1, 9, 20),
    BackgroundTransparency = 0.42,
    BorderSizePixel = 0,
    ZIndex = 1,
}, gui)
local shadow = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(932, 572),
    BackgroundColor3 = ice,
    BackgroundTransparency = 0.89,
    BorderSizePixel = 0,
    ZIndex = 2,
}, gui)
round(shadow, 28)
local main = make("Frame", {
    Name = "MainHub",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(920, 560),
    BackgroundColor3 = panel,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 3,
}, gui)
round(main, 22)
local mainStroke = make("UIStroke", {Color = ice, Thickness = 1.5, Transparency = 0.35}, main)
make("UIGradient", {
    Color = ColorSequence.new(Color3.fromRGB(13, 36, 65), Color3.fromRGB(7, 20, 39)),
    Rotation = 90,
}, main)
local openingScale = make("UIScale", {Scale = 0.94}, main)

local sidebar = make("Frame", {
    Size = UDim2.new(0, 190, 1, 0),
    BackgroundColor3 = Color3.fromRGB(10, 30, 56),
    BorderSizePixel = 0,
    ZIndex = 4,
}, main)
make("UIGradient", {
    Color = ColorSequence.new(Color3.fromRGB(16, 45, 78), Color3.fromRGB(7, 23, 46)),
    Rotation = 90,
}, sidebar)
local brand = make("Frame", {
    Position = UDim2.fromOffset(13, 13),
    Size = UDim2.fromOffset(165, 70),
    BackgroundTransparency = 1,
    ZIndex = 5,
}, sidebar)
local brandLogo = make("ImageLabel", {
    Position = UDim2.fromOffset(-12, -9),
    Size = UDim2.fromOffset(94, 63),
    BackgroundTransparency = 1,
    Image = assets.logo.asset or "",
    ZIndex = 5,
}, brand)
local brandFallback = make("TextLabel", {
    Position = UDim2.fromOffset(7, 7),
    Size = UDim2.fromOffset(42, 42),
    BackgroundColor3 = Color3.fromRGB(168, 92, 35),
    Text = "C",
    TextColor3 = white,
    TextSize = 28,
    Font = Enum.Font.GothamBold,
    Visible = not assets.logo.asset,
    ZIndex = 5,
}, brand)
round(brandFallback, 24)
make("TextLabel", {
    Position = UDim2.fromOffset(58, 9),
    Size = UDim2.fromOffset(104, 27),
    BackgroundTransparency = 1,
    Text = "COCO HUB",
    TextColor3 = white,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    ZIndex = 5,
}, brand)
make("TextLabel", {
    Position = UDim2.fromOffset(59, 34),
    Size = UDim2.fromOffset(105, 17),
    BackgroundTransparency = 1,
    Text = "UNIVERSAL HUB",
    TextColor3 = softText,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    ZIndex = 5,
}, brand)

local nav = make("ScrollingFrame", {
    Name = "Navigation",
    Position = UDim2.fromOffset(12, 102),
    Size = UDim2.new(1, -24, 1, -120),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 0,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    CanvasSize = UDim2.fromOffset(0, 352),
    ZIndex = 5,
}, sidebar)
local navLayout = make("UIListLayout", {
    Padding = UDim.new(0, 6),
    FillDirection = Enum.FillDirection.Vertical,
    SortOrder = Enum.SortOrder.LayoutOrder,
}, nav)
local navItems = {}
local navCodes = {Home = "H", Game = "G", Combat = "C", Movement = "M", Visuals = "V", Configs = "S", More = "··"}
for index, tab in ipairs(tabs) do
    local item = make("TextButton", {
        Name = tab,
        Size = UDim2.new(1, -2, 0, 42),
        BackgroundColor3 = ice,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        LayoutOrder = index,
        AutoButtonColor = false,
        ZIndex = 5,
    }, nav)
    round(item, 11)
    local mark = make("Frame", {
        Position = UDim2.fromOffset(0, 7),
        Size = UDim2.fromOffset(3, 28),
        BackgroundColor3 = ice,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 6,
    }, item)
    round(mark, 3)
    local icon = make("TextLabel", {
        Position = UDim2.fromOffset(10, 7),
        Size = UDim2.fromOffset(28, 28),
        BackgroundColor3 = Color3.fromRGB(31, 65, 95),
        Text = navCodes[tab],
        TextColor3 = white,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        ZIndex = 6,
    }, item)
    round(icon, 9)
    local name = make("TextLabel", {
        Position = UDim2.fromOffset(47, 0),
        Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1,
        Text = tab,
        TextColor3 = softText,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
        ZIndex = 6,
    }, item)
    navItems[tab] = {button = item, mark = mark, icon = icon, name = name}
end
local sidebarFoot = make("TextLabel", {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 20, 1, -15),
    Size = UDim2.new(1, -32, 0, 20),
    BackgroundTransparency = 1,
    Text = "DRAFT  •  CHRISTMAS EDITION",
    TextColor3 = softText,
    TextTransparency = 0.35,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamMedium,
    ZIndex = 5,
}, sidebar)

local content = make("Frame", {
    Position = UDim2.fromOffset(190, 0),
    Size = UDim2.new(1, -190, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 4,
}, main)
local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 76),
    BackgroundTransparency = 1,
    ZIndex = 5,
}, content)
local headerTitle = make("TextLabel", {
    Position = UDim2.fromOffset(22, 13),
    Size = UDim2.new(1, -86, 0, 32),
    BackgroundTransparency = 1,
    Text = "Home",
    TextColor3 = white,
    TextSize = 26,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    ZIndex = 6,
}, header)
local headerSub = make("TextLabel", {
    Position = UDim2.fromOffset(23, 45),
    Size = UDim2.new(1, -86, 0, 20),
    BackgroundTransparency = 1,
    Text = "Everything in one place.",
    TextColor3 = softText,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.Gotham,
    ZIndex = 6,
}, header)
local search = make("TextBox", {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -60, 0, 21),
    Size = UDim2.fromOffset(190, 38),
    BackgroundColor3 = Color3.fromRGB(20, 45, 72),
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "Search modules...",
    PlaceholderColor3 = softText,
    TextColor3 = white,
    TextSize = 14,
    ClearTextOnFocus = false,
    Font = Enum.Font.Gotham,
    ZIndex = 6,
}, header)
round(search, 13)
make("UIStroke", {Color = ice, Thickness = 1, Transparency = 0.66}, search)
make("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 10)}, search)
local close = make("TextButton", {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -16, 0, 21),
    Size = UDim2.fromOffset(34, 38),
    BackgroundColor3 = Color3.fromRGB(29, 55, 82),
    BorderSizePixel = 0,
    Text = "×",
    TextColor3 = white,
    TextSize = 22,
    Font = Enum.Font.GothamMedium,
    ZIndex = 6,
}, header)
round(close, 12)

local page = make("ScrollingFrame", {
    Name = "Page",
    Position = UDim2.fromOffset(20, 78),
    Size = UDim2.new(1, -40, 1, -96),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = ice,
    CanvasSize = UDim2.fromOffset(0, 0),
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ZIndex = 5,
}, content)
local pageLayout = make("UIListLayout", {
    Padding = UDim.new(0, 11),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, page)
pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    page.CanvasSize = UDim2.fromOffset(0, pageLayout.AbsoluteContentSize.Y + 18)
end)

local toast = make("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -20),
    Size = UDim2.fromOffset(300, 40),
    BackgroundColor3 = Color3.fromRGB(32, 68, 98),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = white,
    TextTransparency = 1,
    TextSize = 14,
    Font = Enum.Font.GothamMedium,
    Visible = false,
    ZIndex = 15,
}, main)
round(toast, 12)
local toastSerial = 0
local function notify(message)
    toastSerial = toastSerial + 1
    local id = toastSerial
    toast.Text = message
    toast.Visible = true
    animate(toast, 0.2, {BackgroundTransparency = 0.08, TextTransparency = 0})
    task.delay(2.5, function()
        if id ~= toastSerial or not toast.Parent then return end
        animate(toast, 0.25, {BackgroundTransparency = 1, TextTransparency = 1}).Completed:Wait()
        if id == toastSerial then toast.Visible = false end
    end)
end

local bubble = make("TextButton", {
    Name = "ReopenHub",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -22, 1, -22),
    Size = UDim2.fromOffset(54, 54),
    BackgroundColor3 = panel,
    BorderSizePixel = 0,
    Text = "C",
    TextColor3 = white,
    TextSize = 28,
    Font = Enum.Font.GothamBold,
    Visible = false,
    ZIndex = 17,
}, gui)
round(bubble, 28)
make("UIStroke", {Color = ice, Thickness = 2}, bubble)

local function label(parent, textValue, size, color, font, height)
    return make("TextLabel", {
        Size = UDim2.new(1, 0, 0, height),
        BackgroundTransparency = 1,
        Text = textValue,
        TextColor3 = color or white,
        TextSize = size,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Font = font or Enum.Font.Gotham,
        ZIndex = 7,
    }, parent)
end
local layoutIndex = 0
local function card(height, tint)
    layoutIndex = layoutIndex + 1
    local frame = make("Frame", {
        Size = UDim2.new(1, -5, 0, height),
        BackgroundColor3 = tint or surface,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = layoutIndex,
        ZIndex = 6,
    }, page)
    round(frame, 18)
    make("UIStroke", {Color = accent, Thickness = 1, Transparency = 0.7}, frame)
    return frame
end
local function clearPage()
    layoutIndex = 0
    for _, child in ipairs(page:GetChildren()) do
        if child ~= pageLayout then child:Destroy() end
    end
    page.CanvasPosition = Vector2.new(0, 0)
end
local function pill(parent, textValue, x, y, width, tint)
    local tag = make("TextLabel", {
        Position = UDim2.fromOffset(x, y),
        Size = UDim2.fromOffset(width, 25),
        BackgroundColor3 = tint or Color3.fromRGB(31, 69, 100),
        Text = textValue,
        TextColor3 = white,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        ZIndex = 8,
    }, parent)
    round(tag, 13)
    return tag
end
local function emptyCard(titleText, descriptionText)
    local frame = card(102)
    local circle = make("TextLabel", {
        Position = UDim2.fromOffset(17, 24),
        Size = UDim2.fromOffset(50, 50),
        BackgroundColor3 = Color3.fromRGB(33, 75, 109),
        Text = "+",
        TextColor3 = accent,
        TextSize = 30,
        Font = Enum.Font.GothamMedium,
        ZIndex = 7,
    }, frame)
    round(circle, 16)
    make("TextLabel", {
        Position = UDim2.fromOffset(82, 19),
        Size = UDim2.new(1, -100, 0, 30),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = white,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 7,
    }, frame)
    make("TextLabel", {
        Position = UDim2.fromOffset(82, 53),
        Size = UDim2.new(1, -100, 0, 32),
        BackgroundTransparency = 1,
        Text = descriptionText,
        TextColor3 = softText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, frame)
    return frame
end

local function moduleCard(module)
    local frame = card(112)
    pill(frame, "MODULE", 16, 15, 72)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 44),
        Size = UDim2.new(1, -136, 0, 27),
        BackgroundTransparency = 1,
        Text = module.title,
        TextColor3 = white,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 7,
    }, frame)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 73),
        Size = UDim2.new(1, -136, 0, 27),
        BackgroundTransparency = 1,
        Text = module.description or "",
        TextColor3 = softText,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, frame)
    local run = make("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -16, 0.5, 0),
        Size = UDim2.fromOffset(88, 34),
        BackgroundColor3 = accent,
        Text = "Run",
        TextColor3 = night,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 8,
    }, frame)
    round(run, 12)
    run.MouseButton1Click:Connect(function()
        local ok, err = pcall(module.run)
        notify(ok and (module.title .. " launched") or ("Module error: " .. tostring(err)))
    end)
end

local renderPage
local selectTab
local function renderHome()
    local hero = card(185, Color3.fromRGB(19, 52, 86))
    make("UIGradient", {
        Color = ColorSequence.new(Color3.fromRGB(25, 69, 105), Color3.fromRGB(13, 34, 65)),
    }, hero)
    for i = 1, 3 do
        local ring = make("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(1, -35, 0, 100),
            Size = UDim2.fromOffset(110 + i * 43, 110 + i * 43),
            BackgroundTransparency = 1,
            ZIndex = 7,
        }, hero)
        round(ring, 200)
        make("UIStroke", {Color = accent, Thickness = 1, Transparency = 0.72 + i * 0.07}, ring)
    end
    pill(hero, "WINTER EDITION  •  PROTOTYPE", 18, 17, 217)
    make("TextLabel", {
        Position = UDim2.fromOffset(20, 55),
        Size = UDim2.new(1, -40, 0, 45),
        BackgroundTransparency = 1,
        Text = "Welcome to Coco Hub",
        TextColor3 = white,
        TextSize = 28,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 8,
    }, hero)
    make("TextLabel", {
        Position = UDim2.fromOffset(21, 108),
        Size = UDim2.new(1, -75, 0, 48),
        BackgroundTransparency = 1,
        Text = "One home for universal scripts. Browse sections and add modules as the hub grows.",
        TextColor3 = softText,
        TextSize = 15,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        ZIndex = 8,
    }, hero)
    local sectionLabel = make("TextLabel", {
        Size = UDim2.new(1, -5, 0, 27),
        BackgroundTransparency = 1,
        Text = "Explore sections",
        TextColor3 = white,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        LayoutOrder = layoutIndex + 1,
        ZIndex = 6,
    }, page)
    layoutIndex = layoutIndex + 1
    local row = make("ScrollingFrame", {
        Size = UDim2.new(1, -5, 0, 138),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.X,
        CanvasSize = UDim2.fromOffset(668, 0),
        LayoutOrder = layoutIndex + 1,
        ZIndex = 6,
    }, page)
    layoutIndex = layoutIndex + 1
    make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, row)
    for index, info in ipairs({
        {name = "Combat", tint = coral, code = "CB"},
        {name = "Movement", tint = ice, code = "MV"},
        {name = "Visuals", tint = violet, code = "VS"},
    }) do
        local targetSection = info.name
        local tile = make("TextButton", {
            Size = UDim2.fromOffset(210, 126),
            BackgroundColor3 = Color3.fromRGB(20, 48, 78),
            BorderSizePixel = 0,
            Text = "",
            LayoutOrder = index,
            AutoButtonColor = false,
            ZIndex = 7,
        }, row)
        round(tile, 17)
        make("UIStroke", {Color = info.tint, Thickness = 1.2, Transparency = 0.35}, tile)
        local badge = make("TextLabel", {
            Position = UDim2.fromOffset(15, 15),
            Size = UDim2.fromOffset(36, 36),
            BackgroundColor3 = info.tint,
            BackgroundTransparency = 0.7,
            Text = info.code,
            TextColor3 = white,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
            ZIndex = 8,
        }, tile)
        round(badge, 11)
        make("TextLabel", {
            Position = UDim2.fromOffset(15, 56),
            Size = UDim2.fromOffset(180, 30),
            BackgroundTransparency = 1,
            Text = info.name,
            TextColor3 = white,
            TextSize = 19,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.GothamBold,
            ZIndex = 8,
        }, tile)
        make("TextLabel", {
            Position = UDim2.fromOffset(15, 88),
            Size = UDim2.fromOffset(182, 27),
            BackgroundTransparency = 1,
            Text = "Open section  →",
            TextColor3 = softText,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.Gotham,
            ZIndex = 8,
        }, tile)
        tile.MouseButton1Click:Connect(function() selectTab(targetSection) end)
        tile.MouseEnter:Connect(function() if motion then animate(tile, 0.18, {BackgroundColor3 = Color3.fromRGB(30, 65, 97)}) end end)
        tile.MouseLeave:Connect(function() if motion then animate(tile, 0.18, {BackgroundColor3 = Color3.fromRGB(20, 48, 78)}) end end)
    end
    local statusCard = card(99)
    pill(statusCard, "READY FOR MODULES", 16, 16, 155)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 53),
        Size = UDim2.new(1, -30, 0, 29),
        BackgroundTransparency = 1,
        Text = "Sections are live. Scripts can be registered when we build them.",
        TextColor3 = softText,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, statusCard)
end

local function renderCategory(tab)
    if tab == "Game" then
        local gameCard = card(103, Color3.fromRGB(19, 51, 80))
        pill(gameCard, "CURRENT GAME", 16, 15, 110)
        make("TextLabel", {
            Position = UDim2.fromOffset(17, 47),
            Size = UDim2.new(1, -35, 0, 30),
            BackgroundTransparency = 1,
            Text = tostring(game.Name),
            TextColor3 = white,
            TextSize = 19,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Font = Enum.Font.GothamBold,
            ZIndex = 7,
        }, gameCard)
        make("TextLabel", {
            Position = UDim2.fromOffset(17, 77),
            Size = UDim2.new(1, -35, 0, 18),
            BackgroundTransparency = 1,
            Text = "Place ID: " .. tostring(game.PlaceId),
            TextColor3 = softText,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.Gotham,
            ZIndex = 7,
        }, gameCard)
    end
    local introCard = card(92)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 17),
        Size = UDim2.new(1, -35, 0, 31),
        BackgroundTransparency = 1,
        Text = tab .. " collection",
        TextColor3 = white,
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 7,
    }, introCard)
    make("TextLabel", {
        Position = UDim2.fromOffset(18, 50),
        Size = UDim2.new(1, -35, 0, 28),
        BackgroundTransparency = 1,
        Text = descriptions[tab],
        TextColor3 = softText,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, introCard)
    if #modules[tab] == 0 then
        for _, titleText in ipairs(ideas[tab]) do
            emptyCard(titleText, "A space for a future universal module.")
        end
    else
        for _, module in ipairs(modules[tab]) do moduleCard(module) end
    end
end

local function settingCard(titleText, detailText, valueText, onClick)
    local frame = card(92)
    make("TextLabel", {
        Position = UDim2.fromOffset(16, 15),
        Size = UDim2.new(1, -140, 0, 28),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = white,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 7,
    }, frame)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 49),
        Size = UDim2.new(1, -142, 0, 28),
        BackgroundTransparency = 1,
        Text = detailText,
        TextColor3 = softText,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, frame)
    local control = make("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -16, 0.5, 0),
        Size = UDim2.fromOffset(100, 34),
        BackgroundColor3 = Color3.fromRGB(31, 76, 108),
        Text = valueText,
        TextColor3 = white,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        ZIndex = 7,
    }, frame)
    round(control, 11)
    control.MouseButton1Click:Connect(onClick)
    return control
end
local function renderConfigs()
    local headerCard = card(85)
    pill(headerCard, "UI SETTINGS", 16, 14, 94)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 46),
        Size = UDim2.new(1, -32, 0, 27),
        BackgroundTransparency = 1,
        Text = "Tune how Coco Hub looks and moves.",
        TextColor3 = softText,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, headerCard)
    local motionButton
    motionButton = settingCard("UI animations", "Transitions and hover effects.", motion and "ON" or "OFF", function()
        motion = not motion
        motionButton.Text = motion and "ON" or "OFF"
        notify("Animations " .. (motion and "enabled" or "reduced"))
    end)
    settingCard("Accent color", "Switch between icy blue and warm gold.", accent == ice and "ICE" or "GOLD", function()
        accent = accent == ice and gold or ice
        mainStroke.Color = accent
        shadow.BackgroundColor3 = accent
        notify("Accent changed")
        renderPage()
    end)
    settingCard("Reset layout", "Center and reopen the hub.", "RESET", function()
        main.Position = UDim2.fromScale(0.5, 0.5)
        notify("Layout reset")
    end)
end
local function renderMore()
    local info = card(170, Color3.fromRGB(17, 51, 81))
    pill(info, "COCO HUB  •  PROTOTYPE", 16, 16, 174)
    make("TextLabel", {
        Position = UDim2.fromOffset(17, 53),
        Size = UDim2.new(1, -34, 0, 34),
        BackgroundTransparency = 1,
        Text = "A home for every script",
        TextColor3 = white,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        ZIndex = 7,
    }, info)
    make("TextLabel", {
        Position = UDim2.fromOffset(18, 93),
        Size = UDim2.new(1, -36, 0, 61),
        BackgroundTransparency = 1,
        Text = "This first build has the layout, navigation, search, and module slots. We can add real universal scripts section by section.",
        TextColor3 = softText,
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Gotham,
        ZIndex = 7,
    }, info)
    emptyCard("Module API", "Future scripts can register directly with CocoHub.")
    emptyCard("Updates", "More sections and layouts can be added here.")
end
renderPage = function()
    clearPage()
    headerTitle.Text = query ~= "" and "Search" or selected
    headerSub.Text = query ~= "" and ("Results for \"" .. query .. "\"") or (selected == "Home" and "Everything in one place." or selected == "Configs" and "Make the hub yours." or selected == "More" and "About this prototype." or descriptions[selected] or "")
    if query ~= "" then
        local found = 0
        for _, tab in ipairs({"Game", "Combat", "Movement", "Visuals"}) do
            for _, module in ipairs(modules[tab]) do
                if string.find(string.lower(module.title .. " " .. (module.description or "")), string.lower(query), 1, true) then
                    moduleCard(module)
                    found = found + 1
                end
            end
        end
        if found == 0 then
            local empty = card(155)
            make("TextLabel", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Text = "No modules found yet.\nAdd a script to start your collection.",
                TextColor3 = softText,
                TextSize = 16,
                Font = Enum.Font.GothamMedium,
                ZIndex = 7,
            }, empty)
        end
    elseif selected == "Home" then
        renderHome()
    elseif selected == "Configs" then
        renderConfigs()
    elseif selected == "More" then
        renderMore()
    else
        renderCategory(selected)
    end
end
selectTab = function(tab)
    selected = tab
    if search.Text ~= "" then search.Text = "" end
    for name, entry in pairs(navItems) do
        local active = name == selected
        entry.mark.BackgroundTransparency = active and 0 or 1
        entry.name.TextColor3 = active and white or softText
        entry.icon.BackgroundColor3 = active and Color3.fromRGB(53, 107, 140) or Color3.fromRGB(31, 65, 95)
        if motion then
            animate(entry.button, 0.2, {BackgroundTransparency = active and 0.78 or 1})
        else
            entry.button.BackgroundTransparency = active and 0.78 or 1
        end
    end
    renderPage()
    if motion then
        local x = page.Position.X.Offset
        local y = page.Position.Y.Offset
        page.Position = UDim2.fromOffset(x + 10, y)
        animate(page, 0.22, {Position = UDim2.fromOffset(x, y)})
    end
end
for name, entry in pairs(navItems) do
    local targetSection = name
    entry.button.MouseButton1Click:Connect(function() selectTab(targetSection) end)
    entry.button.MouseEnter:Connect(function()
        if targetSection ~= selected and motion then animate(entry.button, 0.16, {BackgroundTransparency = 0.88}) end
    end)
    entry.button.MouseLeave:Connect(function()
        if targetSection ~= selected and motion then animate(entry.button, 0.16, {BackgroundTransparency = 1}) end
    end)
end
search:GetPropertyChangedSignal("Text"):Connect(function()
    query = string.match(search.Text, "^%s*(.-)%s*$") or ""
    renderPage()
end)

local function updateHubLayout()
    local view = camera and camera.ViewportSize or Vector2.new(960, 540)
    local width = math.max(280, math.min(920, view.X - 20))
    local height = math.max(300, math.min(560, view.Y - 20))
    main.Size = UDim2.fromOffset(width, height)
    shadow.Size = UDim2.fromOffset(width + 12, height + 12)
    local narrow = width < 650
    if narrow then
        sidebar.Size = UDim2.new(1, 0, 0, 100)
        nav.Position = UDim2.fromOffset(12, 59)
        nav.Size = UDim2.new(1, -24, 0, 38)
        nav.ScrollingDirection = Enum.ScrollingDirection.X
        nav.CanvasSize = UDim2.fromOffset(#tabs * 111, 0)
        navLayout.FillDirection = Enum.FillDirection.Horizontal
        sidebarFoot.Visible = false
        content.Position = UDim2.fromOffset(0, 100)
        content.Size = UDim2.new(1, 0, 1, -100)
        header.Size = UDim2.new(1, 0, 0, 105)
        headerSub.Visible = false
        search.Position = UDim2.new(1, -20, 0, 59)
        search.Size = UDim2.new(1, -40, 0, 36)
        page.Position = UDim2.fromOffset(15, 111)
        page.Size = UDim2.new(1, -30, 1, -125)
        for _, entry in pairs(navItems) do
            entry.button.Size = UDim2.fromOffset(104, 36)
            entry.mark.Visible = false
            entry.icon.Position = UDim2.fromOffset(5, 4)
            entry.name.Position = UDim2.fromOffset(38, 0)
            entry.name.Size = UDim2.new(1, -40, 1, 0)
            entry.name.TextSize = 13
        end
    else
        sidebar.Size = UDim2.new(0, 190, 1, 0)
        nav.Position = UDim2.fromOffset(12, 102)
        nav.Size = UDim2.new(1, -24, 1, -120)
        nav.ScrollingDirection = Enum.ScrollingDirection.Y
        nav.CanvasSize = UDim2.fromOffset(0, #tabs * 48)
        navLayout.FillDirection = Enum.FillDirection.Vertical
        sidebarFoot.Visible = true
        content.Position = UDim2.fromOffset(190, 0)
        content.Size = UDim2.new(1, -190, 1, 0)
        header.Size = UDim2.new(1, 0, 0, 76)
        headerSub.Visible = true
        search.Position = UDim2.new(1, -60, 0, 21)
        search.Size = UDim2.fromOffset(190, 38)
        page.Position = UDim2.fromOffset(20, 78)
        page.Size = UDim2.new(1, -40, 1, -96)
        for _, entry in pairs(navItems) do
            entry.button.Size = UDim2.new(1, -2, 0, 42)
            entry.mark.Visible = true
            entry.icon.Position = UDim2.fromOffset(10, 7)
            entry.name.Position = UDim2.fromOffset(47, 0)
            entry.name.Size = UDim2.new(1, -50, 1, 0)
            entry.name.TextSize = 16
        end
    end
end
updateHubLayout()
if camera then camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateHubLayout) end

local dragging = false
local dragStart, startPosition
headerTitle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)
headerTitle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if not dragging or not main.Parent then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
        shadow.Position = main.Position
    end
end)
close.MouseButton1Click:Connect(function()
    main.Visible = false
    shadow.Visible = false
    dimmer.Visible = false
    bubble.Visible = true
end)
bubble.MouseButton1Click:Connect(function()
    main.Visible = true
    shadow.Visible = true
    dimmer.Visible = true
    bubble.Visible = false
    openingScale.Scale = motion and 0.92 or 1
    if motion then animate(openingScale, 0.3, {Scale = 1}) end
end)

local hubApi = {}
function hubApi:RegisterModule(info)
    if type(info) ~= "table" or not modules[info.section] or type(info.title) ~= "string" or type(info.run) ~= "function" then
        return false, "Expected {section, title, run, description?}"
    end
    for _, existing in ipairs(modules[info.section]) do
        if existing.title == info.title then return false, "Module already registered" end
    end
    table.insert(modules[info.section], info)
    if selected == info.section or query ~= "" then renderPage() end
    notify(info.title .. " added to " .. info.section)
    return true
end
function hubApi:OpenTab(tab)
    if not table.find(tabs, tab) then return false end
    if not main.Visible then
        main.Visible = true
        shadow.Visible = true
        dimmer.Visible = true
        bubble.Visible = false
    end
    selectTab(tab)
    return true
end
function hubApi:Destroy()
    if gui.Parent then gui:Destroy() end
end
local environment = (getgenv and getgenv()) or _G
environment.CocoHub = hubApi

selectTab("Home")
if motion then animate(openingScale, 0.38, {Scale = 1}) else openingScale.Scale = 1 end
animate(veil, 0.4, {BackgroundTransparency = 1}).Completed:Wait()
veil:Destroy()
