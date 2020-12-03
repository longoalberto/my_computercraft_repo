INPUT_CHEST = "left" 
OUTPUT_CHEST = "right" --manually specify trash can name-id or side if next to pc

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


input = peripheral.wrap(INPUT_CHEST)
output = peripheral.wrap(OUTPUT_CHEST)

input_size = input.size()
output_size = output.size()

while true do
    for i=1,input_size,1 do
        if not input.getItemMeta(i)["name"] then
            break
        end
        item_name = input.getItemMeta(i)["name"]
        if not item_name then

        elseif filter_check(item_name) then
            input.pushItems(OUTPUT_CHEST, i)
            print("moved "..item_name.." to output chest")        
        end 
    end
    sleep(1)
end