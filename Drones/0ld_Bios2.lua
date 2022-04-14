local function proxyComp(name) return component.proxy(component.list(name)()) end
function Split(s, delimiter) result = {}; for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, tostring(match)); end return result; end
local m = proxyComp("modem")
local d = proxyComp("drone")
local function returnMSG(msg) m.broadcast(2412, msg) end
m.open(2412)
local LAST_executation_result = { motive = "none", state = false, returnned = nil }

local function execute()
    while true do
        local event, _, _, _, _, cmd = computer.pullSignal()
        if event == "modem_message" then
            result = {}
            local Splitted_cmd = Split(cmd, " ")
            motive = "none"
            state = false
            if Splitted_cmd[1] == "move" or Splitted_cmd[1] == "mov" then
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
            elseif Splitted_cmd[1] == "setstatustext" or Splitted_cmd[1] == "sst" then
                if Splitted_cmd[2] then
                    state = true
                    LAST_executation_result.returnned = d.setStatusText(Splitted_cmd[2])
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif Splitted_cmd[1] == "setlightcolor" or Splitted_cmd[1] == "slc" then
                if Splitted_cmd[2] then
                    state = true
                    LAST_executation_result.returnned = d.setLightColor(tonumber(Splitted_cmd[2]))
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif Splitted_cmd[1] == "getlightcolor" then
                state = true
                LAST_executation_result.returnned = d.getLightColor()
            elseif Splitted_cmd[1] == "setacceleration" or Splitted_cmd[1] == "sa" then
                if Splitted_cmd[2] then
                    state = true
                    LAST_executation_result.returnned = d.setAcceleration(tonumber(Splitted_cmd[2]))
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif Splitted_cmd[1] == "shutdown" then
                state = true
                returnMSG("Drone Shutdownned port '2412' closed.")
                LAST_executation_result.returnned = computer.shutdown()
            else
                motive = "This command not exists!"
            end
            LAST_executation_result.motive = motive
            LAST_executation_result.state = state
            if LAST_executation_result.returnned == nil then LAST_executation_result.returnned = " " end
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
