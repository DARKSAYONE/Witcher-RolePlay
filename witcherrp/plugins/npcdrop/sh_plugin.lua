PLUGIN.name = "Butcherable animals"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Butcher dead animals to get meat, bones and hides!"
local PLUGIN = PLUGIN

nut.corpse = {}
nut.corpse.deer = {
	"deer_meat",
	"deer_hide",
	"deer_sinew"
}

nut.corpse.goat = {
	"goat_meat",
	"goat_hide",
	"goat_horn"
}

nut.corpse.wolf = {
	"wolf_meat",
	"wolf_hide",
	"wolf_klik"
}

nut.corpse.bear = {
	"bear_meat",
	"bear_hide",
	"bear_fat"
}

nut.corpses = {
	["models/monsters/mdl_creature_wolf.mdl"] = "wolf",
	["models/monsters/mdl_creature_whtwolf.mdl"] = "whitewolf",
	["models/monsters/mdl_creature_slvrwolf.mdl"] = "silverwolf",
	["models/animals/deer.mdl"] = "deer",
	["models/animals/bear.mdl"] = "bear",
	["models/animals/goat.mdl"] = "goat"
}

nut.maxmeat = {
	["deer"] = 6,
	["wolf"] = 4,
	["goat"] = 5,
	["bear"] = 6
}

nut.animalsSkills = {
	["deer"] = 1.5,
	["wolf"] = 0.7,
	["goat"] = 1,
	["bear"] = 2

}

local playerMeta = FindMetaTable("Player")

function playerMeta:giveLoot(animal, chance, usingKnife)
	local meat = nut.corpse[animal][1]
	local leather = nut.corpse[animal][2]
	local rare = nut.corpse[animal][3]
	if (chance <= 60 and !usingKnife) or (chance <= 50 and usingKnife) then
		self:ChatPrint("Вам не удалось добыть что-либо.")
	else
		self:ChatPrint("Вам удалось добыть:")
	end
	local function addLoot(loot)
		if !self:getChar():getInv():add(loot) then
			nut.item.spawn(loot, self:getItemDropPos())
		else
		
		end
	end
	
	if chance > 60 then
		for i = 1, math.Clamp(math.floor((chance - 60)/10), 0, nut.maxmeat[animal]) do
			addLoot(meat)
		end
		self:ChatPrint(math.Clamp(math.floor((chance - 60)/10), 0, nut.maxmeat[animal]).." х "..nut.item.list[meat]:getName())
	end
	if usingKnife and chance > 50 then
		addLoot(leather)
		self:ChatPrint(nut.item.list[leather]:getName())
	end
	if animal == "deer" then
		chance = chance - 5
	end
	if usingKnife and chance > 85 then
		addLoot(rare)
		self:ChatPrint(nut.item.list[rare]:getName())
	end
end

function PLUGIN:KeyRelease(client, key)
	if (key == IN_USE) then
		local tr = client:GetEyeTraceNoCursor()
		local weapons = {
			["nut_saber_iron"] = -15,
			["nut_halberd_iron"] = -20,
			["nut_axe_iron2"] = -20,
			["nut_axe_iron"] = -5,
			["nut_long_iron"] = -10,
			["nut_short_iron"] = 0,
			["nut_dagger_iron"] = 5,
			["nut_dagger_ironknife"] = 10,
			["nut_broadsword_iron"] = - 10,
			["nut_claymore_imp"] = -25,
			["nut_dai_katana_witcher"] = -15,
			["nut_long_nilf"] = -10,
			["nut_short_nilf"] = 0,
			["nut_short_worn"] = -5,
			["nut_broadsword_rune"] = -5,
			["nut_claymore_nord"] = -20,
			["nut_halberd_steel"] = -25,
			["nut_saber_steel"] = -15,
			["nut_axe_steel2"] = -25,
			["nut_axe_steel"] = -5,
			["nut_claymore_steel"] = -20,
			["nut_long_steel"] = -15,
			["nut_dagger_steel"] = 10,
			["nut_short_steel"] = 0,
			["nut_dagger_steelknife"] = 15,
			["nut_broadsword_steel"] = -5,
			["nut_axe_hatchet"] = -5,
			["nut_claymore_family"] = -25,
			["nut_long_family"] = -15			
		}
		if tr.Hit and tr.Entity:GetClass() == "prop_ragdoll" and IsValid(tr.Entity) and nut.corpses[tr.Entity:GetModel()] and !tr.Entity.nutBeingUsed then
			if weapons[client:GetActiveWeapon():GetClass()] then
				local wep = client:GetActiveWeapon():GetClass()
				local entity = tr.Entity
				local time = 15 - 5 * 0.01 * client:getChar():getAttrib("hnt", 0) - weapons[client:GetActiveWeapon():GetClass()] * 0.2
				local chance = math.random(1, 100) + client:getChar():getAttrib("hnt", 0) / 2 + weapons[client:GetActiveWeapon():GetClass()]
				entity.nutBeingUsed = true
				if (SERVER) then
					client:setAction("Разделываю... ", time)
					client:doStaredAction(entity, function()
						for k, v in pairs(client:getChar():getInv():getItems()) do
							if v.class == wep and v:getData("equip") then
								v:setData("durability", math.Clamp(v:getData("durability", 100) - 2, 0, 100))
								if v:getData("durability", 100) <= 0 then
									local entity = client
									entity:notify("Инструмент пришел в негодность!")
									v:setData("equip", nil)

									entity.carryWeapons = entity.carryWeapons or {}
									v:setData("ammo", weapon:Clip1())

									entity:StripWeapon(v.class)
									entity.carryWeapons[v.weaponCategory] = nil
									entity:EmitSound("items/ammo_pickup.wav", 80)
									if (v.pacData) then
										entity:getChar():removePart(v.uniqueID)
									end
									
								end
							end
						end
						client:giveLoot(nut.corpses[entity:GetModel()], chance, weapons[wep] > 0)
						client:getChar():updateAttrib("hnt", nut.animalsSkills[nut.corpses[entity:GetModel()]])
						entity.nutBeingUsed = false
						entity:Remove()
					end, time, function()
						if (IsValid(entity)) then
							entity.nutBeingUsed = false
						end

						if (IsValid(client)) then
							client:setAction()
						end
					end)
				end
			else
				if (SERVER) then
					client:notify("Вы должны держать в руках подходящий инструмент для разделки!")
				end
			end
		end
	end
end

function PLUGIN:OnNPCKilled(npc, attacker, inflictor)
	if npc:GetClass() == "npc_wolf" then
		local corpse = ents.Create("prop_ragdoll")
		corpse:SetPos(npc:GetPos())
		corpse:SetAngles(npc:GetAngles())
		corpse:SetModel(npc:GetModel())
		corpse:Spawn()
	elseif npc:GetClass() == "npc_bear" then
		local corpse = ents.Create("prop_ragdoll")
		corpse:SetPos(npc:GetPos())
		corpse:SetAngles(npc:GetAngles())
		corpse:SetModel(npc:GetModel())
		corpse:Spawn()
	end
end