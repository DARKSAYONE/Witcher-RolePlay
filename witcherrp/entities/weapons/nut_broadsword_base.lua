
AddCSLuaFile()

SWEP.PrintName = "Morrowind Broadsword"
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.Category = "Morrowind Broadswords"
SWEP.Author			= "Doug Tyrrell + Mad Cow (Revisions by Neotanks) For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.HoldType = "melee"
SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.ViewModel      = "models/morrowind/iron/broadsword/v_iron_broadsword.mdl"
SWEP.WorldModel   = "models/morrowind/iron/broadsword/w_iron_broadsword.mdl"

SWEP.Primary.NumShots		= 0
SWEP.Primary.Delay 		= 1

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
	util.PrecacheSound("weapons/broadsword/morrowind_broadsword_deploy1.wav")
	util.PrecacheSound("weapons/broadsword/morrowind_broadsword_hitwall1.wav")
	util.PrecacheSound("weapons/broadsword/morrowind_broadsword_hit.wav")
	util.PrecacheSound("weapons/broadsword/morrowind_broadsword_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("melee")
	self.Hit = { 
	Sound( "weapons/broadsword/morrowind_broadsword_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/broadsword/morrowind_broadsword_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/broadsword/morrowind_broadsword_deploy1.wav")
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