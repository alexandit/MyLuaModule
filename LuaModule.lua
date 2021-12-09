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
      s = string.gsub("\\([\"])", 
      function(c)
        return string.format("\\(%03d)", string.byte(c))
      end)
      return s
    elseif m == "q2" then
      s = string.gsub("\\(%d%d%d)",
      function(c)
        return "\\" .. string.char(c)
      end)
    end
  end
end
return Lua
