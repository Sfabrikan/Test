function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  x = 10
  
  y = x
  print(x)
end
