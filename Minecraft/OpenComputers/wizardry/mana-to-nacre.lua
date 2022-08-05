--MADE FOR ROBOTS--
--Requires, geolyzer, 2 tanks, 1 tank controller, 1 inventory and controller
local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local robot = require("robot")
local geo = component.geolyzer
local inv_con = component.inventory_controller
local tank_con = component.tank_controller

whitelist = {"wizardry:nacre_fluid"}
internal_inv_size = robot.inventorySize()

altitude = 0
mana_tank = 1
nacre_tank = 2

function scan()
    while true do
        result_table = geo.analyze(sides.front)
        for block in pairs(whitelist) do
            block_name = whitelist[block]
            if(result_table.name == block_name) then
                pickup_nacre()
                manage_tank()
                manage_inventory()
                start_craft()
                print_info()
            end
        end
        os.sleep(3)
    end
end

function manage_tank()
    mana_capacity = robot.tankLevel(mana_tank)
    nacre_capacity = robot.tankLevel(nacre_tank)
    if(mana_capacity < 1000 or nacre_capacity > 15000) then
        robot.up()
        robot.up()
        nacre_store_limit = tank_con.getTankCapacity(sides.front)
        robot.selectTank(nacre_tank)
        while(nacre_capacity > 0) do
            nacre_store_capacity = tank_con.getTankLevel(sides.front)
            nacre_capacity = robot.tankLevel(nacre_tank)
            if((nacre_store_capacity + nacre_capacity) < nacre_store_limit) then
                robot.fill(nacre_capacity)
            end 
        end

        robot.up()
        mana_store_limit = tank_con.getTankCapacity(sides.front)
        robot.selectTank(mana_tank)
        while(mana_capacity < 16000) do
            mana_capacity = robot.tankLevel(mana_tank)
            robot.drain()
        end
        robot.down()
        robot.down()
        robot.down()
    end
end

function manage_inventory()
    robot.select(1)
    if(inv_con.getStackInInternalSlot(1) == nil) then
        robot.turnAround()
        for slot = 1, inv_con.getInventorySize(sides.front), 1 do
            if(inv_con.getStackInSlot(sides.front, slot) ~= nil) then
                inv_con.suckFromSlot(sides.front, slot, 64)
                break
            end
        end
        robot.turnAround()
    end
end

function start_craft()
    robot.selectTank(mana_tank)
    robot.fill()
    robot.select(1)
    robot.drop(1)
end

function pickup_nacre()
    robot.selectTank(nacre_tank)
    robot.drain()
end

function print_info()
    term.clear()

    mana_capacity = robot.tankLevel(mana_tank)
    nacre_capacity = robot.tankLevel(nacre_tank)
    print("Internal mana capacity: " .. mana_capacity)
    print("Internal nacre capacity: " .. nacre_capacity)
end

manage_tank()
manage_inventory()
start_craft()
print_info()
scan()