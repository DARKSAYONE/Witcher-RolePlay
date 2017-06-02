ITEM.name = "Щит с драконом"
ITEM.desc = "Щит, украшенный рисунком дракона."
ITEM.category = "Armor"
ITEM.model = "models/aoc_weapon/w_e_shield.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .85,
	[DMG_SLASH] = .90,
	[DMG_CRUSH] = .75
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(-73.776550292969, 104.31211853027, 71.965171813965),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(3.2343139648438, -2.4188537597656, -6.53125),
				["Bone"] = "left hand",
				["Model"] = "models/aoc_weapon/w_e_shield.mdl",
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