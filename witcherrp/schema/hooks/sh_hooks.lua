function SCHEMA:CanPlayerEditData(client, target)
	if (client:IsAdmin()) then
		return true
	end

	return false
end

function SCHEMA:PlayerFootstep(client, position, foot, soundName, volume)
	if (client:getChar():getData("ArmorType") == 3) then
		client:EmitSound("witcherrp/heavyarmor/heavyarmor"..math.random(1, 8)..".ogg")
		return true
	elseif (client:getChar():getData("ArmorType") == 2) then
		client:EmitSound("hgn/crussaria/move/chain/jump_0"..math.random(1, 3)..".wav")
		return true
	end
end