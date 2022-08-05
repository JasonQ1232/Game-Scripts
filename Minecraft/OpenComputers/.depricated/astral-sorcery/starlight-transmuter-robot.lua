local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local robot = require("robot")
local geo = component.geolyzer
local inv_con = component.inventory_controller


whitelist = {"gregtech:ore_uranium_0", "minecraft:clay", "minecraft:end_stone"}
internal_inv_size = robot.inventorySize()

function scan()
    while true do
        result_table = geo.analyze(sides.front)
        for block in pairs(whitelist) do
            block_name = whitelist[block]
            if(result_table.name == block_name) then
                robot.swing(sides.front)
                clean_inventory()
            end
        end
        os.sleep(1)
    end
end

function clean_inventory()
    robot.turnRight()
    robot.select(1)
    inv_con.dropIntoSlot(sides.front, 1)

    robot.turnAround()
    robot.select(1)
    while(inv_con.getStackInInternalSlot(1) == nil) do
        for slot = 1, inv_con.getInventorySize(sides.front), 1 do
            if(inv_con.getStackInSlot(sides.front, slot) ~= nil) then
                inv_con.suckFromSlot(sides.front, slot, 1)
                robot.turnRight()
                place_block()
            end
        end
        os.sleep(5)
    end
end

function place_block()
    robot.select(1)
    component.robot.place(sides.front)
    scan()
end


clean_inventory()