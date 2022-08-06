local shell = require "shell"

shell.execute("wget https://github.com/JasonQ1232/Game-Scripts/blob/15aef93c96e3ede609ab7e2fb609c12108d84894/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/starlight-transmuter.lua /etc/rc.d/starlight-transmuter.lua")
shell.execute("mkdir /etc/rc.d/starlight-transmuter")
shell.execute("wget https://github.com/JasonQ1232/Game-Scripts/blob/15aef93c96e3ede609ab7e2fb609c12108d84894/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/script.lua /etc/rc.d/starlight-transmuter/script.lua")