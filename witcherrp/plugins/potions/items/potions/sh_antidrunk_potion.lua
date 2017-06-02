ITEM.name = "Слезы Жён"
ITEM.desc = "Выпив эту микстуру можно быстро избавиться от опьянения."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 2

ITEM:hook("use", function(item)
	local client = item.player
	client:getChar():removeDrunk(client:getChar():getData("drunk", 0))
end)