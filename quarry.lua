os.loadAPI("turtleapi")
turtleapi.test_print()

while true do
    turtleapi.dig_layer_spiral(16)
    if not turtleapi.go_down(3) then
        break
    end
end