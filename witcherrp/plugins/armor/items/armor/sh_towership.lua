ITEM.name = "Башенный щит с шипом"
ITEM.desc = "Тяжелый стальной башенный щит с огромным шипом на нем."
ITEM.category = "Armor"
ITEM.model = "models/morrowind/dragon/shield/m_dragontower.mdl"
ITEM.width = 2
ITEM.height = 3
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .50,
	[DMG_SLASH] = .50,
	[DMG_CRUSH] = .50
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(-1.79263484478, 85.689514160156, -19.556531906128),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-3.8905029296875, 0.81689453125, -2.6064453125),
				["Bone"] = "left hand",
				["Model"] = "models/morrowind/dragon/shield/m_dragontower.mdl",
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