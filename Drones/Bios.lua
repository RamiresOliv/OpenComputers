local function proxyComp(name) return component.proxy(component.list(name)()) end
function Split(s, delimiter) result = {}; for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, tostring(match)); end return result; end
local m = proxyComp("modem")
local d = proxyComp("drone")
local function Send(msg) m.broadcast(2412, msg) end
m.open(2412)
local Last_exe_result = { state = false, returnned = nil }

local function execute()
    while true do
        local event, _, _, _, _, cmd_all = computer.pullSignal()
        if event == "modem_message" then
            local cmd = Split(cmd_all, " ")
            motive = "none"
            state = false
            if cmd[1] == "move" or cmd[1] == "mov" then
                if cmd[2] then
                    state = true
                    Args = Split(cmd[2], ",")
                    if Args[1] == "" or Args[1] == nil then Args[1] = 0 end
                    if Args[2] == "" or Args[2] == nil then Args[2] = 0 end
                    if Args[3] == "" or Args[3] == nil then Args[3] = 0 end
                    Last_exe_result.returnned = d.move(tonumber(Args[1]), tonumber(Args[2]), tonumber(Args[3]))
                else
                    state = false
                end
            elseif cmd[1] == "setstatustext" or cmd[1] == "sst" then
                if cmd[2] then
                    state = true
                    Last_exe_result.returnned = d.setStatusText(cmd[2])
                else
                    state = false
                end
            elseif cmd[1] == "setlightcolor" or cmd[1] == "slc" then
                if cmd[2] then
                    state = true
                    Last_exe_result.returnned = d.setLightColor(tonumber(cmd[2]))
                else
                    state = false
                end
            elseif cmd[1] == "getlightcolor" then
                state = true
                Last_exe_result.returnned = d.getLightColor()
            elseif cmd[1] == "setacceleration" or cmd[1] == "sa" then
                if cmd[2] then
                    state = true
                    Last_exe_result.returnned = d.setAcceleration(tonumber(cmd[2]))
                end
            elseif cmd[1] == "drop" then
                Last_exe_result.returnned = d.drop(1, tonumber(cmd[2]))
            elseif cmd[1] == "suck" then
                if cmd[2] then
                    state = true
                    if not cmd[3] then
                        Last_exe_result.returnned = d.suck(1, tonumber(cmd[2]))
                    else
                        Last_exe_result.returnned = d.suck(tonumber(cmd[2]), tonumber(cmd[3]))
                    end
                end
            elseif cmd[1] == "shutdown" then
                state = true
                Send("Drone Shutdownned port '2412' closed.")
                Last_exe_result.returnned = computer.shutdown()
            elseif cmd[1] == "select" then
                Last_exe_result.returnned = d.select(tonumber(cmd[2]))
                state = true
            else motive = "This command not exists"
            end
            Last_exe_result.motive = motive
            Last_exe_result.state = state
            if motive ~= "none" then Send(motive) end
            if Last_exe_result.returnned == nil then Last_exe_result.returnned = " " elseif Last_exe_result.returnned == false then Last_exe_result.returnned = "false, Some error ocurred!" end
            return Last_exe_result
        end
    end
end

while true do
    local success, reason = pcall(function()
        local success, result = execute()
        if not Last_exe_result.state then
            Send("ERROR: Not Success in execte this command") return
        else Send("Success in execte this command!\nReturn: " .. tostring(Last_exe_result.returnned))
        end
    end)

    if not success then Send(reason) end
end
