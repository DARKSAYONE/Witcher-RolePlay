ITEM.name = "Рунический меч"
ITEM.desc = "Покрыт выгравированными рунами."
ITEM.class = "nut_broadsword_rune"
ITEM.weaponCategory = "primary"
ITEM.price = 300
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/nordic/broadsword/w_nordic_broadsword.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.63337022066116, 58.79768371582, 12.133473396301),
	ang = Angle(0, 270, 77.818862915039),
	fov = 45
}
ITEM.type = "1h"
ITEM.permit = "melee"
ITEM.damage = {1, 6}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Arguments"] = "nut_broadsword_rune",
						["UniqueID"] = "1438428583",
						["Event"] = "weapon_class",
						["ClassName"] = "event",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-0.098680905997753, -68.547721862793, -89.108619689941),
				["UniqueID"] = "3565616645",
				["Position"] = Vector(4.9995727539063, 0.212890625, 3.8609619140625),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/nordic/broadsword/w_nordic_broadsword.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "3535041505",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}