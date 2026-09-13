return {
    Remix = loadstring(httpget("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Remix/assets.luau"))(),
    Lucide = loadstring(httpget("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Lucide/assets.luau"))(),
    Tabler = loadstring(httpget("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Tabler/assets.luau"))(),
    Hero = loadstring(httpget("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Hero/assets.luau"))(),

    Material = {
        variants = {
            ["400_24_rounded"] = loadstring(httpget("https://raw.githubusercontent.com/AlexanderTheWorst/Kairo/refs/heads/main/IconPacks/Material/400_24_rounded/assets.luau"))(),
        },
    },
}
