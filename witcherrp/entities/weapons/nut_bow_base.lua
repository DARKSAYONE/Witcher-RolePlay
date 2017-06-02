AddCSLuaFile(  )
if( CLIENT ) then
	SWEP.PrintName = "Morrowind Bow"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	
	function SWEP:DrawHUD()
		local scrx = ScrW()/2
		local scry = ScrH()/2
		if self.Crosshair == true then
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawRect(scrx - 5 - 15, scry - 1, 15, 2)
			surface.DrawRect(scrx + 5, scry - 1, 15, 2)
			surface.DrawRect(scrx - 1, scry + 5, 2, 15)
			surface.DrawRect(scrx -1 , scry - 5 - 15, 2, 15)
		end
		local scrx = ScrW()
		local scry = ScrH()
		surface.SetDrawColor(255, 255, 255, 100)
		surface.DrawRect(scrx - 175, scry - 105, 108, 16)
		if self:GetDTFloat(0) != 0 then
			local ratio = math.Clamp((self.MaxHoldTime + CurTime() - self:GetDTFloat(0))/(self.MaxHoldTime * .5), .5, 1)
			ratio = 2 * (ratio - .5)
			surface.SetDrawColor(255, 0, 0, 180)
			surface.DrawRect(scrx - 171, scry - 103, 100 * ratio, 12)
		end
	end
end

SWEP.Category = "Morrowind Bows - LP FIX"
SWEP.Author			= ""
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/steel/shortbow/v_steel_shortbow.mdl"
SWEP.WorldModel   = "models/morrowind/steel/shortbow/w_steel_shortbow.mdl"

SWEP.Primary.Damage		= 50
SWEP.Primary.Delay 		= 2

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Velocity		= 3600				// Arrow speed.
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "XBowBolt"
SWEP.Primary.AmmoType		= "crossbow_bolt"
SWEP.Crosshair				= true

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.QuickFireRatio		= .9			// Changes quickfire damage/velocity, a ratio of normal damage/velocity.
SWEP.MaxHoldTime		= 10				// Must let go after this time. Determines damage/velocity based on time held.
//Do not touch.
//SWEP.FiredArrow			= false
SWEP.DelayTime			= 0
SWEP.dmgtype = 1
function SWEP:Precache()
	util.PrecacheSound("sound/weapons/bow/OUT.wav")
	util.PrecacheSound("sound/weapons/bow/PULL.wav")
	util.PrecacheSound("sound/weapons/bow/SHOOT.wav")
end

function SWEP:Initialize()
    --self:SetWeaponHoldType("pistol")
end

function SWEP:Equip()
	self:Deploy()
end

function SWEP:SetupDataTables()
	self:DTVar("Bool", 0, "FiredArrow")
	self:DTVar("Float", 0, "HoldTimer")
end

function SWEP:Deploy()
	self:EmitSound("weapons/bow/OUT.wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)	
	self.DelayTime = CurTime() + 1
//	local anim = self:LookupSequence("draw")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDTBool(0, false)
	self:SetDTFloat(0, 0)
	return true
end

function SWEP:Holster()
	return true
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
--[[function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
      
	if ( self.m_bInZoom && IsMultiplayer() ) then
//		self:FireSniperBolt();
		self:FireBolt();
	else
		self:FireBolt();
	end
	
	// Signal a reload
	self.m_bMustReload = true;

end

   function SWEP:FireBolt()

	if ( self.Weapon:Clip1() <= 0 && self.Primary.ClipSize > -1 ) then
	if ( self:Ammo1() > 3 ) then
			self:Reload();
	        self:ShootBullet( 150, 1, 0.01 )
		else
			self.Weapon:SetNextPrimaryFire( 5 );
		
		end

		return;
	end

	local pOwner = self.Owner;

	if ( pOwner == NULL ) then
		return;
	end

if ( !CLIENT ) then
	local vecAiming		= pOwner:GetAimVector();
	local vecSrc		= pOwner:GetShootPos();

	local angAiming;
	angAiming = vecAiming:Angle();

	local pBolt = ents.Create ( self.Primary.AmmoType );
	pBolt:SetPos( vecSrc );
	pBolt:SetAngles( angAiming );
	pBolt.Damage = self.Primary.Damage;
		self:ShootBullet( 150, 1, 0.01 )
    pBolt.AmmoType = self.Primary.Ammo;
	pBolt:SetOwner( pOwner );
	pBolt:Spawn()

	if ( pOwner:WaterLevel() == 3 ) then
		pBolt:SetVelocity( vecAiming * BOLT_WATER_VELOCITY );
	else
		pBolt:SetVelocity( vecAiming * BOLT_AIR_VELOCITY );
	end

end

	self:TakePrimaryAmmo( self.Primary.NumAmmo );

	if ( !pOwner:IsNPC() ) then
		pOwner:ViewPunch( Angle( -2, 0, 0 ) );
	end

	self.Weapon:EmitSound( self.Primary.Sound );
	self.Owner:EmitSound( self.Primary.Special2 );

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK );

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay );

	// self:DoLoadEffect();
	// self:SetChargerState( CHARGER_STATE_DISCHARGE );

end]]



