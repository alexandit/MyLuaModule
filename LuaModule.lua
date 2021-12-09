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
  function strings.strip(s, t, n, a)
    local x = string.rep("%s", t or 1)
    return string.gsub(s:sub((n or 1)), x .. "\n",
    function()
      return "\n"
    end, a or #s)
  end
  function strings.new(s)
    local t = {["host"]=s}
    local m = {}
    for i, v in pairs(strings) do if i ~= "new" then m[i] = v end end
    for i, v in pairs(m) do m[i] = function(...) return v(t.host, ...) end end
  end
end

return Lua
