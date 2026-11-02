# Coco Hub prototype

Paste this into Delta:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/brookbrookcms-cmyk/Cookie-Hub/main/PotassiumChristmas.lua"))()
```

The Christmas loader opens the Coco Hub main UI when it finishes. The first prototype includes Home, Game, Combat, Movement, Visuals, Configs, and More. Navigation, search, the reopen button, visual settings, and module slots are interactive. No gameplay modules are bundled yet.

Once the hub is open, future Lua modules can register a card in a section:

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

The hub displays registered modules in their sections and runs their `run` function when their **Run** button is pressed. [CocoHubPrototype.jpg](CocoHubPrototype.jpg) is a design draft of the intended look.
