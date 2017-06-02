ENT.Type = "anim"
ENT.PrintName = "Растущая травка"
ENT.Author = "DrodA"
ENT.Category = "NutScript Farming System"
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/aoc_trees/aoc_lowveg14.mdl") --В строгом порядке изменить модель!
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON ) -- Позволяет пройти насквозь объекта (Отличное решение, если объектов много, а пройти невозможно)
		self:SetModelScale(0.25)
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:Think()
	if self:getNetVar("spawn") and self:getNetVar("grow") and self:getNetVar("grow") > CurTime() then
		local GrowthPercent = (CurTime() - self:getNetVar("spawn")) / (self:getNetVar("grow") - self:getNetVar("spawn"))
	 
		if GrowthPercent <= 1 then
			self:SetModelScale(math.max(1 * GrowthPercent, 0.1))
		end
	end
end

function ENT:OnTakeDamage(dmg)
	local player = dmg:GetAttacker()
	if( player:IsPlayer() ) then self:Remove() end
end

function ENT:Use(activator)	
	local gathertime = math.random(11, 25) - math.floor(activator:getChar():getAttrib("frm", 0)/10)
	local chance = math.random(1, 100) + math.floor(activator:getChar():getAttrib("frm", 0)/2)
	if self:getNetVar("grow") <= CurTime() and !self.isGathering then
		self.isGathering = true
		activator:setAction("Собираем урожай...", gathertime)
		activator:doStaredAction(self, function()
			self:EmitSound("player/footsteps/grass"..math.random(1, 4)..".wav")
			activator:getChar():updateAttrib("frm", math.random(0.1, 0.7))
			local item = nut.item.list[self.uid]
			local items = item.BadGathering
			if chance < 40 then
				activator:notify("Вам удалось собрать лишь семена.")
			elseif chance > 40 and chance < 80 then
				items = item.CommonGathering
				activator:notify("Вы успешно собрали урожай.")
			elseif chance >= 80 then
				items = item.MasterGathering
				activator:notify("Вы мастерски собрали урожай.")
			end
			for i = 1, #items do
				if !activator:getChar():getInv():add(items[i]) then
					nut.item.spawn(items[i], player:getItemDropPos())
				else
				
				end
			end
			self:Remove()
		end, gathertime, function()
			self.isGathering = false
		
			if IsValid(activator) then
				activator:setAction()
			end
		end)
	else
		activator:notify("Растение еще не созрело. Нужно подождать еще немного.")
	end
end

