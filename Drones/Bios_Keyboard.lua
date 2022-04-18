--[[
Not great.
muth delay and can't see nothing.

F

]]

local function proxyComp(name) return component.proxy(component.list(name)()) end
function Split(s, delimiter) result = {}; for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, tostring(match)); end return result; end
local m = proxyComp("modem")
local d = proxyComp("drone")
local function returnMSG(msg) m.broadcast(2412, msg) end
m.open(2412) -- Commands port
local LAST_executation_result = { motive = "none", state = false, returnned = nil }

local function execute()
    while true do
        local event, _, _, _, _, cmd = computer.pullSignal()
        if event == "modem_message" then
            local Splitted_cmd = Split(cmd, " ")
            motive = "none"
            state = false
            if Splitted_cmd[1] == "w" then
                LAST_executation_result.returnned = d.move(1, 0, 0)
            end
            if Splitted_cmd[1] == "s" then
                LAST_executation_result.returnned = d.move(-1, 0, 0)
            end
            if Splitted_cmd[1] == "a" then
                LAST_executation_result.returnned = d.move(0, 0, -1)
            end
            if Splitted_cmd[1] == "d" then
                LAST_executation_result.returnned = d.move(0, 0, 1)
            end
            if Splitted_cmd[1] == "q" then
                LAST_executation_result.returnned = d.move(0, -1, 0)
            end
            if Splitted_cmd[1] == "e" then
                LAST_executation_result.returnned = d.move(0, 1, 0)
            end
            if LAST_executation_result.returnned == nil then LAST_executation_result.returnned = " " end
            return LAST_executation_result
        end
    end
end

while true do
    local success, reason = pcall(function()
        local success, result = execute()
        if not success then
            returnMSG("11: Not Success in make this command") return
        else returnMSG(tostring(LAST_executation_result.returnned))
        end
    end)

    if not success then returnMSG(reason) end
end
