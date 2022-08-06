local shell = require "shell"


shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/blood-magic/slates-v3.lua /home/slates-v3.lua")

shell.execute("mkdir /home/installers")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/greg-tech/diesel-engine-toggle/install-diesel-engine-toggle.lua /home/installers/install-diesel-engine-toggle.lua")
shell.execute("/home/installers/install-diesel-engine-toggle.lua")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/starlight-transmuter-server/install-starlight-transmuter.lua /home/installers/install-starlight-transmuter.lua")
shell.execute("/home/installers/install-starlight-transmuter.lua")
