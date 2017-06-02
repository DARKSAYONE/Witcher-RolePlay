ITEM.name = "Стальной кинжал"
ITEM.desc = "Популярен из-за своих маленьких размеров и смертельной остроты."
ITEM.class = "nut_dagger_steel"
ITEM.weaponCategory = "secondary"
ITEM.price = 200
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/silver/dagger/w_silverdagger.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-2.0151453018188, 28.397392272949, 0.88056617975235),
	ang = Angle(0, 270, -100.42403411865),
	fov = 45
}
ITEM.damage = {1, 4}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_dagger_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(20.576623916626, 141.9306640625, 111.52377319336),
				["UniqueID"] = "732790205",
				["Position"] = Vector(3.4730834960938, -3.9169921875, -1.3170166015625),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/silver/dagger/w_silverdagger.mdl",
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