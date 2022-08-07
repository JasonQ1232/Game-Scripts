local os = require("os")
local sides = require("sides")
local component = require("component")
local term = require("term")

local rs_address = "a466"
local rs_side = sides.east
local injectorA_address = "c48c"
local injectorB_address = "ebf6"

local rs = component.proxy(component.get(rs_address))
local injectorA = component.proxy(component.get(injectorA_address))
local injectorB = component.proxy(component.get(injectorB_address))


local injectors = { injectorA, injectorB }
local status = {}

active = false
while true do
    for injector in pairs(injectors) do
        max_energy = injectors[injector].getMaxEnergyStored()
        cur_energy = injectors[injector].getEnergyStored()
        --term.write(injector .. " : " .. cur_energy .. "\n")
        if (cur_energy < (max_energy * 0.20)) then
            table.insert(status, true)
            --term.write("true" .. "\n")
        elseif (cur_energy > (max_energy * 0.75)) then
            table.insert(status, false)
            --term.write("false" .. "\n")
        end
    end

    activate = false
    for i in pairs(status) do
        if (status[i] == true) then
            activate = true
            --term.write("activate generator" .. "\n")
            break
        end
    end

    if (activate) then
        rs.setOutput(rs_side, 15)
    else
        rs.setOutput(rs_side, 0)
    end

    for i in pairs(status) do
        status[i] = nil
    end

    os.sleep(5)
end