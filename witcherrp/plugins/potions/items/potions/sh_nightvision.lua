ITEM.name = "Зелье Кошачьего Зрения"
ITEM.desc = "Если выпить, начинешь видеть в темноте."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 3

ITEM:hook("use", function(item)
	local client = item.player
	client:setLocalVar("nightPotion", 100)
	timer.Create("nvBuff"..client:SteamID(), 2, 0, function()
		if !IsValid(client) then
			timer.Destroy("nvBuff"..client:SteamID())
		end
		if client:getLocalVar("nightPotion") > 0 then
			client:setLocalVar("nightPotion", client:getLocalVar("nightPotion") - 1)	
		else
			timer.Destroy("nvBuff"..client:SteamID())
		end
	end)
end)