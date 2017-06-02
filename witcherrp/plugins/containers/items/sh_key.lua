ITEM.category = "Остальное"
ITEM.model = "models/aoc_objects/key_01.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(78.25227355957, 68.268035888672, 47.486251831055),
	ang = Angle(25, 220, 0),
	fov = 4.3005635317871
}


function ITEM:getName()
	return self:getData("name", "Ключ")
end

function ITEM:getDesc()
	return self:getData("desc", "Обычный ключ")
end

ITEM.functions.use = {
	name = "Сделать дубликат",
	icon = "icon16/key.png",
	onRun = function(item)
	local client = item.player
		if client:getChar():getInv():hasItem("key_base") then
			local data = {}
			data["lockid"] = item:getData("lockid")
			data["owner"] = client:getChar():getID()
			client:getChar():getInv():remove(client:getChar():getInv():hasItem("key_base"):getID())
			client:getChar():getInv():add("key", 1, data)
			client:notify("Вы сделали ключ.")
		else
			client:notify("У Вас нет заготовки ключа!")
		end
		return false
	end,
}
--[[
ITEM.functions.Hang = {
	name = "Повесить на связку ключей",
	icon = "icon16/key_add.png",
	onRun = function(item)
		local client = item.player				
		local char = client:getChar()
		local clientKeys = char:getKeys()

		-- Make an attempt to put item into the stash.
		if (item:transfer(nil, nil, nil, client, nil, true)) then
			nut.item.loadItemByID(item:getID(), 0, nil)
			clientKeys[item:getID()] = item:getData("name", "Ключ")
			client:EmitSound("physics/metal/metal_chainlink_impact_soft2.wav")

			char:setKeys(clientKeys)
		else
			client:notify("Ошибка!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}
]]
ITEM.functions.Rename = {
	name = "Переименовать",
	icon = "icon16/font.png",
	onRun = function(item)
		item.player:requestString(
			"Изменить название ключа",
			"Как будет называться этот ключ?",
			function(text)
				item:setData("name", text)
			end,
			item:getData("name", "Ключ"))
		return false
	end
}

ITEM.functions.Redesc = {
	name = "Изменить описание",
	icon = "icon16/font.png",
	onRun = function(item)
		item.player:requestString(
			"Изменить описание ключа",
			"Как будет выглядеть этот ключ?",
			function(text)
				item:setData("desc", text)
			end,
			item:getData("desc", "Обычный ключ"))
		return false
	end
}