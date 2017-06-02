local PLUGIN = PLUGIN

-----------------------------------------------------
-- =====     START OF DOOR MISC SETTINGS     ===== --
-----------------------------------------------------

nut.command.add("doortogglehidden", {
	adminOnly = true,
	syntax = "[bool]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity
		
		if (IsValid(entity) and entity:isDoor()) then
			if (!entity:getNetVar("doorData")["hidden"]) then
				hook.Run("doorSetVar", entity, "hidden", true)
				client:ChatPrint("Дверь спрятана.")
				PLUGIN:SaveData()
			else
				hook.Run("doorSetVar", entity, "hidden", nil)
				client:ChatPrint("Дверь отображена.")
				PLUGIN:SaveData()
			end;
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

nut.command.add("doorsettitle", {
	syntax = "[string title]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity
		local data = entity:getNetVar("doorData") or {}
		
		if (IsValid(entity) and entity:isDoor()) then
			if (client:IsAdmin() or client:IsSuperAdmin() or client:getChar():getID() == data["ownerID"]) then
			
				hook.Run("doorSetVar", entity, "title", arguments[1])
				if arguments[1] == nil then
					client:ChatPrint("Вы сбросили название двери.")
				else
					client:ChatPrint("Теперь дверь имеет название '"..arguments[1].."'.")
				end
				PLUGIN:SaveData()
			else
				client:ChatPrint("Вы не имеете права редактировать параметры данной двери.")
			end;
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

---------------------------------------------------
-- =====     END OF DOOR MISC SETTINGS     ===== --
---------------------------------------------------



--------------------------------------------------------
-- =====     START OF DOOR OWNERSHIP/ACCESS     ===== --
--------------------------------------------------------

nut.command.add("doorsetowner", {
	adminOnly = true,
	syntax = "[string name]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity
		local target = nut.command.findPlayer(client, arguments[1])
		
		if (IsValid(entity) and entity:isDoor()) then
			if (IsValid(target)) then
				hook.Run("doorSetVar", entity, "factionID", nil)
				hook.Run("doorSetVar", entity, "ownerID", target:getChar():getID())
				client:ChatPrint("Теперь "..target:getChar():getName().." владеет дверью.")
				PLUGIN:SaveData()
			else
				client:ChatPrint("Игрок недействителен!")
			end;
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

nut.command.add("doorremoveowner", {
	adminOnly = true,
	syntax = "[nil]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity
		
		if (IsValid(entity) and entity:isDoor()) then
			hook.Run("doorSetVar", entity, "ownerID", nil)
			hook.Run("doorSetVar", entity, "factionID", nil)
			client:ChatPrint("Владелец двери удален.")
			PLUGIN:SaveData()
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

nut.command.add("doorsetfaction", {
	adminOnly = true,
	syntax = "[string name]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity 
		
		if (IsValid(entity) and entity:isDoor()) then
			local faction
			
			if (arguments[1]) then
				local name = table.concat(arguments, " ")
				for k, v in pairs(nut.faction.teams) do
					if (nut.util.stringMatches(k, name) or nut.util.stringMatches(L(v.name, client), name)) then
						faction = v
						break
					end
				end;
			else
				client:ChatPrint("Вы не указали название фракции.")
			end
			
			if (faction) then
				hook.Run("doorSetVar", entity, "ownerID", nil)
				hook.Run("doorSetVar", entity, "factionID", faction.uniqueID)
				client:ChatPrint("Теперь эта дверь принадлежит фракции '"..faction.name.."'.")
				PLUGIN:SaveData()
			else
				client:ChatPrint("Фракция недействительна!")
			end;
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

nut.command.add("dooraddguest", {
	syntax = "[string name]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity
		local target = nut.command.findPlayer(client, arguments[1])
		
		if (IsValid(entity) and entity:isDoor()) then
			if (IsValid(target) and !target:getChar() == client:getChar()) then
				local data = entity:getNetVar("doorData") or {}
				local owners = data["guestIDs"] or {}
				
				if (client:getChar():getID() == data["ownerID"]) then
					if (!table.HasValue(target:getChar():getID())) then
						table.Add(owners, target:getChar():getID())
						hook.Run("doorSetVar", entity, "guestIDs", owners)
						client:ChatPrint(target:getChar():getName()" теперь имеет доступ к двери .")
					else
						client:ChatPrint(target:getChar():getName()" уже имеет доступ к двери.")
					end;
				else
					client:ChatPrint(target:getChar():getName()" не имеет доступа к двери.")
				end;
			else
				client:ChatPrint("Игрок недействителен!")
			end;
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

nut.command.add("doorremoveguest", {
	syntax = "[string name]",
	onRun = function(client, arguments)
		local entity = client:GetEyeTrace().Entity
		local target = nut.command.findPlayer(client, arguments[1])
		
		if (IsValid(entity) and entity:isDoor()) then
			if (IsValid(target) and !target:getChar() == client:getChar()) then
				local data = entity:getNetVar("doorData") or {}
				local owners = data["guestIDs"] or {}
				
				if (client:getChar():getID() == data["ownerID"]) then
					if (table.HasValue(target:getChar():getID())) then
						table.Remove(owners, target:getChar():getID())
						hook.Run("doorSetVar", entity, "guestIDs", owners)
						client:ChatPrint(target:getChar():getName()" больше не имеет доступа к двери.")
					else
						client:ChatPrint(target:getChar():getName()" не имеет доступа к двери.")
					end;
				else
					client:ChatPrint("Вы не владеете этой дверью.")
				end;
			else
				client:ChatPrint("Игрок недействителен!")
			end;
		else
			client:ChatPrint("Вы должны смотреть на дверь!")
		end;
	end
})

------------------------------------------------------
-- =====     END OF DOOR OWNERSHIP/ACCESS     ===== --
------------------------------------------------------