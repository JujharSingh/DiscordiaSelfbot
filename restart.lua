local discordia = require('discordia')
local client = discordia.Client()

client:on('messageCreate', function(message)
    if message.content == "open/" then
        os.execute([[C:\Users\jujha\Documents\GitHub\DiscordiaSelfbot\run.bat]])
    end
    if message.content == "restart/" then
        local msg = message.channel:sendMessage {
            embed = {
                title = "SelfBot Restarting..."
            }
        }
        os.execute("ping www.google.com")
        msg.embed = {
                title = "SelfBot Restart Complete"
            }
        os.execute([[C:\Users\jujha\Documents\GitHub\DiscordiaSelfbot\run.bat]])
    end

end)

client:run("")