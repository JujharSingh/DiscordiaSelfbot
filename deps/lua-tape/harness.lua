local deepequal = require('deep-equal')
local process = require('process').globalProcess()

local results = {
  count = 0
, fails = 0
, passes = 0
}

function results:display()
  print()
  print('1..' .. tostring(results['count']))
  print('# tests\t' .. tostring(results['count']))
  print('# pass\t' .. tostring(results['passes']))
  if results['fails'] > 0 then
    print('# fail\t' .. tostring(self['fails']))
    os.exit(1)
  end
  os.exit(0)
end

process:on('exit', function()
  results:display()
end)

local harness = {}

function harness:new(o)
  local o = o or {}
  o['__done'] = false
  setmetatable(o, self)
  self.__index = self
  return o
end

function harness:ok(value, description) 
  results['count'] = results['count'] + 1
  if (value) then
    self:pass(description)
  else
    self:fail(description)
  end
end

function harness:notOk(value, description) 
  results['count'] = results['count'] + 1
  if (value) then
    self:fail(description)
  else
    self:pass(description)
  end
end

function harness:equals(a, b, description)
  results['count'] = results['count'] + 1
  if a == b then
    self:pass(description)
  else
    self:fail(description)
  end
end

function harness:notEquals(a, b, description)
  results['count'] = results['count'] + 1
  if a ~= b then
    self:pass(description)
  else
    self:fail(description)
  end
end

function harness:deepEquals(a, b, description)
  results['count'] = results['count'] + 1
  if a == b then 
    self:pass(description)
    return
  end
  if type(a) == 'table' then
    if deepequal(a, b, '') then
      self:pass(description)
    else
      self:fail(description)
    end
  else
    self:fail(description) 
  end
end

function harness:pass(description)
  results['passes'] = results['passes'] + 1
  print('passes', results['passes'])
  print('ok ' .. tostring(results['count']) .. ' - ' .. description)
end

function harness:fail(description)
  results['fails'] = results['fails'] + 1
  print('not ok ' .. tostring(results['count']) .. ' - ' .. description)
end

function harness:done()
  self['__done'] = true
end

return harness
