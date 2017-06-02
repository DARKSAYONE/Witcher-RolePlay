ITEM.name = "Зелье выносливости"
ITEM.desc = "Временно ускоряет восстановление выносливости."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.quantity = 3

ITEM:hook("use", function(item)
	local client = item.player
	client:setLocalVar("stmBuff", 1)
	timer.Create("stmBuff"..client:SteamID(), 3, 0, function()
		if !IsValid(client) then
			timer.Destroy("stmBuff"..client:SteamID())
		end
		if client:getLocalVar("stmBuff") > 0 then
			client:setLocalVar("stmBuff", client:getLocalVar("stmBuff") - 0.01)	
		else
			timer.Destroy("stmBuff"..client:SteamID())
		end
	end)
end)