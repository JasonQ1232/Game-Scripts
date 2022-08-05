local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local serial = require("serialization")
local event  = require("event")
local tunnel = component.tunnel


--[[
    Valid commands:
    "request_manifest"
]]
function wan()

end

function request_inventory_manifest()
    tunnel.send("request_manifest")
    local _, _, from, port, _, message = event.pull("modem_message")
    local manifest = serial.unserialize(message)
    return manifest
end

function print_manifest()
    local manifest = request_inventory_manifest()
    term.clear()
    print("Swap manifest:")
    print("SLOT | ITEM | STACK | MAX")
    for slot = 1, 16, 1 do
        if(manifest[slot] ~= nil) then
            if(slot < 10) then spacer = "  |  " else spacer = " |  "
            print(slot .. "  |  " .. manifest[slot].name .. "  |  " .. 
                manifest[slot].stackSize .. "  |  " .. manifest[slot].maxStackSize)
        end
    end
end

wan()
print_manifest()