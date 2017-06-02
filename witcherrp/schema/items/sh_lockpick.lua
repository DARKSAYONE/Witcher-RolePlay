
-----------------------------------------------------
ITEM.name = "Отмычка."
ITEM.category = "misc"
ITEM.desc = "Ржавая металлическая отмычка с острым наконечником. Используется для взломов и иногда как предмет самообороны."
ITEM.model = "models/items/special/lockpicks/lockpick_02.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1

ITEM.iconCam = {
	pos = Vector(78.25227355957, 68.268035888672, 47.486251831055),
	ang = Angle(25, 220, 0),
	fov = 4.3005635317871
}


ITEM.functions.use = {
	name = "Взломать",
	onRun = function(item)
	local client = item.player
	local data = {}
	data.start = item.player:GetShootPos()
	data.endpos = data.start + item.player:GetAimVector()*96
	data.filter = item.player
	local entity = util.TraceLine(data).Entity	
	local skill = client:getChar():getAttrib("brk", 0)
	local odds = math.random(1, 100) + skill/2.5
	local skilltime = 15 - skill*0.1
	if (IsValid(entity) and entity:isDoor() and entity:GetPos():Distance( item.player:GetPos() ) <= 70) then
		local data = entity:getNetVar("doorData")
		if data["locked"] then
			item.player:emote("startlockpick")
			item.player:setAction("Взламываем...", skilltime)
			item.player:doStaredAction(entity, function()
				if odds >= 80 then
					client:EmitSound("hgn/crussaria/devices/unlockdoor_key.wav")
					entity:Fire("unlock")
					data["locked"] = false
					entity:setNetVar("doorData", data)
					if odds >= 95 then
						client:emote("unlockcritsucc")
						client:getChar():updateAttrib("brk", 1)
					else
						client:emote("unlocksucc")
						client:getChar():updateAttrib("brk", 0.25)
					end
				else
					client:EmitSound("physics/metal/metal_computer_impact_bullet1.wav")
					item:remove()
					if odds <= 10 then
						client:emote("unlockcritfail")
						client:getChar():updateAttrib("brk", 0.05)
					else
						client:emote("unlockfail")
						client:getChar():updateAttrib("brk", 0.1)
					end
				end
			end, skilltime, function()
				if IsValid(client) then
					client:setAction()
				end
			end)
		else
			client:notify("Дверь уже открыта.")
		end
	elseif (IsValid(entity) and entity:GetClass() == "nut_container" and entity:GetPos():Distance( item.player:GetPos() ) <= 70) then
		if entity:getNetVar("locked") then
			item.player:emote("startlockpick")
			item.player:setAction("Взламываем...", skilltime)
			item.player:doStaredAction(entity, function()
				if odds >= 80 then
					client:EmitSound("hgn/crussaria/devices/unlockdoor_key.wav")
					entity:setNetVar("locked", false)
					if odds >= 95 then
						client:emote("unlockcritsucc")
						client:getChar():updateAttrib("brk", 1)
					else
						client:emote("unlocksucc")
						client:getChar():updateAttrib("brk", 0.25)
					end
				else
					client:EmitSound("physics/metal/metal_computer_impact_bullet1.wav")
					item:remove()
					if odds <= 10 then
						client:emote("unlockcritfail")
						client:getChar():updateAttrib("brk", 0.05)
					else
						client:emote("unlockfail")
						client:getChar():updateAttrib("brk", 0.1)
					end
				end
			end, skilltime, function()
				if IsValid(client) then
					client:setAction()
				end
			end)
		else
			client:notify("Контейнер уже открыт.")
		end
	else
	end	
	return false
end
}
ITEM.permit = "misc"