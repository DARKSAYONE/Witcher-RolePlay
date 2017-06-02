ITEM.name = "Дурман"
ITEM.desc = "Почти моментально склоняет человека в сон."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 1

ITEM:hook("use", function(item)
	local client = item.player
	timer.Simple(5, function()
		client:sleep()
	end)
end)