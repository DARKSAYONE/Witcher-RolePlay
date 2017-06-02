
	AddCSLuaFile()

	SWEP.PrintName = "Morrowind Claymores"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false


SWEP.Category = "Morrowind Claymores"
SWEP.Author			= "Doug Tyrrell + Mad Cow (Revisions by Neotanks) For LUA (Models, Textures, ect. By: Hellsing/JJiron)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.HoldType = "melee"
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/iron/claymore/v_iron_claymore.mdl"
SWEP.WorldModel   = "models/morrowind/iron/claymore/w_iron_claymore.mdl"

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
	util.PrecacheSound("weapons/claymore/morrowind_claymore_deploy1.wav")
	util.PrecacheSound("weapons/claymore/morrowind_claymore_hitwall1.wav")
	util.PrecacheSound("weapons/claymore/morrowind_claymore_hit.wav")
	util.PrecacheSound("weapons/claymore/morrowind_claymore_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee2")
	self.Hit = { 
	Sound( "weapons/claymore/morrowind_claymore_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/claymore/morrowind_claymore_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/claymore/morrowind_claymore_deploy1.wav")
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