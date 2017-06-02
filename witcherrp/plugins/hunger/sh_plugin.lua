PLUGIN.name = "Primary Needs"
PLUGIN.author = "LiGyH, AleXXX_007"
PLUGIN.desc = "Adds hunger, thirst and fatigue."

if (SERVER) then
	function PLUGIN:OnCharCreated(client, character)
		character:setData("hunger", 100)
		character:setData("thirst", 100)
		character:setData("fatigue", 100)
		character:setData("drunk", 0)
	end
	
	function PLUGIN:PlayerTick(player)
		local DrunkShit = {
			"Эх, раз... Да ещё раз... Да ещё много-много раз! Ик!",
			"Хо-р-р-шо пошла...",
			"А как лесное лихо трахаеца никто, ик, не видел? Могу рассказать!",
			"О,видите птицу? А факел видите? С-час буим, ик, делать, ик-бля, чудо-птицу... Этого... Феникса, во!..",
			"Ну-с, между первой и второй - перерывчик не большой... Или какая это у нас?",
			"А де-е-евица-а-а из Викова-а-аро... Ык!... Любит то-о-лька... За амба-а-аром!",
			"А у второ-о-ой из Викова-а-аро не в чести ложи-и-итца да-а-аром!",
			"А у третьей нету пра-а-авил, лишь бы кто-о-о-нибудь, да вста-а-авил!"
		
		}
		if player:getChar() then
			if player.nextDrunk == nil then player.nextDrunk = 0 end
			if player:getChar():getData("drunk", 0) > 20 and player.nextDrunk <= CurTime() and !IsValid(player.nutRagdoll) then
				player.nextDrunk = CurTime() + math.random(30, 60)
				if math.random(1, 2) == 1 then
					player:emote("drunk")
				elseif player:getChar():getFaction() == "tem" then
					player:say("Лишь ступив на поля Темерской земли, эх, ик! Император Эмгыр наделал в штаны!")
				elseif player:getChar():getFaction() == "nilf" then
					player:say("Фольтест хер, ик, наелся... Блох... Сел под лавочку и сдох, ик!")
				else
					player:say(table.Random(DrunkShit))
				end
			end
		end
	end
	
	function PLUGIN:PostPlayerLoadout(client)		
		local hungSpeed = 400
		local thirSpeed = 200
		local fatSpeed = 600
		if client:getChar() then
			timer.Create("hunger"..client:SteamID(), hungSpeed, 0, function()
				if !client:getChar() then
					timer.Destroy("hunger"..client:SteamID())
				end
				if client:getChar():getData("hunger", 100) > 0 and client:getChar() then
					client:getChar():setData("hunger", client:getChar():getData("hunger", 100) - 1)
				end
			end)
			
			timer.Create("thirst"..client:SteamID(), thirSpeed, 0, function()
				if !client:getChar() then
					timer.Destroy("thirst"..client:SteamID())
				end
				if client:getChar():getData("thirst", 100) > 0 and client:getChar() then
					client:getChar():setData("thirst", client:getChar():getData("thirst", 100) - 1)
				end
			end)
			
			timer.Create("fatigue"..client:SteamID(), fatSpeed, 0, function()
				if !client:getChar() then
					timer.Destroy("fatigue"..client:SteamID())
				end
				if client:getChar():getData("fatigue", 100) > 0 and client:getChar() then
					client:getChar():setData("fatigue", client:getChar():getData("fatigue", 100) - 1)
				end
			end)
			
			timer.Create("healthreg"..client:SteamID(), 60, 0, function()
				if !client:getChar() then
					timer.Destroy("healthreg"..client:SteamID())
				end
				if IsValid(client) and client:getChar():getData("hunger", 100) > 70 and client:getChar():getData("thirst", 100) > 50 and client:Health() < 100 and client:getChar() then
					client:SetHealth(math.Clamp(client:Health() + math.random(1,5), 0, 100))
				end
			end)
			
			timer.Create("TakeDamage"..client:SteamID(), 5, 0, function()
				if !client:getChar() then
					timer.Destroy("TakeDamage"..client:SteamID())
				end
				if (IsValid(client)) then
					if ((client:getChar():getData("hunger", 100) <= 0) or (client:getChar():getData("thirst", 100) <= 0)) and client:Health() > 5 and client:getChar() then
						client:SetHealth(client:Health() - 0.1)
					end
					if (client:getChar():getData("fatigue", 100) <= 10) and !IsValid(client.nutRagdoll) and client:getChar() then
						client:sleep()
					end
					if client:getChar():getData("drunk", 0) > 0 and client:getChar() then
						if !IsValid(client.nutRagdoll) and (client:getChar():getData("drunk", 100) > (100 + client:getChar():getAttrib("end", 0))) then
							client:sleep()
						end
						client:getChar():setData("drunk",  client:getChar():getData("drunk", 100) - 1)
					end
				end
			end)
		end
	end

	local charMeta = nut.meta.character

	function charMeta:restoreHunger(amount)
		timer.Create("HungerAdd"..self:getPlayer():SteamID(), 0.5, amount, function()
			self:setData("hunger", math.Clamp(self:getData("hunger", 100) + 1, -100, 100))
			if self:getData("drunk", 0) > 0 and amount > 20 then
				self:setData("drunk", self:getData("drunk", 0) - 0.5)
				self:setData("thirst", math.Clamp(self:getData("thirst", 100) - 0.25, -100, 100))
			end
			if self:getData("hunger", 0) == 100 then
				timer.Destroy("HungerAdd"..self:getPlayer():SteamID())
			end
		end)
	end
	
	function charMeta:restoreThirst(amount)
		timer.Create("ThirstAdd"..self:getPlayer():SteamID(), 0.5, amount, function()
			self:setData("thirst", math.Clamp(self:getData("thirst", 100) + 1, -100, 100))
			if self:getData("drunk", 0) > 0 and amount > 20 then
				self:setData("drunk", self:getData("drunk", 0) - 0.5)
			end
			if self:getData("thirst") == 100 then
				timer.Destroy("ThirstAdd"..self:getPlayer():SteamID())
			end
		end)
	end
	
	function charMeta:restoreFatigue(amount)		
		timer.Create("FatigueAdd"..self:getPlayer():SteamID(), 0.5, amount, function()
			self:setData("fatigue", math.Clamp(self:getData("fatigue", 100) + 1, -100, 100))
			if self:getData("fatigue") == 100 then
				timer.Destroy("FatigueAdd"..self:getPlayer():SteamID())
			end
		end)
	end
	
	function charMeta:addDrunk(amount)
		amount = math.floor(amount * (1 - (self:getAttrib("end", 0) / 110)))
		timer.Create("DrunkAdd"..self:getPlayer():SteamID(), 0.5, amount, function()
			self:setData("drunk", math.Clamp(self:getData("drunk", 0) + 1, -100, 200))
		end)
	end
	
	function charMeta:removeDrunk(amount)
		amount = math.floor(amount * (1 + (self:getAttrib("end", 0) / 110)))
		timer.Destroy("DrunkAdd"..self:getPlayer():SteamID())
		timer.Create("DrunkRemove"..self:getPlayer():SteamID(), 0.5, amount, function()
			self:setData("drunk", math.Clamp(self:getData("drunk", 0) - 1, -100, 200))
		end)
	end
	
	local playerMeta = FindMetaTable("Player")
	
	function playerMeta:sleep()
		timer.Destroy("DrunkAdd"..self:SteamID())
		local sleeptime = math.random(180, 320) - self:getChar():getData("fatigue", 100) + self:getChar():getData("drunk", 0)
		self:setRagdolled(true, sleeptime)
		timer.Create("fatigue", 1, sleeptime, function()
			self:getChar():restoreFatigue(1)
			if self:getChar():getData("drunk", 0) > 75 and self:getChar():getData("thirst") > 15 then
				self:getChar():setData("thirst", self:getChar():getData("thirst") - 1)
				if self:getChar():getData("drunk", 0) > 0 then
					self:getChar():setData("drunk", self:getChar():getData("drunk") - 1)
				end
			end
		end)
	end
