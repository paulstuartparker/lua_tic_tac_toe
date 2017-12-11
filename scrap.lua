
-- function dup(_board)
--   if type(_board) ~= 'table' then return _board end
--   local res = {}
--   for k, v in pairs(_board) do res[dup(k)] = dup(v) end
--   return res
-- end


--
-- local function dup(original)
--     local copy = {}
--     for k, v in pairs(original) do
--         -- as before, but if we find a table, make sure we copy that too
--         if type(v) == 'table' then
--             v = dup(v)
--         end
--         copy[k] = v
--     end
--     return copy
-- end

-- function dup(orig)
--     local orig_type = type(orig)
--     local copy
--     if orig_type == 'table' then
--         copy = {}
--         for orig_key, orig_value in next, orig, nil do
--             copy[dup(orig_key)] = dup(orig_value)
--         end
--         setmetatable(copy, dup(getmetatable(orig)))
--     else -- number, string, boolean, etc
--         copy = orig
--     end
--
--     return copy
-- end

-- end util

-- win / draw / loss evaluation


-- end win eval section

-- computer player section


-- function Board:dup(o, seen)
--   seen = seen or {}
--   if o == nil then return nil end
--   if seen[o] then return seen[o] end
--
--   local no
--   if type(o) == 'table' then
--     no = {}
--     seen[o] = no
--
--     for k, v in next, o, nil do
--       no[dup(k, seen)] = dup(v, seen)
--     end
--     setmetatable(no, dup(getmetatable(o), seen))
--   else -- number, string, boolean, etc
--     no = o
--   end
--   return no
-- end
