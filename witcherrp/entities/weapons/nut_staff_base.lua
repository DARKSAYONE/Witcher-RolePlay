
	AddCSLuaFile()



	SWEP.PrintName = "Morrowind Staff"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false


SWEP.Category = "Morrowind Staffs"
SWEP.Author			= "Doug Tyrrell + Mad Cow For LUA (Models, Textures, ect. By: Hellsing/JJSteel)"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.ViewModel      = "models/morrowind/staff/staff/v_staff.mdl"
SWEP.WorldModel   = "models/morrowind/staff/staff/w_staff.mdl"

SWEP.Primary.NumShots		= 0
SWEP.Primary.Delay 		= 1.5

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"
SWEP.dmgtype = 3
function SWEP:Precache()
	util.PrecacheSound("weapons/staff/morrowind_staff_deploy1.wav")
	util.PrecacheSound("weapons/staff/morrowind_staff_hitwall1.wav")
	util.PrecacheSound("weapons/staff/morrowind_staff_hit.wav")
	util.PrecacheSound("weapons/staff/morrowind_staff_slash.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType("pistol")
	self.Hit = { 
	Sound( "weapons/staff/morrowind_staff_hitwall1.wav" )}
	self.FleshHit = {
  	Sound("weapons/staff/morrowind_staff_hit.wav") }
end

function SWEP:Deploy()
	self.Owner:EmitSound("weapons/staff/morrowind_staff_deploy1.wav")
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