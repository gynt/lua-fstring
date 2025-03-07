y = 100
test_2 = [[0x{ y :%X}]]

if f(test_2) ~= "0x64" then
  error()
end

addr = 0x401000

result = f[[
  push {addr:0x%X}
  call {addr}
]]
expected = [[
  push 0x401000
  call 0x401000
]]

if result ~= expected then
  error()
end
