AddCSLuaFile()

SWEP.PrintName = "Ясеневый лук"
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false


SWEP.Category = "WitcherRP"
SWEP.Author			= ""
SWEP.Base			= "nut_bow_base"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
  
SWEP.ViewModel      = "models/morrowind/artifacts/longbow/v_bow_of_shades.mdl"
SWEP.WorldModel   = "models/morrowind/artifacts/longbow/w_bow_of_shadows.mdl"

SWEP.Primary.Damage		= 55
SWEP.Primary.Delay 		= 2
SWEP.Primary.Velocity 		= 2800

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "XBowBolt"
SWEP.Crosshair				= true
SWEP.dmgtype = 1
SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"