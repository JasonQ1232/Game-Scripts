local component = require("component") 
local os = require("os")
local sides = require("sides")
local term = require("term")
local robot = require("robot")
local geo = component.geolyzer
local piston = component.piston

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
internal_inv_size = robot.inventorySize()

function scan()
    while true do
        result_table = geo.analyze(sides.front)
        for block in pairs(whitelist) do
            block_name = whitelist[block]
            if(result_table.name == block_name) then
                piston.push()
            end
        end
    end
end

while true do
    scan()
end