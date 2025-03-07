
test_1 = "hel{x}! I am: {y}"
y = 'Gynt'

local x = 'lo world'; result = f(test_1)

if result ~= "hello world! I am: Gynt" then
  error()
end
