local ContentProvider = game:GetService("ContentProvider")

--[[
    Creates an IconPackInitializer object

    @param url: string

    @return IconPackInitializer
]]
function IconPackInitializer(url)
    if typeof(url) ~= "string" then
        error("Error: Pack provided is invalid!")
    end

    local loader = {
        loaded = false,
        Icons = {},

        _cached = {}
    }

    --[[
        Preloads icons.

        @param icons: { string }
        @param cb: (succeeded: { string }, failed: { string }, count: number) -> (nil)
    ]]
    function loader.Preload(icons, updateCb)
        if not loader.loaded then
            loader.Load()
        end

        local assetIds = {}
        local iconIndex = {}

        for _, icon in icons do
            print(icon)
            local assetId = loader.Icon(icon)

            if not iconIndex[assetId] then
                iconIndex[assetId] = icon
                table.insert(assetIds, assetId)
            end
        end

        local succeded = {}
        local failed = {}
        ContentProvider:PreloadAsync(assetIds, function(a, b)
            local iconName = iconIndex[a]

            if b == Enum.AssetFetchStatus.Success then
                table.insert(succeded, iconName)
            elseif b == Enum.AssetFetchStatus.Failure then
                table.insert(failed, iconName)
            end

            updateCb(succeded, failed, #assetIds)
        end)
    end

    --[[
        Loads all icons into memory
    ]]
    function loader.Load()
        if loader.loaded then
            return
        end

        local code = httpget(url)

        if not code then
            error("Error: Pack provided is invalid!")
        end

        local icons = loadstring(code)()

        if typeof(icons) ~= "table" then
            error("Error: Icon pack returned invalid data!")
        end

        for name, asset in icons do
            loader.Icons[name:lower()] = asset
        end

        loader.loaded = true
    end

    --[[
        Returns an icon if it exists.

        @param icon: string

        @return string
    ]]
    function loader.Icon(icon)
        if typeof(icon) ~= "string" then
            error("Error: Icon name must be a string!")
        end

        loader.Load()

        if loader._cached[icon:lower()] then
            return loader._cached[icon:lower()]
        end

        local key = icon:lower()
        local asset = loader.Icons[key]

        if not asset then
            error(
                `Error: Requested icon "{icon}" does not exist in pack.`
            )
        end

        loader._cached[key] = asset

        return asset
    end

    return loader
end

return {
    Remix = IconPackInitializer("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Remix/assets.luau"),
    Lucide = IconPackInitializer("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Lucide/assets.luau"),
    Tabler = IconPackInitializer("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Tabler/assets.luau"),
    Hero = IconPackInitializer("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Hero/assets.luau"),
    Phosphor = IconPackInitializer("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Phosphor/assets.luau"),

    Material = {
        variants = {
            ["400_24_rounded"] = IconPackInitializer("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Material/400_24_rounded/assets.luau"),
        },
    },
}
