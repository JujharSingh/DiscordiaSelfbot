--[[
	notes= {
		    timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
			footer = {text = message.author.name}
	}
]]

local discordia = require('discordia')
local client = discordia.Client()
local pp = require('pretty-print')

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

	if not arg then return end
	if msg.author ~= msg.client.owner then return end

	arg = arg:gsub('```\n?', '') -- strip markdown codeblocks

	local lines = {}

	sandbox.message = msg

	sandbox.cprint = function(tobeprinted)
		print(tobeprinted)
	end

	sandbox.say = function(message)
		msg.channel:sendMessage()
	end

	sandbox.print = function(...)
		table.insert(lines, printLine(...))
	end

	sandbox.p = function(...)
		table.insert(lines, prettyLine(...))
	end

	local fn, syntaxError = load(arg, 'DiscordBot', 't', sandbox)
	if not fn then return msg:reply(code(syntaxError)) end

	local success, runtimeError = pcall(fn)
	if not success then return msg:reply(code(runtimeError)) end
	lines = table.concat(lines, '\n')
	local cchannel = msg.channel

	--return msg:reply(luacode(lines))
	msg:delete()
	return cchannel:sendMessage {
		embed = {
			fields = {
				{name = "Lua Console", value = lines, inline = true},
			},
			color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
		}
	}
end

client:on('messageCreate', function(message)	
	if message.content:lower() == 'ping'..suffix then
		if message.author ~= message.client.owner then return end
		message.channel:sendMessage {
  			embed = {
    			title = "pong",
    			color = discordia.Color(math.random(255), math.random(255), math.random(255)).value
 	 		}
		}
		message:delete()
	end

	if message.content:sub(1,4):lower() == "say"..suffix then
		if message.author ~= message.client.owner then return end
		message.channel:sendMessage(code(message.content:sub(5)))
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
		message.channel:sendMessage {
			embed = {
				title = "Files:",
    			fields = {
					{name = "ᅠ", value = "ᅠuse download/FILENAME to download", inline = true},
					{name = "ᅠ", value = "ᅠ", inline = true},
					{name = "\n\n\nScripts", value = "Heishi\nArc_Slicer", inline = true},
					{name = "\n\n\nOther", value = "test", inline = true},
				},
				thumbnail = {url="http://www.staples-3p.com/s7/is/image/Staples/m005167845_sc7?$splssku$"},
    			color = discordia.Color(math.random(255), math.random(255), math.random(255)).value
 	 		}
		}
	end
	if message.content:sub(1,5):lower() == "poll"..suffix then
		message.reply(message.content:sub(6).." ".."React with up for yes and down for no"):addReaction(":thumbsup::skin-tone-1:"):addReaction(":thumbdown::skin-tone-1:")
	end
end)

client:run("MjcxNzM3MTE2MjE0NDI3NjUw.C91Oaw.qTRNFziBP-1S7p1drbS0dg7VC28")
