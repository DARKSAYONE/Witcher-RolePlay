ENT.Type = "anim"
ENT.PrintName = "Курочка"
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
		self:SetModel("models/aoc_animated/chicken_01.mdl")	
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetNetworkedBool("Usable", true)
		self:SetPersistent(true)
		self:Fire("SetAnimation", "ACT_IDLE2", 0)
		self:Activate()

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:Use(activator)
	if self:GetNetworkedBool("Usable") == true then
		self:SetNetworkedBool("Usable", false)
		activator:setAction("Собираю яйца...", 15)
		activator:doStaredAction(self, 
		function()
			if activator:getChar():getInv():add("egg") then
				activator:notify("Вы собрали яиц.")
			else
				activator:notify("Вам не хватает места в инвентаре!")
			end
			
			timer.Simple(math.random(180, 600), function()
				self:SetNetworkedBool("Usable", true)
			end)
		end, 15, 
		function()
			self:SetNetworkedBool("Usable", true)
			if (IsValid(activator)) then
				activator:setAction()
			end
		end)
	else
		activator:notify("Курочка еще не готова!")
	end
end
function ENT:OnRemove()
	self:SetNetworkedBool("Usable", true)
end