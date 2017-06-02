ITEM.name = "Лошадиный свисток"
ITEM.category = "misc"
ITEM.desc = "Если дунуть, то Ваша лошадь моментально появится рядом."
ITEM.model = "models/irisitems2.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.functions.use = {
	name = "Свистнуть",
	icon = "icon16/bell.png",
	onRun = function(item)		
		local data = {}
		data.start = item.player:GetShootPos()
		data.endpos = data.start + item.player:GetAimVector()*96
		data.filter = item.player
		local trace = util.TraceLine(data)
		local check = true
		for k,v in ipairs(ents.FindByClass("npc_horsey")) do
			if v:GetNetworkedInt("ItemID") == item:getID() then
				check = false
			end
		end
		if (trace.HitPos) and check == true then
			local horse = ents.Create("npc_horsey")
			horse:SetNetworkedInt("ItemID", item:getID())
			horse:SetPos(trace.HitPos + trace.HitNormal)
			horse:Spawn()
			item.player:EmitSound("whistle.wav")
			
		elseif check == false then
			item.player:notify("Вы уже призвали лошадь!")
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}
ITEM.permit = "misc"