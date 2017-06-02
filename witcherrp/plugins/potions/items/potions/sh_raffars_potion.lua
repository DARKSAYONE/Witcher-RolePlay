ITEM.name = "Зелье Раффара Белого"
ITEM.desc = "Раффард Белый, известный маг давних времен, разработал лечебное зелье для воинов, которые завоевывали для людей новый мир много веков назад."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 1

ITEM:hook("use", function(item)
	local client = item.player
	client:SetHealth(math.Clamp(client:Health() + math.random(30, 50), 0, 100))
	client:getChar():setData("broken_legs", 0)
	client:getChar():setData("bleeding", false)
	client:getChar():setData("bleeding_level", 0)
end)