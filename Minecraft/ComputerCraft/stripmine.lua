function stripmine()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
end

function checkFuel()
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel<100 then
        turtle.refuel(5)
    end
end

args = {...}
for i=1, args[1] do
    checkFuel()
    stripmine()
end