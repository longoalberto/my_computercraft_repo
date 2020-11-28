os.loadAPI("turtleapi")
turtleapi.test_print()

while true do
    local depth = 0
    turtleapi.dig_layer_spiral(16)
    if not turtleapi.go_down(3) then
        break
    end
    depth = depth+3
    
end

for i=1, depth do
    turtle.up()
end