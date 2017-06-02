ENT.Type = "anim"
ENT.PrintName = "Мишень"
ENT.Author = "AleXXX_007"
ENT.Category = "NutScript"
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
		self:SetModel("models/aoc_arena/aoc_target01.mdl") --В строгом порядке изменить модель!
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetPersistent(true)
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:OnTakeDamage(dmg) 
	local player = dmg:GetAttacker()
	if player:IsPlayer() and IsValid(player:GetActiveWeapon()) then
	--	player:ChatPrint(dmg:GetDamage())
		local attrib
		for k, v in pairs(self:getChar():getInv():getItems()) do
			if v.type == "1h" and v:getData("equip") == true and v.class == self:GetActiveWeapon():GetClass() then
				attrib = "onehanded"
			elseif v.type == "2h" and v:getData("equip") == true and v.class == self:GetActiveWeapon():GetClass() then
				if table.HasValue(bows, self:GetActiveWeapon():GetClass()) then
					attrib = "bow"
				else
					attrib = "twohanded"
				end
			end
		end
		if !attrib then
			attrib = "melee"
		end
		player:getChar():updateAttrib(attrib, math.random(0.01, 0.05))
	end
end