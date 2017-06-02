
	AddCSLuaFile()



	SWEP.PrintName = "Morrowind Hammer"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
SWEP.dmgtype = 3
SWEP.Category = "Morrowind Hammers"
SWEP.Author			= "Neotanks+Doug Tyrrell + Mad Cow For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.HoldType = "melee"
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/hammer/hammer/v_hammer.mdl"
SWEP.WorldModel   = "models/morrowind/hammer/hammer/w_hammer.mdl"

SWEP.Primary.NumShots		= 0
SWEP.Primary.Delay 		= 0.50

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

function SWEP:Precache()
	util.PrecacheSound("weapons/hammer/morrowind_hammer_deploy1.wav")
	util.PrecacheSound("weapons/hammer/morrowind_hammer_hitwall1.wav")
	util.PrecacheSound("weapons/hammer/morrowind_hammer_hit.wav")
	util.PrecacheSound("weapons/hammer/morrowind_hammer_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee2")
	self.Hit = { 
	Sound( "weapons/hammer/morrowind_hammer_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/hammer/morrowind_hammer_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/hammer/morrowind_hammer_deploy1.wav")
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