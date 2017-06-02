AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Ключи"
	SWEP.Slot = 0
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end;

SWEP.Author = "Vex"
SWEP.Instructions = "ЛКМ: Закрыть/Открыть\nR: Связка ключей"
--SWEP.Purpose = "Hitting things and knocking on doors."
SWEP.Drop = false

SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.ViewTranslation = 4

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 5
SWEP.Primary.Delay = 0.75

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = Model("models/weapons/c_arms_cstrike.mdl")
SWEP.WorldModel = ""

SWEP.UseHands = true
SWEP.LowerAngles = Angle(0, 5, -14)
SWEP.LowerAngles2 = Angle(0, 5, -22)

SWEP.IsAlwaysLowered = true
SWEP.FireWhenLowered = true
SWEP.HoldType = "fist"

function SWEP:PreDrawViewModel(viewModel, weapon, client)
	local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(client:GetModel()))

	if (hands and hands.model) then
		viewModel:SetModel(hands.model)
		viewModel:SetSkin(hands.skin)
		viewModel:SetBodyGroups(hands.body)
	end;
end;

ACT_VM_FISTS_DRAW = 3
ACT_VM_FISTS_HOLSTER = 2

function SWEP:Deploy()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
	end

	return true
end;

function SWEP:Holster()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
	end

	return true
end;

function SWEP:Precache()
end;

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end;

function SWEP:PrimaryAttack()
	local time = 2

	self:SetNextPrimaryFire(CurTime() + 2)
	self:SetNextSecondaryFire(CurTime() + 2)

	if (!IsFirstTimePredicted()) then
		return
	end;

	if (CLIENT) then
		return
	end;

	local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector() * 96
		data.filter = self.Owner
		
	local entity = util.TraceLine(data).Entity

	if (IsValid(entity) and entity:isDoor()) then
		local data = entity:getNetVar("doorData") or {}

		local faction
		if data["factionID"] then
			for _, v in pairs(nut.faction.indices) do
				if (v.uniqueID == data["factionID"]) then
					faction = v.index
					break
				end;
			end;
		end
		
		if (self.Owner:getChar():hasKey(data["lockedid"])) then
			if (data["locked"]) then
				self.Owner:setAction("Открываем...", time)
				self.Owner:doStaredAction(entity, function()
					data["locked"] = nil
					entity:setNetVar("doorData", data)
					entity:Fire("unlock")
					self.Owner:emote("unlock")
					self.Owner:EmitSound("hgn/crussaria/devices/unlockdoor_key.wav")
				end, time, function()
					if (IsValid(self.Owner)) then
						self.Owner:setAction()
					end
				end)
			else
				self.Owner:setAction("Закрываем...", time)
				self.Owner:doStaredAction(entity, function()
					data["locked"] = true
					entity:setNetVar("doorData", data)
					self.Owner:emote("lock")
					entity:Fire("lock")
					self.Owner:EmitSound("hgn/crussaria/devices/lock_door_01.wav")
				end, time, function()
					if (IsValid(self.Owner)) then
						self.Owner:setAction()
					end
				end)
			end;
		end;
	elseif (IsValid(entity) and entity:GetClass() == "nut_container") then		
		if (self.Owner:getChar():hasKey(entity.lockedid)) then
			if (entity:getNetVar("locked")) then
				self.Owner:setAction("Открываем...", time)
				self.Owner:doStaredAction(entity, function()
					entity:setNetVar("locked", false)
					self.Owner:emote("unlock")
					self.Owner:EmitSound("hgn/crussaria/devices/unlockdoor_key.wav")
				end, time, function()
					if (IsValid(self.Owner)) then
						self.Owner:setAction()
					end
				end)
			else
				self.Owner:setAction("Закрываем...", time)
				self.Owner:doStaredAction(entity, function()
					entity:setNetVar("locked", true)
					self.Owner:emote("lock")
					self.Owner:EmitSound("hgn/crussaria/devices/lock_door_01.wav")
				end, time, function()
					if (IsValid(self.Owner)) then
						self.Owner:setAction()
					end
				end)
			end;
		end;
		
	end
end;

function SWEP:SecondaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2)
	self:SetNextSecondaryFire(CurTime() + 2)

	if (!IsFirstTimePredicted()) then
		return
	end;
	
	if (CLIENT) then
		return
	end;
	
	local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector() * 96
		data.filter = self.Owner
		
	local entity = util.TraceLine(data).Entity

	if (IsValid(entity) and entity:isDoor()) then
		--netstream.Start(self.Owner, "openDoorManager", entity)
	end;
end;
--[[
SWEP.nextReload = 0

function SWEP:Reload()
	if self.nextReload > CurTime() then return end
	netstream.Start("KeysMenu", self.Owner)
end]]