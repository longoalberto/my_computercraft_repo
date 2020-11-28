FUEL_CHEST = 1
RESOURCE_CHEST = 2
FUEL_STACK_SIZE = 64

stone_variants = {    
    "minecraft:cobblestone",
    "minecraft:gravel",
    "minecraft:grass",
    "minecraft:dirt",
    "minecraft:sand",
    "minecraft:sandstone",
    "minecraft:stone",
    "quark:basalt",
    "nuclearcraft:dry_earth",
    "biomesoplenty:grass",
    "biomesoplenty:dirt",
    "biomesoplenty:mud",
    "chisel:basalt",
    "chisel:basalt2",
    "chisel:marble",
    "chisel:marble2",
    "chisel:limestone",
    "chisel:limestone2"}

function test_print()
    print("harambe")
end

function log(error_code, error_desc)
end

function check_and_refuel()
--TODO: check id of FUEL_SLOT and move it away if its not valid
    local fuel_level = turtle.getFuelLevel()
    print("fuel level is "..fuel_level)
    while fuel_level < 2000 do
        print("inside while loop fuel level is "..fuel_level)
        turtle.select(FUEL_CHEST)
        turtle.turnRight()
        turtle.turnRight()
        if not turtle.place() then
            turtle.dig()
            turtle.place()
        end

        if not turtle.suck(FUEL_STACK_SIZE) then
            log("e", "Fuel chest empty.")
        end

        if not turtle.refuel(FUEL_STACK_SIZE) then
            local wrong_fuel = turtle.getItemDetail()["name"]
            log("e", "Incompatible Fuel"..wrong_fuel)
            turtle.drop()
        end

        turtle.dig()
        turtle.turnRight()
        turtle.turnRight()
    end
end

function check_and_empty_inv()
--TODO: check iterating list of turtle.drop against constants to make the slots customizable
    while (turtle.getItemCount(16) ~= 0) do
        turtle.select(RESOURCE_CHEST)
        turtle.turnRight()
        turtle.turnRight()
        if not turtle.place() then
            turtle.dig()
            turtle.place()
        end

        for i=3,16 do
            turtle.select(i)
            if not turtle.drop() then
                log("e", "Resource chest is full")
                break
            end            
        end
        
        turtle.select(RESOURCE_CHEST)
        turtle.dig()

        turtle.turnRight()
        turtle.turnRight()

    end
end

function check_against_stone_variants(block)
    for i, block_name in pairs(stone_variants) do
        if block_name == nil then
            return false
        elseif block_name == block then
            return true
        end        
    end
    return false
end

function vertical_dig(steps)
    for i=1,steps do
        check_and_refuel()
        check_and_empty_inv()

        if not turtle.forward() then
            turtle.dig()
            turtle.forward()
        end

        local success_top, block_top = turtle.inspectUp()
        local success_down, block_down = turtle.inspectDown()

        if (success_top or success_down) then
            check_and_empty_inv()
            if not check_against_stone_variants(block_top["name"]) then
                turtle.digUp()
            end
            if not check_against_stone_variants(block_down["name"]) then
                turtle.digDown()
            end
        end
    end
end

function standard_dig()
    check_and_refuel()
    check_and_empty_inv()
    if not turtle.forward() then
        turtle.dig()
    end
end

function dig_layer_spiral(width)
    local distance_to_dig = width-1
    vertical_dig(distance_to_dig)
    turtle.turnRight()
    while distance_to_dig > 0 do
        vertical_dig(distance_to_dig)
        turtle.turnRight()
        vertical_dig(distance_to_dig)
        turtle.turnRight()
        distance_to_dig = distance_to_dig - 1
    end

    vertical_dig(8)
    turtle.turnLeft()
    vertical_dig(7)
    turtle.turnRight()
    turtle.turnRight()
end