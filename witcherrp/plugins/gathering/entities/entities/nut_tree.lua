local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Дерево"
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
		self:SetModel(table.Random(PLUGIN.TreeModels))
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetPersistent(true)
		self.HP = PLUGIN.tree[self:GetModel()].hp
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end
function ENT:OnTakeDamage(dmg)
	local player = dmg:GetAttacker()
	local hatchets = {
		["nut_axe_hatchet"] = 10,
		["nut_axe_iron2"] = 5,
		["nut_axe_iron"] = 0,
		["nut_axe_steel2"] = 15,
		["nut_axe_steel"] = 10
	}	

	if( player:IsPlayer() and IsValid(player:GetActiveWeapon()) and (hatchets[player:GetActiveWeapon():GetClass()])) then
		if self.HP > 0 then
			self:EmitSound("hgn/crussaria/weapon/axe/axe_chopwood" .. math.random(1, 2) .. ".wav")
			self.HP = self.HP - 1
			if self.HP == 0 then
				local tree = ents.Create("nut_wood_node")
				tree:Spawn()				
				tree:SetModel(self:GetModel())
				tree:SetAngles(self:GetAngles())
				tree:SetPos(self:GetPos())
				tree:PhysicsInit(SOLID_VPHYSICS)
				tree:SetSolid(SOLID_VPHYSICS)
				tree.id = self:EntIndex()
				tree:SetNetworkedInt("condition", PLUGIN.tree[self:GetModel()].condition)
				
				local physObj = tree:GetPhysicsObject()

				local data = {}
					data.start = player:GetPos()
					data.endpos = self:GetPos()
					data.filter = player
				local trace = util.TraceLine(data)
				
				if (IsValid(physObj)) then
					physObj:EnableMotion(true)
					physObj:Wake()
					physObj:SetMass(300)
					physObj:AddVelocity(trace.Normal * 95)
					physObj:AddAngleVelocity(trace.Normal * 95)
				end				
				self.effect = CreateSound( self , "hgn/crussaria/world/treefall3.wav" );
				self.effect:Play()
				timer.Simple(1.25, function()
					self.effect:Stop()
				end)
				self:DeleteOnRemove(tree)
				
				self:SetNoDraw(true)
				self:PhysicsInit(SOLID_NONE)
				
			end
		end
		--[[self:EmitSound("physics/wood/wood_plank_break" .. math.random(1, 4) .. ".wav")
		if (self:GetNetworkedInt("condition") == 0) then
			player:notify("Ресурс иссяк.")
			local pos = self.spawnPos
			self:Remove()
			timer.Simple(5, function()
				local tree = ents.Create("nut_tree")
				tree:SetPos(pos)
				tree:Spawn()
			end)
		else
			if (chance > 60) and (chance <= 90) then
				player:getChar():getInv():add("wood")
				self:SetNetworkedInt("condition", self:GetNetworkedInt("condition") - 1)
				player:notify("Вы добыли древесину.")
				player:getChar():updateAttrib("wdc", 0.1)
				end
			if (chance > 90) and (chance <=100) then
				player:getChar():getInv():add("pitch")
				self:SetNetworkedInt("condition", self:GetNetworkedInt("condition") - 1)
				player:notify("Вы добыли немного смолы.")
				player:getChar():updateAttrib("wdc", 0.2)
			end
			if (chance < 10) then
				self:SetNetworkedInt("condition", self:GetNetworkedInt("condition") - 1)
			end
		end--]]
	end
end

function ENT:OnRemove()
	if self.effect and self.effect:IsPlaying() then
		self.effect:Stop()
	end
end