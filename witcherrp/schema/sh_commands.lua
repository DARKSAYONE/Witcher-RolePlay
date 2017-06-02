nut.command.add("command", {
	adminOnly = true,
	syntax = "<string name> <string command>",
	onRun = function (client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local args = arguments
		table.remove(args, 1)
		local arg = table.concat(args, " ")
		if arguments[2] == nil then
			client:notify("Вы не указали команду!")
			return
		end
		target:ConCommand(tostring(arg))
	end
})

nut.command.add("maxchar", {
	adminOnly = true,
	syntax = "<string name> <number Chars>",
	onRun = function (client, arguments)
		local target
		if arguments[1] == nil then
			target = client
		end	
		if !target then
			target = nut.command.findPlayer(client, arguments[1])
		end
		if arguments[2] == nil then
			client:notify("Вы не указали максимальное количество персонажей!")
			return
		end
		local maxChars = tonumber(arguments[2])
		if maxChars >= 1 and maxChars < 16 then
			target:setNutData("maxChars", maxChars)
			client:notify("Максимальное количество персонажей для ".. target:Name() .." установлено на ".. maxChars ..".")
		else
			client:notify("Максимальное количество персонажей не может быть меньше 1 и больше 16!")
		end
	end
})

nut.command.add("teach", {
	syntax = "<string attrib>",
	onRun = function(client, arguments)
		local attrib = arguments[1]
		if attrib == nil then
			client:notify("Вы не выбрали атрибут!")
			return
		end
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local target = util.TraceLine(data).Entity
		if (client:getChar():hasFlags("T")) then
			if (IsValid(target) and target:IsPlayer() and target:getChar()) then
				if client:getChar():getData("nextTeach", 0) <= CurTime() then
					if client:getChar():getAttrib(attrib, 0)/1.5 >= target:getChar():getAttrib(attrib, 0) then
						client:notify("Вы успешно научили персонажа навыку.")
						local boost = math.floor(client:getChar():getAttrib(attrib, 0)/math.random(5, 10))
						target:getChar():addBoost("teach", attrib, boost, 3600)
						target:getChar():updateAttrib(attrib, math.floor(boost/math.random(5, 10)))
						client:getChar():setData("nextTeach", CurTime() + 3600)
					else
						client:notify("Ваш навык слишком мал для обучения этого персонажа!")
					end
				else
					client:notify("Вы должны подождать, прежде чем обучить персонажа еще раз.")
				end
			else
				client:notify("Вы должны смотреть на игрока!")
			end
		else
			client:notify("Вы не имеете флага обучения!")
		end
	end
})

nut.command.add("clearinv", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function (client, arguments)
	local target
		if arguments[1] == nil then
			target = client
		end	
		if !target then
			target = nut.command.findPlayer(client, arguments[1])
		end
		if target:getChar() then
			for k, v in pairs(target:getChar():getInv():getItems()) do
				v:remove()
			end
			client:notify("Инвентарь ".. target:getChar():getName() .." очищен.")
		end
	end
})

nut.command.add("worldlight", {
	adminOnly = true,
	syntax = "<word type>",
	onRun = function(client, arguments)
		client:notify( os.date(format, nut.date.get()+ 100) )
	end
})

nut.command.add("poker", {
	syntax = "[number dice1] [number dice2] [number dice3] [number dice4] [number dice5]",
	onRun = function (client, argument)
	local a = math.random(1, 6)
	local b = math.random(1, 6)
	local c = math.random(1, 6)
	local d = math.random(1, 6)
	local e = math.random(1, 6)
		if client:getChar():getInv():hasItem("dice") then
			sound.Play("physics/wood/wood_strain".. math.random(1, 3) ..".wav", client:GetPos(), 75)
			nut.chat.send(client, "me", " бросил кости: ".. a .." ".. b .. " " .. c .. " " .. d .. " " .. e)
			client:getChar():setData("Dice", true)
		else
			client:notify("У вас нет игральных костей!")
		end
	end
})

nut.command.add("dice", {
	onRun = function(client)
	local rl = math.random(1, 6)
		nut.chat.send(client, "roll", rl)
	end
})


nut.command.add("data", {
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, table.concat(arguments, " "))

		if (IsValid(target) and target:getChar()) then
			if (!hook.Run("CanPlayerViewData", client, target)) then
			client.nutDataTarget = target
			netstream.Start(client, "plyData", target:getChar():getData("txt"), target:Name().." ["..target:getDigits().."]", hook.Run("CanPlayerEditData", client, target))
			end

			client.nutDataTarget = target
			netstream.Start(client, "plyData", target:getChar():getData("txt"), target:Name().." ["..target:getDigits().."]", hook.Run("CanPlayerEditData", client, target))
		end
	end
})