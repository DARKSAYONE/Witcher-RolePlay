ITEM.name = "Темерский каплевидный щит"
ITEM.desc = "Каплевидный щит, украшенный темерскими лилиями."
ITEM.category = "Armor"
ITEM.model = "models/witcher2soldiers/tw2_temeria_shield_kite.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .90,
	[DMG_SLASH] = .60,
	[DMG_CRUSH] = .80
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(14.03119468689, 166.03442382813, 93.614891052246),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-1.4299926757813, 0.2978515625, -8.5146484375),
				["Bone"] = "left hand",
				["Model"] = "models/witcher2soldiers/tw2_temeria_shield_kite.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "2020086382",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},

}