local Lua = {}

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
end
return Lua
