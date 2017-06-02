ITEM.name = "Самодельная шина"
ITEM.category = "Медицина"
ITEM.desc = "Просто палка и несколько лоскутов ткани для фиксации конечности."
ITEM.model = "models/toussaint_paper13.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.functions.use = {
	name = "Использовать на себе",
	icon = "icon16/add.png",
	onRun = function(item)
		local client = item.player
		if client:getChar():getData("brokenLegs", 0) > CurTime() then
			local time = 5 * (1 - 0.01 * item.player:getChar():getAttrib("mdc", 0)) + 5
			client:EmitSound("hgn/crussaria/items/itm_clothing_up.wav", 60, 100)
			client:setAction("Накладываю шину...", time)
			client:emote("splintstart")
			client:doStandAction(function()
				local brokestop = 300 + client:getChar():getAttrib("mdc", 0) * 2.5
				client:getChar():setData("brokenLegs", client:getChar():getData("brokenLegs", 0) - brokestop)
				client:emote("splintend")
				client:getChar():updateAttrib("mdc", 0.5)
				item:remove()
			end, time, function()
				if IsValid(client) then
					client:setAction()			
					client:emote("splintstop")
				end
				return false
			end)
		else	
			item.player:notify("У Вас нет переломов!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.useon = {
	name = "Использовать на...",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
		local trace = item.player:GetEyeTraceNoCursor()
		local target = trace.Entity
		local client = item.player
		if target:IsPlayer() and IsValid(target) and target and target:Alive() then
			if target:getChar():getData("bleeding") then
				local time = 5 * (1 - 0.01 * item.player:getChar():getAttrib("mdc", 0)) + 5
				item.player:EmitSound("hgn/crussaria/items/itm_clothing_up.wav", 60, 100)
				item.player:setAction("Накладываю шину...", time)
				item.player:emote("splintstart1")
				target:setAction("Вам накладывают шину...", time)
				item.player:doStaredAction(target, function()
					local brokestop = 300 + client:getChar():getAttrib("mdc", 0) * 2.5
					target:getChar():setData("brokenLegs", target:getChar():getData("brokenLegs", 0) - brokestop)
					client:emote("splintend")
					client:getChar():updateAttrib("mdc", 0.25)
					item:remove()				
				end, time, function()
					if IsValid(item.player) then
						item.player:setAction()		
						client:emote("splintstop")
					end
					if IsValid(target) then
						target:setAction()
					end
				end)
			else
				item.player:notify("У этого персонажа нет переломов.")
			end
		else
			item.player:notify("Вы должны смотреть на персонажа!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}
ITEM.permit = "misc"