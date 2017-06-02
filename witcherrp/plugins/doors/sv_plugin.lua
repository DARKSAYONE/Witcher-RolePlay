local PLUGIN = PLUGIN

function PLUGIN:PostPlayerLoadout(client)
	client:Give("nut_keys")
end;

function PLUGIN:SaveData()
	local data = {}
	
	for _, v in pairs(ents.GetAll()) do
		if (v:isDoor()) then
			local vars = v:getNetVar("doorData") or nil
			
			if (vars) then
				data[v:MapCreationID()] = v:getNetVar("doorData")
			end;
		end;
	end;
	
	nut.data.set("simplifiedDoors", data)
end;

function PLUGIN:LoadData()
	local data = nut.data.get("simplifiedDoors")
	if (!data) then return end;
	
	for _, v in pairs(ents.GetAll()) do
		if (v:isDoor()) then
			v:SetSkin(10)
			v:SetBodygroup(1, 0)
			if data[v:MapCreationID()] then
				v:setNetVar("doorData", data[v:MapCreationID()])
				
				if (v:getNetVar("doorData")["locked"] and v:getNetVar("doorData")["locked"] == true) then
					v:Fire("lock")
				end;
			end
		end;
	end;
end;

hook.Add("doorSetVar", "betterdoors_196019752", function(door, name, var)
	if (door:isDoor()) then
		local data = door:getNetVar("doorData") or {}
		
		data[name] = var 
		
		door:setNetVar("doorData", data)
		return true
	else
		return false
	end;
end)