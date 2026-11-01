-- Cookie Hub: Christmas intro draft
-- Run this as a client-side Roblox script.
-- Set VIDEO_ASSET_ID to an uploaded Roblox video asset ID to use a real video.
-- The built-in animated intro plays when the ID is 0.

local VIDEO_ASSET_ID = 0
local INTRO_SECONDS = 5.5

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
if not player then return end
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("CookieHubGui")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "CookieHubGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 10000
gui.Parent = playerGui

local function make(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties) do
        object[key] = value
    end
    object.Parent = parent
    return object
end

local function corner(parent, radius)
    make("UICorner", {CornerRadius = UDim.new(0, radius)}, parent)
end

local function tween(object, seconds, properties, style, direction)
    local info = TweenInfo.new(seconds, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    return TweenService:Create(object, info, properties)
end

local navy = Color3.fromRGB(12, 31, 52)
local red = Color3.fromRGB(183, 43, 54)
local cream = Color3.fromRGB(255, 241, 218)
local gold = Color3.fromRGB(255, 205, 113)

local intro = make("Frame", {
    Name = "ChristmasIntro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = navy,
    BorderSizePixel = 0,
}, gui)

make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 24, 46)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(23, 62, 80)),
    }),
    Rotation = 90,
}, intro)

local video
if VIDEO_ASSET_ID ~= 0 then
    video = make("VideoFrame", {
        Name = "ChristmasVideo",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Video = "rbxassetid://" .. tostring(VIDEO_ASSET_ID),
        Looped = true,
        Volume = 0.35,
        ZIndex = 1,
    }, intro)
    pcall(function() video:Play() end)
end

-- A little winter landscape sits behind the logo when no video is configured.
local landscape = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = video == nil,
    ZIndex = 2,
}, intro)

local moon = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.79, 0.21),
    Size = UDim2.fromOffset(78, 78),
    BackgroundColor3 = cream,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ZIndex = 2,
}, landscape)
corner(moon, 100)

for i = 1, 26 do
    local x = ((i * 73) % 97) / 100
    local y = ((i * 41) % 47) / 100
    local star = make("Frame", {
        Position = UDim2.fromScale(x, y),
        Size = UDim2.fromOffset(i % 4 == 0 and 3 or 2, i % 4 == 0 and 3 or 2),
        BackgroundColor3 = cream,
        BackgroundTransparency = 0.15 + (i % 3) * 0.18,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, landscape)
    corner(star, 5)
end

local snowBank = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.fromScale(0.5, 1.12),
    Size = UDim2.fromScale(1.4, 0.26),
    BackgroundColor3 = Color3.fromRGB(221, 237, 239),
    BorderSizePixel = 0,
    ZIndex = 2,
}, landscape)
corner(snowBank, 200)

for i = 1, 9 do
    local size = 12 + i % 3 * 8
    local flake = make("TextLabel", {
        Name = "Snowflake",
        Position = UDim2.fromScale(((i * 37) % 91) / 100, -0.1 - i * 0.11),
        Size = UDim2.fromOffset(size, size),
        BackgroundTransparency = 1,
        Text = "✦",
        TextColor3 = cream,
        TextTransparency = 0.25,
        TextScaled = true,
        Font = Enum.Font.Gotham,
        ZIndex = 3,
    }, landscape)
    flake:SetAttribute("Speed", 0.08 + (i % 4) * 0.025)
end

local shade = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(4, 12, 25),
    BackgroundTransparency = 0.44,
    BorderSizePixel = 0,
    ZIndex = 4,
}, intro)

local center = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.47),
    Size = UDim2.new(0.9, 0, 0, 305),
    BackgroundTransparency = 1,
    ZIndex = 5,
}, intro)
make("UISizeConstraint", {MaxSize = Vector2.new(420, 305)}, center)

local cookie = make("Frame", {
    Name = "CookieLogo",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.34),
    Size = UDim2.fromOffset(106, 106),
    BackgroundColor3 = Color3.fromRGB(212, 146, 82),
    BorderSizePixel = 0,
    Rotation = -17,
    ZIndex = 6,
}, center)
corner(cookie, 100)
make("UIStroke", {Color = Color3.fromRGB(255, 205, 140), Thickness = 4}, cookie)

local chips = {
    {0.25, 0.29, 14}, {0.65, 0.22, 10}, {0.76, 0.56, 14},
    {0.45, 0.56, 11}, {0.26, 0.77, 10}, {0.56, 0.82, 8},
}
for _, chip in ipairs(chips) do
    local dot = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(chip[1], chip[2]),
        Size = UDim2.fromOffset(chip[3], chip[3]),
        BackgroundColor3 = Color3.fromRGB(95, 52, 44),
        BorderSizePixel = 0,
        ZIndex = 7,
    }, cookie)
    corner(dot, 20)
end

