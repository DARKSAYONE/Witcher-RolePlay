PLUGIN.name = "Languages"
PLUGIN.author = "AleXXX_007, DrodA"
PLUGIN.desc = "Now players can use different languages, learn them and understand."

netstream.Hook("UpdateNilfAttrib", function(client, isSpeaker)
	client:getChar():updateAttrib("nilf", 0.075)
end)

netstream.Hook("UpdateElfAttrib", function(client, isSpeaker)
	client:getChar():updateAttrib("elf", 0.05)
end)
if (SERVER) then
	function SCHEMA:OnCharCreated(client, character)
		if character:getFaction() == "nilf" then
			character:setAttrib("nilf", 100)
		elseif character:getFaction() == "belki" then
			character:setAttrib("elf", 100)
		end
	end
end

string.corrupt = function( str, intensity )
	local utf = {
		"Ġ","Æ","ì","Ä","φ","ï","₧","Ç",
	
		"Ɯ","Ĥ","Ǆ","ƒ","Ƀ","Ň","Ł","Ç",
	
		"¢","Ÿ","Ƀ","ӕ","Ň","Ł","Ą","Ÿ",
	}
	
	local function constructStr( tab )
		local str = ""
		for _, char in pairs( tab ) do
			str = str .. char
		end
	
		return str
	end

	bstr = {}
	str:gsub( "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", function( c ) table.insert( bstr, c ) end )
	for i=1, intensity do
		bstr[ math.random( 1, #bstr ) ] = table.Random( utf )
	end
	
	return constructStr( bstr )
end

nut.chat.register("nilf", {
	onCanSay =  function(speaker, text)
		local lang = speaker:getChar():getAttrib("nilf", 0)
		if lang >= 50 then
			return true
		end
		speaker:notify("Вы не знаете нильфгаардского диалекта!")
		return false
	end,
	onCanHear = nut.config.get("chatRange", 280),
	onChatAdd = function(speaker, text, anon, skill)
		local color
		if (LocalPlayer():GetEyeTrace().Entity == speaker) then
			color = nut.config.get("chatListenColor")
		else
			color = nut.config.get("chatColor")
		end	
		
		local langspeak = skill
		local msg = string.corrupt(text, utf8.len(text) - math.Round((utf8.len(text)/100)*(langspeak)))

		if LocalPlayer():getChar():getID() == speaker:getChar():getID() then				
			if langspeak == 100 then
				chat.AddText(color, speaker:Name().." говорит на нильфгаардском: " .. text)
			else
				chat.AddText(color, speaker:Name().." говорит на нильфгаардском: " .. msg)
			end
		else
			local langlisten = LocalPlayer():getChar():getAttrib("nilf", 0)
			local msg1 = string.corrupt(msg, utf8.len(text) - math.Round((utf8.len(text) / 50) * (langlisten)))
			local msg2 = string.corrupt(text, utf8.len(text) - math.Round((utf8.len(text) / 50) * (langlisten)))
			if langspeak == 100 then
				if langlisten >= 50 then
					chat.AddText(color, speaker:Name().." говорит на нильфгаардском: " .. text)
				else
					chat.AddText(color, speaker:Name().." говорит на нильфгаардском: " .. msg2)
				end
			else
				if langlisten >= 50 then
					chat.AddText(color, speaker:Name().." говорит на нильфгаардском: " .. msg)
				else
					chat.AddText(color, speaker:Name().." говорит на нильфгаардском: " .. msg1)
				end
			end
		end
		if speaker:getChar():getID() ~= LocalPlayer():getChar():getID() then
			netstream.Start("UpdateNilfAttrib", LocalPlayer(), speaker:getChar():getID() == LocalPlayer():getChar():getID())
		else
			netstream.Start("UpdateNilfAttrib", speaker, speaker:getChar():getID() == LocalPlayer():getChar():getID())
		end
	end,
	prefix = {"/b"}
})

nut.chat.register("elf", {
	onCanSay =  function(speaker, text)
		local lang = speaker:getChar():getAttrib("elf", 0)
		if lang >= 50 then
			return true
		end
		speaker:notify("Вы не знаете Старшей Речи!")
		return false
	end,
	onCanHear = nut.config.get("chatRange", 280),
	onChatAdd = function(speaker, text, anon, skill)
		local color
		if (LocalPlayer():GetEyeTrace().Entity == speaker) then
			color = nut.config.get("chatListenColor")
		else
			color = nut.config.get("chatColor")
		end	
		
		local langspeak = skill
		local msg = string.corrupt(text, utf8.len(text) - math.Round((utf8.len(text)/100)*(langspeak)))

		if LocalPlayer():getChar():getID() == speaker:getChar():getID() then				
			if langspeak == 100 then
				chat.AddText(color, speaker:Name().." говорит на Старшей Речи: " .. text)
			else
				chat.AddText(color, speaker:Name().." говорит на Старшей Речи: " .. msg)
			end
		else
			local langlisten = LocalPlayer():getChar():getAttrib("elf", 0)
			local msg1 = string.corrupt(msg, utf8.len(text) - math.Round((utf8.len(text) / 50) * (langlisten)))
			local msg2 = string.corrupt(text, utf8.len(text) - math.Round((utf8.len(text) / 50) * (langlisten)))
			if langspeak == 100 then
				if langlisten >= 50 then
					chat.AddText(color, speaker:Name().." говорит на Старшей Речи: " .. text)
				else
					chat.AddText(color, speaker:Name().." говорит на Старшей Речи: " .. msg2)
				end
			else
				if langlisten >= 50 then
					chat.AddText(color, speaker:Name().." говорит на Старшей Речи: " .. msg)
				else
					chat.AddText(color, speaker:Name().." говорит на Старшей Речи: " .. msg1)
				end
			end
		end
		if speaker:getChar():getID() ~= LocalPlayer():getChar():getID() then
			netstream.Start("UpdateElfAttrib", LocalPlayer(), speaker:getChar():getID() == LocalPlayer():getChar():getID())
		else
			netstream.Start("UpdateElfAttrib", speaker, speaker:getChar():getID() == LocalPlayer():getChar():getID())
		end
	end,
	prefix = {"/e"}
})