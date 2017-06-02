
	AddCSLuaFile()


	SWEP.PrintName = "Morrowind Halberd"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false

SWEP.dmgtype = 2
SWEP.Category = "Morrowind Halberds"
SWEP.Author			= "Neotanks+Doug Tyrrell + Mad Cow For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/halberd/halberd/v_halberd.mdl"
SWEP.WorldModel   = "models/morrowind/halberd/halberd/w_halberd.mdl"

SWEP.Primary.Damage		= 50
SWEP.Primary.NumShots		= 0

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

function SWEP:Precache()
	util.PrecacheSound("weapons/halberd/morrowind_halberd_deploy1.wav")
	util.PrecacheSound("weapons/halberd/morrowind_halberd_hitwall1.wav")
	util.PrecacheSound("weapons/halberd/morrowind_halberd_hit.wav")
	util.PrecacheSound("weapons/halberd/morrowind_halberd_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee2")
	self.Hit = { 
	Sound( "weapons/halberd/morrowind_halberd_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/halberd/morrowind_halberd_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/halberd/morrowind_halberd_deploy1.wav")
	return true
end



function SWEP:Holster()
	return true
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end