local os = require("os")
local component = require("component") 
local sides = require("sides")

tp_address = "bb39"
tp_player_side = sides.east
tp_buffer_side = sides.north
tp = component.proxy(component.get(tp_address))

chest_inv_size = tp.getInventorySize(tp_buffer_side)

-- minecraft:leaves
-- Oak Leaves
while true do
    player_inv_size = tp.getInventorySize(tp_player_side)
    for slot = 1, player_inv_size, 1 do
        item = tp.getStackInSlot(tp_player_side, slot)
        if(item ~= nil and item.label == "Oak Leaves") then
            count = tp.getSlotStackSize(tp_player_side, slot)
            tp.transferItem(tp_player_side, tp_buffer_side, count, slot, 1)
        end
    end
    os.sleep(0.005)
end