ITEM.name = "Нильфгаардский длинный лук"
ITEM.desc = "Чёрный позолоченный лук. Очень популярен среди южных лучников."
ITEM.class = "nut_bow_nilf"
ITEM.weaponCategory = "primary"
ITEM.price = 150
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/ariel/longbow/w_ariel_longbow.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-5.8491797447205, 68.93278503418, -1.5244702100754),
	ang = Angle(0, 270, -101.34812164307),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {1, 7}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_bow_ash",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(85.104362487793, 37.524349212646, -136.18646240234),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-10.239868164063, -1.812255859375, 4.583740234375),
				["EditorExpand"] = true,
				["Bone"] = "spine 4",
				["Model"] = "models/morrowind/ariel/longbow/w_ariel_longbow.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "2083764954",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}