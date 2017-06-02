ITEM.name = "Фонарь"
ITEM.desc = "Ночью без него не обойтись."
ITEM.class = "nut_latern"
ITEM.weaponCategory = "melee"
ITEM.price = 100
ITEM.category = "Оружие"
ITEM.model = "models/aoc_objects/lamp_02.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-209.16239929199, -176.16641235352, 135.21553039551),
	ang = Angle(25, 40, 0),
	fov = 4.8030063577597
}

ITEM.permit = "melee"

ITEM.functions.use = {
	name = "Поставить",
	tip = "placeTip",
	icon = "icon16/anchor.png",	
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)

		if (trace.HitPos) then
			local furniture = ents.Create("nut_furniture")
			furniture:SetPos(trace.HitPos + trace.HitNormal)
			furniture:Spawn()
			client:notify("Е - зафиксировать, ALT + E - подобрать.")
			hook.Run("OnFurnitureSpawned", furniture, item)
		end
		return
	end,
}
ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["ClassName"] = "light",
						["Position"] = Vector(7.8857574462891, -0.048828125, 0.01416015625),
						["Size"] = 230.025,
						["Color"] = Vector(209, 190, 21),
						["Bone"] = "right hand",
						["Brightness"] = 0.4,
						["UniqueID"] = "1557334183",
					},
				},
			},
			["self"] = {
				["Arguments"] = "nut_latern@@0",
				["Invert"] = true,
				["UniqueID"] = "3095838829",
				["Event"] = "weapon_class",
				["Operator"] = "equal",
				["EditorExpand"] = true,
				["ClassName"] = "event",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "2702931155",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}