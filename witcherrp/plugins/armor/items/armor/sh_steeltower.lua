ITEM.name = "Стальной башенный щит"
ITEM.desc = "Огромный стальной щит, обладающий очень высоким показателем защиты."
ITEM.category = "Armor"
ITEM.model = "models/morrowind/steel/shield/m_steeltower.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .50,
	[DMG_SLASH] = .60,
	[DMG_CRUSH] = .80
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(1.0286988019943, 88.726104736328, -9.3919610977173),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-4.4053955078125, 0.47900390625, -0.9169921875),
				["Bone"] = "left hand",
				["Model"] = "models/morrowind/steel/shield/m_steeltower.mdl",
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