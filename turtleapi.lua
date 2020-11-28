FUEL_CHEST = 1
RESOURCE_CHEST = 2
FUEL_STACK_SIZE = 64

stone_variants = {
    "minecraft:stone"
    "quark:basalt"}

function test_print()
    print("harambe")
end

function log(error_code, error_desc)
end

function check_and_refuel()
--TODO: check id of FUEL_SLOT and move it away if its not valid
    local fuel_level = turtle.getFuelLevel()
    while fuel_level < 2000 do
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

        if not turtle.refuel(64) then
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

        for i = 3, i = 16 do
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

function selective_dig()
    local success_top, block_top = turtle.inspectUp()
    local success_down, block_down = turtle.inspectDown()

    print(check_against_stone_variants(success_top))
    print(check_against_stone_variants(success_down))    

end

function safe_dig()
    check_and_refuel()
    check_and_empty_inv()
    if not turtle.move() then
        turtle.dig()
    end
end