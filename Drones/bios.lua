--[[

Welcome to the Bios.lua
be free to change

Explain:

This script will be like the main part for the drone to work, it is so important that if it is not present the drone will not turn on.
Okay, but what is it anyway? The bios is where the drone system will act like "do" or "go" things like that.

The Script is still under construction, many things will change!

NEVER! USE lua bios (default)
it is incompatible for drones! It is necessary to create a compatible bios.

In this case, this script takes information sent or specific commands sent from Client.lua to bios via Network,
thus executing functions within the bios.

Requirements:
- Wireless network card - LVL1 or LVL2
- EEPROM configured with this code.
- FLASH to put this script inside the EEPROM.

Sample code: https://gist.github.com/fnuecke/6bcbd66910b946b54ec7

Tutorial at README.md on Drones!
]]

local function proxyComp(name) return component.proxy(component.list(name)()) end
function Split(s, delimiter) result = {}; for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, tostring(match)); end return result; end
local m = proxyComp("modem")
local d = proxyComp("drone")

local function returnMSG(msg) m.broadcast(2412, msg) end

m.open(2412) -- Port from the modem

local LAST_executation_result = { -- VERY important
    motive = "none";
    state = false;
    returnned = nil;
}

-- Executing functions for... 4 commands lol.
local function execute()
    while true do
        local event, _, _, _, _, cmd = computer.pullSignal()
        if event == "modem_message" then
            result = {}
            local Splitted_cmd = Split(cmd, " ")
            motive = "none"
            state = false

            if Splitted_cmd[1] == "move" then
                if Splitted_cmd[2] then
                    state = true
                    Args = Split(Splitted_cmd[2], ",")
                    if Args[1] == "" or Args[1] == nil then Args[1] = 0 end
                    if Args[2] == "" or Args[2] == nil then Args[2] = 0 end
                    if Args[3] == "" or Args[3] == nil then Args[3] = 0 end
                    LAST_executation_result.returnned = d.move(tonumber(Args[1]), tonumber(Args[2]), tonumber(Args[3]))
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif Splitted_cmd[1] == "setstatustext" then
                if Splitted_cmd[2] then
                    state = true
                    LAST_executation_result.returnned = d.setStatusText(Splitted_cmd[2])
                else
                    state = false
                end
            elseif Splitted_cmd[1] == "setlightcolor" then
                if Splitted_cmd[2] then
                    state = true
                    LAST_executation_result.returnned = d.setLightColor(tonumber(Splitted_cmd[2]))
                else
                    state = false
                end
            elseif Splitted_cmd[1] == "getlightcolor" then
                state = true
                LAST_executation_result.returnned = d.getLightColor()

            else
                motive = "This command not exists!"
            end

            LAST_executation_result.motive = motive
            LAST_executation_result.state = state
            if motive ~= "none" then returnMSG(motive) end
            return LAST_executation_result
        end
    end
end

while true do
    local success, reason = pcall(function()
        local success, result = execute()
        if not LAST_executation_result.state then
            returnMSG("11: Not Success in make this command") return
        else returnMSG("Success in make this action!\n" .. tostring(LAST_executation_result.returnned))
        end
    end)

    if not success then returnMSG(reason) end
end
