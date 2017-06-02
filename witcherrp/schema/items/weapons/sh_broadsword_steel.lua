ITEM.name = "Стальной палаш"
ITEM.desc = "Распространенное оружие, ввиду хорошей прочности и маленькой массы."
ITEM.class = "nut_broadsword_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 500
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/imperial/broadsword/w_imperial_broadsword.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.012090435251594, 71.259475708008, 9.8364782333374),
	ang = Angle(0, 270, -104.14011383057),
	fov = 45
}

ITEM.permit = "melee"
ITEM.damage = {1, 5}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Arguments"] = "nut_broadsword_steel",
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
				["Model"] = "models/morrowind/imperial/broadsword/w_imperial_broadsword.mdl",
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