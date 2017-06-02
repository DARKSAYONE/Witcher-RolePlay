ITEM.name = "Огниво"
ITEM.model = "models/items/special/lockpicks/lockpick_02.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Чирканув по камню, можно извлечь искру, чтобы зажечь огонь."

ITEM.functions.use = { -- sorry, for name order.
	name = "Разжечь костер",
	tip = "useTip",
	icon = "icon16/fire.png",
	onRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor()
	if trace.HitPos:Distance( client:GetShootPos() ) <= 192 then
		if (trace.HitPos) then
			if client:getChar():getInv():hasItem("wood") then
				client:getChar():getInv():remove(client:getChar():getInv():hasItem("wood"):getID())
				local fire = ents.Create("nut_campfire")
				fire:SetPos(trace.HitPos)
				fire:Spawn()
				client:notify("Нажмите ALT+E, чтобы убрать костер.")
			else
				client:notify("У вас нет дров!")
				return false
			end
		end
	else
		client:notify("Вы не можете разжечь костер так далеко!")
	end;
		return false
	end,
}
