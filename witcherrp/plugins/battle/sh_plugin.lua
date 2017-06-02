PLUGIN.name = "Battle"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Makes RP battles easier and more balanced."

nut.util.Include("cl_plugin.lua")

local bows = {
	"nut_bow_long",
	"nut_crossbow",
	"nut_bow_nilf",
	"nut_bow_ash"		
}

nut.command.add("sethp", {
	syntax = "<number amount>",
	onRun = function(client, arguments)
		local amount = math.floor(tonumber(arguments[1]))

		if (!amount or !isnumber(amount) or amount <= 0 or amount > client:battle_getMaxHealthPoints()) then
			return L("invalidArg", client, 1)
		end
		client:getChar():setData("battle_HP", amount)
	end
})

nut.command.add("charsethp", {
	adminOnly = true,
	syntax = "<string name> <number hp>",
	onRun = function (client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local amount = math.floor(tonumber(arguments[2]))

		if (!amount or !isnumber(amount) or amount <= 0 or amount > target:battle_getMaxHealthPoints()) then
			return L("invalidArg", client, 1)
		end
		target:getChar():setData("battle_HP", amount)
	end
})

if (SERVER) then
	function PLUGIN:EntityFireBullets(entity, bullet)
		if (entity:IsPlayer()) then
			local attrib
			for k, v in pairs(entity:getChar():getInv():getItems()) do
				if v.type == "1h" and v:getData("equip") == true and v.class == entity:GetActiveWeapon():GetClass() then
					attrib = "onehanded"
				elseif v.type == "2h" and v:getData("equip") == true and v.class == entity:GetActiveWeapon():GetClass() then
					if !table.HasValue(bows, entity:GetActiveWeapon():GetClass()) then
						attrib = "twohanded"
					end
				end
			end
			if !attrib then
				attrib = "melee"
			end
			entity:getChar():updateAttrib(attrib, math.random(0.01, 0.05))
			bullet.Damage = (bullet.Damage - entity:getChar():getAttrib("str", 0) / 2) * (0.5 + entity:getChar():getAttrib("str", 0) / 2 * 0.01 + entity:getChar():getAttrib(attrib, 0) / 2 * 0.01)
		end;
	end
end

local playerMeta = FindMetaTable("Player")

netstream.Hook("battle_reflex", function(player)
	local rand = math.random(1, 100)
	local roll = math.Round(rand + player:getChar():getAttrib("stm", 0) / 3 + player:getChar():getAttrib("str", 0) / 3 + player:getChar():getAttrib("end", 0) / 3)
	nut.chat.send(player, "me", "пытается среагировать. \nРефлекс: "..roll..".")
end)

netstream.Hook("battle_leave", function(player)
	player:forceSequence("Jump_Holding_Jump")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getDodgeChance()
	roll = math.Round(roll / player:getChar():getData("ArmorType", 1))
	nut.chat.send(player, "me", "пытается сбежать. \nПроворство: "..roll..".")
--	player:battle_calculateHit(roll)
end)

netstream.Hook("battle_block", function(player, bShield)
	player:forceSequence("Shoot_Ar2_Alt")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getBlockChance()
	nut.chat.send(player, "me", "пытается заблокировать удар. \nСтойкость: "..roll..".")
--	player:battle_calculateHit(roll)
end)

netstream.Hook("battle_dodge", function(player)
	player:forceSequence("Jump_Holding_Jump")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getDodgeChance()
	roll = math.Round(roll / player:getChar():getData("ArmorType", 1))
	nut.chat.send(player, "me", "пытается увернуться. \nПроворство: "..roll..".")
	--player:battle_calculateHit(roll)
end)

netstream.Hook("battle_stop", function(player, target)
	player:forceSequence("MeleeAttack01")
	local rand = math.random(1, 100)
	local roll = math.Round(rand + player:getChar():getAttrib("str", 0) / 3.5 + player:getChar():getAttrib("stm", 0) / 3.5 + player:getChar():getAttrib("melee", 0) / 3.5)	
	nut.chat.send(player, "me", "пытается остановить "..target:Name()..". \nСила: "..roll..".")
end)

netstream.Hook("battle_attack", function(player, target)
	player:forceSequence("MeleeAttack01")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getHitChance()
	local limb
	if rand >= 0 then limb = "левую ногу" end
	if rand >= 15 then limb = "правую ногу" end
	if rand >= 30 then limb = "левую руку" end
	if rand >= 45 then limb = "правую руку" end
	if rand >= 60 then limb = "грудь" end
	if rand >= 75 then limb = "живот" end
	if rand >= 85 then limb = "пах" end
	if rand >= 90 then limb = "шею" end
	if rand >= 95 then limb = "голову" end
	local limb1
	local limbs = {
		["Голова"] = "голову",
		["Шея"] = "шею",
		["Пах"] = "пах",
		["Живот"] = "живот",
		["Грудь"] = "грудь",
		["Правая рука"] = "правую руку",
		["Левая рука"] = "левую руку",
		["Правая нога"] = "правую ногу",
		["Левая нога"] = "левую ногу"
	}
	for k, v in pairs(limbs) do
		if v == limb then
			limb1 = k
			
			break
		end
	end
	
	--[[local limbsDamage = {
		["Голова"] = 1.5,
		["Шея"] = 1.5,
		["Пах"] = 1.25,
		["Живот"] = 1.25,
		["Грудь"] = 1,
		["Правая рука"] = 0.75,
		["Левая рука"] = 0.75,
		["Правая нога"] = 0.5,
		["Левая нога"] = 0.5
	}]]
	
	local dmg = player:battle_getWeaponDamage(target, true)
	
	if player:battle_getCritChance() <= math.random(1, 100) then
		dmg = dmg * 1.5
	end
	
	local wound
	if dmg >= 0 then wound = "Минимальный урон" end
	if dmg >= 4 then wound = "Легкий урон" end
	if dmg >= 8 then wound = "Средний урон" end
	if dmg >= 12 then wound = "Тяжелый урон" end
	if dmg >= 16 then wound = "Крайне тяжелый урон" end
	if dmg >= 20 then wound = "Фатальный урон" end
	
	dmg = math.Round(dmg)
	
	nut.chat.send(player, "me", "пытается атаковать "..target:Name()..". \nТочность: "..roll.."\nПри попадании: "..dmg.." ед. урона в "..limb..".")
	
	--target:battle_addHit(player, dmg, limb, roll)
end)

netstream.Hook("battle_attack_aim", function(player, target, aim, limb)
	--if target:battle_hasHit(player) then
	--	player:notify("Вы уже атаковали эту цель!")
	--	return
	--end
	player:forceSequence("MeleeAttack01")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getHitChance()
	
	local limbs = {
		["Голова"] = -80,
		["Шея"] = -75,
		["Пах"] = -70,
		["Живот"] = -40,
		["Грудь"] = -35,
		["Правая рука"] = -20,
		["Левая рука"] = -20,
		["Правая нога"] = -20,
		["Левая нога"] = -20
	}
	roll = math.max(roll + limbs[limb], 0)
	
	--[[local limbsDamage = {
		["Голова"] = 1.5,
		["Шея"] = 1.5,
		["Пах"] = 1.25,
		["Живот"] = 1.25,
		["Грудь"] = 1,
		["Правая рука"] = 0.75,
		["Левая рука"] = 0.75,
		["Правая нога"] = 0.5,
		["Левая нога"] = 0.5
	}
	]]
	local dmg = player:battle_getWeaponDamage(target, true)
	
	if player:battle_getCritChance() <= math.random(1, 100) then
		dmg = dmg * 1.5
	end
	
	local wound
	if dmg >= 0 then wound = "Минимальный урон" end
	if dmg >= 4 then wound = "Легкий урон" end
	if dmg >= 8 then wound = "Средний урон" end
	if dmg >= 12 then wound = "Тяжелый урон" end
	if dmg >= 16 then wound = "Крайне тяжелый урон" end
	if dmg >= 20 then wound = "Фатальный урон" end
	
	dmg = math.Round(dmg)
	
	nut.chat.send(player, "me", "пытается атаковать "..target:Name().." в "..aim..". \nТочность: "..roll.."\nПри попадании: "..dmg.." ед. урона в "..aim..".")
end)

netstream.Hook("battle_shoot", function(player, target)
	--if target:battle_hasHit(player) then
	--	player:notify("Вы уже атаковали эту цель!")
	--	return
	--end
	if player:GetActiveWeapon():Ammo1() <= 0 then
		player:notify("У Вас нет боеприпасов!")
		return
	end
	if player.battle_shootArrow then	
		nut.chat.send(player, "me", "перезаряжается.")
		player.battle_shootArrow = false
		return
	end	
	player.battle_shootArrow = true
	player:GetActiveWeapon():TakePrimaryAmmo(1)
	player:EmitSound("hgn/crussaria/weapon/bow/shoot.wav")
	player:forceSequence("Shoot_Ar2")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getShootChance()
	local limb
	if rand >= 0 then limb = "левую ногу" end
	if rand >= 15 then limb = "правую ногу" end
	if rand >= 30 then limb = "левую руку" end
	if rand >= 45 then limb = "правую руку" end
	if rand >= 60 then limb = "грудь" end
	if rand >= 75 then limb = "живот" end
	if rand >= 85 then limb = "пах" end
	if rand >= 90 then limb = "шею" end
	if rand >= 95 then limb = "голову" end
	
	local limb1
	local limbs = {
		["Голова"] = "голову",
		["Шея"] = "шею",
		["Пах"] = "пах",
		["Живот"] = "живот",
		["Грудь"] = "грудь",
		["Правая рука"] = "правую руку",
		["Левая рука"] = "левую руку",
		["Правая нога"] = "правую ногу",
		["Левая нога"] = "левую ногу"
	}
	for k, v in pairs(limbs) do
		if v == limb then
			limb1 = k
			
			break
		end
	end
	
	--[[local limbsDamage = {
		["Голова"] = 1.5,
		["Шея"] = 1.5,
		["Пах"] = 1.25,
		["Живот"] = 1.25,
		["Грудь"] = 1,
		["Правая рука"] = 0.75,
		["Левая рука"] = 0.75,
		["Правая нога"] = 0.5,
		["Левая нога"] = 0.5
	}
	
	
	]]
	local dmg = player:battle_getWeaponDamage(target)
	if player:battle_getCritChance() <= math.random(1, 100) then
		dmg = dmg * 1.5
	end
	
	local wound
	if dmg >= 0 then wound = "Минимальный урон" end
	if dmg >= 4 then wound = "Легкий урон" end
	if dmg >= 8 then wound = "Средний урон" end
	if dmg >= 12 then wound = "Тяжелый урон" end
	if dmg >= 16 then wound = "Крайне тяжелый урон" end
	if dmg >= 20 then wound = "Фатальный урон" end
	
	dmg = math.Round(dmg)
	
	nut.chat.send(player, "me", "пытается выстрелить в "..target:Name()..". \nТочность: "..roll.."\nПри попадании: "..dmg.." ед. урона в "..limb..".")
	nut.chat.send(target, "it", "В "..target:Name().." летит стрела. \nТочность: "..roll.."\nПри попадании: "..dmg.." ед. урона в "..limb..".")
end)

netstream.Hook("battle_shoot_aim", function(player, target, aim, limb)
	--if target:battle_hasHit(player) then
	--	player:notify("Вы уже атаковали эту цель!")
	--	return
	--end
	if player:GetActiveWeapon():Ammo1() <= 0 then
		player:notify("У Вас нет боеприпасов!")
		return
	end
	if player.battle_shootArrow then	
		nut.chat.send(player, "me", "перезаряжается.")
		player.battle_shootArrow = false
		return
	end	
	player.battle_shootArrow = true
	
	player:GetActiveWeapon():TakePrimaryAmmo(1)
	player:EmitSound("hgn/crussaria/weapon/bow/shoot.wav")
	player:forceSequence("Shoot_Ar2")
	local rand = math.random(1, 100)
	local roll = rand + player:battle_getShootChance()
	local limbs = {
		["Голова"] = -80,
		["Шея"] = -70,
		["Пах"] = -55,
		["Живот"] = -20,
		["Грудь"] = -15,
		["Правая рука"] = -20,
		["Левая рука"] = -20,
		["Правая нога"] = -20,
		["Левая нога"] = -20
	}
	
	--[[local limbsDamage = {
		["Голова"] = 1.5,
		["Шея"] = 1.5,
		["Пах"] = 1.25,
		["Живот"] = 1.25,
		["Грудь"] = 1,
		["Правая рука"] = 0.75,
		["Левая рука"] = 0.75,
		["Правая нога"] = 0.5,
		["Левая нога"] = 0.5
	}
	]]
	local dmg = player:battle_getWeaponDamage(target)
	roll = math.max(rand + limbs[limb], 0)	
	if player:battle_getCritChance() <= math.random(1, 100) then
		dmg = dmg * 1.5
	end
	
	local wound
	if dmg >= 0 then wound = "Минимальный урон" end
	if dmg >= 4 then wound = "Легкий урон" end
	if dmg >= 8 then wound = "Средний урон" end
	if dmg >= 12 then wound = "Тяжелый урон" end
	if dmg >= 16 then wound = "Крайне тяжелый урон" end
	if dmg >= 20 then wound = "Фатальный урон" end
	
	dmg = math.Round(dmg)
	
	nut.chat.send(player, "me", "пытается выстрелить в "..aim.." "..target:Name()..". \nТочность: "..roll.."\nПри попадании: "..dmg.." ед. урона в "..aim..".")
	nut.chat.send(target, "it", "В "..aim.." "..target:Name().." летит стрела. \nТочность: "..roll.."\nПри попадании: "..dmg.." ед. урона в "..aim..".")
end)

--[[
netstream.Hook("battle_hit", function(player, target)
	player:forceSequence("MeleeAttack01")
	if math.random(1, 100) <= player:battle_getHitChance() then
		battle_def(player, target)
	else
		nut.chat.send(player, "me", "пытается атаковать "..target:Name()..", но промахивается.")
	end
end)

function battle_def(player, target)
	if math.random(1, 100) <= target:battle_getDodgeChance() then
		nut.chat.send(player, "me", "пытается атаковать "..target:Name()..", но он(а) уклоняется.")
	elseif math.random(1, 100) <= target:battle_getBlockChance() then
		nut.chat.send(player, "me", "пытается атаковать "..target:Name()..", но он(а) блокирует удар.")
	else
		battle_takeDamage(player, target)
	end
end

function battle_takeDamage(player, target)
	local hp = target:battle_getHealthPoints()
	local maxhp = target:battle_getMaxHealthPoints()
	local damage = player:battle_getWeaponDamage(target)
	
	target:getChar():setData("battle_HP", math.max(hp - damage, 0))
	hpstring = "здоров(а)"
	local n = hp/maxhp * 100
	if n <= 90 and n > 50 then
		hpstring = "легко ранен(а)"
	elseif n <= 50 and n > 25 then
		hpstring = "ранен(а)"
	elseif n <=25 and n > 10 then
		hpstring = "тяжело ранен(а)"
	elseif n <=10 then
		hpstring = "при смерти"
	end	
	nut.chat.send(player, "me", "успешно атакует "..target:Name()..", нанося "..damage.." ед. урона. "..target:Name().." "..hpstring..".")
end
]]

function playerMeta:battle_addHit(player, damage, limbAim, chance)
	hits = self:getChar():getData("hits", {})
	local hit = {
		dealer = player,
		dmg = damage,
		limb = limbAim,
		roll = chance
	}
	table.insert(hits, hit)
	self:getChar():setData("hits", hits)
end

function playerMeta:battle_calculateHit(roll)
	hits = self:getChar():getData("hits", {})
	local hit = hits[1]
	if hit.roll > roll then
		self:getChar():setData("battle_hp", math.Clamp(self:battle_getHealthPoints() - hit.dmg, 0, self:battle_getMaxHealthPoints()))
		nut.chat.send(self, "me", "получает "..dmg.." ед. урона в "..limb..".")
	end
	hits[1] = nil
	self:getChar():setData("hits", hits)
end

function playerMeta:battle_hasHit(player)
	if !player then
		if !self:getChar():getData("hits") then
			return false
		else
			return true
		end
	end
	if self:getChar():getData(hits) then
		for k, v in pairs(self:getChar():getData(hits)) do
			if v.dealer == player then	
				return true
			end
		end
	end
	return false
end

function playerMeta:battle_wearingShield()
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.armorclass == "shield" and v:getData("equip") == true then
			return true
		end
	end
end

function playerMeta:battle_hasTarget(dist)
	local trace = self:GetEyeTraceNoCursor()
	if trace.Entity:IsPlayer() and trace.HitPos:Distance( self:GetShootPos() ) <= dist then
		return trace.Entity
	end
	return false
end

function playerMeta:battle_getWeaponDamage(target, bMelee)
	local num, dice
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.isWeapon and v.class == self:GetActiveWeapon():GetClass() then
			if !bMelee or (bMelee and !table.HasValue(bows, v.class)) then
				num = v.damage[1]
				dice = v.damage[2]
			end
		end
	end
	if !num or !dice then
		num = 1
		dice = 2
	end
	local damage = 0
	for i = 1, num do
		damage = damage + math.random(1, dice)
	end
	local dmgtypes = {
		[1] = DMG_CLUB,
		[2] = DMG_SLASH,
		[3] = DMG_CRUSH
	}
	if self:GetActiveWeapon().dmgtype and target:battle_getArmorDefence()[dmgtypes[self:GetActiveWeapon().dmgtype]] ~= nil then
		damage = damage * (1 - (target:battle_getArmorDefence()[dmgtypes[self:GetActiveWeapon().dmgtype]] * 0.01))
	end
	if self:GetActiveWeapon().dmgtype and target:getChar():getData("RPArmor") then
		damage = damage * (1 - (target:getChar():getData("RPArmor")[dmgtypes[self:GetActiveWeapon().dmgtype]] * 0.01))
	end
	
	damage = math.Round(damage * (1 + self:getChar():getAttrib("str", 0) * 0.0025))
	
	if math.random(1, 100) <= self:battle_getCritChance() then
		damage = damage * 1.5
	end
	
	return damage
end

function playerMeta:battle_getArmorDefence()
	local def = {}
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.armorclass == "suit" and v:getData("equip") == true then
			for k1, v1 in pairs(v.resistance) do
				def[k1] = (1 - v1) * v:getData("durability", 100)
			end
		end
	end
	if self:getChar():getData("RPArmor") then
		for k, v in pairs(self:getChar():getData("RPArmor")) do
			def[k] = (1 - v) * 100
		end
	end
	return def
end

function playerMeta:battle_getShootChance()
	return math.Round(self:getChar():getAttrib("bow", 0) / 2 + self:getChar():getAttrib("stm", 0) / 4 + self:getChar():getAttrib("str", 0) / 4)
end

function playerMeta:battle_getHitChance()

	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.type == "1h" and v:getData("equip") == true and v.class == self:GetActiveWeapon():GetClass() then
			return math.Round(10 + self:getChar():getAttrib("onehanded", 0) / 1.5 + self:getChar():getAttrib("stm", 0) / 3)
		elseif v.type == "2h" and v:getData("equip") == true and v.class == self:GetActiveWeapon():GetClass() and !table.HasValue(bows, self:GetActiveWeapon():GetClass()) then
			return math.Round(self:getChar():getAttrib("twohanded", 0) / 1.5 + self:getChar():getAttrib("stm", 0) / 3)
		end
	end

	return math.Round(15 + self:getChar():getAttrib("melee", 0) / 1.5 + self:getChar():getAttrib("stm", 0) / 3)
end

function playerMeta:battle_getCritChance()
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.type == "1h" and v:getData("equip") == true and v.class == self:GetActiveWeapon():GetClass() then
			return math.Round(self:getChar():getAttrib("onehanded", 0) / 20)
		elseif v.type == "2h" and v:getData("equip") == true and v.class == self:GetActiveWeapon():GetClass() then
			if table.HasValue(bows, self:GetActiveWeapon():GetClass()) then
				return math.Round(self:getChar():getAttrib("bow", 0) / 20)		
			else
				return math.Round(self:getChar():getAttrib("twohanded", 0) / 20)		
			end
		end
	end

	return math.Round(self:getChar():getAttrib("melee", 0) / 20)
end

function playerMeta:battle_getWeapon()
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.type == "1h" and v:getData("equip") == true then
			return 1
		elseif v.type == "2h" and v:getData("equip") == true and !table.HasValue(bows, v.class) then
			return 2
		end
	end

	return 0
end

function playerMeta:battle_getMaxHealthPoints()
	return math.Round(15 + self:getChar():getAttrib("end", 0) / 5 + self:getChar():getAttrib("str", 0) / 10)
end

function playerMeta:battle_getHealthPoints()
	return self:getChar():getData("battle_HP", self:battle_getMaxHealthPoints())
end

function playerMeta:battle_getDodgeChance()
	return math.Round(self:getChar():getAttrib("stm", 0)/2 + self:getChar():getAttrib("str", 0) / 3 + self:getChar():getAttrib("end", 0) / 4)
end

function playerMeta:battle_getBlockChance()
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.armorclass == "shield" and v:getData("equip") == true then
			return math.Round(25 + self:getChar():getAttrib("shield", 0)/2 + self:getChar():getAttrib("end", 0)/5 + self:getChar():getData("str", 0)/5)
		end
	end
	for k, v in pairs(self:getChar():getInv():getItems()) do
		if v.type == "1h" and v:getData("equip") == true then
			return math.Round(15 + self:getChar():getAttrib("onehanded", 0)/2 + self:getChar():getData("stm", 0)/5 + self:getChar():getData("str", 0)/5)
		elseif v.type == "2h" and v:getData("equip") == true then
			return math.Round(15 + self:getChar():getAttrib("twohanded", 0)/2 + self:getChar():getData("stm", 0)/5 + self:getChar():getData("str", 0)/5)
		end
	end
	return math.Round(15 + self:getChar():getAttrib("melee", 0)/2 + self:getChar():getData("end", 0)/5 + self:getChar():getData("str", 0)/5)
end
