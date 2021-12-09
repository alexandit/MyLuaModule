local Lua = {}
local import = function(x)
  local s = x[1]
  if Lua[tostring(s)] then return Lua[tostring(s)] end
end

Lua.strings = {}
Lua.numbers = {}
Lua.tables = {}
Lua.bools = {}

do local strings = Lua.strings;
  function strings.capitalize(s)
    return string.upper(s:sub(1,1)) .. s:sub(2)
  end
  function strings.preprocess(s, m)
    if m == "q1" then
      s= string.gsub(s,"\\(\")", function(c)
        return string.format("\\%03d", string.byte(c))
      end)
      return s
    elseif m == "q2" then
      s = string.gsub(s, "\\(%d%d%d)",function(c)
        return "\\" .. string.char(c)
      end)
      return s
    end
  end
  function strings.whitespace(s, c, n)
    return string.gsub(s, "%s",
    function()
      return string.format("%s", c or "")
    end, n or #s)
  end
  function strings.toArray(s, m, n)
    local a= m or 1
    local c = a
    local x = {}
    repeat
      x[a+1 - c] = string.sub(s, a, a)
      a = a + 1
    until a > (n or #s)
    return x
  end
  function strings.strip(s, t, n, a)
    local x = string.rep("%s", t or 1)
    return string.gsub(s:sub((n or 1)), x .. "\n",
    function()
      return "\n"
    end, a or #s)
  end
end

do local tables = Lua.tables
  function tables.iCopy(t)
    local x = {};
    for i, v in ipairs(t) do
      x[i] = v
    end
    return x
  end
  function tables.sCopy(t)
    local x = {}
    for i, v in pairs(t) do
      if type(i) == "string" then
        x[i] = v
      end
    end
    return x
  end
  function tables.assign(h, t)
    local x = t
    local b = h
    for i, v in pairs(x) do
      b[i] = v
    end
    return b
  end
  function tables.getValue(t)
    local x = 0
    for _,_ in pairs(t) do x = x + 1 end
    return x
  end
  function tables.getValueOfType(t, s)
    local x = 0
    if not s or type(s) ~= "string" then return nil end
    for i, v in pairs(t) do
      if type(v) == s then
        x = x + 1
      end
    end
    return x
  end
end

return import
