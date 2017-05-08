local harness = require('./harness')

function test (name, cb)
  local h = harness:new()
  print('# ' .. name)
  cb(h)
  
  if h['__done'] == false then
    h:fail('test ended without calling :done()')
  end
end

return test
