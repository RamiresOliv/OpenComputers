local function proxyComp(name)return component.proxy(component.list(name)())end
function Split(s,del)out={};for match in(s..del):gmatch("(.-)"..del)do;table.insert(out,tostring(match));end return out;end
local m=proxyComp("modem")
local d=proxyComp("drone")
local function Send(msg)m.broadcast(2412,msg)end
m.open(2412)

local function exe()
    while true do
        local evt,_,_,_,_,cmd,arg1,arg2,arg3,arg4= computer.pullSignal()
        if evt== "modem_message" then
            local exec= {motive= "none", state= false, out= nil}
            local cmd= Split(cmd_all, " ")
            if cmd[1] == "move" or cmd[1] == "mov" then
                if cmd[2] then Args = Split(cmd[2], ",") exec.out = d.move((tonumber(cmd[2]) or 0), (tonumber(cmd[3]) or 0), (tonumber(cmd[4]) or 0)) exec.state = true else exec.motive="No args" end
            elseif cmd[1] == "setstatustext" or cmd[1] == "sst" then
                if cmd[2] then exec.out = d.setStatusText(cmd[2]) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "setlightcolor" or cmd[1] == "slc" then
                if cmd[2] then exec.out = d.setLightColor(tonumber(cmd[2])) exec.state = true else exec.motive="No 2 args"  end
            elseif cmd[1] == "setacceleration" or cmd[1] == "sa" then
                if cmd[2] then exec.out = d.setAcceleration(tonumber(cmd[2])) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "drain" then if cmd[3] == "all" then cmd[3] = 16000 end
                if cmd[2] then exec.out = d.drain(tonumber(cmd[2]), tonumber(cmd[3])) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "fill" then if cmd[3] == "all" then cmd[3] = 16000 end
                if cmd[2] then exec.out = d.fill(tonumber(cmd[2]), tonumber(cmd[3])) exec.state = true else exec.motive="No 2 args" end
            elseif cmd[1] == "drop" then
                if cmd[2] then exec.state = true exec.out = d.drop(tonumber(cmd[2]), tonumber((cmd[3] or 64))) else exec.motive="No 2 args" end
            elseif cmd[1] == "suck" then
                if cmd[2] then exec.state = true exec.out = d.suck(tonumber(cmd[2]), tonumber((cmd[3] or 64))) else exec.motive="No 2 args" end
            elseif cmd[1] == "place" then
                if cmd[2] then exec.state = true exec.out = d.place(tonumber(cmd[2]), tonumber((cmd[3] or false))) else exec.motive="No 2 args" end
            elseif cmd[1] == "select" then exec.state = true
                exec.out = d.select(tonumber(cmd[2]))
            elseif cmd[1] == "selecttank" or cmd[1] == "st" then exec.state = true
                exec.out = d.selectTank(tonumber(cmd[2]))
            elseif cmd[1] == "tanklevel" or cmd[1] == "tl" then exec.state = true
                exec.out = d.tankLevel(tonumber(cmd[2]))
            elseif cmd[1] == "getlightcolor" then exec.state = true
                exec.out = d.getLightColor()
            elseif cmd[1] == "name" then exec.state = true
                exec.out = d.name()
            elseif cmd[1] == "shutdown" then exec.state = true Send("Drone Shutdownned port '2412' closed.. Bye")
                exec.out = computer.shutdown()
            else
                exec.motive = "Command not found"
            end
            if exec.out == nil then exec.out = " " elseif exec.out == false then exec.out = "false, Some error ocurred!" end
            return exec, cmd[1], '👌'
        end
    end
end
while true do local succ,reason= pcall(function() local rt, cmd=exe()
    if not rt.state then Send("ERROR: Not Success in ".. cmd .."\nReturn: ".. tostring(rt.motive)) else Send("Return: ".. tostring(rt.out)) end end)
    if not succ then Send(reason)end
end
