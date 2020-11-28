fuel_minimum_level = 1000
coal_slot = 1
chest_slot = 2
depth = 0
 
function refuel_if_needed()
    local fuel_level = turtle.getFuelLevel()
    turtle.select(coal_slot)
    while fuel_level < 1000 do
        turtle.refuel(1)
        fuel_level = turtle.getFuelLevel()
    end
end
 
function dump_inventory()
    turtle.select(chest_slot)
    turtle.turnRight()
    turtle.turnRight()
    turtle.dig()
    turtle.place()
 
    for i = 3, 16 do
        turtle.select(i)
        turtle.drop()
    end
    
    turtle.select(chest_slot)
    turtle.dig()
 
    turtle.turnLeft()
    turtle.turnLeft()
end
 
function check_inventory()
    if turtle.getItemCount(16) ~= 0 then
        dump_inventory()
    end
end
 
function dig_move()
    if turtle.detect() then
        turtle.dig()
    end
    turtle.forward()
    check_inventory()
end
 
function dig_line(direction)
    for i = 1, 15 do
        dig_move()
    end
 
    if direction == "right" then
        turtle.turnRight()
        dig_move()
        turtle.turnRight()
    elseif direction == "left" then
        turtle.turnLeft()
        dig_move()
        turtle.turnLeft()
    end
end
    
function dig_layer()
    for i = 1, 7 do
        dig_line("right")
        dig_line("left")
    end
 
    dig_line("right")
    dig_line("stay")
    
    turtle.turnRight()
    for i = 1, 15 do
        turtle.forward()
    end
    turtle.turnRight()
end
 
function go_down()
    depth = depth + 1
    if not turtle.digDown() then
        for i = 1, (depth-1) do
            turtle.up()
        end
 
    end
    
end
 
function wrapper()
    refuel_if_needed()
 
    while true do
        dig_layer()
        refuel_if_needed()
 
        depth = depth+1
        turtle.digDown()
        if not turtle.down() then
            dump_inventory()
            for i = 1, (depth-1) do
                turtle.up()
            end
            break
        end                 
    end
end
 
wrapper()