local hat = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.48, -0.13),
    Size = UDim2.fromOffset(75, 36),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
    Rotation = -21,
    ZIndex = 8,
}, cookie)
corner(hat, 12)
local brim = make("Frame", {
    Position = UDim2.fromScale(0, 0.72),
    Size = UDim2.fromScale(1, 0.32),
    BackgroundColor3 = cream,
    BorderSizePixel = 0,
    ZIndex = 9,
}, hat)
corner(brim, 12)
local pom = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.1, 0.08),
    Size = UDim2.fromOffset(20, 20),
    BackgroundColor3 = cream,
    BorderSizePixel = 0,
    ZIndex = 9,
}, hat)
corner(pom, 20)

local title = make("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.55),
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundTransparency = 1,
    Text = "COOKIE HUB",
    TextColor3 = cream,
    TextScaled = true,
    Font = Enum.Font.GothamBlack,
    ZIndex = 6,
}, center)
make("UITextSizeConstraint", {MaxTextSize = 42}, title)

local subtitle = make("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.75),
    Size = UDim2.new(1, 0, 0, 29),
    BackgroundTransparency = 1,
    Text = "A little holiday magic is loading...",
    TextColor3 = gold,
    TextScaled = true,
    Font = Enum.Font.GothamMedium,
    ZIndex = 6,
}, center)
make("UITextSizeConstraint", {MaxTextSize = 18}, subtitle)

local loadingTrack = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromScale(0.5, 0.92),
    Size = UDim2.new(0.75, 0, 0, 8),
    BackgroundColor3 = Color3.fromRGB(64, 85, 99),
    BorderSizePixel = 0,
    ZIndex = 6,
}, center)
corner(loadingTrack, 10)
local loadingFill = make("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = Color3.fromRGB(214, 66, 73),
    BorderSizePixel = 0,
    ZIndex = 7,
}, loadingTrack)
corner(loadingFill, 10)

local start = os.clock()
local snowConnection
snowConnection = RunService.RenderStepped:Connect(function(dt)
    if not intro.Parent then
        snowConnection:Disconnect()
        return
    end
    local elapsed = os.clock() - start
    cookie.Rotation = -17 + math.sin(elapsed * 2.8) * 5
    cookie.Position = UDim2.fromScale(0.5, 0.34 + math.sin(elapsed * 2.8) * 0.018)
    loadingFill.Size = UDim2.fromScale(math.clamp(elapsed / INTRO_SECONDS, 0, 1), 1)
    for _, flake in ipairs(landscape:GetChildren()) do
        if flake.Name == "Snowflake" then
            local position = flake.Position
            local nextY = position.Y.Scale + dt * flake:GetAttribute("Speed")
            if nextY > 1 then nextY = -0.08 end
            flake.Position = UDim2.fromScale(position.X.Scale, nextY)
        end
    end
end)

task.wait(INTRO_SECONDS)
if not gui.Parent then return end
if snowConnection then snowConnection:Disconnect() end
if video then pcall(function() video:Pause() end) end

local fade = make("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = navy,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 20,
}, gui)
local fadeIn = tween(fade, 0.3, {BackgroundTransparency = 0})
fadeIn:Play()
fadeIn.Completed:Wait()
intro:Destroy()

local main = make("Frame", {
    Name = "MainHub",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(0.8, 0, 0, 220),
    BackgroundColor3 = Color3.fromRGB(23, 49, 61),
    BorderSizePixel = 0,
    ZIndex = 2,
}, gui)
make("UISizeConstraint", {MaxSize = Vector2.new(400, 220)}, main)
corner(main, 18)
make("UIStroke", {Color = gold, Thickness = 2, Transparency = 0.25}, main)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
corner(header, 18)
make("Frame", {
    Position = UDim2.new(0, 0, 1, -14),
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundColor3 = red,
    BorderSizePixel = 0,
    ZIndex = 3,
}, header)
make("TextLabel", {
    Position = UDim2.fromOffset(18, 0),
    Size = UDim2.new(1, -65, 1, 0),
    BackgroundTransparency = 1,
    Text = "COOKIE HUB  •  CHRISTMAS",
    TextColor3 = cream,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    ZIndex = 4,
}, header)

local close = make("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -13, 0.5, 0),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Color3.fromRGB(139, 30, 41),
    Text = "×",
    TextColor3 = cream,
    TextSize = 23,
    Font = Enum.Font.GothamBold,
    ZIndex = 4,
}, header)
corner(close, 8)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

make("TextLabel", {
    Position = UDim2.new(0, 12, 0, 74),
    Size = UDim2.new(1, -24, 0, 100),
    BackgroundTransparency = 1,
    Text = "test",
    TextColor3 = cream,
    TextSize = 48,
    Font = Enum.Font.GothamBlack,
    ZIndex = 3,
}, main)

local fadeOut = tween(fade, 0.35, {BackgroundTransparency = 1})
fadeOut:Play()
fadeOut.Completed:Wait()
fade:Destroy()
