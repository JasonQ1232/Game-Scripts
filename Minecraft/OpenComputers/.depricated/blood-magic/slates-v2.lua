local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local rs = component.redstone
local ba = component.blood_altar

function reset_rs()
    rs.setOutput(sides.right, 0)
    rs.setOutput(sides.left, 0)
    os.sleep(0.5)
end

function altar_update()
    altar_content = ba.getStackInSlot(1).label:lower()
    altar_capacity = ba.getTankInfo().amount
end

function insert_item()
    capacity_message = false
    insert_message = false

    while(altar_capacity < 15000) do
        altar_update()
        if(capacity_message == false) then
            print("Altar capacity too low, awaiting refill.")
            capacity_message = true
        end
        os.sleep(5)
    end
    os.sleep(0.5)
    capacity_message = false
    
    while(ba.getStackInSlot(1).size < 1) do
        rs.setOutput(sides.left, 10)
        if(insert_message == false) then
            print("Inserting new item.")
        end
        os.sleep(0.1)
    end
    insert_message = false
    reset_rs()
end

function extract_item()
    print("Extracting item.")
    rs.setOutput(sides.right, 10)
    os.sleep(5)
    reset_rs()
end

function cycle()
    extract_item()
    os.sleep(1)
    insert_item()
end

function start()
    term.clear()
    reset_rs()
    term.write("enter target item: ")
    target_item = string.gsub(term.read():lower(), "\n", "")
    os.sleep(2)
    term.clear()
    loop()
end

function loop()
    altar_update()
    if(altar_content == "air") then
        print("Altar Empty, inserting new item.")
        insert_item()
    elseif(altar_content == target_item) then
        print("Item complete.")
        cycle()
    elseif(altar_capacity < 100) then
        cycle()
    end

    os.sleep(1)
    term.clear()
    print("Altar Capacity: " .. ba.getTankInfo().amount)
    print("Altar Contents: " .. altar_content)
    print("Altar Target: " .. target_item)
    loop()
end

start()