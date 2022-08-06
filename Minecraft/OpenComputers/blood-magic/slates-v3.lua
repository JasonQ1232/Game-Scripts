local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local ba = component.blood_altar
local tp = component.transposer
--local gpu = component.gpu

--Sides
--0 Bottom: down, negy
--1 Top: up, posy
--2 Back: north, negz
--3 Front: south, posz, forward
--4 Right: west, negx
--5 Left: east, posx


sides_input_chest = 4
sides_output_chest = 5
sides_blood_altar = 3

altar_min_capacity = 2500
altar_transfer_count = 1

--gpu.setResolution(75,24)
term.clear()
altar_insert_error = false
altar_extract_error = false

function altar_update()
    altar_content = ba.getStackInSlot(1).label:lower()
    altar_capacity = tonumber(string.format("%.0f", ba.getTankInfo().amount))
    altar_max_capacity = tonumber(string.format("%.0f", ba.getTankInfo().capacity))
    os.sleep(0.5)
    term.clear()
    print("Altar capacity: " .. altar_capacity .. "/" .. altar_max_capacity)
    print("Altar capacity lower limit: " .. altar_min_capacity)
    print("Altar content: " .. altar_content)
    print("Target item: " .. altar_target_item)
    if(altar_insert_error == true) then print("Altar capacity low, awaiting refil.") end
    if(altar_extract_error == true) then print("Altar empty, skipping step.") end 
end

function user_input_get_target()
    term.write("Enter target item: ")
    altar_target_item = string.gsub(term.read():lower(), "\n", "")
    term.write("Enter altar minimum blood level: ")
    altar_min_capacity = tonumber(term.read())
    os.sleep(1)
end

function altar_insert()
    while true do
        altar_update()
        if(altar_capacity >= altar_min_capacity) then
            altar_insert_error = false
            for slot=1, tp.getInventorySize(sides_input_chest), 1 do
                local item = tp.getStackInSlot(sides_input_chest, slot)
                if(item ~= nil) then
                    tp.transferItem(sides_input_chest, sides_blood_altar, altar_transfer_count, slot, 1)
                    goto altar_insert_end
                end
            end
        else
            if(altar_insert_error == false) then
                altar_insert_error = true
                goto altar_insert_end
            end
            os.sleep(1)
        end
    end
    ::altar_insert_end::
end

function altar_extract()
    while true do
        altar_update()
        if(altar_insert_error == true) then
            goto altar_extract_end
        elseif(altar_content == "air" and altar_extract_error == false) then
            altar_extract_error = true
            print("Altar empty, skipping step.")
            altar_extract_error = true
        elseif(altar_content == altar_target_item) then
            altar_extract_error = false
            for slot=1, tp.getInventorySize(sides_output_chest), 1 do
                item = tp.getStackInSlot(sides_output_chest, slot)
                if(item == nil) then
                    tp.transferItem(sides_blood_altar, sides_output_chest, altar_transfer_count, 1, slot)
                    goto altar_extract_end
                else
                    if(item.label:lower() == altar_target_item) then
                        tp.transferItem(sides_blood_altar, sides_output_chest, altar_transfer_count, 1, slot)
                        goto altar_extract_end
                    end
                end
            end
        else
            os.sleep(1)
        end
    end
    ::altar_extract_end::
end

function check_finished()
    for slot=1, tp.getInventorySize(sides_input_chest), 1 do
        local item = tp.getStackInSlot(sides_input_chest, slot)
        if(item ~= nil) then
            return
        end
    end
    term.write("Input empty, terminating program.")
    os.exit()
end

function work()
    user_input_get_target()
    while true do
        check_finished()
        altar_insert()
        altar_extract()
        os.sleep(0.5)
    end
end

work()