TRASH_CHEST = "xu2:tiletrashcan_0" --manually specify trash can name-id

armor_variants = {
    "minecraft:leather_helmet_",
    "minecraft:leather_chestplate_",
    "minecraft:leather_leggings_",
    "minecraft:leather_boots_",

    "minecraft:iron_helmet",
    "minecraft:iron_chestplate",
    "minecraft:iron_leggings",
    "minecraft:iron_boots",

    "minecraft:chainmail_helmet_",
    "minecraft:chainmail_chestplate_",
    "minecraft:chainmail_leggings_",
    "minecraft:chainmail_boots_",

    "minecraft:golden_helmet",
    "minecraft:golden_chestplate",
    "minecraft:golden_leggings",
    "minecraft:golden_boots",

    "minecraft:diamond_helmet_",
    "minecraft:diamond_chestplate_",
    "minecraft:diamond_leggings_",
    "minecraft:diamond_boots_"
}

tools_variants = {
    "minecraft:wooden_sword",
    "minecraft:wooden_shovel",
    "minecraft:wooden_pickaxe",
    "minecraft:wooden_axe",
    "minecraft:wooden_hoe",

    "minecraft:stone_sword",
    "minecraft:stone_shovel",
    "minecraft:stone_pickaxe",
    "minecraft:stone_axe",
    "minecraft:stone_hoe",

    "minecraft:iron_sword",
    "minecraft:iron_shovel",
    "minecraft:iron_pickaxe",
    "minecraft:iron_axe",
    "minecraft:iron_hoe",
    
    "minecraft:golden_sword",
    "minecraft:golden_shovel",
    "minecraft:golden_pickaxe",
    "minecraft:golden_axe",
    "minecraft:golden_hoe",

    "minecraft:diamond_sword",
    "minecraft:diamond_shovel",
    "minecraft:diamond_pickaxe",
    "minecraft:diamond_axe",
    "minecraft:diamond_hoe"

}

mods_blacklist = {
    "botania",
    "ic2",
    "openblocks",
    "mysticalagriculture",
    "nuclearcraft",
    "twilightforest",
    "immersiveengineering",
    "redstonearsenal",
    "psi",
    "quark"
}


function get_connected_devices()
    local var = peripheral.getNames()
    local modem = table.remove(var, 1)

    for i, device_name in ipairs(var) do
        if device_name == TRASH_CHEST then
            print("Trash peripheral found and connected")
            trash = table.remove(var, i)
        end
    end

    if not trash then
        print("Trash peripheral not found, check denomination of TRASH_CHEST variable in sorterApi.lua")
        os.exit()
    end
    return var, modem
end

chest_list, modem_pos = get_connected_devices()


chest = peripheral.wrap(chest_list[1])
item_list = chest.list()

for index, item in pairs(item_list) do
    if not item then
        break
    end

    print(item[index]["name"])
end

