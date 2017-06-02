ITEM.name = "Броня"
ITEM.desc = "Описание."
ITEM.category = "Броня"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.SetModel = "models/aoc_player/e_archer.mdl"
ITEM.armorclass = "suit"
ITEM.width = 3
ITEM.height = 3
ITEM.mass = 0
ITEM.classes = {}
ITEM.armorType = 1
ITEM.resistance = {
	[DMG_SLASH] = 1, --Режущий
	[DMG_CLUB] = 1, --Колющий
	[DMG_CRUSH] = 1, --Дробящий
}
ITEM.pacData ={}

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
		item.player.armor[item.armorclass] = nil
		item:setData("equip", nil)
		item.player:setNetVar(item.armorclass, nil)
		if (item.armorclass != "shield") then
			item.player:SetModel(item.player:getChar():getModel())
			item.player:getChar():setData("ArmorType", nil)
		else
			if (item.pacData) then
				item.player:getChar():removePart(item.uniqueID)
			end
		end
	end
end)

hook.Add("PlayerDeath", "nutStripArmor", function(client)
	for k, v in pairs(client:getChar():getInv():getItems()) do
		if (v.armorclass and v:getData("equip")) then
			client.armor[v.armorclass] = nil
			v:setData("equip", nil)
			client:setNetVar(v.armorclass, nil)
			if (v.armorclass != "shield") then
				client:SetModel(client:getChar():getModel())
				client:getChar():setData("ArmorType", nil)
			else
				if (v.pacData) then
					client:getChar():removePart(v.uniqueID)
				end
			end
		end
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Снять",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item.player.armor = item.player.armor or {}
		if item.armorType == 1 and item.armorclass == "suit" then
			item.player:EmitSound("hgn/crussaria/items/itm_clothing_down.wav", 80)
		elseif item.armorType == 2 then
			item.player:EmitSound("hgn/crussaria/move/cloth/cloth_armor_unequip.wav", 80)
		elseif item.armorType == 3 then
			item.player:EmitSound("hgn/crussaria/move/chain/chain_armor_unequip.wav", 80)
		else
			item.player:EmitSound("hgn/crussaria/items/itm_ammo_down.wav", 80)
		end
		item.player.armor[item.armorclass] = nil
		if item.armorclass != "shield" then 
			item.player:SetModel(item.player:getChar():getModel()) 
			item.player:getChar():setData("ArmorType", nil)
		end
		item:setData("equip", false)
		
		item.player:setNetVar(item.armorclass, nil)
		if (item.pacData) then
			item.player:getChar():removePart(item.uniqueID)
		end
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
		client.armor = client.armor or {}

		for k, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]
				if item.armorclass == "suit" and v.armorclass == "suit" and v:getData("equip") then
					client:notify("На Вас уже надет доспех!")
					return false
				end
				if (client.armor["suit"] and (item.armorclass == "shield" or item.armorclass == "suit") and itemTable:getData("equip")) then 
					client:notify("Доспех не сочетается с другим доспехом или щитом!") return false 
				end
				if (client.armor["shield"] and (item.armorclass == "shield" or item.armorclass == "suit") and itemTable:getData("equip")) then 
					client:notify("Этот щит не сочетается с доспехом!") return false 
				end				
				if itemTable.isWeapon and itemTable.type == "2h" and itemTable:getData("equip") and item.armorclass == "shield" then
					client:notify("Вы не можете экипировать щит при использовании двуручного оружия!")					
					return false
				end
			
			end
		end

		client.armor[item.armorclass] = item
		if item.armorclass != "shield" then 
			client:SetModel(item.SetModel) 
			client:getChar():setData("ArmorType", item.armorType)
		end
		if item.armorType == 1 and item.armorclass == "suit" then
			item.player:EmitSound("hgn/crussaria/items/itm_clothing_up.wav", 80)
		elseif item.armorType == 2 then
			item.player:EmitSound("hgn/crussaria/move/cloth/cloth_armor_equip.wav", 80)
		elseif item.armorType == 3 then
			item.player:EmitSound("hgn/crussaria/move/chain/chain_armor_equip.wav", 80)
		else
			item.player:EmitSound("hgn/crussaria/items/itm_ammo_up.wav", 80)
		end
		item:setData("equip", true)
		client:setNetVar(item.armorclass, item)		
		if (item.pacData) then
			item.player:getChar():addPart(item.uniqueID)
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}

ITEM.functions.Repair = {
	name = "Починить",
	tip = "equipTip",
	icon = "icon16/bullet_wrench.png",
	onRun = function(item)
		local client = item.player
		local items = client:getChar():getInv()
		
		if items:hasItem("remnabor_armor") then
			client:getChar():getInv():hasItem("remnabor_armor"):setData("quantity", client:getChar():getInv():hasItem("remnabor_armor"):getData("quantity", 5) - 1)
			if client:getChar():getInv():hasItem("remnabor_armor"):getData("quantity", 5) > 0 then
				client:getChar():getInv():remove(client:getChar():getInv():hasItem("remnabor_armor"):getID())
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
function ITEM:onTransfered()
	local client = self:getOwner()
	if IsValid(client) then
		client.armor[self.armorclass] = nil
		client:setNetVar(self.armorclass, nil)
		client:getChar():setData("ArmorType", nil)
		client:SetModel(client:getChar():getModel())
		
		if (self.pacData) then
			client:getChar():removePart(self.uniqueID)
		end
	end
	if self:getData("equip") then self:setData("equip", false) end
end

function ITEM:onLoadout()
	if (self:getData("equip")) then
		local client = self.player
		client.armor = {}
		client.armor[self.armorclass] = self
		if self.armorclass != "shield" then client:SetModel(self.SetModel) end
		client:setNetVar(self.armorclass, self)
		if (self.pacData) then
			self.player:getChar():addPart(self.uniqueID)
		end
	end
end

function getDamageName(dmg)
	if dmg == DMG_CLUB then return "колющего урона" end
	if dmg == DMG_SLASH then return "режущего урона" end
	if dmg == DMG_CRUSH then return "дробящего урона" end
	return "различного урона"
end

function ITEM:onInstanced()
	if (self:getData("durability")) == nil then
		self:setData("durability", 100)
	end
end

function ITEM:getDesc()
	local description = self.desc
	
	if self.armorType == 1 and !self.armorclass == "shield" then
		description = description .. "\nЛегкий доспех"
	elseif self.armorType == 2 then
		description = description .. "\nСредний доспех"
	elseif self.armorType == 3 then
		description = description .. "\nТяжелый доспех"
	end
	if self.armorclass == "shield" then
		description = description .. "\nЩит"
	end
	description = description .. "\n[*] Состояние: " .. self:getData("durability", 100) .. "/100"
	if self.invID != nil then
		description = description .. "\n Защитные характеристики: "
		for k, v in pairs(self.resistance) do
			if self.resistance[k] == 1 then continue end
			description = description .. "\n [*] Защита от " .. getDamageName(k) .. ": " .. math.Round((1 - self.resistance[k]) * self:getData("durability", 100), 1)
		end
	end
	return description
end