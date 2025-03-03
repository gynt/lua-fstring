# Easy string formatting in lua
Lua implementation of Python f-strings (string formatting) focused on performance

## Usage
```lua
f = require("fstring")

v = 100

print(f"Let's format {v}") -- prints: "Let's format 100"

print(f"Let's format {v:0x%X}") -- prints: "Let's format 0x64"
```

## Implementation
The f string searches the environment of the calling scope for variables named inside `{}`.  
If not found it searches the global environment. 
It does not "walk up" the stacktrace to find variables in those environments. This is for performance reasons.

Furthermore, it doesn't evaluate what is between `{}` but rather only a variable name is supported.
Thus, it is important that you (re)declare variables in your f strings as local variables like so:
```lua
ignored_function = function()
  local ignored_variable = 100
  used_function = function()
    local used_variable = ignored_variable * 2
    return f"{ignored_variable} + {used_variable}"
  end
  return used_function
end
```
