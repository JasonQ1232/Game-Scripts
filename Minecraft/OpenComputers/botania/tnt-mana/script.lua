local os = require("os")
local sides = require("sides")
local component = require("component")
local term = require("term")

for address, componentType in component.list() do
    term.write(address .. "\n")
end