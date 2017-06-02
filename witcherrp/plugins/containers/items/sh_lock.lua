ITEM.name = "Замок"
ITEM.category = "Остальное"
ITEM.desc = "Металлический замок, с помощью которого можно запереть дверь или контейнер."
ITEM.model = "models/props_wasteland/prison_padlock001a.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.functions.use = {
	name = "Повесить",
	icon = "icon16/key_delete.png",
	onRun = function(item)
		local data = {}
		data.start = item.player:GetShootPos()
		data.endpos = data.start + item.player:GetAimVector()*96
		data.filter = item.player
		local entity = util.TraceLine(data).Entity	
		local client = item.player
		local Doordata = {}
		if (IsValid(entity) and entity:isDoor() and entity:GetPos():Distance( client:GetPos() ) <= 70) then
			Doordata = entity:getNetVar("doorData")
			local faction			
			for _, v in pairs(nut.faction.indices) do
				if Doordata["factionID"] and (v.uniqueID == Doordata["factionID"]) then
					faction = v.index
					break
				end;
			end;
		end
		if !IsValid(entity) then
			client:notify("Вы должны смотреть на дверь или контейнер, владельцем которого являетесь!")
			return false
		end
		if (entity:GetClass() == "nut_container") or (entity:isDoor()) then
			if entity:GetPos():Distance( item.player:GetPos() ) <= 70 then
				if ((!Doordata["locked"] and !Doordata["lockedid"] and entity:isDoor()) or (!entity:getNetVar("locked", false) == true and entity:GetClass() == "nut_container" and entity.placed)) then				
					if entity:isDoor() then
						entity:Fire("lock")
						Doordata["locked"] = true
						Doordata["lockedid"] = item:getData("id", item:getID())
						entity:setNetVar("doorData", Doordata)
					else
						entity:setNetVar("locked", true)
						entity.lockedid = item:getData("id", item:getID())
					end
					return true
				else
					client:notify("Объект уже заперт!")
				end	
			else
				client:notify("Вы должны подойти ближе к двери!")
			end	
		else
			client:notify("Вы должны смотреть на дверь или контейнер!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.MakeCopy = {
	name = "Сделать ключ",
	icon = "icon16/key.png",
	onRun = function(item)
	local client = item.player
		if client:getChar():getInv():hasItem("key_base") then
			local data = {}
			data["lockid"] = item:getData("id", item:getID())
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("key_base"):getID())
			client:getChar():getInv():add("key", 1, data)
			client:notify("Вы сделали ключ.")
		else
			client:notify("У Вас нет заготовки ключа!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}
ITEM.permit = "misc"