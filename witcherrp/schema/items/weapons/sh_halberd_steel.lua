ITEM.name = "Стальная алебарда"
ITEM.desc = "Качественная алебарда с длинным деревянным древком."
ITEM.class = "nut_halberd_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 450
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/halberd/w_steel_halberd.mdl"
ITEM.width = 6
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.48194655776024, 95.974884033203, 6.0606727600098),
	ang = Angle(0, 270, 78.423278808594),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {2, 6}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_halberd_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(67.530212402344, -49.973838806152, -40.551517486572),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-14.187042236328, -1.6748046875, 0.016357421875),
				["EditorExpand"] = true,
				["Bone"] = "spine 4",
				["Model"] = "models/morrowind/steel/halberd/w_steel_halberd.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "2083764954",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}