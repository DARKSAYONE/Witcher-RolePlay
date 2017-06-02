ITEM.name = "Железный кортик"
ITEM.desc = "Из-за своих маленьких размеров может быть спрятан где угодно."
ITEM.class = "nut_dagger_iron"
ITEM.weaponCategory = "secondary"
ITEM.price = 75
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/dagger/w_irondagger.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1.4403147697449, 28.865507125854, 0),
	ang = Angle(0, 270, 79.598670959473),
	fov = 45
}
ITEM.damage = {1, 3}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Arguments"] = "nut_dagger_iron",
						["UniqueID"] = "1438428583",
						["Event"] = "weapon_class",
						["ClassName"] = "event",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-4.8945455551147, -15.714040756226, 78.521339416504),
				["UniqueID"] = "3565616645",
				["Position"] = Vector(10.1279296875, 0.482421875, -3.7047119140625),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/iron/dagger/m_throwiron.mdl",
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