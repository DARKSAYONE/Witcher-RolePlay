ENT.Type = "anim"
ENT.PrintName = "Руда"
ENT.Author = "DrodA"
ENT.Category = "NutScript Mining System"
ENT.Spawnable = true
ENT.AdminOnly = true

if (CLIENT) then
	function ENT:Draw()
		local mypos = self:GetPos()
		local dist = LocalPlayer():GetPos():Distance(mypos)

		if(dist < 5000) then
			self.Entity:DrawModel()
		end
	end
end

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/prop/junk/unique_rock01.mdl") --В строгом порядке изменить модель!
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetPersistent(true)
		self:SetNetworkedInt("condition", math.random(2, 7))
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:OnTakeDamage(dmg) -- предметы выпадают при ударе определенным классом оружия
	local player = dmg:GetAttacker()
	local skill = player:getChar():getAttrib("mng")
	if (skill == nil) then
		skill = 0
	end
	local chance = math.random(1, 100) + skill/2
	local comore = {
		"stone",
		"coal",
	}
	local uncore = {
		"ore_iron"
	}
	local rarore = {
		"ore_gold",
		"ore_silver",
		"dwimeriteore"	
	}
	if( player:IsPlayer() and IsValid(player:GetActiveWeapon()) and (player:GetActiveWeapon():GetClass() == "nut_pickaxe")) then
		self:EmitSound("physics/concrete/concrete_break" .. math.random(2, 3) .. ".wav")
		if (self:GetNetworkedInt("condition") == 0) then
			player:notify("Ресурс иссяк.")
			timer.Simple(600, function()
				self:SetNetworkedInt("condition", math.random(2, 7))
			end)
		else
		local com = table.Random(comore)
		local unc = table.Random(uncore)
		local rar = table.Random(rarore)
		local com1 = table.Random(comore)
		local unc1 = table.Random(uncore)
		local rar1 = table.Random(rarore)
			if chance < 50 then
				for k, v in pairs(player:getChar():getInv():getItems()) do
					if v.class == "nut_pickaxe" and v:getData("equip") ==  true then
						v:setData("durability",	math.Clamp(v:getData("durability", 100) - 1, 0, 100))
						if v:getData("durability", 100) == 0 then
							local entity = player
							entity:notify("Инструмент пришел в негодность!")
							v:setData("equip", nil)

							entity.carryWeapons = entity.carryWeapons or {}
							entity:StripWeapon(v.class)
							entity.carryWeapons[v.weaponCategory] = nil
							entity:EmitSound("items/ammo_pickup.wav", 80)
							if (v.pacData) then
								entity:getChar():removePart(v.uniqueID)
							end
						end
					end
				end
				return
			end
			if chance >= 50 and chance < 80 then
				player:getChar():getInv():add(com)
				player:notify("Вы добыли руду.")
			elseif chance >= 80 and chance <95 then
				player:getChar():getInv():add(unc)
				player:notify("Вы добыли руду.")
			elseif chance >= 95 and chance <100 then
				player:getChar():getInv():add(rar)
				player:notify("Вы добыли руду.")
			elseif chance >= 100 and chance < 110 then
				player:getChar():getInv():add(com)
				player:getChar():getInv():add(com1)
				player:notify("Вы добыли руду.")
			elseif chance >= 110 and chance < 120 then
				player:getChar():getInv():add(com)
				player:getChar():getInv():add(unc)
				player:notify("Вы добыли руду.")
			elseif chance >= 120 and chance < 130 then
				player:getChar():getInv():add(unc)
				player:getChar():getInv():add(unc1)
				player:notify("Вы добыли руду.")
			elseif chance >= 130 and chance < 140 then
				player:getChar():getInv():add(unc)
				player:getChar():getInv():add(rar)
				player:notify("Вы добыли руду.")
			elseif chance >=140 and chance <= 150 then
				player:getChar():getInv():add(rar)
				player:getChar():getInv():add(rar1)
				player:notify("Вы добыли руду.")
			end
			self:SetNetworkedInt("condition", self:GetNetworkedInt("condition") - 1)
			player:getChar():updateAttrib("mng", 0.05)
		end
	end
end