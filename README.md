# Easy string formatting in lua
Lua implementation of Python f-strings (string formatting) focused on performance

## Usage
```lua
f = require("fstring")

v = 100

print(f"Let's format {v}") -- prints: "Let's format 100"

print(f"Let's format {v:0x%X}") -- prints: "Let's format 0x64"
```

### Formatting options
Formatting options are provided by lua's `string.format` library.

## Implementation & Caveats

### Lookup
The f string searches the environment of the calling scope for variables named inside `{}`. 
If 'walk' option is one, it keeps walking up the call stack to find the variable.
If not found it searches the global environment.

### Evaluation
It doesn't evaluate what is between `{}` but rather only a variable name is supported.
Thus, it is important that you (re)declare variables in your computed f strings as local variables like so:
```lua
local used_variable = ignored_variable * 2
return f"{ignored_variable} + {used_variable}"
```

### Tailcalls
Avoid tail calls as the debug library cannot find local variables.
