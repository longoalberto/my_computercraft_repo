TRASH_CHEST = "right" --manually specify trash can name-id or side if next to pc

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

function filter_check(item_name)
    for i, blacklisted_name in pairs(armor_variants) do
        if blacklisted_name == nil then
            return false
        elseif blacklisted_name == item_name then
            return true
        end
    end
    return false
end

function get_connected_devices()
    local var = peripheral.getNames()
    local modem = table.remove(var, 1)

    for i, device_name in ipairs(var) do
        if device_name == TRASH_CHEST then
            print("Trash peripheral found and connected")
            trash_object = peripheral.wrap(TRASH_CHEST)
            trash = table.remove(var, i)
        end
    end

    if not trash then
        print("Trash peripheral not found, check denomination of TRASH_CHEST variable in sorterApi.lua")
        os.exit()
    end
    return var, modem, trash_object
end

chest_list, modem_pos, trash_object = get_connected_devices()

--item_list = chest.list()


chest = peripheral.wrap(chest_list[1])
chest_size = chest.size()

for i=1,chest_size,1 do

    local item_name = chest.getItemMeta(i)["name"]
    print(item_name)
    if filter_check(item_name) then
        local item_object = chest.getItem(i)
        item_object.drop(i, TRASH_CHEST)
    end 
end
