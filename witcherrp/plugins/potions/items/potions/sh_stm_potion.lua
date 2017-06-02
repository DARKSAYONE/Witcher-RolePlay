ITEM.name = "Зелье Змеиной Ловкости"
ITEM.desc = "Временно повышает ловкость выпившего."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 1

ITEM:hook("use", function(item)
	local client = item.player
	client:getChar():addBoost("staminaPotion", "stm", 30, 300)
end)