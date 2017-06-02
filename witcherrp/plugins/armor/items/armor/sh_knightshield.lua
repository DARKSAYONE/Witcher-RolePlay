ITEM.name = "Рыцарский щит"
ITEM.desc = "Щит, который используют рыцари на турнирах."
ITEM.category = "Armor"
ITEM.model = "models/toussaint_shield13.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .55,
	[DMG_SLASH] = .80,
	[DMG_CRUSH] = .90
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(-12.058601379395, 85.152359008789, -31.522077560425),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(3.7870483398438, -1.9093933105469, -0.5263671875),
				["Bone"] = "left hand",
				["Model"] = "models/toussaint_shield13.mdl",
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