include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/aoc_objects/fire1.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_NONE);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE)
	self:SetSkin(2)
	self:GetAngles(Angle(-5,0,0));
	local phys = self:GetPhysicsObject();
	if phys:IsValid() then
		phys:Wake();
		phys:EnableMotion(false);
	end;

	self.amb = CreateSound( self , "ambient/fire/fire_small1.wav" );
	self.amb:Play()
	
	self.working = true
	local lifetime = nut.config.get("campfireLifeTime")
	timer.Simple(lifetime, function()
		self.amb:Stop()
		self.working = false
	end)
	
	self.flame = ents.Create("env_fire");
	self.flame:SetKeyValue("health", lifetime);
	self.flame:SetKeyValue("duration",100);
	self.flame:SetKeyValue("firesize",25);
	self.flame:SetKeyValue("fireattack",15);
	self.flame:SetKeyValue("damagescale",0.5);
	self.flame:SetPos(self:GetPos() + Vector(0,0,80));
	self.flame:SetParent(self);
	self.flame:Spawn();
	self.flame:Activate()
	self.flame:Fire("StartFire","",0);
end;

function ENT:Use(activator)
	if activator:KeyDown(IN_WALK) then
		activator:setAction("Убираем...", math.random(5, 10), function()
		self:Remove()
	end)
	return
	end
	if self.working then
		activator:getChar():setData("CraftPlace", 2)
		netstream.Start( activator, "nut_CraftWindow", activator)
		netstream.Hook("nut_CraftWindow", function(client, data)
		if (IsValid(nut.gui.crafting)) then
			nut.gui.crafting:Remove()
			return
		end
		surface.PlaySound( "items/ammocrate_close.wav" )
		nut.gui.crafting = vgui.Create("nut_Crafting")
		nut.gui.crafting:Center()
		end)
	end
end

function ENT:OnRemove()
	self.amb:Stop();
end;
