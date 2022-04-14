--[[
Unlike the bios,
Client.lua sends the information via Network to the bios remotely,
so it is necessary to use this script on a computer with a Wireless Network Card LVL1 or LVL2
]]

local component = require("component")
local event = require("event")
local term = require("term")
local modem = component.modem
modem.open(2412)
print("Warning: for no give errors you can use the commands like: 'move 0,3,0' with NO SPACES,\nif you put spaces the script can't read it.\n")
while true do
  local cmd = io.read()
  if not cmd then return end
  if cmd:lower() == "clear" or cmd:lower() == "cls" then term.clear() else
  modem.broadcast(2412, cmd)
  local evt, _, _, _, _, msg = event.pull(5, "modem_message")
  if msg == "" or msg == nil then
    io.stderr:write("None Returns.\n")
    print("Remember: if have so muth time to none returns? the port '2412' can be closed. Check the Drone and restart this script.")

  else
    print(msg)
  end
  end
end