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

local main = make("Frame", {
    Name = "MainHub",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.86, 0, 0, 205),
    BackgroundColor3 = Color3.fromRGB(8, 30, 52),
    BorderSizePixel = 0,
    ZIndex = 2,
}, gui)
make("UISizeConstraint", {MaxSize = Vector2.new(430, 205)}, main)
round(main, 16)
make("UIStroke", {Color = white, Thickness = 1.5, Transparency = 0.15}, main)
make("TextLabel", {
    Position = UDim2.new(0, 20, 0, 15),
    Size = UDim2.new(1, -40, 0, 38),
    BackgroundTransparency = 1,
    Text = "C O C O   H U B",
    TextColor3 = white,
    TextSize = 22,
    Font = Enum.Font.GothamMedium,
    ZIndex = 3,
}, main)
make("TextLabel", {
    Position = UDim2.new(0, 20, 0, 65),
    Size = UDim2.new(1, -40, 0, 110),
    BackgroundTransparency = 1,
    Text = "test",
    TextColor3 = white,
    TextSize = 48,
    Font = Enum.Font.GothamBold,
    ZIndex = 3,
}, main)
animate(veil, 0.4, {BackgroundTransparency = 1}).Completed:Wait()
veil:Destroy()
