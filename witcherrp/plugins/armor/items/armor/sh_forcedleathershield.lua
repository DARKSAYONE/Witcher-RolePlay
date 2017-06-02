ITEM.name = "Улучшенный кожаный щит"
ITEM.desc = "Дополнительные слои кожи дают дополнительную защиту."
ITEM.category = "Armor"
ITEM.model = "models/morrowind/auriel/shield/m_aurielshield.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .95,
	[DMG_SLASH] = .90,
	[DMG_CRUSH] = .65
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(-1.79263484478, 85.689521789551, 164.08004760742),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(0.08349609375, 1.58984375, -1.1953125),
				["Bone"] = "left hand",
				["Model"] = "models/morrowind/auriel/shield/m_aurielshield.mdl",
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