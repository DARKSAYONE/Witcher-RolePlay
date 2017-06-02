local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Древесина"
ENT.Author = "DrodA"
ENT.Category = "NutScript Mining System"
ENT.Spawnable = false

function ENT:Initialize()
	if (SERVER) then
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
			
		end
	end
end
function ENT:OnTakeDamage(dmg) -- предметы выпадают при ударе определенным классом оружия
	local player = dmg:GetAttacker()
	local skill = player:getChar():getAttrib("wdc", 0)
	
	local hatchets = {
		["nut_axe_hatchet"] = 10,
		["nut_axe_iron2"] = 5,
		["nut_axe_iron"] = 0,
		["nut_axe_steel2"] = 15,
		["nut_axe_steel"] = 10
	}
	
	if( player:IsPlayer() and IsValid(player:GetActiveWeapon()) and (hatchets[player:GetActiveWeapon():GetClass()])) then
		local chance = math.random(1, 100) + skill + hatchets[player:GetActiveWeapon():GetClass()]
		self:EmitSound("hgn/crussaria/weapon/axe/axe_chopwood" .. math.random(1, 2) .. ".wav")
		if (self:GetNetworkedInt("condition") == 0) then
			local mdl = self:GetModel()
			local id = self.id
			player:notify("Ресурс иссяк.")
			self:EmitSound("hgn/crussaria/world/cratedeath1.wav")
			self:Remove()
			timer.Simple(PLUGIN.tree[self:GetModel()].respawntime, function()
				local tree = ents.GetByIndex(id)
				if IsValid(tree) then
					tree:SetNoDraw(false)
					tree:PhysicsInit(SOLID_VPHYSICS)
					tree:SetSolid(SOLID_VPHYSICS)
					
					local physObj = tree:GetPhysicsObject()
					if (IsValid(physObj)) then
						physObj:EnableMotion(false)
						physObj:Sleep()
					end
					tree.HP = PLUGIN.tree[tree:GetModel()].hp
				end
			end)
		else
			if (chance > 60) and (chance <= 90) then
				player:getChar():getInv():add("wood")
				self:SetNetworkedInt("condition", self:GetNetworkedInt("condition") - 1)
				player:notify("Вы добыли древесину.")
				player:getChar():updateAttrib("wdc", 0.1)			
			elseif (chance > 90) and (chance <=100) then
				player:getChar():getInv():add("pitch")
				self:SetNetworkedInt("condition", self:GetNetworkedInt("condition") - 1)
				player:notify("Вы добыли немного смолы.")
				player:getChar():updateAttrib("wdc", 0.2)
			end
		end
	end
end