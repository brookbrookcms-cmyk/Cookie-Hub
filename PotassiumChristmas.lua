-- Cookie Hub Christmas loader
-- Client-side script. The old filename is kept so existing loadstrings keep working.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
if not player then return end
local playerGui = player:WaitForChild("PlayerGui")
local imageUrl = "https://raw.githubusercontent.com/brookbrookcms-cmyk/Cookie-Hub/main/ChristmasBackgroundV2.jpg"
local imageFile = "cookie_hub_christmas_background_v2.jpg"
local introTime = 5.8

for _, parent in ipairs({CoreGui, playerGui}) do
    for _, name in ipairs({"PotassiumLoader", "CookieHubChristmas", "CookieHubGui"}) do
        pcall(function()
            local old = parent:FindFirstChild(name)
            if old then old:Destroy() end
        end)
    end
end

local function new(className, props, parent)
    local object = Instance.new(className)
    for key, value in pairs(props) do object[key] = value end
    object.Parent = parent
    return object
end

local function rounded(object, pixels)
    new("UICorner", {CornerRadius = UDim.new(0, pixels)}, object)
end

local function playTween(object, seconds, props, style, direction)
    local info = TweenInfo.new(seconds, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    local animation = TweenService:Create(object, info, props)
    animation:Play()
    return animation
end

local white = Color3.fromRGB(255, 249, 232)
local gold = Color3.fromRGB(255, 211, 131)
local red = Color3.fromRGB(191, 52, 61)
local deepBlue = Color3.fromRGB(5, 20, 39)

local gui = new("ScreenGui", {
    Name = "CookieHubChristmas",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = 10000,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, nil)
if not pcall(function() gui.Parent = CoreGui end) then gui.Parent = playerGui end

local intro = new("Frame", {
    Name = "FullscreenIntro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = deepBlue,
    BorderSizePixel = 0,
}, gui)
new("UIGradient", {
    Rotation = 90,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 19, 42)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 61, 74)),
    }),
}, intro)

local background = new("ImageLabel", {
    Name = "ChristmasBackground",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ImageTransparency = 1,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 1,
}, intro)
local dim = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = deepBlue,
    BackgroundTransparency = 0.56,
    BorderSizePixel = 0,
    ZIndex = 2,
}, intro)
new("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.5, 0.1),
        NumberSequenceKeypoint.new(1, 0.75),
    }),
}, dim)

local snow = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 3,
}, intro)
local flakes = {}
for i = 1, 28 do
    local diameter = 2 + i % 4
    local flake = new("Frame", {
        Position = UDim2.fromScale(((i * 67) % 97) / 100, ((i * 43) % 99) / 100),
        Size = UDim2.fromOffset(diameter, diameter),
        BackgroundColor3 = white,
        BackgroundTransparency = 0.3 + (i % 3) * 0.16,
        BorderSizePixel = 0,
        ZIndex = 3,
    }, snow)
    rounded(flake, 20)
    flakes[i] = {object = flake, speed = 0.025 + (i % 5) * 0.012}
end

local center = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.49),
    Size = UDim2.new(0.86, 0, 0.62, 0),
    BackgroundTransparency = 1,
    ZIndex = 5,
}, intro)
new("UISizeConstraint", {MaxSize = Vector2.new(600, 395)}, center)

local cookie = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.22),
    Size = UDim2.fromOffset(94, 94),
    BackgroundColor3 = Color3.fromRGB(221, 156, 91),
    BorderSizePixel = 0,
    Rotation = -9,
    ZIndex = 6,
}, center)
rounded(cookie, 100)
new("UIStroke", {Color = Color3.fromRGB(255, 211, 151), Thickness = 3}, cookie)
for _, chip in ipairs({{0.28, 0.27, 13}, {0.68, 0.25, 10}, {0.51, 0.46, 12}, {0.24, 0.69, 10}, {0.72, 0.68, 13}, {0.47, 0.79, 8}}) do
    local dot = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(chip[1], chip[2]),
        Size = UDim2.fromOffset(chip[3], chip[3]),
        BackgroundColor3 = Color3.fromRGB(91, 48, 42),
        BorderSizePixel = 0,
        ZIndex = 7,
    }, cookie)
    rounded(dot, 20)
end
local hat = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.48, -0.14),
    Size = UDim2.fromOffset(69, 33),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
    Rotation = -17,
    ZIndex = 8,
}, cookie)
rounded(hat, 10)
local brim = new("Frame", {
    Position = UDim2.fromScale(0, 0.7),
    Size = UDim2.fromScale(1, 0.35),
    BackgroundColor3 = white,
    BorderSizePixel = 0,
    ZIndex = 9,
}, hat)
rounded(brim, 10)
local pom = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.08, 0.08),
    Size = UDim2.fromOffset(18, 18),
    BackgroundColor3 = white,
    BorderSizePixel = 0,
    ZIndex = 9,
}, hat)
rounded(pom, 20)

local eyebrow = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.43),
    Size = UDim2.new(1, 0, 0.07, 0),
    BackgroundTransparency = 1,
    Text = "THE CHRISTMAS EDITION",
    TextColor3 = gold,
    TextScaled = true,
    Font = Enum.Font.GothamBold,
    ZIndex = 6,
}, center)
new("UITextSizeConstraint", {MaxTextSize = 16}, eyebrow)
local title = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.51),
    Size = UDim2.new(1, 0, 0.18, 0),
    BackgroundTransparency = 1,
    Text = "COOKIE HUB",
    TextColor3 = white,
    TextScaled = true,
    Font = Enum.Font.GothamBlack,
    ZIndex = 6,
}, center)
new("UITextSizeConstraint", {MaxTextSize = 55}, title)
new("UIStroke", {Color = deepBlue, Thickness = 1.5, Transparency = 0.3}, title)
local subtitle = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.70),
    Size = UDim2.new(1, 0, 0.07, 0),
    BackgroundTransparency = 1,
    Text = "Your winter adventure starts here",
    TextColor3 = white,
    TextTransparency = 0.1,
    TextScaled = true,
    Font = Enum.Font.GothamMedium,
    ZIndex = 6,
}, center)
new("UITextSizeConstraint", {MaxTextSize = 20}, subtitle)

