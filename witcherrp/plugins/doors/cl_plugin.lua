local PLUGIN = PLUGIN

function PLUGIN:ShouldDrawEntityInfo(entity)
	if (entity.isDoor(entity)) then
		return true
	end;
end;

local toScreen = FindMetaTable("Vector").ToScreen

function PLUGIN:DrawEntityInfo(entity, alpha)
	if (entity.isDoor(entity)) then
		local data = entity:getNetVar("doorData") or {}
		
		if (!data["hiddenDoor"]) then
			local position = toScreen(entity.LocalToWorld(entity, entity.OBBCenter(entity)))
			local x, y = position.x, position.y
			
			local owner = data["ownerID"] or nil
			local faction = data["factionID"] or nil
			local title = data["title"] or nil
			local locked = data["locked"] or nil
			
			if (owner) then
			--	draw.DrawText("Эта дверь приобретена", "nutSmallFont", x, y + 12, Color(255, 255, 255, alpha), 1)
			elseif (faction) then
				local info = {}
				
				for _, v in pairs(nut.faction.indices) do
					if (v.uniqueID == faction) then
						info = v
						break
					end;
				end;
				
			--	draw.DrawText("Эта дверь принадлежит фракции '"..info.name.."'", "nutSmallFont", x, y + 12, Color(255, 255, 255, alpha), 1)
			else
			--	draw.DrawText("Дверь никому не принадлежит", "nutSmallFont", x, y + 12, Color(255, 255, 255, alpha), 1)
			end;
			
			if (title) then
		--		draw.DrawText(title, "nutSmallFont", x, y - 12, Color(21, 255, 18, alpha), 1)
			end;
		end;
	end;
end;