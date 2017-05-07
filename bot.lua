--[[
	note1= {"
		    timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
			footer = {text = message.author.name}
	"}
	note2 = "remember to remove token"
]]

local discordia = require('discordia')
local client = discordia.Client()
local pp = require('pretty-print')
client.voice:loadOpus('libopus-x64')
client.voice:loadSodium('libsodium-x64')

local suffix = "/"

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

local function code(str)
	return string.format('```\n%s```', str)
end

local function luacode(str)
	return string.format('```lua\n%s```', str)
end


local sandbox = setmetatable({
	os = {}
}, {__index = _G})

local function printLine(...)
	local ret = {}
	for i = 1, select('#', ...) do
		local arg = tostring(select(i, ...))
		table.insert(ret, arg)
	end
	return table.concat(ret, '\t')
end

local function prettyLine(...)
	local ret = {}
	for i = 1, select('#', ...) do
		local arg = pp.strip(pp.dump(select(i, ...)))
		table.insert(ret, arg)
	end
	return table.concat(ret, '\t')
end

local function exec(arg, msg)
	local permissions = discordia.Permissions()
	if not arg then return end
	if msg.author ~= msg.client.owner then return end
	local on = false
	arg = arg:gsub('```\n?', '')

	local lines = {}
	local msgbool = false
	sandbox.message = msg

	sandbox.cprint = function(tobeprinted)
		print(tobeprinted)
		msgbool = true
	end

	sandbox.say = function(messag)
		local embedmessage = msg.channel:sendMessage{
			embed = {
				fields = {
					{name = "I say...", value = messag, inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = msg.author.name}
			}
		}
		msgbool = true
		if not embedmessage then msg.channel:sendMessage(luacode(messag)) end
	end

	sandbox.print = function(...)
		table.insert(lines, printLine(...))
	end

	sandbox.pp = function(...)
		table.insert(lines, prettyLine(...))
	end

	sandbox.exit = function()
		os.exit()
	end

	sandbox.cmd = function(command)
		local f = assert(io.popen(command, 'r'))
		local s = assert(f:read('*a'))
		f:close()
		s = string.gsub(s, '^%s+', '')
		s = string.gsub(s, '%s+$', '')
		s = string.gsub(s, '[\n\r]+', ' ')
		local embedmessage = msg.channel:sendMessage {
			embed = {
				fields = {
					{name = "Command Prompt", value = s, inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = msg.author.name}
			}
		}
		msgbool = true
		if not embedmessage then msg.channel:sendMessage(luacode(s)) end
	end

	local fn, syntaxError = load(arg, 'DiscordBot', 't', sandbox)
	if not fn then return msg:reply(code(syntaxError)) end

	local success, runtimeError = pcall(fn)
	if not success then return msg:reply(code(runtimeError)) end
	lines = table.concat(lines, '\n')
	local embedmessage = msg.channel:sendMessage {
		embed = {
			fields = {
				{name = "Lua Console", value = lines, inline = true},
			},
			color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
			timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
			footer = {text = msg.author.name}
		}
	}
	if not embedmessage and msgbool == false then msg:reply(luacode(lines)) end
end

client:on('messageCreate', function(message)
	if message.content:sub(1,5):lower() == "info"..suffix then
		if msg.author ~= msg.client.owner then return end
		member = message.guild:getMember(mentioned[3])
		if not member then member = message.member end
		message.channel:sendMessage {
			embed = {
				title = "User Info:",
				description = "some info bout' the user.",
				fields = {
					{name = "Username", value = member.name, inline = true},
					{name = "Discriminator", value = member.discriminator, inline = true},
				},
				thumbnail = {url = member.avatarUrl;}
			}
		}
	end
	if message.content:sub(1,5):lower() == "help"..suffix then
		message.channel:sendMessage {
			embed = {
				title = "Help",
				description = "Glorious commands!",
				fields = {
					{name = "Fun", value = "\nlua"..suffix.." - `run lua!`",inline = true},
					{name = "Misc", value = "suffix"..suffix.." - `change the suffix.`\nping"..suffix.." - `pong.`",inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name}
			}
		}
	end	
	if message.content:sub(1,5):lower() == 'ping'..suffix then
		if message.author ~= message.client.owner then return end
		local x = os.clock()
		local s = 0
		for i=1,100000 do s = s + i end
		local ccolor = discordia.Color(math.random(255), math.random(255), math.random(255)).value
		local embedmessage = message.channel:sendMessage {
  			embed = {
    			title = "pong",
    			color = ccolor,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name}
 	 		}
		}
		if not embedmessage then noembedmsg = message.channel:sendMessage(luacode("pong")) end
		if not embedmessage then noembedmsg.content = luacode("pong"..string.format(" - time taken: %.2fs", os.clock() - x)) end
		if embedmessage then embedmessage.embed = {
    		title = "pong",
			description = string.format("time taken: %.2fs", os.clock() - x),
    		color = ccolor,
			timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
			footer = {text = message.author.name}
		} end
	end

	if message.content:sub(1,7):lower() == "suffix"..suffix then
		if message.author ~= message.client.owner then return end
		suffix = message.content:sub(8,8)
	end

	if message.content:sub(1,4):lower() == "say"..suffix then
		if message.author ~= message.client.owner then return end
		local embedmessage = message.channel:sendMessage{
			embed = {
				fields = {
					{name = message.author.name.." says...", value = message.content:sub(5), inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name}
			}
		}
		if not embedmessage then message.channel:sendMessage(luacode(message.content:sub(5))) end
	end
	if message.content:sub(1,6):lower() == suffix.."lenny" then
		if message.author ~= message.client.owner then return end
		message.content = [[( ͡° ͜ʖ ͡°)]]
	end
	if message.content:sub(1,4):lower() == "lua"..suffix then
		exec(message.content:sub(5),message)
	end
	if message.content:sub(1,9):lower() == "download"..suffix then
		if message.author ~= message.client.owner then return end
		local messagesend = message.channel:sendMessage {
			file = "files/"..message.content:sub(10)..".txt"
		}
		if not messagesend then message.channel:sendMessage("File does not exist/File uploading disabled") end
	end
	if message.content:sub(1,6):lower() == "files"..suffix then
		if message.author ~= message.client.owner then return end
		local embedmessage = message.channel:sendMessage {
			embed = {
				title = "Files:",
    			fields = {
					{name = "ᅠ", value = "ᅠuse download/FILENAME to download", inline = true},
					{name = "ᅠ", value = "ᅠ", inline = true},
					{name = "\n\n\nScripts", value = "Heishi\nArc_Slicer", inline = true},
					{name = "\n\n\nOther", value = "test", inline = true},
				},
				thumbnail = {url="http://www.staples-3p.com/s7/is/image/Staples/m005167845_sc7?$splssku$"},
    			color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name}
 	 		}
		}
		if not embedmessage then message.channel:sendMessage(luacode("Files: \nuse download/FILENAME to download \n\nScripts:\nHeishi\nArc_Slicer\n\nOther:\ntest")) end
	end
	if message.content:sub(1,5):lower() ==	"play"..suffix then
		if message.author ~= message.client.owner then return end
		local splitmessage = message.content:split("/")
		local channel = client:getVoiceChannel(splitmessage[2])
		local connection = channel:join()
		connection:playFile(splitmessage[3], 99000)
	end
	if message.content:sub(1,8):lower() == "argtest"..suffix then
		if message.author ~= message.client.owner then return end
		local splitmessage = message.content:split("/")
		message.channel:sendMessage(luacode("arg 1: "..splitmessage[2]..", arg 2: "..splitmessage[3]))
	end
end)

client:run("")