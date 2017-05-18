local discordia = require('discordia')
local client = discordia.Client()
local pp = require('pretty-print')
local los = require('los')
local operatingsystem = los.type()
client.voice:loadOpus('libopus-x64')
client.voice:loadSodium('libsodium-x64')
local timer = require('timer')
local json = require('json')
local http = require("coro-http")
local suffix = "/"
local ball = {"It is certain", "It is decidedly so", "Without a doubt", "Yes definitely", "As I see it, yes", 
"Most likely", "Outlook good", "Yes", "Signs point to yes", "Don't count on it", 
"My reply is no", "My sources say no", "Outlook not so good", "Very doubtful"}
		function dump(o)
			if type(o) == 'table' then
	      		local s = '{ '
	      		for k,v in pairs(o) do
	         		if type(k) ~= 'number' then k = '"'..k..'"' end
	         		s = s .. '['..k..'] = ' .. dump(v) .. ','
	      		end
	      		return s .. '} '
	   		else
      			return tostring(o)
   			end
		end
function print_t ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end
local wait = function(time)
	timer.sleep(time)
end

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

	sandbox.client = client
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
	if lines == "" then msgbool = true end
	if not embedmessage and msgbool == false then msg:reply(luacode(lines)) end
end

client:on('messageCreate', function(message)
	if message.author ~= message.client.owner then return end
	if message.content == "close/" then
		os.exit()
	end
	if message.content:sub(1,7):lower() == "shares"..suffix then
		query = message.content:sub(8):lower()
		query = query:gsub("(%s)", "%%20")
		coroutine.wrap(function()
			local head,body = http.request("GET", "http://count.donreach.com/?url="..query)
			local result = json.parse(dump(body))
			message.channel:sendMessage {
				embed = {
					title = "How many times "..result["url"].." has been shared",
					fields = {
						{name = "Facebook", value = result["shares"]["facebook"], inline = true},
						{name = "Google", value = result["shares"]["google"], inline = true},
						{name = "LinkedIn", value = result["shares"]["linkedin"], inline = true},
						{name = "Pinterest", value = result["shares"]["pinterest"], inline = true},
						{name = "Total", value = result["total"], inline = true}
					}
				}
			}
		end)()
	end
	if message.content:sub(1,8):lower() == "netflix"..suffix then
		query = message.content:sub(9)
		query = query:gsub("(%s)", "%%20")
		coroutine.wrap(function()
			local netflixError = false
			local head,body = http.request("GET", "http://netflixroulette.net/api/api.php?title="..query)
			local result = json.parse(dump(body))
			if result["message"] then
				message.channel:sendMessage {
					embed = {
						title = result["errorcode"],
						description = result["message"],
						timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
						color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
						footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
					}
				}
				netflixError = true
			end
			if netflixError == false then 
				message.channel:sendMessage {
					embed = {
						title = result["show_title"].." - "..result["runtime"],
						description = result["summary"],
						thumbnail = {url = result["poster"]},
						timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
						color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
						footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
					}
				}
			end
		end)()
	end
	if message.content:sub(1,6):lower() == "urban"..suffix then
		query = message.content:sub(7)
		query = query:gsub("(%s)", "%%20")
		coroutine.wrap(function()
			local head,body = http.request("GET","http://urbanscraper.herokuapp.com/define/"..query)
			local result = json.parse(dump(body))
			message.channel:sendMessage {
				embed = {
					title = result['term'],
					description = result['definition'].."\n\n\n\n\nᅠ",
					fields = {
						{name = "Example", value = result['example'], inline = false}
					},
					color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
					timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
					footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
				}
			}
		end)()
	end
	if message.content == "restart/" then
		os.exit()
		os.exit()
		os.exit()
	end
	if message.content:sub(1,6):lower() == "8ball"..suffix then
		local reply = ball[math.random(#ball)]
		message.channel:sendMessage {
			embed = {
				title = "8Ball",
				description = "Magic 8Ball",
				fields = {
					{name = "Question", value = message.content:sub(7), inline = true},
					{name = "Answer", value = reply, inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
			}
		}
	end
	if message.content:lower() == "osinfo"..suffix then
		message.channel:sendMessage {
			embed = {
				title = "OS Information",
				description = ":P",
				fields = {
					{name = "Operating System", value = operatingsystem, inline = true}
				}
			}
		}
	end
	if message.content:sub(1,5):lower() == "info"..suffix then
		local mentioned = message.mentionedUsers()
		local member = message.guild:getMember(mentioned[3])
		if not member.gameName then gameplaying = "Nothing" else gameplaying = member.gameName end
		message.channel:sendMessage {
			embed = {
				title = "User Info:",
				description = "information about the mentioned user",
				fields = {
					{name = "Username", value = member.name, inline = true},
					{name = "Discriminator", value = member.discriminator, inline = true},
					{name = "Playing", value = gameplaying, inline = true},
					{name = "Snowflake ID", value = member.id, inline = true},
					{name = "Bot", value = member.bot, inline = true},
					{name = "Role Count", value = tostring(member.roleCount), inline = true},
					{name = "Avatar Url", value = member.avatarUrl, inline = true},
				},
				thumbnail = {url = member.avatarUrl;},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
			}
		}
	end
	if message.content:lower() == "unsafe.spam"..suffix then
		local spammembers = ""
		local spoomed = false
		local spam = {}
		local thing = 0
		while true do
		for member in message.guild.members do
			thing = thing + 1
			spammembers = spammembers.." "..member.mentionString
			if string.len(spammembers) > 1800 then
				message.channel:sendMessage(spammembers)
				spammembers = ""
				spoomed = true
			end
		end
		if spoomed == false then
			message.channel:sendMessage(spammembers)
		end
		end
		print(thing.." users mentioned!")
	end
	if message.content:sub(1,6):lower() == "cinfo"..suffix then
		local mentioned = message.mentionedChannels()
		local channel = message.guild:getChannel(mentioned[2])
		local nsfw = "false"
		if channel.name:startswith("nsfw") == true then nsfw = "true" end
		local embedmessage = message.channel:sendMessage {
			embed = {
				title = "Channel Info:",
				description = "information about the mentioned channel",
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				fields = {
					{name = "Name", value = channel.name, inline = true},
					{name = "Oldest Message", value = channel.firstMessage.content, inline = true},
					{name = "NSFW", value = nsfw, inline = true},
					{name = "Latest Message", value = channel.lastMessage.content, inline = true}
				}
			}
		}
		if not embedmessage then
			message.channel:sendMessage(luacode("Channel Info:\nName: "..channel.name.."\nOldest Message: "..channel.firstMessage.content.."\nLatest Message: "..channel.lastMessage.content))
		end
	end
	if message.content:sub(1,5):lower() == "help"..suffix then
		message.channel:sendMessage {
			embed = {
				title = "Help",
				description = "Glorious commands!",
				fields = {
					{name = "Fun", value = "\nlua"..suffix.." - `run lua!`\n8Ball"..suffix.." - `consult the magic 8ball!`",inline = true},
					{name = "Misc", value = "suffix"..suffix.." - `change the suffix.`\nping"..suffix.." - `pong.`".."\ninfo"..suffix.." - `info about user mentioned.`",inline = true},
					{name = "Moderation", value = "None", inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
			}
		}
	end	
	if message.content:sub(1,5):lower() == 'ping'..suffix then
		local x = os.clock()
		local s = 0
		for i=1,100000 do s = s + i end
		local ccolor = discordia.Color(math.random(255), math.random(255), math.random(255)).value
		local embedmessage = message.channel:sendMessage {
  			embed = {
    			title = "pong",
    			color = ccolor,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
 	 		}
		}
		if not embedmessage then noembedmsg = message.channel:sendMessage(luacode("pong")) end
		if not embedmessage then noembedmsg.content = luacode("pong"..string.format(" - time taken: %.2fs", os.clock() - x)) end
		if embedmessage then embedmessage.embed = {
    		title = "pong",
			description = string.format("time taken: %.2fs", os.clock() - x),
    		color = ccolor,
			timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
			footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
		} end
	end

	if message.content:sub(1,7):lower() == "suffix"..suffix then
		suffix = message.content:sub(8,8)
	end

	if message.content:sub(1,4):lower() == "say"..suffix then
		local embedmessage = message.channel:sendMessage{
			embed = {
				fields = {
					{name = message.author.name.." says...", value = message.content:sub(5), inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
			}
		}
		if not embedmessage then message.channel:sendMessage(luacode(message.content:sub(5))) end
	end
	if message.content:lower() == suffix.."lenny" then
		message.content = [[( ͡° ͜ʖ ͡°)]]
	end
	if message.content:sub(1,4):lower() == "cmd"..suffix then
		local f = assert(io.popen(message.content:sub(5), 'r'))
		local s = assert(f:read('*a'))
		f:close()
		local embedmessage = message.channel:sendMessage {
			embed = {
				fields = {
					{name = "Command Prompt", value = s, inline = true},
				},
				color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
			}
		}
	end
	if message.content:lower() == suffix.."idk" then
		local fatnooblet = client:getGuild('163820409677021187')
		local googlemoji = client:getGuild('272885620769161216')
		local kawaii = fatnooblet:getEmoji("name", "FeelsKawaiiMan")
		local musclel = googlemoji:getEmoji("name", "googlemuscleL")
		local muscler = googlemoji:getEmoji("name", "googlemuscleR")
		message.content = musclel.string..kawaii.string..muscler.string
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
				description = "use download/FILENAME to download",
    			fields = {
					{name = "\n\n\nScripts", value = "Heishi\nArc_Slicer", inline = true},
					{name = "\n\n\nOther", value = "test", inline = true},
				},
				thumbnail = {url="http://www.staples-3p.com/s7/is/image/Staples/m005167845_sc7?$splssku$"},
    			color = discordia.Color(math.random(255), math.random(255), math.random(255)).value,
				timestamp = os.date('!%Y-%m-%dT%H:%M:%S'),
				footer = {text = message.author.name.." | Bot by [FuZion] Sexy Cow#0018"}
 	 		}
		}
		if not embedmessage then message.channel:sendMessage(luacode("Files: \nuse download/FILENAME to download \n\nScripts:\nHeishi\nArc_Slicer\n\nOther:\ntest")) end
	end

	if message.content:lower() == "advertise"..suffix then
		message.channel:sendMessage {
			embed = {
				title = "DiscordiaSelfBot",
				description = "A self bot made by [FuZion] Sexy Cow#0018",
				fields = {
					{name = "Features", value = "• Ability to change the suffix.\n• fun commands!\n• Unique restart feature!"},
					{name = "Download", value = "https://github.com/JujharSingh/DiscordiaSelfbot\nget started by opening a command prompt and running luvit.exe bootstrapper.lua TOKEN and typing open/ in discord"},
				},
				color = discordia.Color(255, 0, 0).value
			}
		}
	end

	if message.content:sub(1,5):lower() == "play"..suffix then
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
	if message.content == "crash"..suffix then
		error("Crash test executed!")
	end
end)

client:run(args[2])