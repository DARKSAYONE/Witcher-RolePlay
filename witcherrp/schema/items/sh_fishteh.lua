ITEM.name = "Фисштех"
ITEM.desc = "Для ведения нездорового образа жизни."
ITEM.model = "models/items/jewels/purses/big_purse.mdl"
ITEM.Width = 1
ITEM.Height = 1
ITEM.price = 50
ITEM.permit = "mat"
ITEM.duration = 60
ITEM.attribBoosts = {
	["str"] = 10,
	["stm"] = 15,
	["end"] = 5,
}

ITEM.functions.use = {
	name = "Принять",
	icon = "icon16/tick.png",
	onRun = function(item)
	local char = item.player:getChar()
		for k, v in pairs(item.attribBoosts) do
			char:addBoost(item.uniqueID, k, v)
		end
		item.player:EmitSound("player/suit_sprint.wav")
		timer.Create("DrugEffect_" .. item.uniqueID, item.duration, 1, function()
			if (client and IsValid(client)) then
					if (item.attribBoosts) then
							for k, v in pairs(item.attribBoosts) do
								char:removeBoost(item.uniqueID, k)
							end
					end
			end
		end)
		
		return true
	end
}