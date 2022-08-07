local os = require("os")
local component = require("component") 
local sides = require("sides")

local rs_address = "9e0c"
local rs_side = sides.top
local geo_address = "a38c"
local geo_side = sides.top

local rs = component.proxy(component.get(rs_address))
local geo = component.proxy(component.get(geo_address))

local whitelist = {
    "gregtech:ore_uranium_0", 
    "minecraft:clay", 
    "minecraft:end_stone", 
    "gregtech:compressed_7", 
    "contenttweaker:sub_block_holder_0",
    "contenttweaker:sub_block_holder_1",
    "contenttweaker:sub_block_holder_3",
    "contenttweaker:sub_block_holder_4",
    "contenttweaker:sub_block_holder_5",
    "contenttweaker:sub_block_holder_6",
    "actuallyadditions:block_crystal_cluster_redstone",
    "actuallyadditions:block_crystal_cluster_lapis",
    "actuallyadditions:block_crystal_cluster_coal",
    "actuallyadditions:block_crystal_cluster_diamond",
    "actuallyadditions:block_crystal_cluster_iron"
}

while true do
    result_table = geo.analyze(geo_side)
    for block in pairs(whitelist) do
        block_name = whitelist[block]
        if(result_table.name == block_name) then
            rs.setOutput(rs_side, 15)
            rs.setOutput(rs_side, 0)
        end
    end
    os.sleep(0.2)
end

