ITEM.name = "Зелье Лихой Удали"
ITEM.desc = "Вызывает выброс адреналина в кровь, как следствие повышение физической силы."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 1

ITEM:hook("use", function(item)
	local client = item.player
	client:getChar():addBoost("strenghtPotion", "str", 30, 300)
end)