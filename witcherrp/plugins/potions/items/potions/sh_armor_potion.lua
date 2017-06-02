ITEM.name = "Зелье Каменной Кожи"
ITEM.desc = "Повышает физическую защиту выпившего."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 3

ITEM:hook("use", function(item)
	local client = item.player
	client:SetArmor(math.Clamp(client:Armor() + 100, 0, 100))
	timer.Create("armorBuff"..client:SteamID(), 3, 0, function()
		if !IsValid(client) then
			timer.Destroy("armorBuff"..client:SteamID())
		end
		if client:Armor() > 0 then
			client:SetArmor(math.Clamp(client:Armor() - 1, 0, 100))
		else
			timer.Destroy("armorBuff"..client:SteamID())
		end
	end)
end)