-- Given by CoderLiam x

local function init()
	DarkRP.declareChatCommand({
		command = "looc",
		description = "Sends a message in Local OOC chat.",
		delay = 1.5
	})
	if (SERVER) then
		DarkRP.defineChatCommand("looc",function(ply,args)
			if args == "" then
				DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
				return ""
			end
			local DoSay = function(text)
				if text == "" then
					DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
					return
				end
				if GAMEMODE.Config.alltalk then
					for _, target in pairs(player.GetAll()) do
						DarkRP.talkToPerson(target, "(LOOC) " .. ply:Nick(), text)
					end
				else
				DarkRP.talkToRange(ply, "(LOOC) " .. ply:Nick(), text, 250)
				end
			end
			hook.Call("LOOCMessage", nil, ply, args)
			return args, DoSay
		end, 1.5)
	end
end
if (SERVER) then
	if (#player.GetAll() > 0) then
		init()
	else
		hook.Add("PlayerInitialSpawn","dfca-load",function()
			init()
		end)
	end
else
	hook.Add("InitPostEntity","dfca-load",function()
		init()
	end)
end
