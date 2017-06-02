
AddCSLuaFile()

SWEP.PrintName				= "Топор"
SWEP.Author				= "Dr. Towers"
SWEP.Instructions			= ""
SWEP.Category				= "WitcherRP"
SWEP.HoldType = "melee"
SWEP.Slot				= 1
SWEP.SlotPos				= 0

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_axe.mdl" )
SWEP.WorldModel				= Model( "models/weapons/HL2meleepack/w_axe.mdl" )
SWEP.ViewModelFOV			= 67
SWEP.UseHands				= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= false

SWEP.HitDistance		= 35
SWEP.HitInclination		= 0.4
SWEP.HitPushback		= 700
SWEP.HitRate			= 1.5

SWEP.dmgtype = 2

local SwingSound = Sound( "WeaponFrag.Roll" )
local HitSoundWorld = Sound( "physics/metal/metal_canister_impact_hard".. math.random(1,3) ..".wav" )
local HitSoundBody = Sound("npc/ministrider/flechette_flesh_impact1.wav")
local PushSoundBody = Sound( "Flesh.ImpactSoft" )

function SWEP:Initialize()

	self:SetHoldType( "melee2" )
end

function SWEP:PrimaryAttack()

	

	local vm = self.Owner:GetViewModel()
	local value = self.Owner:getLocalVar("stm", 0) - 35
	if (value < 0) then
		return
	end
	if (SERVER) then
		self.Owner:setLocalVar("stm", value)
		self.Owner:getChar():updateAttrib("str", 0.001)
	end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:EmitSound( SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("hitdelay", 0.4, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:SecondaryAttack()
end

function SWEP:OnDrop()

	
end

function SWEP:Hitscan()

//This function calculate the trajectory

	for i=0, 170 do

	local tr = util.TraceLine( {
		start = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)),
		endpos = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)) + ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.7 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) ),
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

//This if shot the bullets

	if ( tr.Hit ) then
		
		local strikevector = ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.5 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) )
		local skill = self.Owner:getChar():getAttrib("str")
		
		bullet = {}
		bullet.Num    = 1
		bullet.Src    = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 15))
		bullet.Dir    = strikevector:GetNormalized()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 30
		bullet.Hullsize = 0
		bullet.Distance = self.HitDistance * 1.5
		bullet.Damage = math.random( 15, 25 )
		self.Owner:FireBullets(bullet)
		
		//local vPoint = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10))
		//local effectdata = EffectData()
		//effectdata:SetOrigin( vPoint )
		//util.Effect( "BloodImpact", effectdata )

		self:EmitSound( SwingSound )

		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
			tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * self.HitPushback )
		elseif tr.Entity:GetClass() == "nut_tree" or tr.Entity:GetClass() == "nut_wood_node" then
			
		else
			self:EmitSound( HitSoundWorld )
		end
//if break
		break
//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
		end
end

end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )
	
	return true
end

function SWEP:Holster()

	return true
end

function SWEP:OnRemove()
	
	timer.Remove("hitdelay")
	return true
end