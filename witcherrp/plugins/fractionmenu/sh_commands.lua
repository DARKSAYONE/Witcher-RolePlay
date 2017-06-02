PLUGIN.commands = {}

function PLUGIN:CreateCommand(data, command)
	if (!data or !command) then
		return
	end

	local callback = data.onRun
	local group = data.group
	local syntax = data.syntax or "[none]"
	local hasTarget = data.hasTarget
	local allowDead = data.allowDead

	if (hasTarget == nil) then
		hasTarget = true
	end

	if (allowDead == nil) then
		allowDead = true
	end
	data.onMenu = data.onMenu or function( menu, icon, client, command )
		menu:AddOption(client:Name(), function()
			LocalPlayer():ConCommand( 'say /faction'..command..' "'..client:Name()..'"' )
		end):SetImage(icon)--nut.schema.Call("GetUserIcon", client) or icon)
	end
	self.commands[command] = data
	
	nut.command.add("faction"..command, {
		syntax = (hasTarget and "<string target> " or "")..syntax,
		allowDead = allowDead,
		hasPermission = function(client)
			return self:IsAllowed(client, group)
		end,
		silent = (data.silent or false),
		onRun = function(client, arguments)
			local target

			if (hasTarget) then
				target = nut.command.findPlayer(client, arguments[1])

				if (!IsValid(target)) then
					return
				end
			end

			if (IsValid(target) and !self:IsAllowed(client, target)) then
				client:notify("Цель выше Вас по рангу.")

				return
			end

			if (hasTarget) then
				table.remove(arguments, 1)
			end

			callback(client, arguments, target)
		end
	})
end


local PLUGIN = PLUGIN

PLUGIN:CreateCommand({
	text = "Узнать текущее звание",
	desc = "Узнать свое текущее звание во фракции.",
	group = "Рекрут",
	syntax = "",
	onMenu = function( menu, icon, client, command )
		LocalPlayer():ConCommand( 'say /faction'..command..' '..client:Name() )
	end,
	onRun = function(client)
		client:ChatPrint("Ваше текущее звание во фракции: '"..client:GetUserRank().."'")
	end
}, "checkrank")

PLUGIN:CreateCommand({
	text = "Добавить во фракцию",
	desc = "Добавить сталкера во фракцию.",
	group = "Лидер",
	hasTarget = false,
	onAll = true,
	syntax = "<string name/steamID>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1], true)
		if IsValid(target) then
		--	if (client:GetUserRank() != "Лидер") then
		--		return
		--	end
			if (target == client) then
				client:notify("Вы уже в этой фракции.")
				return
			end
			if !(target:Team() == FACTION_CITIZEN) then
				client:notify("Игрок уже в другой фракции.")
				return
			end
			
			PLUGIN:AddToFaction(target, client:getChar():getFaction())
			client:notify(target:Name().." был добавлен в Вашу фракцию.")
		end
	end
}, "useradd")

PLUGIN:CreateCommand({
	text = "Выгнать из фракции",
	desc = "Выгнать персонажа из фракции.",
	group = "Лидер",
	syntax = "<string name/steamID>",
	hasTarget = false,
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1], true)
		
		if (client:GetUserRank() != "Лидер") then
			return
		end
		if (!IsValid(target)) then
			client:notifyLocalized("missing_arg", 1)
			return
		end
		if (target == client) then
			client:notify("Вы не можете выгнать себя.")
			return
		end
		if !(target:Team() == client:Team()) then
			client:notify("Этот игрок не в Вашей фракции.")
			return
		end

		PLUGIN:RemoveFromFaction(target)
		client:notify(target:Name().." был(а) исключен(а) из Вашей фракции.")
	end
}, "userremove")


PLUGIN:CreateCommand({
	text = "Назначить звание",
	desc = "Повысить или понизить персонажа во звании.",
	group = "Лидер",
	syntax = "<string name/steamID> [string group]",
	hasTarget = false,
	onMenu = function( menu, icon, client, command )
		local submenu = menu:AddSubMenu( client:Name() )
		for uid, power in pairs( PLUGIN.ranks ) do
			if (!client:IsSuperAdmin()) and (uid == "Суперадминистратор" or uid == "Лидер") then continue end
			submenu:AddOption(uid, function()
				LocalPlayer():ConCommand( 'say /faction'..command..' "'..client:Name()..'" '.. uid )
			end):SetImage(icon)--.schema.Call("GetUserIcon", client) or icon)
		end
	end,
	onRun = function(client, arguments)
		local steamID = arguments[1]
		local group = arguments[2] or "Рекрут"

		if (!steamID) then
			client:notify(L("invalidArg", client, 1))

			return
		end
		if PLUGIN.ranks[group] == nil then
			client:notify("Группа не найдена!")
			return
		end
		--if !client:IsSuperAdmin() and group == "superadmin" or group == "leader" then
		--	client:notify("Доступ запрещен.")
		--	return
		--end

		local target

		-- If a player's name is passed since it is not a valid SteamID.
		if (!string.find(steamID, "STEAM_0:[01]:[0-9]+")) then
			target = nut.command.findPlayer(client, steamID)

			if (!IsValid(target)) then
				return
			end

			steamID = target:SteamID()
		end

		PLUGIN:SetUserRank(steamID or "", group, target)
		client:notify(client:Name().." изменил группу "..(IsValid(target) and target:Name() or steamID).." на "..group..".")
	end
}, "usersetrank")

PLUGIN:CreateCommand({
	text = "Назначить звание [Администратор]",
	desc = "Повысить или понизить персонажа во звании.",
	group = "Суперадминистратор",
	syntax = "<string name/steamID> [string group]",
	hasTarget = false,
	superAdminOnly = true,
	onMenu = function( menu, icon, client, command )
		local submenu = menu:AddSubMenu( client:Name() )
		for uid, power in pairs( PLUGIN.ranks ) do
			--if (!client:IsSuperAdmin()) and (uid == "superadmin" or uid == "leader") then continue end
			submenu:AddOption(uid, function()
				LocalPlayer():ConCommand( 'say /faction'..command..' "'..client:Name()..'" '.. uid )
			end):SetImage(icon)--.schema.Call("GetUserIcon", client) or icon)
		end
	end,
	onRun = function(client, arguments)
		local steamID = arguments[1]
		local group = arguments[2] or "user"

		if (!steamID) then
			client:notify(L("invalidArg", client, 1))

			return
		end
		if PLUGIN.ranks[group] == nil then
			client:notify("Группа не найдена!")
			return
		end
		
		--if !client:IsSuperAdmin() and group == "superadmin" or group == "leader" then
		--	client:notify("Доступ запрещен.")
		--	return
		--end

		local target

		-- If a player's name is passed since it is not a valid SteamID.
		if (!string.find(steamID, "STEAM_0:[01]:[0-9]+")) then
			target = nut.command.findPlayer(client, steamID)

			if (!IsValid(target)) then
				return
			end

			steamID = target:SteamID()
		end

		PLUGIN:SetUserRank(steamID or "", group, target)
		client:notify(client:Name().." изменил группу "..(IsValid(target) and target:Name() or steamID).." на "..group..".")
	end
}, "admsetrank")