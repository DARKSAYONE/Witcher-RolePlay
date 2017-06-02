ITEM.name = "Темерский щит"
ITEM.desc = "Щит, украшенный темерскими лилиями."
ITEM.category = "Armor"
ITEM.model = "models/witcher2soldiers/tw2_temeria_shield.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .70,
	[DMG_SLASH] = .75,
	[DMG_CRUSH] = .80
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(69.572456359863, 174.62716674805, 100.09331512451),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-0.187255859375, 0.54931640625, 0.99365234375),
				["Bone"] = "left hand",
				["Model"] = "models/witcher2soldiers/tw2_temeria_shield.mdl",
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