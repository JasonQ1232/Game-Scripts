local shell = require "shell"
local term = require("term")

shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/15aef93c96e3ede609ab7e2fb609c12108d84894/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/starlight-transmuter.lua /etc/rc.d/starlight-transmuter.lua")
shell.execute("mkdir /etc/rc.d/starlight-transmuter")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/15aef93c96e3ede609ab7e2fb609c12108d84894/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/script.lua /etc/rc.d/starlight-transmuter/script.lua")

term.write("Remember to add 'starlight-transmuter' to the /etc/rc.cfg file.")