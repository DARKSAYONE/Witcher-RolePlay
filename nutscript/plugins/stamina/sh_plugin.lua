PLUGIN.name = "Stamina"
PLUGIN.author = "Chessnut, AleXXX_007"
PLUGIN.desc = "Adds a stamina system to limit running and jumping."
if (SERVER) then
	function PLUGIN:SetupMove(player, movedata)	
		if player:getChar() then
			local stamina = player:getLocalVar("stm", 100)
			player:SetJumpPower(player:getChar():getAttrib("stm", 0) * 1.5 + 150)
		end
	end
	
	function PLUGIN:PostPlayerLoadout(client)
		client:SetWalkSpeed(nut.config.get("walkSpeed"))
		local skill = client:getChar():getAttrib("end", 0)
		client:setLocalVar("stm", math.Round(100 + skill))
		local uniqueID = "nutStam"..client:SteamID()
		local offset = 0
		local velocity
		local length2D = 0
		local runSpeed = client:GetRunSpeed() - 5

		timer.Create(uniqueID, 0.05, 0, function()
			if (IsValid(client)) then
				client:setLocalVar("maxStm", math.Round(100 + skill))
				local character = client:getChar()

				if (client:GetMoveType() != MOVETYPE_NOCLIP and character) then
					velocity = client:GetVelocity()
					length2D = velocity:Length2D()
					runSpeed = nut.config.get("runSpeed")
					local armor = 0
					if client:getChar():getData("ArmorType", 0) == 3 then
						armor = -0.5
					elseif client:getChar():getData("ArmorType", 0) == 2 then
						armor = -0.25
					end
					local buff = 0
					if client:getLocalVar("stmBuff", 0) > 0 then
						buff = client:getLocalVar("stmBuff")
					end
					offset = armor + buff

					if (client:WaterLevel() > 1) then
						runSpeed = runSpeed * 0.775
					end

					if (client:KeyDown(IN_SPEED) and length2D >= (runSpeed - 55)) then
						offset = offset - 0.5 + math.floor(character:getAttrib("end", 0) / 200)
						character:updateAttrib("end", 0.00025)
						character:updateAttrib("stm", 0.00005)
						if math.random(1, 30) == 1 then
							character:setData("thirst", math.max(character:getData("thirst", 100) - 0.25, 0))
						elseif math.random(1, 30) == 1 then
							character:setData("hunger",  math.max(character:getData("hunger", 100) - 0.25, 0))							
						elseif math.random(1, 30) == 1 then
							character:setData("fatigue",  math.max(character:getData("fatigue", 100) - 0.25, 0))
						end
					else
						offset = offset + 0.6
					end

					local current = client:getLocalVar("stm", 0)
					local value = math.Clamp(current + offset, 0, 100 + skill)

					if (current != value) then
						client:setLocalVar("stm", value, 2)
						client:setLocalVar("maxStm", 100 + skill, 2)

						if (client:getLocalVar("stm", 0) == 0 and !client.nutBreathing) then
							client:SetRunSpeed(nut.config.get("walkSpeed"))
							client.nutBreathing = true
							hook.Run("PlayerStaminaLost", client)
						elseif (value >= 50 and client.nutBreathing) then
							client:SetRunSpeed(runSpeed)
							client.nutBreathing = false
						end
					end
				end
			else
				timer.Remove(uniqueID)
			end
		end)
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:restoreStamina(amount)
		local skill = self:getChar():getAttrib("end", 0)
		local current = self:getLocalVar("stm", 0)
		local value = math.Clamp(current + amount, 0, 100 + skill)

		self:setLocalVar("stm", value)
	end
end