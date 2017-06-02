ITEM.name = "Стальной боевой топор"
ITEM.desc = "Качественное оружие, которое может послужить в быту."
ITEM.class = "nut_axe_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 500
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/axe/w_steelaxe.mdl"
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 41.746334075928, 0),
	ang = Angle(0, 270, 73.16658782959),
	fov = 45
}
ITEM.type = "1h"
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
						["Arguments"] = "nut_axe_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-4.4775476455688, 101.06852722168, -96.870231628418),
				["UniqueID"] = "732790205",
				["Position"] = Vector(12.403930664063, 1.93603515625, 4.541259765625),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/steel/axe/w_steelaxe.mdl",
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