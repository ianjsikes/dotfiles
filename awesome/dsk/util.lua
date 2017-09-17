local util = {}

-- Returns a new table with the properties of both
-- t1 and t2. If t1 and t2 overlap, the values of t1
-- are overridden by t2.
function util.merge(t1, t2)
  local t3 = {}
  for k1,v1 in pairs(t1) do
    t3[k1] = v1
  end
  for k2,v2 in pairs(t2) do
    t3[k2] = v2
  end
  return t3
end

-- Same as merge(t1, t2), but will recursively merge
-- nested tables.
function util.merge_deep(t1, t2)
  local t3 = {}
  for k1,v1 in pairs(t1) do
    t3[k1] = v1
  end
  for k2,v2 in pairs(t2) do
    if type(v2) == "table" and t3[k2] and type(t3[k2]) == "table" then
      t3[k2] = merge_deep(t3[k2], v2)
    else
      t3[k2] = v2
    end
  end
  return t3
end

-- Safely access deep key on table
function util.check(t, s)
  local v = t

  for key in string.gmatch(s, "([^%.]+)(%.?)") do
    if v[key] then
      v = v[key]
    else
      return nil
    end
  end

  return v
end

return util
