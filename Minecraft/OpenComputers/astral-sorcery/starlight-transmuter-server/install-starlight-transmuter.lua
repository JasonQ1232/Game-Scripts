local shell = require "shell"
local term = require("term")
local rc = require "rc"



shell.execute("mkdir /etc/rc.d/starlight-transmuter")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/starlight-transmuter.lua /etc/rc.d/starlight-transmuter/starlight-transmuter.lua")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/script.lua /etc/rc.d/starlight-transmuter/script.lua")
rc.unload("starlight-transmuter/starlight-transmuter")
shell.execute("rc starlight-transmuter/starlight-transmuter enable")
shell.execute("rc starlight-transmuter/starlight-transmuter restart")
term.write("Remember to edit 'starlight-transmuter/script.lua' with the correct address and sides")