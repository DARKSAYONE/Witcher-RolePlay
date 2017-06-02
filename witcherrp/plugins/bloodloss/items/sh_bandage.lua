ITEM.name = "Бинт"
ITEM.category = "Медицина"
ITEM.desc = "Длинный лоскут ткани, с помощью которого можно перевязать рану."
ITEM.model = "models/toussaint_paper13.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.functions.use = {
	name = "Перевязать себя",
	icon = "icon16/add.png",
	onRun = function(item)
		local client = item.player
		if client:getChar():getData("bleeding", false) then
			local time = 5 * (1 - 0.01 * item.player:getChar():getAttrib("mdc", 0)) + 5
			client:EmitSound("hgn/crussaria/items/itm_clothing_up.wav", 60, 100)
			client:setAction("Перевязываюсь...", time)
			client:emote("bandagestart")
			client:doStandAction(function()
				local bloodstop = 10 + client:getChar():getAttrib("mdc", 0) * 0.2
				if client:getChar():getData("bleeding_level", 0) <= bloodstop then
					client:getChar():setData("bleeding_level", 0)
					client:getChar():setData( "bleeding", false)
					client:notify("Кровь остановлена!")
				else
					client:notify("Кровь все еще течет!")
					client:getChar():setData("bleeding_level", client:getChar():getData("bleeding_level", 0) - 5)
				end			
				client:emote("bandageend")
				client:getChar():updateAttrib("mdc", 0.25)
				item:remove()
			end, time, function()
				if IsValid(client) then
					client:setAction()			
					client:emote("bandagestop")
				end
				return false
			end)
		else	
			item.player:notify("У Вас нет кровотечения!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.useon = {
	name = "Перевязать персонажа...",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
		local trace = item.player:GetEyeTraceNoCursor()
		local target = trace.Entity
		local client = item.player
		if target:IsPlayer() and IsValid(target) and target and target:Alive() then
			if target:getChar():getData("bleeding") then
				local time = 5 * (1 - 0.01 * item.player:getChar():getAttrib("mdc", 0)) + 5
				item.player:EmitSound("hgn/crussaria/items/itm_clothing_up.wav", 60, 100)
				item.player:setAction("Перевязываю...", time)
				item.player:emote("bandagestart1")
				target:setAction("Вас перевязывают...", time)
				item.player:doStaredAction(target, function()
					local bloodstop = 10 + client:getChar():getAttrib("mdc", 0) * 0.2
					if target:getChar():getData("bleeding_level", 0) <= bloodstop then
						target:getChar():setData("bleeding_level", 0)
						target:getChar():setData( "bleeding", false)
						client:notify("Кровь остановлена!")
					else
						target:getChar():setData("bleeding_level", target:getChar():getData("bleeding_level", 0) - 5)
						client:notify("Кровь все еще течет!"..target:getChar():getData("bleeding_level", 0))
					end		
					client:emote("bandageend")
					client:getChar():updateAttrib("mdc", 0.25)
					item:remove()				
				end, time, function()
					if IsValid(item.player) then
						item.player:setAction()		
						client:emote("bandagestop")
					end
					if IsValid(target) then
						target:setAction()
					end
				end)
			else
				item.player:notify("У этого персонажа нет кровотечения.")
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