else
	function PLUGIN:RenderScreenspaceEffects()
	local a
	if LocalPlayer():getChar() then
		a = LocalPlayer():getChar():getData("drunk", 0) or 0
	end
	if a == nil then a = 0 end
		if a > 0 then
			DrawMotionBlur( 0.2, a * 0.01, 0.05 )
		end
	end
end

function PLUGIN:SetupMove(player, moveData)
	if (player:Alive()) and player:getChar() then
		local frameTime = FrameTime();
		local curTime = CurTime();
		
		if (player:getChar():getData("drunk", 0) > 30) and player.DrunkSwerve then
			player.DrunkSwerve = math.Clamp(player.DrunkSwerve + frameTime, 0, math.min(player:getChar():getData("drunk", 0) * 2, 16));
			
			moveData:SetMoveAngles(moveData:GetMoveAngles() + Angle(0, math.cos(curTime) * player.DrunkSwerve, 0));
		elseif (player.DrunkSwerve and player.DrunkSwerve > 2) and (player:getChar():getData("drunk", 0) > 30) then
			player.DrunkSwerve = math.max(player.DrunkSwerve - frameTime, 0);
			
			moveData:SetMoveAngles(moveData:GetMoveAngles() + Angle(0, math.cos(curTime) * player.DrunkSwerve, 0));
		elseif (player.DrunkSwerve != 2) and (player:getChar():getData("drunk", 0) > 30) then
			player.DrunkSwerve = 2;
		end;
	end;
end;

nut.command.add("sleep", {
	onRun = function(client)
		if (IsValid(client)) then
			if client:getChar():getData("fatigue") <= 40 then
				client:sleep()
			else
				client:notify("Вы не хотите спать.")
			end
		end
	end
})

nut.command.add("charsetthirst", {
	syntax = "<string Name> [number Amount]",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if IsValid(target) and target:getChar() then
			timer.Destroy("ThirstAdd"..target:SteamID())
			target:getChar():setData("thirst", tonumber(arguments[2]))
			client:notify("Жажда ".. target:getChar():getName() .. " изменена.")
		end
	end
})

nut.command.add("charsethunger", {
	syntax = "<string Name> [number Amount]",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if IsValid(target) and target:getChar() then
			timer.Destroy("HungerAdd"..target:SteamID())
			target:getChar():setData("hunger", tonumber(arguments[2]))
			client:notify("Голод ".. target:getChar():getName() .. " изменен.")
		end
	end
})

nut.command.add("charsetfatigue", {
	syntax = "<string Name> [number Amount]",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if IsValid(target) and target:getChar() then
			timer.Destroy("FatigueAdd"..target:SteamID())
			target:getChar():setData("fatigue", tonumber(arguments[2]))
			client:notify("Усталость ".. target:getChar():getName() .. " изменена.")
		end
	end
})

nut.command.add("charsetdrunk", {
	syntax = "<string Name> [number Amount]",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if IsValid(target) and target:getChar() then
			timer.Destroy("DrunkAdd"..target:SteamID())
			timer.Destroy("DrunkRemove"..target:SteamID())
			target:getChar():setData("drunk", tonumber(arguments[2]))
			client:notify("Уровень интоксикации ".. target:getChar():getName() .. " изменен.")
		end
	end
})