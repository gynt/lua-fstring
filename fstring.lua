
local namespace = {}

function parse(s)
  
  local results = {}
  
  local r = ''
  local is_var = false
  local lhs = ''
  local rhs = ''
  local is_rhs = false
  local var = ''
  local start = 0
  local finish = 0

  for i=1,s:len() do
    local c = s:sub(i, i)
    if c == '{' then
      table.insert(results, r)
    
      is_var = true
      var = ''
      lhs = ''
      rhs = ''
      is_rhs = false
      start = i
    elseif c == '}' then
      is_var = false
      finish = i
      if is_rhs then
        table.insert(results, {start = start, finish = finish, lhs = lhs:gsub("^%s+", ""):gsub("%s+$", ""),
          rhs = rhs,
        })
      else
        table.insert(results, {start = start, finish = finish, lhs = lhs:gsub("^%s+", ""):gsub("%s+$", ""),
          rhs = nil,
        })
      end
      
      r = ''
    else
      if is_var then
        if c == ":" then
          is_rhs = true
        else
          if is_rhs then 
            rhs = rhs .. c
          else
            lhs = lhs .. c
          end
        end        
      else
        r = r .. c
      end
    end
  end
  
  table.insert(results, r)
  
  return results
end

function lookup(var, level, use_globals)
  for i=1,100,1 do
    local k, v = debug.getlocal(level, i)
    if k == nil then
      break
    end
    if k == var then
      return v
    end
  end


  
  if use_globals == true and _G[var] ~= nil then return _G[var] end
  
  error(string.format("Could not find variable: %s", var))
end

function f(s, use_globals, default_number_format)  
  local default_number_format = default_number_format or "0x%X"
  local use_globals = use_globals or true
  
  local parts = parse(s)
  for i, part in ipairs(parts) do
    if type(part) ~= "string" then
      local value = lookup(part.lhs, 3, use_globals)
      if type(value) == "number" then
        parts[i] = string.format(part.rhs or default_number_format, value)
      else
        parts[i] = string.format(part.rhs or "%s", value)
      end
      
    end
  end
  
  return table.concat(parts, "")
end

return f, namespace -- for future options
