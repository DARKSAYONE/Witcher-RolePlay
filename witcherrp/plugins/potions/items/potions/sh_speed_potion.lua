ITEM.name = "Настой скорости"
ITEM.desc = "Временно увеличивает скорость бега."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 2

ITEM:hook("use", function(item)
	local client = item.player
	client:setLocalVar("speedBuff", 100)
	timer.Create("speedBuff"..client:SteamID(), 1.5, 0, function()
		if !IsValid(client) then
			timer.Destroy("speedBuff"..client:SteamID())
		end
		if client:getLocalVar("speedBuff") > 0 then
			client:setLocalVar("speedBuff", client:getLocalVar("speedBuff") - 1)	
		else
			timer.Destroy("speedBuff"..client:SteamID())
		end
	end)
end)