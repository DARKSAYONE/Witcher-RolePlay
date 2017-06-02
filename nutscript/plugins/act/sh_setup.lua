local function facingWall(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start + client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWall"
	end
end

local function facingWallBack(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start - client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWallBack"
	end
end

ACT_ENDSEQ = 0
ACT_STARTSEQ = 1

PLUGIN.acts["sit"] = {
	["citizen_male"] = {sequence = "sit_ground", untimed = true, transition = { [ACT_STARTSEQ] = "Idle_to_Sit_Ground", [ACT_ENDSEQ] = "Sit_Ground_to_Idle" }},
	["citizen_female"] = {sequence = {"sit_ground", "Canals_Mary_Postidle"}, untimed = true}
}
PLUGIN.acts["examineground"] = {
	["citizen_male"] = {sequence = "D1_Town05_Daniels_Kneel_Idle", untimed = true, transition = { [ACT_STARTSEQ] = "D1_Town05_Daniels_Kneel_Entry", [ACT_ENDSEQ] = "Sit_Ground_to_Idle" }},
	["citizen_female"] = {sequence = {"sit_ground", "Canals_Mary_Postidle"}, untimed = true}
}
PLUGIN.acts["seat"] = {
	["citizen_male"] = {sequence = {"Silo_Sit", "Sit_Chair", "D1_T01_BreakRoom_Sit02", "Plazaidle4", "Citizen2", "Sitccouchtv1"}, untimed = true, transition = { [ACT_STARTSEQ] = "Idle_to_Sit_Ground", [ACT_ENDSEQ] = "Citizen2_Stand" }},
	["citizen_female"] = {sequence = {"D1_T02_Plaza_Sit02", "D1_T03_Sit_Bed", "D1_T03_Sit_Couch", "Plazaidle4", "Silo_Sit", "Sit_Chair"}, untimed = true}
}
PLUGIN.acts["injured"] = {
	["citizen_male"] = {sequence = {"d1_town05_wounded_idle_1", "d1_town05_wounded_idle_2", "d1_town05_winston_down"}, untimed = true},
	["citizen_female"] = {sequence = "d1_town05_wounded_idle_1", untimed = true}
}
PLUGIN.acts["arrest"] = {
	["citizen_male"] = {sequence = "apcarrestidle", untimed = true, onCheck = facingWall}
}
PLUGIN.acts["cheer"] = {
	["citizen_male"] = {sequence = {"cheer1", "cheer2", "wave_smg1"}},
	["citizen_female"] = {sequence = {"cheer1", "wave_smg1"}}
}
PLUGIN.acts["here"] = {
	["citizen_male"] = {sequence = {"wave_close", "wave"}},
	["citizen_female"] = {sequence = {"wave_close", "wave"}}
}
PLUGIN.acts["sitwall"] = {
	["citizen_male"] = {sequence = {"plazaidle4", "injured1"}, untimed = true, onCheck = facingWallBack},
	["citizen_female"] = {sequence = {"plazaidle4", "injured1", "injured2"}, untimed = true, onCheck = facingWallBack}
}
PLUGIN.acts["stand"] = {
	["citizen_male"] = {sequence = {"lineidle01", "lineidle02", "lineidle03", "lineidle04"}, untimed = true},
	["citizen_female"] = {sequence = {"lineidle01", "lineidle02", "lineidle03"}, untimed = true},
	["metrocop"] = {sequence = "plazathreat2", untimed = true}
}