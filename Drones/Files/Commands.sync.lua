'''{
  move = function(arg2, arg3, arg4) if arg2 then exec.out = d.move((tonumber(arg2) or 0), (tonumber(arg3) or 0), (tonumber(arg4) or 0)) exec.state = true else exec.motive="No args" end end,
  setstatustext = function(arg2, arg3, arg4) if arg2 then exec.out = d.setStatusText(arg2) exec.state = true else exec.motive="No 2 args" end end,
  setacceleration = function(arg2, arg3, arg4) if arg2 then exec.out = d.setLightColor(tonumber(arg2)) exec.state = true else exec.motive="No 2 args" end end,
  drain = function(arg2, arg3, arg4) if arg3 == "all" then arg3 = 16000 end if arg2 then exec.out = d.drain(tonumber(arg2), tonumber(arg3)) exec.state = true else exec.motive="No 2 args" end end,
  fill = function(arg2, arg3, arg4) if arg3 == "all" then arg3 = 16000 end if arg2 then exec.out = d.fill(tonumber(arg2), tonumber(arg3)) exec.state = true else exec.motive="No 2 args" end end,
  drop = function(arg2, arg3, arg4) if arg2 then exec.state = true exec.out = d.drop(tonumber(arg2), tonumber((arg3 or 64))) else exec.motive="No 2 args" end end,
  suck = function(arg2, arg3, arg4) if arg2 then exec.state = true exec.out = d.suck(tonumber(arg2), tonumber((arg3 or 64))) else exec.motive="No 2 args" end end,
  place = function(arg2, arg3, arg4) if arg2 then exec.state = true exec.out = d.place(tonumber(arg2), tonumber((arg3 or false))) else exec.motive="No 2 args" end end,
  select = function(arg2, arg3, arg4) if arg2 then exec.state = true exec.out = d.place(tonumber(arg2), tonumber((arg3 or false))) else exec.motive="No 2 args" end end,
  place = function(arg2, arg3, arg4) exec.out = d.select(tonumber(arg2)) end,
  selecttank = function(arg2, arg3, arg4) exec.out = d.selectTank(tonumber(arg2)) end,
  tanklevel = function(arg2, arg3, arg4) exec.out = d.tankLevel(tonumber(arg2)) end,
  getlightcolor = function(arg2, arg3, arg4) exec.out = d.getLightColor() end,
  name = function(arg2, arg3, arg4) exec.out = d.name() end,
  shutdown = function(arg2, arg3, arg4) exec.out = computer.shutdown()) end
}'''
