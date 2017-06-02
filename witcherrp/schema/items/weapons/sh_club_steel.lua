ITEM.name = "Стальная палица"
ITEM.desc = "Небольшая дубинка, отлитая из стали, что придает ей солидную массу."
ITEM.class = "nut_club_steel"
ITEM.weaponCategory = "secondary"
ITEM.price = 300
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/club/w_steel_club.mdl"
ITEM.width = 3
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1.9879275560379, 45.912052154541, 0),
	ang = Angle(0, 270, -98.252250671387),
	fov = 45
}
ITEM.damage = {1, 8}
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
						["Arguments"] = "nut_club_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-1.458613038063, -48.091259002686, -104.06153106689),
				["UniqueID"] = "732790205",
				["Position"] = Vector(0.24237060546875, 3.342041015625, -2.970947265625),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/steel/club/w_steel_club.mdl",
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