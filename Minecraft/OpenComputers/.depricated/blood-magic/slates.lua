local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local rs = component.redstone
local ba = component.blood_altar

capacity_message = false
term_count = 0

function reset_rs()
    rs.setOutput(sides.right, 0)
    rs.setOutput(sides.left, 0)
    os.sleep(0.5)
end

function timeout()
    term_count = term_count + 1
    if(term_count >= 10) then
        term.clear()
        os.sleep(0.5)
        print("Timeout: Program terminated.")
        reset_rs()
        os.sleep(1)
        start()
    end
end

function timeout_reset()
    term_count = 0
end

function cycle()
    rs.setOutput(sides.right, 10)
    while(ba.getTankInfo().amount < 15000) do
        if(capacity_message == false) then
            print("Altar capacity too low, awaiting refill.")
            capacity_message = true
        end
        os.sleep(5)
    end
    capacity_message = false
    rs.setOutput(sides.right, 0)
    while(ba.getStackInSlot(1).size < 1) do
        rs.setOutput(sides.left, 10)
        timeout()
    end
    timeout_reset()
    rs.setOutput(sides.left, 0)
end

function start()
    reset_rs()
    term.write("enter target item: ")
    target_item = string.gsub(term.read():lower(), "\n", "")
    os.sleep(2)
    cycle()
    term.clear()
    loop()
end

function loop()
    while true do
        altar_content = ba.getStackInSlot(1).label:lower()
        
        if(altar_content == target_item) then
            print("DONE")
            cycle()
        end
    
        os.sleep(1)
        term.clear()
        print("Altar Capacity: " .. ba.getTankInfo().amount)
        print("Altar Contents: " .. altar_content)
        print("Altar Target: " .. target_item)
    end
end

term.clear()
start()



