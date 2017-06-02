
	AddCSLuaFile()



	SWEP.PrintName = "Morrowind Longswords"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false

SWEP.dmgtype = 2
SWEP.Category = "Morrowind Longswords"
SWEP.Author			= "Doug Tyrrell + Mad Cow (Revisions by Neotanks) For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.HoldType = "melee"
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/steel/longsword/v_steel_longsword.mdl"
SWEP.WorldModel   = "models/morrowind/steel/longsword/w_steel_longsword.mdl"


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
	util.PrecacheSound("weapons/longsword/morrowind_longsword_deploy1.wav")
	util.PrecacheSound("weapons/longsword/morrowind_longsword_hitwall1.wav")
	util.PrecacheSound("weapons/longsword/morrowind_longsword_hit.wav")
	util.PrecacheSound("weapons/longsword/morrowind_longsword_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee")
	self.Hit = { 
	Sound( "weapons/longsword/morrowind_longsword_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/longsword/morrowind_longsword_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/longsword/morrowind_longsword_deploy1.wav")
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