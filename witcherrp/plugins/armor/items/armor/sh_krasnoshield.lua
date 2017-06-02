ITEM.name = "Краснолюдский щит"
ITEM.desc = "Щит, выполненный в краснолюдском стиле."
ITEM.category = "Armor"
ITEM.model = "models/morrowind/dwemer/shield/m_spellbreaker.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .70,
	[DMG_SLASH] = .65,
	[DMG_CRUSH] = .55
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(-0.30872264504433, 80.676063537598, -163.47308349609),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(0.46923828125, 2.02685546875, -0.2109375),
				["Bone"] = "left hand",
				["Model"] = "models/morrowind/dwemer/shield/m_spellbreaker.mdl",
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