local function proxyComp(name) return component.proxy(component.list(name)()) end
function Split(s, del) out = {}; for match in (s..del):gmatch("(.-)"..del) do table.insert(out, tostring(match)); end return out; end
local m = proxyComp("modem")
local d = proxyComp("drone")
local function Send(msg) m.broadcast(2412, msg) end
m.open(2412)

local function execute()
    while true do
        local evt, _, _, _, _, cmd_all = computer.pullSignal()
        if evt == "modem_message" then
            local exec = { motive = "none", state = false, Return = nil }
            local cmd = Split(cmd_all, " ")
            if cmd[1] == "move" or cmd[1] == "mov" then
                if cmd[2] then Args = Split(cmd[2], ",") exec.Return = d.move((tonumber(cmd[2]) or 0), (tonumber(cmd[3]) or 0), (tonumber(cmd[4]) or 0)) exec.state = true else exec.motive="No args" end
            elseif cmd[1] == "setstatustext" or cmd[1] == "sst" then
                if cmd[2] then exec.Return = d.setStatusText(cmd[2]) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "setlightcolor" or cmd[1] == "slc" then
                if cmd[2] then exec.Return = d.setLightColor(tonumber(cmd[2])) exec.state = true else exec.motive="No 2 args"  end
            elseif cmd[1] == "setacceleration" or cmd[1] == "sa" then
                if cmd[2] then exec.Return = d.setAcceleration(tonumber(cmd[2])) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "drain" then if cmd[3] == "all" then cmd[3] = 16000 end
                if cmd[2] then exec.Return = d.drain(tonumber(cmd[2]), tonumber(cmd[3])) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "fill" then if cmd[3] == "all" then cmd[3] = 16000 end
                if cmd[2] then exec.Return = d.fill(tonumber(cmd[2]), tonumber(cmd[3])) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "drop" then
                if cmd[2] then exec.state = true exec.Return = d.drop(tonumber(cmd[2]), tonumber((cmd[3] or 64))) else exec.motive="No 2 args" end
            elseif cmd[1] == "suck" then
                if cmd[2] then exec.state = true exec.Return = d.suck(tonumber(cmd[2]), tonumber((cmd[3] or 64))) else exec.motive="No 2 args" end
            elseif cmd[1] == "select" then exec.state = true
                exec.Return = d.select(tonumber(cmd[2]))
            elseif cmd[1] == "selecttank" or cmd[1] == "st" then exec.state = true
                exec.Return = d.selectTank(tonumber(cmd[2]))
            elseif cmd[1] == "tanklevel" or cmd[1] == "tl" then exec.state = true
                exec.Return = d.tankLevel(tonumber(cmd[2]))
            elseif cmd[1] == "getlightcolor" then exec.state = true
                exec.Return = d.getLightColor()
            elseif cmd[1] == "name" then exec.state = true
                exec.Return = d.name()
            elseif cmd[1] == "shutdown" then exec.state = true Send("Drone Shutdownned port '2412' closed.. Bye")
                exec.Return = computer.shutdown()
            else
                exec.motive = "This command not exists"
            end
            if exec.Return == nil then exec.Return = " " elseif exec.Return == false then exec.Return = "false, Some error ocurred!" end
            return exec, cmd[1], '👌'
        end
    end
end

while true do
    local success, reason = pcall(function()
        local result, cmd = execute()
        if not result.state then Send(cmd .. "> ERROR: Not Success\nReturn: " .. tostring(result.motive)) 
        else Send("Return: " .. tostring(result.Return))
        end
    end)
    if not success then Send(reason) end
end
