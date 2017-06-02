ITEM.name = "Зелье повышения выносливости"
ITEM.desc = "Временно повышает выносливость выпившего."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 1

ITEM:hook("use", function(item)
	local client = item.player
	client:getChar():addBoost("endPotion", "end", 30, 300)
end)