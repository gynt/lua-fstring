global_1 = 100

function a()
  return f[[{global_1}]]
end

if a() ~= "0x64" then
  error()
end

function b()
  local local_1 = 200
  local s =  f[[{global_1} {local_1}]]
  return s
end

if b() ~= "0x64 0xC8" then
  error()
end

-- This will throw an error because of tail calls:
function c()
  local local_1 = 200
  return f[[{global_1} {local_1}]]
end

local r = pcall(c)
if r ~= false then error() end
