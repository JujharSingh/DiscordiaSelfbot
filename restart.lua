local discordia = require('discordia')
local client = discordia.Client()

if not args[2] then error("Please provide a token!") end
local cmd = [[luvit C:\Users\jujha\Documents\GitHub\DiscordiaSelfbot\bot.lua ]]..tostring(args[2])
client:on('messageCreate', function(message)
    if message.content == "open/" then
        os.execute(cmd)
    end
    if message.content == "restart/" then
        local msg = message.channel:sendMessage {
            embed = {
                title = "SelfBot Restarting..."
            }
        }
        local x = os.clock()
		local s = 0
		for i=1,100000 do s = s + i end
        os.execute("ping www.google.com")
        msg.embed = {
                title = "SelfBot Restart Complete",
                description = string.format("time taken: %.2fs", os.clock() - x)
            }
        os.execute(cmd)
    end

end)

client:run(args[2])