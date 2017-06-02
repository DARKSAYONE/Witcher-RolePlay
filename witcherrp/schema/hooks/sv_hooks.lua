--[[
function SCHEMA:PlayerSpawnSENT(ply, class)
	if class == "nut_vendor" and !ply:IsSuperAdmin() then
		return false
	end
end
]]
function SCHEMA:PlayerSpray(player)
	return true;
end;

function SCHEMA:PlayerSpawnNPC(ply, npcclass, wep)
	if npcclass == "npc_goat" or npcclass == "npc_deer" then
		return false
	end
end

function SCHEMA:PostPlayerLoadout(client)
	if !client:IsAdmin() then
		client:SetCanZoom(false)
	else
		client:SetCanZoom(true)
	end
end

function SCHEMA:PlayerInitialSpawn(client)
	client:ConCommand("nut_language russian")
	client:ConCommand("gmod_mcore_test 1")
	--local plys = player.GetAll()
	--for k, ply in pairs(plys) do
	--	ply:ChatPrint(client:steamName().. " подключился к серверу.")
	--end
end
--[[
function SCHEMA:PlayerDisconnected(client)
	local plys = player.GetAll()
	for k, ply in pairs(plys) do
		ply:ChatPrint(client:steamName().. " отключился от сервера.")
	end
end
]]
function SCHEMA:OnCharCreated(client, character)
	local model = character:getModel()
	if model == "models/humans/groupm6/male_02.mdl" then
		character:setData("modelType", "male_02")
	elseif model == "models/humans/groupm6/male_04.mdl" then
		character:setData("modelType", "male_04")
	elseif model == "models/humans/groupm6/male_06.mdl" then
		character:setData("modelType", "male_06")
	elseif model == "models/humans/groupm6/male_07.mdl" then
		character:setData("modelType", "male_07")
	elseif model == "models/humans/groupm6/male_08.mdl" then
		character:setData("modelType", "male_08")
	elseif model == "models/humans/groupm6/male_09.mdl" then
		character:setData("modelType", "male_09")
	elseif model == "models/humans/groupm6/female_01.mdl" then
		character:setData("modelType", "female_01")
	elseif model == "models/humans/groupm6/female_02.mdl" then
		character:setData("modelType", "female_02")
	elseif model == "models/humans/groupm6/female_03.mdl" then
		character:setData("modelType", "female_03")
	end
	local inventory = character:getInv()

	if (inventory) then		
		if (character:getFaction() == FACTION_CITIZEN) then
			inventory:add("apple", 1)
			inventory:add("water", 1)
		end
	end
end

function SCHEMA:PlayerSwitchFlashlight(client, enabled)
	return false
end

function SCHEMA:PlayerMessageSend(client, chatType, message, anonymous, receivers)
	if (!nut.voice.chatTypes[chatType]) then
		return
	end

	for _, definition in ipairs(nut.voice.getClass(client)) do
		local sounds, message = nut.voice.getVoiceList(definition.class, message)

		if (sounds) then
			local volume = 80

			if (chatType == "w") then
				volume = 60
			elseif (chatType == "y") then
				volume = 150
			end
			
			if (definition.onModify) then
				if (definition.onModify(client, sounds, chatType, message) == false) then
					continue
				end
			end

			if (definition.isGlobal) then
				netstream.Start(nil, "voicePlay", sounds, volume)
			else
				netstream.Start(nil, "voicePlay", sounds, volume, client:EntIndex())

				if (chatType == "radio" and receivers) then
					for k, v in pairs(receivers) do
						if (receivers == client) then
							continue
						end

						netstream.Start(nil, "voicePlay", sounds, volume * 0.5, v:EntIndex())
					end
				end
			end

			return message
		end
	end
end

netstream.Hook("dataCls", function(client, text)
	local target = client.nutDataTarget

	if (text and IsValid(target) and target:getChar() and hook.Run("CanPlayerEditData", client, target)) then
		target:getChar():setData("txt", text:sub(1, 750))
		client:EmitSound("buttons/combine_button7.wav", 60, 150)
	end

	client.nutDataTarget = nil
end)