local PLUGIN = PLUGIN
PLUGIN.name = "Equipable armor"
PLUGIN.author = "Neon"
PLUGIN.desc = "Working armor, shields and different types of damage and deflection."

--[[function PLUGIN:PlayerTick(player)
	local mass = 0
	
	player:SetWalkSpeed(nut.config.get("walkSpeed") * (1 - (0.01 * mass)))
	if !(player.nutBreathing) then
		player:SetRunSpeed(nut.config.get("runSpeed") - (100 - player:getLocalVar("stm", 0))/2)
	end
end--]]

nut.command.add("setarmor", {
	adminOnly = true,
	syntax = "<string name> [number pierce] [number slash] [number crush]",
	onRun = function (client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local resistance = {
			[DMG_CLUB] = 1 - arguments[2] * 0.01,
			[DMG_SLASH] = 1 - arguments[3] * 0.01,
			[DMG_CRUSH] = 1 - arguments[4] * 0.01
		}
		target:getChar():setData("RPArmor", resistance)
	end
})


local playerMeta = FindMetaTable("Player")

function playerMeta:getArmor()
	return self.armor
end

if SERVER then
	function PLUGIN:EntityTakeDamage( entity, damage )
		if entity:IsPlayer() and (entity.armor or entity:getChar():getData("RPArmor")) then
			if entity:getChar():getData("RPArmor") then
				entity.armor = entity:getChar():getData("RPArmor")
			end
			local scale = 1
			local dmg = {
			[1] = DMG_CLUB,
			[2] = DMG_SLASH,
			[3] = DMG_CRUSH
			}
			if damage:GetAttacker():IsPlayer() and damage:GetAttacker():GetActiveWeapon().dmgtype then
				damage:SetDamageType(dmg[damage:GetAttacker():GetActiveWeapon().dmgtype or 2])
			end
			if damage:GetAttacker():IsPlayer() and damage:GetAttacker():GetActiveWeapon():GetClass() == "nut_hands" then
				damage:SetDamageType(DMG_CRUSH)
			end
			for k, v in pairs(entity:getChar():getInv():getItems()) do
				if v.armorclass and v:getData("equip", false) == true then
					if math.random(1, 5) == 1 and v:getData("durability", 100) ~= 0 and v.resistance[damage:GetDamageType()] then
						v:setData("durability", v:getData("durability", 100) - 1)
					end
				end
			end
			if entity.armor.suit and entity.armor.suit.resistance[damage:GetDamageType()] then
				local itemdur
				for k, v in pairs(entity:getChar():getInv():getItems()) do
					if v.armorclass == "suit" and v:getData("equip", false) == true then
						itemdur = v:getData("durability", 100)
					end
				end
				local res = entity.armor.suit.resistance[damage:GetDamageType()]
				scale = scale * (res + (1 - res) * 0.01 * (100 - itemdur))
			end
			if entity.armor.shield and entity.armor.shield.resistance[damage:GetDamageType()] and math.random(1, 100) + entity:getChar():getAttrib("shield", 0)/2 > 75 then
				local itemdur
				for k, v in pairs(entity:getChar():getInv():getItems()) do
					if v.armorclass == "shield" and v:getData("equip", false) == true then
						itemdur = v:getData("durability", 100)
					end
				end
				local res = entity.armor.shield.resistance[damage:GetDamageType()]
				scale = scale * (res + (1 - res) * 0.01 * (100 - itemdur))
				entity:getChar():updateAttrib("shield", math.random(0.01, 0.1))
				entity:EmitSound("hgn/crussaria/weapon/shield/wpn_block_shield_h_0"..math.random(1, 3)..".wav")
			end
			damage:ScaleDamage( scale )
		end
	end
end