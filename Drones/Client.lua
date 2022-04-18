--[[
Bem, é o seguinte esse script pega oso comandos envidos pelo prommpt e envia via Network wireless para a Bios.
Mas caso o comando seja help, cls ou sleep são calculados aqui na propria Client.

92: if command:lower() == "clear" or command:lower() == "cls" then term.clear() elseif command:lower() == "help" or command:lower() == "h"
]]

-- Open Configs
version = 0.5.0
Ports = { receive = 2412; send = 2412; }
Commands_File = "commands.conf"

-- Auto Configs
function Split(s, del) out = {}; for match in (s..del):gmatch("(.-)"..del) do table.insert(out, tostring(match)); end return out; end
local component = require("component")
local event = require("event")
local sf = require("filesystem")
local term = require("term")
local modem = component.modem
local gpu = component.gpu
commands_color = "0xFFFFFF"

function Start()
    print("[ Client and Bios " .. tostring(version) .. "v ]")
    print("New update! now with SPACES!! like: 'move 0 3 0'!!\n")
end

Start()
modem.open(Ports.receive)

modem.broadcast(Ports.send, "setlightcolor 0x581B95") commands_color = "0x581B95"

--[[
    No change here! find a file default name "commands.conf" for edit or add commands! for appear on the client.
    and rememeber to put %& at the end for no give errors!!!
]] 
local PRE_Commands={
    move="move the drone from any positions with combinations EX: mov east/west up/down north/south$&",
    setstatustext="Set a new status from the drone.$&",
    setacceleration ="Set acceleration from the drone.$&",
    setlightcolor="Set the light color from the drone in the format RRGGBB EX: '0xFF0000'$&",
    getlightcolor="Return the current light color EX: '0xFF0000'$&",
    name="Returns the Drone name.$&",
    selecttank="Select any space in the fluid tanks, the max of tanks its 4.$&",
    tanklevel="Print the total of liquid in a tank selected.$&",
    drain="Drain any liquid from the world or inventory/tanks in the sides 1 at 5.$&",
    fill="Fill any liquid from world or inventory/tanks in the sides 1 at 5.$&",
    select="Select any space in the inventory from the drone, the max of tanks its 4.$&",
    drop="Drops itens in slected inventory slot from the drone, the max of tanks its 4.$&",
    place="Place any blocks in selected slot from the Drone.$&",
    suck="Sucks any item in any directions or inventorys with a direction 1 at 5. And the Drone try to put in emmpty space, if can't returns false or else true.$&",
    shutdown = "Turn off the Current drone.$&"
}
Check_Commands_File_Existence = function()
    if not io.open(Commands_File, "r") then
        file = io.open(Commands_File, "a")
        r = require("serialization").serialize(PRE_Commands):gsub('$&",','$&"\n'):gsub('{','{\n'):gsub('}','\n}')
        file:write(r)
        file:write("\n")
        file:write("\n### Be free to edit or add more commands! this commands gona be appear on the client side! 👀")
        file:write("\n### For restore the default Configs just delete this file and run on client 'help' and the file appear again")
        file:write("\n### Needs to comment something here? please use # 3x EX: ### Hello World for no give errors :)")
        file:close()
    end
end

local function Help()
    Start()
    print("")
    print("Commands found:")
    print("Actions Displonible from the current drone.")
    Check_Commands_File_Existence()
    os.sleep(0.1)
    file = io.open(Commands_File, "r")
    local result = file:read("a"):gsub('$&"\n','",'):gsub('\n}','}'):gsub('{\n','{'):gsub('###','--'):gsub('\n','')
    file:close()
    for i, v in pairs(require("serialization").unserialize(result)) do
        io.write("\n")
        gpu.setForeground(tonumber(commands_color))
        
        io.write("'" .. i .. "'")
        gpu.setForeground(0xFFFFFF)
        io.write(" - ")
        io.write(v)
    end
    print("\nYes, you can change the commands and add news commands!")
end

while true do
    io.write("> ")
    local command = io.read()
    if not command then return end
    if command:lower() == "clear" or command:lower() == "cls" then term.clear() elseif command:lower() == "help" or command:lower() == "h" then Help() else
        Splitted = Split(command, " ")
        if Splitted[1]:lower() == "sleep" then io.write("> ") command = io.read() os.sleep(tonumber(Splitted[2])) elseif Splitted[1]:lower() == "setlightcolor" or Splitted[1]:lower() == "slc" then commands_color = Splitted[2] end
        modem.broadcast(Ports.send, command:lower()) -- Send Command to the Drone
        local evt, _, _, _, _, msg = event.pull(3, "modem_message")
        if msg == "" or msg == nil then
            io.stderr:write("None Returns.\n")
            print("Remember: too muth time to none returns? the port '" .. tostring(Ports.send) .. "' can be closed. Check the Drone and restart this script.")
        else
            print(msg)
        end
    end
end
