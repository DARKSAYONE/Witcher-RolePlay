ITEM.name = "Деревянное колесо"
ITEM.desc = "Может использоваться как щит."
ITEM.category = "Armor"
ITEM.model = "models/aoc_objects/wheel_solid_01_medium.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .95,
	[DMG_SLASH] = .90,
	[DMG_CRUSH] = .85
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(6.7910418510437, 176.71514892578, 178.31832885742),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-3.0330200195313, 3.3183898925781, -2.2197265625),
				["Size"] = 0.525,
				["Bone"] = "left hand",
				["Model"] = "models/aoc_objects/wheel_solid_01_medium.mdl",
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