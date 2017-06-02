ENT.Type = "anim"
ENT.PrintName = "Колодец"
ENT.Author = "AleXXX_007"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/aoc_outdoor/well_01.mdl")	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetPersistent(true)
		self:Activate()

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:Use(activator)
	activator:setAction("Сбор воды...", 10)
	activator:doStaredAction(self, function()
		for k, v in pairs(activator:getChar():getInv():getItems()) do
			if v.uniqueID == "water" then
				v:setData("quantity", 4)
			elseif v.uniqueID == "water_empty" then
				v:remove()
				activator:getChar():getInv():add("water")				
			end
		end		
		activator:getChar():restoreThirst(100)
		activator:EmitSound("player/footsteps/slosh".. math.random(1, 4) ..".wav")
		activator:notify("Набрали воды и напились.")
	end, 10, function()
		if (IsValid(activator)) then
			activator:setAction()
		end
	end)
end