AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Furniture"
ENT.Author = "AleXXX_007"
ENT.Category = "NutScript"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_BOTH


if (SERVER) then
	function ENT:Initialize()
	end
	
	function ENT:OnRemove()
	end
	
	function ENT:Draw()
		self:DrawModel()
	end
	
	function ENT:Use(activator)
		local act = activator:getChar():getID()
		local own = self:getNetVar("ownerChar")
		if (act == own) and (self:IsValid() == true) then
			if (self:GetNetVar("placed") == false) then
				self:SetMaterial(self:GetVar("selfMaterial"))
				self:setNetVar("placed", true)
				activator:EmitSound("physics/wood/wood_box_impact_hard".. math.random(1, 6) ..".wav")
				
				local physObj = self:GetPhysicsObject()
				if (IsValid(physObj)) then
					physObj:EnableMotion(false)
					physObj:Sleep()
				end
				return
			else
			if (activator:KeyDown(IN_WALK)) then
				activator:setAction("Передвигаем мебель...", 7)
				activator:doStaredAction(self, function()
					if (!activator:getChar():getInv():add(self:getNetVar("ItemId"))) then
						activator:notify("Вам не хватает места в инвентаре!")
						return
					else
						self:Remove()
						return
					end	
				end, 7, function()
					if (IsValid(activator)) then
						activator:setAction()
					end		
				end)
			end
			self:SetMaterial("models/wireframe")
			activator:EmitSound("physics/wood/wood_box_impact_soft".. math.random(1, 6) ..".wav")
			self:setNetVar("placed", false)
			
			local physObj = self:GetPhysicsObject()
				if (IsValid(physObj)) then
					physObj:EnableMotion(true)
					physObj:Wake()
				end		
			return
			end
		end
		return
	end
end

function ENT:getItem()
	return self:getNetVar("ItemId")
end

function ENT:getOwner()
	return self:getNetVar("ownerChar")
end

