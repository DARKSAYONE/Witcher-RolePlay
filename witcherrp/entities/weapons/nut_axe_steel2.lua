
	AddCSLuaFile()



	SWEP.PrintName = "Стальная секира"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false


SWEP.Category = "WitcherRP"
SWEP.Author			= ""
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.HoldType = "melee"
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;
  
SWEP.ViewModel      = "models/morrowind/steel/battleaxe/v_steelbattleaxe.mdl"
SWEP.WorldModel   = "models/morrowind/steel/battleaxe/w_steelbattleaxe.mdl"
  
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 0.5

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "XBowBolt"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.RunArmOffset 		= Vector (0.3671, 0.1571, 5.7856)
SWEP.RunArmAngle	 		= Vector (-37.4833, 2.7476, 0)

SWEP.Sequence			= 0

SWEP.dmgtype = 2
util.PrecacheSound("weapons/axe/morrowind_axe_deploy1.wav")
util.PrecacheSound("weapons/axe/morrowind_axe_hitwall1.wav")
util.PrecacheSound("weapons/axe/morrowind_axe_hit.wav")
util.PrecacheSound("weapons/axe/morrowind_axe_slash.wav")

function SWEP:Initialize()
    	self:SetWeaponHoldType("melee2")
	self.Hit = { 
	Sound( "weapons/axe/morrowind_axe_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/axe/morrowind_axe_hit.wav") }
end


function SWEP:Precache()
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/axe/morrowind_axe_deploy1.wav")
	return true
end

function SWEP:PrimaryAttack()
	if( CurTime() < self.NextStrike ) then return; end
	
 	local trace = self.Owner:GetEyeTrace()
	local value = self.Owner:getLocalVar("stm", 0) - 50
	if (value < 0) then
		return
	end
	if (SERVER) then
		self.Owner:setLocalVar("stm", value)
		self.Owner:getChar():updateAttrib("str", 0.001)
	end
	self.NextStrike = ( CurTime() + .5 )
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 100 then
		if( trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:GetClass()=="prop_ragdoll" ) then
			self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] )
		else
			self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] )
		end
		

			local skill = self.Owner:getChar():getAttrib("str", 0)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 1
				bullet.Damage = math.random( 45, 55 )
			self.Owner:FireBullets(bullet) 
	else
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Weapon:EmitSound("weapons/axe/morrowind_axe_slash.wav")
	end
end

function RemoveKnife( ent )
	if ent:IsValid() then
		ent:Remove()
	end
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

end