local shell = require "shell"
local term = require("term")
local rc = require "rc"



shell.execute("mkdir /etc/rc.d/diesel-engine-toggle")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/botania/diesel-engine-toggle/script.lua /etc/rc.d/diesel-engine-toggle/diesel-engine-toggle.lua")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/botania/diesel-engine-toggle/script.lua /etc/rc.d/diesel-engine-toggle/script.lua")
rc.unload("diesel-engine-toggle/diesel-engine-toggle")
shell.execute("rc diesel-engine-toggle/diesel-engine-toggle enable")
shell.execute("rc diesel-engine-toggle/diesel-engine-toggle restart")
term.write("Remember to edit 'diesel-engine-toggle/script.lua' with the correct address and sides")