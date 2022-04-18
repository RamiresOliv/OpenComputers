local component = require("component")
local internet = require("internet")
local shell = require("shell")
local term = require("term")
local text = require("text")
local folder = os.getenv("PWD")

Bios_status = false
Client_status = false

if not component.isAvailable("internet") then
  io.stderr:write("This program requires an internet card to run.")
  return
end

print("Starting...")
os.sleep(1)
print("Checking Updates...")
os.sleep(1)
local success, response = pcall(internet.request, "https://raw.githubusercontent.com/RamiresOliv/OpenComputers/master/Drones/Bios.lua")
if success then
    os.remove(folder.."/Bios.lua")
    local f, reason = io.open("Bios.lua", "a")
    local success2, reason = pcall(function()
        for chunk in response do
            if not f then
                assert(f, "Bios: failed opening file for writing: " .. tostring(reason))
            end
            f:write(chunk)
        end
    end)
    if not success2 then
        Bios_status = false
        io.stderr:write("Bios: failed, Trying the Client...\n")
    else
        Bios_status = true
        print("Bios: Success.")
    end
    f:close()
end
os.sleep(1)
local success, response = pcall(internet.request, "https://raw.githubusercontent.com/RamiresOliv/OpenComputers/master/Drones/Client.lua")
if success then
    os.remove(folder.."/Client.lua")
    local f, reason = io.open("Client.lua", "a")
    local success2, reason = pcall(function()
        for chunk in response do
            if not f then
                assert(f, "Client: failed opening file for writing: " .. tostring(reason))
            end
            f:write(chunk)
        end
    end)
    if not success2 then
        Client_status = false
        io.stderr:write("Client: failed.\n")
    else
        Client_status = true
        print("Client: Success.")
    end
    f:close()
end
os.sleep(2)
if Client_status then
    term.clear()
    print("Completed!")
    os.sleep(1)
    print("Welcome to...")
    os.sleep(1)
    os.execute("Client.lua")
else
    io.stderr:write("Can't start the Main file because the Client download is aborted!.\n")
    io.stderr:write("Exited.\n")
end
