AddCSLuaFile()

SWEP.PrintName = "Нильфгаардский лук"
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
  
SWEP.ViewModel      = "models/morrowind/ariel/longbow/v_ariel_longbow.mdl"
SWEP.WorldModel   = "models/morrowind/ariel/longbow/w_ariel_longbow.mdl"

SWEP.Primary.Damage		= 65
SWEP.Primary.Delay 		= 2
SWEP.Primary.Velocity 		= 3000

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "XBowBolt"
SWEP.Crosshair				= true

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"