function SWEP:PrimaryAttack()
	if self:Ammo1() < 1 then return end
	if self:GetDTFloat(0) != 0 then return end
	if self.Owner:KeyDown(IN_SPEED) then return end
	
	local anim = self.Owner:GetViewModel():LookupSequence("reload"..math.random(1,3))
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	self.Weapon:EmitSound("weapons/bow/PULL.wav")
	self.DelayTime = CurTime() + .5
	self:SetDTFloat(0, CurTime() + self.MaxHoldTime)
	self:SetNextPrimaryFire(self:GetDTFloat(0))
	self:SetNextSecondaryFire(self:GetDTFloat(0))
end

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()
	if !self.Owner:IsValid() or !self.Owner:IsPlayer() then return end

	if self.Owner:KeyDown(IN_SPEED) then
		--self:SetWeaponHoldType("normal")
	else
		--self:SetWeaponHoldType(self.HoldType)
	end

	if self:GetDTFloat(0) != 0 and self.DelayTime < CurTime() and self:GetDTBool(0) == false then
		if self.Owner:KeyDown(IN_ATTACK) then
			--local skill = self.Owner:getChar():getAttrib("bow", 0)
			--local value = self.Owner:getLocalVar("stm", 0) - 0.5 + skill*0.1
			--if (SERVER) then
			--	self.Owner:setLocalVar("stm", value)
			--end
			--if (self.Owner:getLocalVar("stm", 0) <= 0) then
			--	self:SetDTBool(1, true)
			--	return
			--end
			local skill = self.Owner:getChar():getAttrib("bow", 0)
			local value = self.Owner:getLocalVar("stm", 0) - 1 + skill*0.1
			if (SERVER) then
				self.Owner:setLocalVar("stm", math.Round(value))
			end			
			if self.Owner:getLocalVar("stm", 0) > 0 then
				self:SetDTBool(1, true)
				return
			end
		end
		if !self.Owner:KeyDown(IN_ATTACK) or self:GetDTFloat(0) < CurTime() or self:GetDTBool(1) then
			if SERVER then
				self:ShootArrow()
			end
			self:SetDTBool(0, true)
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
			self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootArrow()
   Desc: Hot Potato.
---------------------------------------------------------*/
function SWEP:ShootArrow()
	if self.DelayTime > CurTime() then return end
	local anim = self.Owner:GetViewModel():LookupSequence("shoot"..math.random(4,6))
	self.Owner:GetViewModel():SetSequence(anim)
	timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function()
		if !self.Owner then return end
		local anim = self.Owner:GetViewModel():LookupSequence("idle")
		self.Owner:GetViewModel():ResetSequence(anim)
//		self.Owner:GetViewModel():SetCycle(10)
	end)
	timer.Simple(.2, function()
		if !self.Owner then return end
		local ratio = math.Clamp((self.MaxHoldTime + CurTime() - self:GetDTFloat(0))/(self.MaxHoldTime * .5), .5, 1)
		self.Weapon:EmitSound("weapons/bow/SHOOT.wav")
	local pOwner = self.Owner;

	if ( pOwner == NULL ) then
		return;
	end
	local vecAiming		= pOwner:GetAimVector();
	local vecSrc		= pOwner:GetShootPos();

	local angAiming;
	angAiming = vecAiming:Angle();
	local skill = self.Owner:getChar():getAttrib("bow", 0)
		self.Owner:getChar():updateAttrib("bow", 0.1)
	local pBolt = ents.Create ( self.Primary.AmmoType );
	pBolt:SetPos( vecSrc );
	pBolt:SetAngles( angAiming );
	pBolt.Damage = self.Primary.Damage * ratio + skill * 0.25
		self:ShootBullet( pBolt.Damage, 1, 0.01 )
    pBolt.AmmoType = self.Primary.Ammo;
	pBolt:SetOwner( pOwner );
	pBolt:Spawn()
	pBolt:SetVelocity(vecAiming * self.Primary.Velocity * ratio)
		//		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self:SetDTFloat(0, 0)
		self:SetDTBool(0, false)
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
		self:TakePrimaryAmmo(1)
	end)
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	 if !self.Zoomed then -- The player is not zoomed in.
		self.Zoomed = true -- Now he is
		if SERVER then
			self.Owner:SetFOV( 35, 0.3 ) -- SetFOV is serverside only
		end
	else
		self.Zoomed = false
		if SERVER then
			self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
		end
	end
end

function SWEP:Reload()
end

function MorBowArrow(ent, ragdoll)
	if ent:IsNPC() then
		for k, v in pairs(ents.FindByClass("ent_mor_arrow")) do
			if v:GetParent() == ent then
				v:SetParent(ragdoll)
			end
		end
	end
end

hook.Add( "CreateEntityRagdoll", "MorBowArrow", MorBowArrow)