local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local serial = require("serialization")
local modem = component.modem
local rs = component.redstone
local battery = component.battery_buffer

battery_lower_limit = 25
battery_upper_limit = 95

last_gen_status = false
last_bat_status = 0

generator_side = sides.bottom

port
modem.open(20)

function get_data()
    battery_max_capacity = battery.getCapacity() 
    battery_current_capacity = battery.getEnergyStored()
    local percent = (battery_current_capacity/battery_max_capacity)*100
    battery_percent = tonumber(string.format("%.2f", percent))
end

function send_data(lines_table)
    get_data()
    data = {
        type = "Gas Turbine",
        battery = battery_percent .. "%",
        status = "unknown"
    }
    message = serial.serialize(data)
    modem.broadcast
end


function active_generator(bool)
    local rs_val = 0

    if(bool == true) then 
        rs_val = 10 
    else 
        rs_val = 0 
    end
    rs.setOutput(sides.bottom, rs_val)
    return bool
end


function loop()
    while true do
        get_data()
        if(battery_percent <= battery_lower_limit) then
            active_generator(true)
            gen_status = "Online"
        elseif(battery_percent >= battery_upper_limit) then
            active_generator(false)
            gen_status = "Offline"
        end

        if(battery_percent ~= last_bat_status or gen_status ~= last_gen_status) then
            term.clear()
            gen_percentage = "Current battery percentage: " .. battery_percent .. "%"

            print(gen_percentage)
            print("Generator: " .. gen_status)

            last_bat_status = battery_percent
            last_gen_status = gen_status
        end
        send_data()
        os.sleep(1)
    end
end

loop()