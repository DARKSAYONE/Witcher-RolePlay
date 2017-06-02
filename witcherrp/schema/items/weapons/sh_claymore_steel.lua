ITEM.name = "Стальной двуручный меч"
ITEM.desc = "Тяжелая клеймора с длинным лезвием."
ITEM.class = "nut_claymore_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 700
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/claymore/w_iron_claymore.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(1.5896986722946, 88.176406860352, 17.284427642822),
	ang = Angle(0, 270, 78.784461975098),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {2, 5}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_claymore_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-4.3824439048767, 152.38891601563, 76.609886169434),
				["UniqueID"] = "732790205",
				["Position"] = Vector(0.18310546875, -4.42626953125, 0.770263671875),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/iron/claymore/w_iron_claymore.mdl",
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