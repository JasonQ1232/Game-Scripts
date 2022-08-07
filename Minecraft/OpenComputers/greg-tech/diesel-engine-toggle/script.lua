local os = require("os")
local sides = require("sides")
local component = require("component")
local term = require("term")

local rs_address = "deb1"
local rs_side = sides.south
local injectorA_address = "229a"
local injectorB_address = "d7ad"

local rs = component.proxy(component.get(rs_address))
local injectorA = component.proxy(component.get(injectorA_address))
local injectorB = component.proxy(component.get(injectorB_address))


local injectors = { injectorA, injectorB }



active = false
while true do
    activate = false
    for injector in pairs(injectors) do
        max_energy = injectors[injector].getMaxEnergyStored()
        cur_energy = injectors[injector].getEnergyStored()
        -- term.write(injector .. " : " .. cur_energy .. "\n")
        if (cur_energy < (max_energy * 0.10)) then
            active = true
            activate = true
        elseif (activate == false) then
            active = false
        end
    end

    if (active) then
        rs.setOutput(rs_side, 15)
    else
        rs.setOutput(rs_side, 0)
    end
    os.sleep(5)
end