ITEM.name = "Кожаный щит"
ITEM.desc = "Легкий щит из кожи."
ITEM.category = "Armor"
ITEM.model = "models/skyrim/shield_hide.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = 1,
	[DMG_SLASH] = .95,
	[DMG_CRUSH] = .80
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(70.384002685547, -28.26060295105, 65.878959655762),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(3.7919921875, 1.7131042480469, 0.2666015625),
				["Bone"] = "left hand",
				["Model"] = "models/skyrim/shield_hide.mdl",
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