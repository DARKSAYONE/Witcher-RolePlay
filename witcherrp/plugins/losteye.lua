PLUGIN.name = "Lost eye"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "'Так же выколоть глаз но пользователь может не умереть а просто пол экрана не видеть.'"

nut.emotes.lostreye = {
	"замечает, что правый глаз попросту вытек.",
	"начинает истошно орать от боли, так как удар пришелся в правый глаз.",
	"невольно хватается за свой правый глаз и осознает, что его больше нет."
}

nut.emotes.lostleye = {
	"замечает, что левый глаз попросту вытек.",
	"начинает истошно орать от боли, так как удар пришелся в левый глаз.",
	"невольно хватается за свой левый глаз и осознает, что его больше нет."
}

nut.command.add("eyes", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function (client, arguments)
	local target
		if arguments[1] == nil then
			target = client
		end	
		if !target then
			target = nut.command.findPlayer(client, arguments[1])
		end
		if target:getChar() then
			target:getChar():setData("noEye", "not")
			client:notify("Персонажу ".. target:getChar():getName() .." были восстановлены глаза.")
			target:getChar():removePart("noLeftEye")
			target:getChar():removePart("noRightEye")
		end
	end
})

nut.command.add("eyeremove", {
	adminOnly = true,
	syntax = "<string name> <string left/right>",
	onRun = function (client, arguments)
	local target
		if !target then
			target = nut.command.findPlayer(client, arguments[1])
		end
		if target:getChar() and (arguments[2] == "left" or arguments[2] == "right") then
			target:getChar():setData("noEye", arguments[2])
			local eye
			if arguments[2] == "left" then 
				eye = "левый"
			else
				eye ="правый" 
			end
			client:notify("Персонажу ".. target:getChar():getName() .." был выколот "..eye.." глаз.")
			if arguments[2] == "left" then
				target:getChar():removePart("noRightEye")
				target:getChar():addPart("noLeftEye")
			else
				target:getChar():removePart("noLeftEye")
				target:getChar():addPart("noRightEye")
			end
		end
	end
})

if (CLIENT) then
	function PLUGIN:HUDPaint()
		if LocalPlayer():getChar() then
			if LocalPlayer():getChar():getData("noEye", "not") == "right" and !(LocalPlayer():CanOverrideView()) then
				surface.SetDrawColor(color_black)
				surface.DrawRect(ScrW() / 2, 0, ScrW() / 2, ScrH())
			elseif LocalPlayer():getChar():getData("noEye", "not") == "left" and !(LocalPlayer():CanOverrideView()) then
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, ScrW() / 2, ScrH())
			end
		end
	end
else
	function PLUGIN:PlayerSpawn( client )
		if client:getChar() then
			if client:getChar():getData("noEye") == "left" then
				client:getChar():addPart("noLeftEye")
			elseif client:getChar():getData("noEye") == "right" then
				client:getChar():addPart("noRightEye")
			end
		end
	end
	
	function PLUGIN:ScalePlayerDamage(player, hitGroup, dmginfo)
		if hitGroup == HITGROUP_HEAD and math.random(1, 200) == 1 and player:getChar():getData("noEye", "not") == "not" then
			local chance = math.random(1, 2)
			if chance == 1 then
				player:getChar():setData("noEye", "left")
				player:emote("lostleye")
				player:getChar():addPart("noLeftEye")
			else
				player:getChar():setData("noEye", "right")
				player:emote("lostreye")
				player:getChar():addPart("noRightEye")
			end
		end
	end
end