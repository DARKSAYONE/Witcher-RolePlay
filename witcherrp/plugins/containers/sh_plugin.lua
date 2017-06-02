PLUGIN.name = "Containers"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Adds placeable containers."

nut.command.add("getlock", {
	onRun = function(client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity
		if target and IsValid(target) and (target:isDoor() or target:GetClass() == "nut_container") then
			if target:isDoor() then
				local data = target:getNetVar("doorData")
				if !data["locked"] then
					if data["lockedid"] then
						local data1 = {}
						data1["id"] = data["lockedid"]
						client:getChar():getInv():add("lock", 1, data)
						data["lockedid"] = nil
						target:setNetVar("doorData", data)
						client:notify("Замок снят!")		
					else
						client:notify("На двери нет замка!")
					end
				else
					client:notify("Дверь должна быть открытой, чтобы снять с нее замок!")
				end
			else
				if !target:getNetVar("locked", false) then
					if (target:getNetVar("lockedid")) then
						client:getChar():getInv():add("lock", 1, data)
						target:setNetVar("lockedid", nil)
						client:notify("Замок снят!")
					else
						client:notify("На контейнере нет замка!")
					end
				else
					client:notify("Контейнер должен быть открытым, чтобы снять с него замок!")
				end
			end
		else
			client:notify("Вы должны смотреть на дверь или контейнер!")
		end
	end
})

function PLUGIN:OnContainerSpawned(container, item, load)	
	container:SetModel(item.model)
	container:PhysicsInit(SOLID_VPHYSICS)
	container:SetMoveType(MOVETYPE_VPHYSICS)
	container:SetUseType(SIMPLE_USE)
	local physicsObject = container:GetPhysicsObject()
	if (IsValid(physicsObject)) then
		physicsObject:EnableMotion(true)
		physicsObject:Wake()
	end

	container.owner = item.player:getChar():getID()
	container.selfMat = container:GetMaterial()
	if (!load == true) then
		container:SetMaterial("models/wireframe")
	end
	container.item = item
	local invData = {
		name = item.name,
		desc = item.desc,
		width = item.invW,
		height = item.invH,
		locksound = item.locksound,
		opensound = item.opensound
	}
	container.invData = invData
	container.money = 0
	container:setNetVar("uid", item.uniqueID)
end

function PLUGIN:LoadData()
	local savedTable = self:getData() or {}
	for k, v in ipairs(savedTable) do
		local container = ents.Create("nut_container")
		
		container:SetPos(v.pos)
		container:SetAngles(v.ang)
		container:Spawn()
		container:SetModel(v.model)
		container:PhysicsInit(SOLID_VPHYSICS)
		container:SetMoveType(MOVETYPE_VPHYSICS)
		container:SetUseType(SIMPLE_USE)
		local physicsObject = container:GetPhysicsObject()
		if (IsValid(physicsObject)) then
			physicsObject:EnableMotion(false)
			physicsObject:Sleep()
		end
		container.owner = v.owner
		container.selfMat = v.selfMat
		container.item = v.item
		container.invData = v.invData
		container.money = v.money
		container.placed = true
		container.lockedid = v.lockedid
		container:setNetVar("uid", v.uid)
		container:setNetVar("locked", v.locked)
		
		nut.item.restoreInv(v.id, v.invData.width, v.invData.height, function(inventory)
			if (IsValid(container)) then
				container:setInventory(inventory)
			end
		end)
	end
end

function PLUGIN:SaveData()
	self:saveContainer()
end

function PLUGIN:saveContainer()
	local saveTable = {}
	for k, v in ipairs(ents.FindByClass("nut_container")) do
		if v.placed == true then
			table.insert(saveTable, {
			model = v:GetModel(), 
			pos = v:GetPos(), 
			ang = v:GetAngles(), 
			item = v.item, 
			owner = v.owner, 
			invData = v.invData,
			selfMat = v.selfMat,	
			id = v:getNetVar("id"),
			money = v:getMoney(),
			lockedid = v.lockedid,
			locked = v:getNetVar("locked", false),
			uid = v:getNetVar("uid")
			})
		end
	end
	
	self:setData(saveTable)
end

if (SERVER) then
	function PLUGIN:StorageItemRemoved(entity, inventory)
		self:saveContainer()
	end
	
	function PLUGIN:StorageCanTransfer(inventory, client, oldX, oldY, x, y, newInvID)
		local inventory2 = nut.item.inventories[newInvID]

		print(inventory2)
	end
	
	netstream.Hook("invExit", function(client)
		local entity = client.nutBagEntity

		if (IsValid(entity)) then
			entity.receivers[client] = nil
		end

		client.nutBagEntity = nil
	end)
	
	netstream.Hook("TakeMoney", function(client, value)
		client:getChar():takeMoney(value)
	end)
	
	netstream.Hook("GiveMoney", function(client, value)
		client:getChar():giveMoney(value)
	end)
	
	netstream.Hook("EntTakeMoney", function(client, entity, value)
		entity:takeMoney(value)
	end)
	
	netstream.Hook("EntGiveMoney", function(client, entity, value)
		entity:giveMoney(value)
	end)
else
	local PLUGIN = PLUGIN
	
	netstream.Hook("ContainerMoney", function(value, index)
		if (!IsValid(nut.gui["inv"..index])) then
			return
		end
		nut.gui["inv"..index].money = value
	end)
	
	netstream.Hook("invOpen2", function(entity, index, lave)
		local inventory = nut.item.inventories[index]
		
		if (inventory and inventory.slots) then
			
			nut.gui.inv1 = vgui.Create("nutInventory")
			nut.gui.inv1:ShowCloseButton(true)
			

			local inventory2 = LocalPlayer():getChar():getInv()

			if (inventory2) then
				nut.gui.inv1:setInventory(inventory2)
			end

			local panel = vgui.Create("nutInventory")
			
			panel:ShowCloseButton(false)
			panel:SetTitle("Контейнер")
			panel:setInventory(inventory)
			panel:MoveRightOf(nut.gui.inv1, 4)
			
			panel.OnClose = function(this)
				if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
					nut.gui.inv1:Remove()
				end
				
				netstream.Start("invExit")
			end
			
			local oldClose = nut.gui.inv1.OnClose
			nut.gui.inv1.OnClose = function()
				if (IsValid(panel) and !IsValid(nut.gui.menu)) then
					panel:Remove()
				end
				if (IsValid(money)) then
					money:Remove()
				end
				netstream.Start("invExit")
				nut.gui.inv1.OnClose = oldClose
			end

			nut.gui["inv"..index] = panel
			nut.gui["inv"..index].money = lave
			nut.gui.inv1:SetSize(nut.gui.inv1:GetWide(), nut.gui.inv1:GetTall() + 48)
			
			local text = nut.gui.inv1:Add("DLabel")
			text.Think = function()
				text:SetText(nut.currency.get(LocalPlayer():getChar():getMoney()))
			end
			text:Dock(BOTTOM)
			text:DockMargin(0, 0, nut.gui.inv1:GetWide()/2, 0)
			text:SetTextColor(color_white)
			text:SetFont("nutGenericFont")
			
			local entry = nut.gui.inv1:Add("DTextEntry")
			entry:Dock(BOTTOM)
			entry:DockMargin(nut.gui.inv1:GetWide()/2, 0, 0, 0)
			entry:SetValue(0)
			entry:SetNumeric(true)
			entry.OnEnter = function()
				local value = tonumber(entry:GetValue()) or 0
				if LocalPlayer():getChar():hasMoney(value) and value > 0 then
					surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
					netstream.Start("TakeMoney", value)
					netstream.Start("EntGiveMoney", entity, value)
					entry:SetValue(0)
				elseif value <= 0 then
					nut.util.notify("Вы ввели недействительное значение!")
					entry:SetValue(0)
				else
					nut.util.notify("У вас нет таких денег!")
					entry:SetValue(0)
				end		
			end
			
			local transfer = nut.gui.inv1:Add("DButton")
			transfer:Dock(BOTTOM)
			transfer:DockMargin(nut.gui.inv1:GetWide()/2, 40, 0, -40)
			transfer:SetText("Переместить")
			transfer.DoClick = function()
				local value = tonumber(entry:GetValue()) or 0
				if LocalPlayer():getChar():hasMoney(value) and value > 0 then
					surface.PlaySound("hgn/crussaria/items/itm_gold_down.wav")
					netstream.Start("TakeMoney", value)
					netstream.Start("EntGiveMoney", entity, value)
					entry:SetValue(0)
				elseif value <= 0 then
					nut.util.notify("Вы ввели недействительное значение!")
					entry:SetValue(0)
				else
					nut.util.notify("У вас нет таких денег!")
					entry:SetValue(0)
				end						
			end
			
			panel:SetSize(panel:GetWide(), panel:GetTall() + 48)
			
			local text1 = panel:Add("DLabel")
			text1.Think = function()
				text1:SetText(nut.currency.get(nut.gui["inv"..index].money or 0))
			end			
			text1:Dock(BOTTOM)
			text1:DockMargin(0, 0, panel:GetWide()/2, 0)
			text1:SetTextColor(color_white)
			text1:SetFont("nutGenericFont")
			
			local entry1 = panel:Add("DTextEntry")
			entry1:Dock(BOTTOM)
			entry1:SetValue(nut.gui["inv"..index].money)
			entry1:SetNumeric(true)
			entry1:DockMargin(panel:GetWide()/2, 0, 0, 0)
			entry1.OnEnter = function()
				local value = tonumber(entry1:GetValue()) or 0
				if nut.gui["inv"..index].money >= value and value > 0 then
					surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
					netstream.Start("EntTakeMoney", entity, value)
					netstream.Start("GiveMoney", value)
					entry1:SetValue(0)
				elseif value <= 0 then
					nut.util.notify("Вы ввели недействительное значение!")
					entry1:SetValue(0)
				else
					nut.util.notify("Здесь нет таких денег!")
					entry1:SetValue(0)
				end			
			end
			
			local transfer1 = panel:Add("DButton")
			transfer1:Dock(BOTTOM)
			transfer1:DockMargin(panel:GetWide()/2, 40, 0, -40)
			transfer1:SetText("Переместить")
			transfer1.DoClick = function()
				local value = tonumber(entry1:GetValue()) or 0
				if nut.gui["inv"..index].money >= value and value > 0 then
					surface.PlaySound("hgn/crussaria/items/itm_gold_up.wav")
					netstream.Start("EntTakeMoney", entity, value)
					netstream.Start("GiveMoney", value)
					entry1:SetValue(0)
				elseif value <= 0 then
					nut.util.notify("Вы ввели недействительное значение!")
					entry1:SetValue(0)
				else
					nut.util.notify("Здесь нет таких денег!")
					entry1:SetValue(0)
				end						
			end
		end
	end)
end