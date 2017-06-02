PLUGIN.name = "Simplified Doors"
PLUGIN.author = "AleXXX_007, Vex"
PLUGIN.desc = "Improves door management."

nut.config.add("doorsLockedDefault", false, "Закрыты ли двери по умолчанию?", nil, {category = "Двери"})

nut.util.include("sv_plugin.lua")
nut.util.include("cl_plugin.lua")
nut.util.include("sh_commands.lua")

local langkey = "russian"
do
	local langTable = {
		keys = "Связка ключей",
		keysMenu = "Ключи",
		keyOut = "Снять ключ",
	}

	table.Merge(nut.lang.stored[langkey], langTable)
end

if (CLIENT) then
	netstream.Hook("openDoorManager", function(entity)
		vgui.Create("nutDoorManager"):Configure(entity)
	end)

	netstream.Hook("keysMenu", function(items)
		local keys = vgui.Create("nutKeys")
		keys:setKeys(items)
		
	end)

	netstream.Hook("keyOut", function(id)
		if (nut.gui.keys and nut.gui.keys:IsVisible()) then
			nut.gui.keys:setKeys()
			surface.PlaySound("physics/metal/metal_chainlink_impact_soft2.wav")
		end
	end)
else
	netstream.Hook("doorSetVar", function(door, name, var)
		print("Stream running!")
		if (door:isDoor()) then
			local data = door:getNetVar("doorData") or {}
			
			data[name] = var 
			
			door:setNetVar("doorData", data)
			return true
		else
			return false
		end;
	end)
	
	netstream.Hook("KeysMenu", function(client)
		local keysItems = client:getChar():getKeys()
		local queryTable = {}

		-- Insert items to load.
		for k, v in pairs(keysItems) do
			table.insert(queryTable, k)
		end

		-- Load item informations.
		nut.item.loadItemByID(queryTable, 0, nil)

		-- Check if item's information is loaded, if does not, do not load the item.
		for k, v in pairs(keysItems) do
			local item = nut.item.instances[k]

			if (item) then
				netstream.Start(client, "item", item.uniqueID, k, item.data, 0)
			end
		end
		netstream.Start(client, "keysMenu", keysItems)
	end)
	
	netstream.Hook("keyOut", function(client, itemID)
		local char = client:getChar()
		local item = nut.item.instances[itemID]

		-- If item information is valid.
		if (item) then
			local clientKeys = char:getKeys()

			-- If the activator does not owns the item, reject request.
			if (!clientKeys[itemID]) then
				client:notify(L("stashError", client))
				return
			end

			-- Make an attempt to take item from the stash.
			if (item:transfer(char:getInv():getID(), nil, nil, client)) then
				clientKeys[itemID] = nil
				
				
				char:setKeys(clientKeys)
				netstream.Start(client, "keyOut")				
				nut.item.loadItemByID(itemID, 0, nil)
			end
		end
	end)
	
	netstream.Hook("keyIn", function(client, itemID)
		local char = client:getChar()
		local item = nut.item.instances[itemID]
		nut.item.loadItemByID(itemID, 0, nil)
		-- If item information is valid.
		if (item) then
			local clientKeys = char:getKeys()

			-- Make an attempt to put item into the stash.
			if (item:transfer(nil, nil, nil, client, nil, true)) then
				clientKeys[itemID] = item:getName()

				char:setKeys(clientKeys)
				netstream.Start(client, "keyIn")
			else
				client:notify("Ошибка!")
			end
		end
	end)
end;

local charMeta = nut.meta.character

function charMeta:getKeys()
	return self:getData("keys", {})
end

function charMeta:hasKey(lockid)
	local tbl = self:getKeys()
	local items = self:getInv():getItems()
	local check = false
	for k, _ in pairs(tbl) do
		local item = nut.item.instances[k]
		if item and item:getData("lockid", 0) == lockid then
			return true
		end
	end
	for k, v in pairs(items) do
		if v:getData("lockid", 0) == lockid then
			return true
		end
	end
	return false
end

function charMeta:setKeys(tbl)
	self:setData("keys", tbl)
end

