# Coco Hub prototype

Paste this into Delta:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/brookbrookcms-cmyk/Cookie-Hub/main/PotassiumChristmas.lua"))()
```

The Christmas loader opens a compact, centered monochrome Coco Hub window. Home has the navigation rail, coconut logo, video preview, live player and game details, and FPS/Ping displays. Game, Combat, Movement, Visuals, Configs, and More are blank until modules are added. The video preview is a placeholder until a Roblox video asset ID is supplied; it does not stream the local MP4.

Once the hub opens, modules can register a card:

```lua
getgenv().CocoHub:RegisterModule({
    section = "Movement",
    title = "Example module",
    description = "A sample slot for a future universal script.",
    run = function()
        print("Example module ran")
    end,
})
```

To connect an uploaded Roblox preview video:

```lua
getgenv().CocoHub:SetPreviewAssetId(123456789)
```
