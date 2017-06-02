include("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self.LightSize = 700;
	self.nextFlicker = 0;
	self.working = true
	local lifetime = nut.config.get("campfireLifeTime")
	timer.Simple(lifetime, function()
		self.working = false
	end)
end;


-- Called when the entity should draw.
function ENT:Draw()
	self:DrawModel();
end;

-- Called when the entity should think.
function ENT:Think()
	if self.working then
		local dlight = DynamicLight( self:EntIndex() );
		
		if ( dlight ) then
			local r, g, b, a = self:GetColor();
			dlight.Pos = self:GetPos() + Vector(0,0,20);
			dlight.r = 255;
			dlight.g = 200;
			dlight.b = 15;
			dlight.Brightness = 1;
			dlight.Size = 1000;
			dlight.Decay = 7;
			dlight.DieTime = CurTime() + 5;
		end;	
	end
end;