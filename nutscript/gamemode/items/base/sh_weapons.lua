ITEM.name = "Weapon"
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.class = "weapon_pistol"
ITEM.width = 2
ITEM.height = 2
ITEM.isWeapon = true
ITEM.weaponCategory = "sidearm"
ITEM.pacData = {}
ITEM.type = "1h"
ITEM.damage = "1d2"
-- Inventory drawing
if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:hook("drop", function(item)
	if (item:getData("equip")) then
		item:setData("equip", nil)

		item.player.carryWeapons = item.player.carryWeapons or {}

		local weapon = item.player.carryWeapons[item.weaponCategory]

		if (IsValid(weapon)) then
			item:setData("ammo", weapon:Clip1())

			item.player:StripWeapon(item.class)
			item.player.carryWeapons[item.weaponCategory] = nil
			item.player:EmitSound("items/ammo_pickup.wav", 80)
			if (item.pacData) then
				item.player:getChar():removePart(item.uniqueID)
			end
		end
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item.player.carryWeapons = item.player.carryWeapons or {}

		local weapon = item.player.carryWeapons[item.weaponCategory]

		if (!weapon or !IsValid(weapon)) then
			weapon = item.player:GetWeapon(item.class)	
		end

		if (weapon and weapon:IsValid()) then
			item:setData("ammo", weapon:Clip1())
		
			item.player:StripWeapon(item.class)
		else
			print(Format("[Nutscript] Weapon %s does not exist!", item.class))
		end

		item.player:EmitSound("items/ammo_pickup.wav", 80)
		item.player.carryWeapons[item.weaponCategory] = nil
		if (item.pacData) then
			item.player:getChar():removePart(item.uniqueID)
		end
		item:setData("equip", nil)
		
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		local client = item.player
		local items = client:getChar():getInv():getItems()

		client.carryWeapons = client.carryWeapons or {}

		for k, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]

				if (itemTable.isWeapon and client.carryWeapons[item.weaponCategory] and itemTable:getData("equip")) then
					client:notify("Вы уже переносите данный тип оружия")

					return false
				end
				if itemTable.armorclass == "shield" and itemTable:getData("equip") and item.type == "2h" then
					client:notify("Вы не можете использовать двуручное оружие при использовании щита!")
					
					return false
				end
			end
		end
		
		if (client:HasWeapon(item.class)) then
			client:StripWeapon(item.class)
		end

		local weapon = client:Give(item.class)

		if (IsValid(weapon)) then
			client.carryWeapons[item.weaponCategory] = weapon
			client:SelectWeapon(weapon:GetClass())
			client:SetActiveWeapon(weapon)
			client:EmitSound("items/ammo_pickup.wav", 80)
			if (item.pacData) then
				client:getChar():addPart(item.uniqueID)
			end
			
			-- Remove default given ammo.
			if (item:getData("ammo", 0) == 0) then
				client:SetAmmo(0, weapon:GetPrimaryAmmoType())
			end

			item:setData("equip", true)

			weapon:SetClip1(item:getData("ammo", 0))
		else
			print(Format("[Nutscript] Weapon %s does not exist!", item.class))
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true and item:getData("durability", 100) > 0)
	end
}

ITEM.functions.Repair = {
	name = "Починить",
	icon = "icon16/bullet_wrench.png",
	onRun = function(item)
		local client = item.player
		local items = client:getChar():getInv()
		local remnabor = "remnabor_weapon"
		
		if items:hasItem("remnabor_weapon") then
			client:getChar():getInv():hasItem("remnabor_weapon"):setData("quantity", client:getChar():getInv():hasItem("remnabor_weapon"):getData("quantity", 5) - 1)
			if client:getChar():getInv():hasItem("remnabor_weapon"):getData("quantity", 5) > 0 then
				client:getChar():getInv():remove(client:getChar():getInv():hasItem("remnabor_weapon"):getID())
			end
			item:setData("durability", math.Clamp(item:getData("durability", 100) + 25, 0, 100))
		else
			client:notify("У Вас нет ремнабора!")
		end		
		
		return false
	end,
	onCanRun = function(item)
		return true	
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return newInventory:getID() == 0
	end

	return true
end

function ITEM:onLoadout()
	if (self:getData("equip")) then
		local client = self.player
		client.carryWeapons = client.carryWeapons or {}

		local weapon = client:Give(self.class)

		if (IsValid(weapon)) then
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())
			client.carryWeapons[self.weaponCategory] = weapon

			weapon:SetClip1(self:getData("ammo", 0))
		else
			print(Format("[Nutscript] Weapon %s does not exist!", self.class))
		end
	end
end

function ITEM:onSave()
	local weapon = self.player:GetWeapon(self.class)

	if (IsValid(weapon)) then
		self:setData("ammo", weapon:Clip1())
	end
end

HOLSTER_DRAWINFO = {}

-- Called after the item is registered into the item tables.
function ITEM:onRegistered()
	if (self.holsterDrawInfo) then
		HOLSTER_DRAWINFO[self.class] = self.holsterDrawInfo
	end
end

function ITEM:onInstanced()
	if (self:getData("durability")) == nil then
		self:setData("durability", 100)
	end
end

hook.Add("PlayerDeath", "nutStripClip", function(client)
	client.carryWeapons = {}

	for k, v in pairs(client:getChar():getInv():getItems()) do
		if (v.isWeapon and v:getData("equip")) then
			v:setData("ammo", nil)
			v:setData("equip", nil)
			if (v.pacData) then
				client:getChar():removePart(v.uniqueID)
			end
		end
	end
end)

function ITEM:getDesc()
	local description = self.desc
	local weapontype = {
		["1h"] = "Одноручное оружие",
		["2h"] = "Двуручное оружие"
	}
	local weptype = "\n"..weapontype[self.type]
	local durability = "\n[*] Состояние: " .. self:getData("durability", 100) .. "/100"
	return description .. weptype .. durability
end