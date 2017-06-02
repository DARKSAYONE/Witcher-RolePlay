ITEM.name = "Seeds base"
ITEM.model = "models/items/jewels/purses/big_purse.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Небольшой мешочек с зерном."
ITEM.category = "Семена"
ITEM.PlantModel = "models/aoc_trees/aoc_lowveg14.mdl"
ITEM.BadGathering = {}
ITEM.CommonGathering = {}
ITEM.MasterGathering = {}

ITEM.functions.use = {
	name = "Посадить",
	tip = "useTip",
	icon = "icon16/accept.png",
	onRun = function(item, client)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor()
		local TextureBL = {
		"PLASTER/PLASTERWALL013C",
		"PLASTER/WALLPAPER001B",
		"PLASTER/WALLPAPER002A",
		"PLASTER/WALLPAPER002B",
		"PLASTER/WALLPAPER003A",
		"PLASTER/WALLPAPER003B",
		"PLASTER/WALLPAPER005A",
		}
		if (trace.HitPos:Distance( client:GetShootPos() ) <= 192) then			
			if trace.MatType == 68 and !IsValid(trace.Entity) and !table.HasValue(TextureBL, trace.HitTexture) then
				local check = true
				for k, v in pairs(ents.FindInSphere(trace.HitPos, 10)) do
					if v:GetClass() == "nut_culture" or v:GetClass() == "nut_plant" then
						check = false
					end
				end
				if check then
					local seed = ents.Create("nut_culture")
					seed:SetPos(trace.HitPos + trace.HitNormal)
					seed.uid = item.uniqueID
					seed:setNetVar("grow", CurTime() + math.random(300, 600))
					seed:setNetVar("spawn", CurTime())
					seed:Spawn()
					seed:SetModel(item.PlantModel)
					client:notify("Вы успешно посадили семена")
					client:getChar():updateAttrib("frm", math.random(0.05, 0.1))
				else
					client:notify("Нельзя сажать растения так близко друг к другу!")
					return false
				end
			else				
				client:notify("Растения можно сажать только в подходящую почву.")
				return false
			end
		else
			client:notify("Вы не можете посадить растение так далеко!")
			return false
		end
	end,
}