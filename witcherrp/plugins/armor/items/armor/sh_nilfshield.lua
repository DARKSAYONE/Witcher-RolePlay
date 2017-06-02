ITEM.name = "Легкий нильфгаардский щит"
ITEM.desc = "Деревянный щит, используемый пехотой Нильфгаарда."
ITEM.category = "Armor"
ITEM.model = "models/props_tes/cityguards/anvils.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .80,
	[DMG_SLASH] = .75,
	[DMG_CRUSH] = .90
}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(10.381753921509, 89.408317565918, 176.7322845459),
				["UniqueID"] = "2899028042",
				["Position"] = Vector(-9.2907104492188, 0.12118530273438, -2.21875),
				["Bone"] = "left hand",
				["Model"] = "models/props_tes/cityguards/anvils.mdl",
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