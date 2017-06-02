ITEM.name = "Обитый сталью щит"
ITEM.desc = "Округлый деревянный щит, обитый сталью."
ITEM.category = "Armor"
ITEM.model = "models/skyrim/shield_steel.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .70,
	[DMG_SLASH] = .60,
	[DMG_CRUSH] = .75
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(70.384002685547, -28.26060295105, 65.878959655762),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(3.87353515625, 2.5846862792969, 0.146484375),
				["Bone"] = "left hand",
				["Model"] = "models/skyrim/shield_steel.mdl",
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