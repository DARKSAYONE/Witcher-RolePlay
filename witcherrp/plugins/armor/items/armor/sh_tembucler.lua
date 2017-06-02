ITEM.name = "Темерский круглый щит"
ITEM.desc = "Круглый щит, украшенный темерскими лилиями."
ITEM.category = "Armor"
ITEM.model = "models/witcher2soldiers/tw2_temeria_buckler.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .50,
	[DMG_SLASH] = 1,
	[DMG_CRUSH] = 1
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(-71.781135559082, 154.42622375488, 101.28287506104),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(2.8440551757813, -0.6787109375, 0.640625),
				["Bone"] = "left hand",
				["Model"] = "models/witcher2soldiers/tw2_temeria_buckler.mdl",
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