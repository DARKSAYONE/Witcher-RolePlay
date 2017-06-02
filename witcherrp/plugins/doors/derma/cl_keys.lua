local PANEL = {}
	function PANEL:Init()
		if (IsValid(nut.gui.keys)) then
			nut.gui.keys:Remove()
		end

		nut.gui.keys = self

		self:SetSize(ScrW() * 0.25, 680)
		self:MakePopup()
		self:Center()

		self.keys = self:Add("nutKeyItemList")
		self.keys:Dock(FILL)
		self.keys:SetDrawBackground(true)
		self.keys.action:SetText(L("keyOut"))

		self.keys.action.DoClick = function()
			local selectedItem = nut.gui.keys.activeItem

			if (IsValid(selectedItem)) then
				-- transfer items.
				netstream.Start("keyOut", selectedItem.indexID)
			end
		end
	end

	function PANEL:setKeys()
		self.keys.title:SetText(L("keys", 0, 50))

		self.keys.items:Clear()

		self:SetTitle(L("keysMenu"))

		for k, v in pairs(LocalPlayer():getChar():getKeys()) do
			local item = nut.item.instances[k]
			self.keys:addItem(item.uniqueID, item, v)
		end
	end

	function PANEL:OnRemove()
		--netstream.Start("vendorExit")
	end
vgui.Register("nutKeys", PANEL, "DFrame")

PANEL = {}
	function PANEL:Init()
		self.title = self:Add("DLabel")
		self.title:SetTextColor(color_white)
		self.title:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self.title:Dock(TOP)
		self.title:SetFont("nutBigFont")
		self.title:SizeToContentsY()
		self.title:SetContentAlignment(7)
		self.title:SetTextInset(10, 5)
		self.title.Paint = function(this, w, h)
			surface.SetDrawColor(0, 0, 0, 150)
			surface.DrawRect(0, 0, w, h)
		end
		self.title:SetTall(self.title:GetTall() + 10)

		self.items = self:Add("DScrollPanel")
		self.items:Dock(FILL)
		self.items:SetDrawBackground(true)
		self.items:DockMargin(5, 5, 5, 5)

		self.action = self:Add("DButton")
		self.action:Dock(BOTTOM)
		self.action:SetTall(32)
		self.action:SetFont("nutMediumFont")
		self.action:SetExpensiveShadow(1, Color(0, 0, 0, 150))

		self.itemPanels = {}
	end

	function PANEL:addItem(uniqueID, itemObject, name)
		local itemTable = nut.item.list[uniqueID]

		if (!itemTable) then
			return
		end

		local color_dark = Color(0, 0, 0, 80)
		
		local oldPanel = self.itemPanels[itemObject:getID()]

		local panel = self.items:Add("DPanel")
		panel:SetTall(36)
		panel:Dock(TOP)
		panel:DockMargin(5, 5, 5, 0)
		panel.Paint = function(this, w, h)
			surface.SetDrawColor(nut.gui.keys.activeItem == this and nut.config.get("color") or color_dark)
			surface.DrawRect(0, 0, w, h)
		end
		panel.indexID = itemObject:getID()
		panel.count = count
		
		panel.icon = panel:Add("SpawnIcon")
		panel.icon:SetPos(2, 2)
		panel.icon:SetSize(32, 32)
		panel.icon:SetModel(itemTable.model, itemTable.skin)

		panel.name = panel:Add("DLabel")
		panel.name:SetText(name)
		panel.name:DockMargin(40, 2, 2, 2)
		panel.name:Dock(FILL)
		panel.name:SetFont("nutIconFont")
		panel.name:SetTextColor(color_white)
		panel.name:SetExpensiveShadow(1, Color(0, 0, 0, 150))

		panel.overlay = panel:Add("DButton")
		panel.overlay:SetPos(0, 0)
		panel.overlay:SetSize(ScrW() * 0.25, 36)
		panel.overlay:SetText("")
		panel.overlay.Paint = function() end
		panel.overlay.DoClick = function(this)
			nut.gui.keys.activeItem = panel
		end
		self.itemPanels[panel.indexID] = panel
		return panel
	end
vgui.Register("nutKeyItemList", PANEL, "DPanel") 

--[[local PANEL = {}
function PANEL:Init()
	if (IsValid(nut.gui.keys)) then
		nut.gui.keys:Remove()
	end

	nut.gui.keys = self

	self:SetSize(ScrW() * 0.25, 400)
	self:MakePopup()
	self:Center()
	self:SetTitle("Связка ключей")
	
	self.tbl = vgui.Create("DListView", self)
	self.tbl:Dock(FILL)
	
	self.tbl:AddColumn("Название")
	self.tbl:AddColumn("ID")

	for k, v in pairs(LocalPlayer():getChar():getKeys()) do
		self.tbl:AddLine(v, k)
	end
	function self.tbl:DoDoubleClick(ID, value)
		netstream.Start("keyOut", tonumber(value:GetColumnText(2)))
		self:RemoveLine(ID)
	end
end

vgui.Register("nutKeys", PANEL, "DFrame")
--]]