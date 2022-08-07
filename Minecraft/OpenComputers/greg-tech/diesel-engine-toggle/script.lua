local os = require("os")
local sides = require("sides")
local component = require("component")
local term = require("term")

local rs_address = "deb1"
local rs_side = sides.south
local injectorA_address = "53f3"
local injectorB_address = "f02f"

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
        -- term.write(injector .. " : " .. cur_energy .. "\n")
        if (cur_energy < (max_energy * 0.20)) then
            table.insert(status, true)
        elseif (cur_energy > (max_energy * 0.80)) then
            table.insert(status, false)
        end
    end

    activate = false
    for i=1, status do
        if (status[i] == true) then
            activate = true
            break
        end
    end

    if (active) then
        rs.setOutput(rs_side, 15)
    else
        rs.setOutput(rs_side, 0)
    end

    for i=1, status do
        status[i] = nil
    end

    os.sleep(5)
end