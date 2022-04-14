-- 4+ KB (NO FUNCTIONABLE)

local function proxyComp(name) return component.proxy(component.list(name)()) end
function Split(s, delimiter) result = {}; for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, tostring(match)); end return result; end
local m = proxyComp("modem")
local d = proxyComp("drone")
local s = proxyComp("side")
local function returnMSG(msg) m.broadcast(2412, msg) end
m.open(2412)
local LAST_exe_r = { motive = "none", state = false, returnned = nil }
local function execute()
    while true do
        local evt, _, _, _, _, cmd = computer.pullSignal()
        if evt == "modem_message" then
            local S_CMD = Split(cmd, " ")
            motive = "none"
            state = false
            if S_CMD[1] == "move" or S_CMD[1] == "mov" then
                if Splitted_cmd[2] then
                    state = true
                    Args = Split(S_CMD[2], ",")
                    LAST_exe_r.returnned = d.move(tonumber(Args[1]), tonumber(Args[2]), tonumber(Args[3]))
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif S_CMD[1] == "setstatustext" or S_CMD[1] == "sst" then
                if S_CMD[2] then
                    state = true
                    LAST_exe_r.returnned = d.setStatusText(Splitted_cmd[2])
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif S_CMD[1] == "setlightcolor" or S_CMD[1] == "slc" then
                if S_CMD[2] then
                    state = true
                    LAST_exe_r.returnned = d.setLightColor(tonumber(S_CMD[2]))
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif S_CMD[1] == "getlightcolor" then
                state = true
                LAST_exe_r.returnned = d.getLightColor()
            elseif S_CMD[1] == "setacceleration" or S_CMD[1] == "sa" then
                if S_CMD[2] then
                    state = true
                    LAST_exe_r.returnned = d.setAcceleration(tonumber(SpliS_CMDtted_cmd[2]))
                else
                    state = false
                    motive = "no secound argument..."
                end
            elseif S_CMD[1] == "drop" then
                if S_CMD[2] then
                    if S_CMD[3] then
                        state = true
                        LAST_exe_r.returnned = d.suck(side[S_CMD[2]], [S_CMD[3]])
                    else
                        state = false
                        motive = "no 3 argument..."
                    end
                else
                    state = false
                    motive = "no 2 argument..."
                end
            elseif S_CMD[1] == "suck" then
                if S_CMD[2] then
                    if S_CMD[3] then
                        state = true
                        LAST_exe_r.returnned = d.suck(side[S_CMD[2]], [S_CMD[3]])
                    else
                        state = false
                        motive = "no 3 argument..."
                    end
                else
                    state = false
                    motive = "no 2 argument..."
                end
            elseif S_CMD[1] == "shutdown" then
                state = true
                returnMSG("Drone Shutdownned port '2412' closed.")
                LAST_exe_r.returnned = computer.shutdown()
            else
                motive = "This command not exists!"
            end
            LAST_exe_r.motive = motive
            LAST_exe_r.state = state
            if LAST_exe_r.returnned == nil then LAST_exe_r.returnned = " " end
            if motive ~= "none" then returnMSG(motive) end
            return LAST_exe_r
        end
    end
end

while true do
    local success, reason = pcall(function()
        local success, result = execute()
        if not LAST_exe_r.state then
            returnMSG("11: Not Success in make this command") return
        else returnMSG(LAST_exe_r.returnned)
        end
    end)

    if not success then returnMSG(reason) end
end
