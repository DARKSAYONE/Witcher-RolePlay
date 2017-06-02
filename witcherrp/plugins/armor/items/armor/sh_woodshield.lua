ITEM.name = "Деревянный 'щит'"
ITEM.desc = "Несколько досок, скрепленных вместе. Называть щитом можно с натяжкой."
ITEM.category = "Armor"
ITEM.model = "models/prop/building_s/sign_hanging04.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 1750
ITEM.armorclass = "shield"
ITEM.resistance = {
	[DMG_CLUB] = .95,
	[DMG_SLASH] = .95,
	[DMG_CRUSH] = 1
}
ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["UniqueID"] = "2899028042",
				["Scale"] = Vector(1, 0.5, 1),
				["Angles"] = Angle(-4.8058495521545, 178.98216247559, 160.36120605469),
				["Size"] = 0.5,
				["ClassName"] = "model",
				["Position"] = Vector(-3.1179809570313, 3.5910339355469, 0.369140625),
				["Bone"] = "left hand",
				["Model"] = "models/prop/building_s/sign_hanging04.mdl",
				["EditorExpand"] = true,
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