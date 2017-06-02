
	AddCSLuaFile()



	SWEP.PrintName = "Morrowind Shortsword"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false


SWEP.Category = "Morrowind Shortswords"
SWEP.Author			= "Doug Tyrrell + Mad Cow (Revisions by Neotanks) For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.HoldType = "melee"
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/dwemer/shortsword/v_dwemer_shortsword.mdl"
SWEP.WorldModel   = "models/morrowind/dwemer/shortsword/w_dwemer_shortsword.mdl"

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
SWEP.dmgtype = 2
function SWEP:Precache()
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_deploy1.wav")
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_hitwall1.wav")
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_hit.wav")
	util.PrecacheSound("weapons/shortsword/morrowind_shortsword_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee")
	self.Hit = { 
	Sound( "weapons/shortsword/morrowind_shortsword_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/shortsword/morrowind_shortsword_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/shortsword/morrowind_shortsword_deploy1.wav")
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