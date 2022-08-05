local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local serial = require("serialization")
local event  = require("event")
local tunnel = component.tunnel
local inv_con = component.inventory_controller

function send_table(table)
    local message = serial.serialize(table)
    tunnel.send(message)
end

function get_local_inventory_list()
    local internal_inv_size = 16
    local contents = {}

    for slot = 1, 16, 1 do
        item = inv_con.getStackInInternalSlot(slot)
        if(item ~= nil) then
            contents[slot] = {}
            contents[slot].name = item.label
            contents[slot].stackSize = item.size
            contents[slot].maxStackSize = item.maxSize
        end
    end
    return contents
end

function await_manifest_request()
    while true do
        local _, _, from, port, _, message = event.pull("modem_message")
        print(message)
        if(message == "request_manifest") then
            break
        end
    end
    print("Manifest requested, sending.")
    manifest = get_local_inventory_list()
    send_table(manifest)
end


await_manifest_request()
