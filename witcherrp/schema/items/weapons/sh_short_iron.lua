ITEM.name = "Короткий железный меч"
ITEM.desc = "Крайне эффективное оружие в закрытых помещениях."
ITEM.class = "nut_short_iron"
ITEM.weaponCategory = "secondary"
ITEM.price = 100
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/shortsword/w_iron_shortsword.mdl"
ITEM.width = 3
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1, 47.873165130615, 6.4969820976257),
	ang = Angle(0, 270, -99.867538452148),
	fov = 45
}
ITEM.damage = {1, 4}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Arguments"] = "nut_short_iron",
						["UniqueID"] = "1438428583",
						["Event"] = "weapon_class",
						["ClassName"] = "event",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(4.5116724967957, 138.09671020508, 92.285530090332),
				["UniqueID"] = "3565616645",
				["Position"] = Vector(4.1578979492188, -3.33740234375, -3.2491455078125),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/steel/shortsword/w_steel_shortsword.mdl",
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