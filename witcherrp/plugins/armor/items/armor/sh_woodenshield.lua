ITEM.name = "Круглый деревянный щит"
ITEM.desc = "Выполнен из качественных материалов."
ITEM.category = "Armor"
ITEM.model = "models/aoc_objects/wood_shield_01.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .80,
	[DMG_SLASH] = .95,
	[DMG_CRUSH] = .75
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(1.0314810276031, 87.000465393066, 169.02709960938),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-6.0928955078125, 2.58984375, 11.6806640625),
				["Bone"] = "left hand",
				["Model"] = "models/aoc_objects/wood_shield_01.mdl",
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