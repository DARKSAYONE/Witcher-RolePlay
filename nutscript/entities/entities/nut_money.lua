AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Money"
ENT.Category = "NutScript"
ENT.Spawnable = false

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/items/jewels/purses/big_purse.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		else
			local min, max = Vector(-8, -8, -8), Vector(8, 8, 8)

			self:PhysicsInitBox(min, max)
			self:SetCollisionBounds(min, max)
		end
	end

	function ENT:Use(activator)
		if (hook.Run("OnPickupMoney", activator, self) != false) then
			self:Remove()
			activator:EmitSound("hgn/crussaria/items/itm_gold_up.wav")
		end
	end
else
	ENT.DrawEntityInfo = true

	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y

		drawText(nut.currency.get(self.getAmount(self)), x, y, colorAlpha(configGet("color"), alpha), 1, 1, "nutSmallFont", alpha * 0.65)
	end
end

function ENT:setAmount(amount)
	self:setNetVar("amount", amount)
end

function ENT:getAmount(amount)
	return self:getNetVar("amount", 0)
end