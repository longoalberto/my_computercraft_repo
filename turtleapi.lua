FUEL_CHEST = 1
RESOURCE_CHEST = 2
FUEL_STACK_SIZE = 64

fuel_level = turtle.getFuelLevel()

stone_variants = {
    "minecraft:cobblestone",
--    "minecraft:gravel",
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
    "chisel:limestone2"
}

falling_blocks = {
    "minecraft:gravel",
    "minecraft:sand"
}

--relative coordinates

coordinates = {0, 0, 0} -- x y z
directions = {"front", "right", "back", "left"}
current_direction = 1

function test_print()
    print("harambe")
end

function log(error_code, error_desc)
end

function set_relative_direction(dir)
    if dir == "front" then
        while current_direction ~= 1 do
            tracked_turn("right")
        end
    elseif dir == "right" then
        while current_direction ~= 2 do
            tracked_turn("right")
        end
    elseif dir == "back" then
        while current_direction ~= 3 do
            tracked_turn("left")
        end
    elseif dir == "left" then
        while current_direction ~= 4 do
            tracked_turn("left")
        end
    end
end

function go_to_start()
    print("gotostart called")
    if coordinates[2] > 0 then
        print("coords "..coordinates[2].." evaluated facing back")
        set_relative_direction("back")
        vertical_dig( coordinates[2] )
    elseif coordinates[2] < 0 then
        print("coords "..coordinates[2].." evaluated facing front")
        set_relative_direction("front")
        vertical_dig( math.abs(coordinates[2]) )
    end

    if coordinates[1] > 0 then
        print("coords "..coordinates[2].." evaluated facing right")
        set_relative_direction("right")
        vertical_dig( coordinates[1] )
    elseif coordinates[1] < 0 then
        print("coords "..coordinates[2].." evaluated facing left")
        set_relative_direction("left")
        vertical_dig( math.abs( coordinates[1] ) )
    end
end

function tracked_turn(dir)
    if dir == "right" then
        current_direction = current_direction + 1
        turtle.turnRight()
    elseif dir == "left" then
        current_direction = current_direction - 1
        turtle.turnLeft()
    end

    if current_direction > 4 then
        current_direction = current_direction - 4
    elseif current_direction < 0 then
        current_direction = current_direction + 4
    end
    print("current dir: "..current_direction.." coords: "..coordinates[1].." "..coordinates[2])
    sleep(2edi)
end

function check_and_refuel()
--TODO: check id of FUEL_SLOT and move it away if its not valid
    fuel_level = turtle.getFuelLevel()
    while fuel_level < 2000 do
        log("l", "fuel level at"..fuel_level)
        turtle.select(FUEL_CHEST)
        tracked_turn("right")
        tracked_turn("right")
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
        tracked_turn("right")
        tracked_turn("right")
        fuel_level = turtle.getFuelLevel()
    end
end

function check_and_empty_inv()
--TODO: check iterating list of turtle.drop against constants to make the slots customizable
    while (turtle.getItemCount(16) ~= 0) do
        turtle.select(RESOURCE_CHEST)
        tracked_turn("right")
        tracked_turn("right")
        if not turtle.place() then
            turtle.dig()
            turtle.place()
        end

        for i=3,16 do
            turtle.select(i)
            turtle.drop()
        end

        turtle.select(RESOURCE_CHEST)
        turtle.dig()

        tracked_turn("right")
        tracked_turn("right")

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

function handle_falling_blocks(block)
    for i, block_name in pairs(falling_blocks) do
        if block_name == nil then
            return false
        elseif block_name == block then
            turtle.dig()
            sleep(0.5)

            local success, next_block = turtle.inspect()
            if success then
                local next_block_name = next_block["name"]
                handle_falling_blocks(next_block_name)
            end
        end
    end
end

function check_if_bedrock_around()
    local success_front, block_front = turtle.inspect()
    local success_down, block_down = turtle.inspectDown()

    if (block_front["name"] == "minecraft:bedrock") or (block_down["name"] == "minecraft:bedrock") then
        return true
    else
        return false
    end
end

function go_down(depth)
    for i=1,depth do
        if not turtle.down() then
            if not turtle.digDown() then
                return false
            end
            turtle.down()
        end
    end
    return true
end

function vertical_dig(steps)
    for i=1,steps do
        check_and_refuel()
        check_and_empty_inv()

        local success_front, block_front = turtle.inspect()
        if success_front then
            handle_falling_blocks(next_block_name)
        end

        if not turtle.forward() then
            turtle.dig()
            while not turtle.forward() do
                sleep(1)
            end
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

    if current_direction == 1 then
        coordinates[2] = coordinates[2] + steps
    elseif current_direction == 2 then
        coordinates[1] = coordinates[1] + steps
    elseif current_direction == 3 then
        coordinates[2] = coordinates[2] - steps
    elseif current_direction == 4 then
        coordinates[1] = coordinates[1] - steps
    end
end

--not used
function standard_dig()
    check_and_refuel()
    check_and_empty_inv()
    if not turtle.forward() then
        turtle.dig()
    end
    turtle.dig()
end

function dig_layer_spiral(width)
    local distance_to_dig = width-1
    vertical_dig(distance_to_dig)
    tracked_turn("right")
    while distance_to_dig > 0 do
        vertical_dig(distance_to_dig)
        tracked_turn("right")
        vertical_dig(distance_to_dig)
        tracked_turn("right")
        distance_to_dig = distance_to_dig - 1
    end

--vertical_dig(width/2)
--tracked_turn("left")
--vertical_dig((width/2)-1)
--tracked_turn("right")
--tracked_turn("right")

    go_to_start()
end