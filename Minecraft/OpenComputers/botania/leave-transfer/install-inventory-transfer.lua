local shell = require "shell"
local term = require("term")
local rc = require "rc"



shell.execute("mkdir /etc/rc.d/leave-transfer")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/leave-transfer-server/leave-transfer.lua /etc/rc.d/leave-transfer/leave-transfer.lua")
shell.execute("wget -f https://raw.githubusercontent.com/JasonQ1232/Game-Scripts/main/Minecraft/OpenComputers/astral-sorcery/leave-transfer-server/script.lua /etc/rc.d/leave-transfer/script.lua")
rc.unload("leave-transfer/leave-transfer")
shell.execute("rc leave-transfer/leave-transfer enable")
shell.execute("rc leave-transfer/leave-transfer restart")
term.write("Remember to edit 'leave-transfer/script.lua' with the correct address and sides")