local track = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.83),
    Size = UDim2.new(0.74, 0, 0, 9),
    BackgroundColor3 = Color3.fromRGB(226, 228, 224),
    BackgroundTransparency = 0.72,
    BorderSizePixel = 0,
    ZIndex = 6,
}, center)
rounded(track, 12)
local fill = new("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = gold,
    BorderSizePixel = 0,
    ZIndex = 7,
}, track)
rounded(fill, 12)
new("UIGradient", {
    Color = ColorSequence.new(Color3.fromRGB(255, 191, 104), Color3.fromRGB(255, 242, 181)),
}, fill)
local status = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.89),
    Size = UDim2.new(0.74, 0, 0.08, 0),
    BackgroundTransparency = 1,
    Text = "Gathering snowflakes...",
    TextColor3 = white,
    TextTransparency = 0.08,
    TextScaled = true,
    Font = Enum.Font.GothamMedium,
    ZIndex = 6,
}, center)
new("UITextSizeConstraint", {MaxTextSize = 16}, status)

local imageFinished = false
local function loadBackground()
    local assetFn = getcustomasset or getsynasset
    if not assetFn then imageFinished = true; return end
    local function useFile()
        local ok, asset = pcall(function() return assetFn(imageFile) end)
        if ok and type(asset) == "string" and #asset > 0 and gui.Parent then
            background.Image = asset
            pcall(function() ContentProvider:PreloadAsync({background}) end)
            playTween(background, 0.6, {ImageTransparency = 0})
            return true
        end
        return false
    end
    if isfile and isfile(imageFile) and useFile() then imageFinished = true; return end
    local data
    local requestFn = request or http_request or (syn and syn.request) or (http and http.request)
    if requestFn then
        local ok, result = pcall(function() return requestFn({Url = imageUrl, Method = "GET"}) end)
        if ok and result and (result.StatusCode == 200 or result.Success) then data = result.Body end
    end
    if not data then
        local ok, result = pcall(function() return game:HttpGet(imageUrl) end)
        if ok then data = result end
    end
    if type(data) == "string" and data:sub(1, 3) == "\255\216\255" and writefile then
        local ok = pcall(function() writefile(imageFile, data) end)
        if ok then useFile() end
    end
    imageFinished = true
end

task.spawn(loadBackground)
playTween(cookie, 1.4, {Rotation = 7, Position = UDim2.fromScale(0.5, 0.19)}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local snowConnection
snowConnection = RunService.RenderStepped:Connect(function(dt)
    if not gui.Parent or not intro.Parent then snowConnection:Disconnect(); return end
    for _, entry in ipairs(flakes) do
        local position = entry.object.Position
        local y = position.Y.Scale + entry.speed * dt
        if y > 1.03 then y = -0.03 end
        entry.object.Position = UDim2.fromScale(position.X.Scale, y)
    end
end)

local began = os.clock()
while gui.Parent do
    local elapsed = os.clock() - began
    local progress = math.min(elapsed / introTime, 0.95)
    fill.Size = UDim2.fromScale(progress, 1)
    if progress < 0.28 then
        status.Text = "Gathering snowflakes..."
    elseif progress < 0.6 then
        status.Text = "Lighting the Christmas tree..."
    else
        status.Text = "Baking something sweet..."
    end
    if elapsed >= introTime and (imageFinished or elapsed >= introTime + 3) then break end
    task.wait(0.03)
end
if not gui.Parent then return end
if snowConnection then snowConnection:Disconnect() end
status.Text = "Ready for Christmas"
playTween(fill, 0.3, {Size = UDim2.fromScale(1, 1)}).Completed:Wait()
task.wait(0.55)
if not gui.Parent then return end

local veil = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = deepBlue,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 20,
}, gui)
playTween(veil, 0.35, {BackgroundTransparency = 0}).Completed:Wait()
intro:Destroy()

local main = new("Frame", {
    Name = "MainHub",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.86, 0, 0, 210),
    BackgroundColor3 = Color3.fromRGB(16, 42, 52),
    BorderSizePixel = 0,
    ZIndex = 2,
}, gui)
new("UISizeConstraint", {MaxSize = Vector2.new(430, 210)}, main)
rounded(main, 18)
new("UIStroke", {Color = gold, Thickness = 2, Transparency = 0.15}, main)
local banner = new("Frame", {
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
rounded(banner, 18)
new("Frame", {
    Position = UDim2.new(0, 0, 1, -17),
    Size = UDim2.new(1, 0, 0, 17),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
    ZIndex = 3,
}, banner)
new("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "COOKIE HUB  •  CHRISTMAS",
    TextColor3 = white,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    ZIndex = 4,
}, banner)
new("TextLabel", {
    Position = UDim2.new(0, 15, 0, 62),
    Size = UDim2.new(1, -30, 0, 125),
    BackgroundTransparency = 1,
    Text = "test",
    TextColor3 = white,
    TextSize = 48,
    Font = Enum.Font.GothamBlack,
    ZIndex = 3,
}, main)
playTween(veil, 0.4, {BackgroundTransparency = 1}).Completed:Wait()
veil:Destroy()
