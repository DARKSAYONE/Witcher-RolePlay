ITEM.name = "Богатая одежда"
ITEM.desc = "Одежды из качественной ткани."
ITEM.category = "Armor"
ITEM.model = "models/props/furnitures/humans/basket_cloth.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.permit = "equip"
ITEM.price = 1750
ITEM.eqslot = "Armor"
ITEM:hook("Equip", function(item)
	if (item.player:getChar():getData("modelType")) then
	local modelType = item.player:getChar():getData("modelType")
		item.SetModel = "models/humans/groupm3/".. modelType ..".mdl"
	else
	item.SetModel = "models/humans/groupm3/male_02.mdl"
	end
end)