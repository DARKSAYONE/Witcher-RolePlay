ITEM.name = "Имперский стальной двуручный меч"
ITEM.desc = "Чёрная гарда, позолота. Всё указывает на нильфгаардское происхождение."
ITEM.class = "nut_claymore_imp"
ITEM.weaponCategory = "primary"
ITEM.price = 500
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/claymore/w_steel_claymore.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0.54541736841202, 95.249534606934, 18.583637237549),
	ang = Angle(0, 270, -99.832427978516),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {2, 5}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_claymore_imp",
						["UniqueID"] = "3827507127",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(20.734369277954, 102.83339691162, 179.27705383301),
				["UniqueID"] = "2529926549",
				["Position"] = Vector(-9.172119140625, 2.674072265625, 8.769287109375),
				["EditorExpand"] = true,
				["Bone"] = "chest",
				["Model"] = "models/morrowind/steel/claymore/w_steel_claymore.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "3888997461",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}