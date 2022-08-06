local shell = require "shell"
local term = require("term")

shell.execute("mkdir /etc/rc.d/starlight-transmuter")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/starlight-transmuter.lua /etc/rc.d/starlight-transmuter/starlight-transmuter.lua")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/script.lua /etc/rc.d/starlight-transmuter/script.lua")
shell.execute("rc enable starlight-transmuter/starlight-transmuter.lua")
term.write("Remember to edit 'starlight-transmuter/script.lua' with the correct address and sides")