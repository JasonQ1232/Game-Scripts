local os = require("os")
local component = require("component") 
local sides = require("sides")
local geo = component.geolyzer

rs_address = "2b41"
rs_side = sides.top
geo_side = sides.top

rs = component.proxy(component.get(rs_address))

whitelist = {
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

function scan()
    while true do
        result_table = geo.analyze(geo_side)
        for block in pairs(whitelist) do
            block_name = whitelist[block]
            if(result_table.name == block_name) then
                rs.setOutput(rs_side, 15)
                rs.setOutput(rs_side, 0)
            end
        end
    end
end

while true do
    scan()
    os.sleep(0.5)
end