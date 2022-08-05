local component = require("component")
local sides = require("sides")
local colors = require("colors")
local rs = component.redstone
local os = require("os")
local term = require("term")

while true do
    term.clear()
    rs.setOutput(sides.left, 0)
    rs.setOutput(sides.bottom, 0)
    os.sleep(0.5)

    term.write("enter number of loops: ")
    tc = term.read()
    tc = tonumber(tc)
    print(tc)
    os.sleep(1)

    for cc = 1, tc, 1 do
        rs.setOutput(sides.left, 10)
        for i = 1, 30, 1 do
            term.clear()
            print(i)
            os.sleep(1)
        end
        rs.setOutput(sides.bottom, 1)
        os.sleep(1)
        rs.setOutput(sides.left, 0)
        rs.setOutput(sides.bottom, 0)
        os.sleep(1)
    end

end