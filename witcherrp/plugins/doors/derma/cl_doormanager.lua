local PANEL = {}

	function PANEL:Init()
		self:SetSize(300, 400)
		self:SetTitle(L"Door Manager")
		self:ShowCloseButton(true)
		self:SetDraggable(true)
		self:Center()
		self:MakePopup()

		--self.scroll = self:Add("DScrollPanel")
		--self.scroll:Dock(FILL)

		self.settings = self:Add("DProperties")
			self.settings:Dock(TOP)
			self.settings:DockMargin(0, 0, 0, 6)
			self.settings:SetSize(300, 64)
	end;
	
	function PANEL:OnRemove()
		print(title:GetValue())
		hook.Run("setDoorVar", door, "title", "test")
	end;
	
	function PANEL:Configure(door)
		local data = door:getNetVar("doorData")
		
		title = self.settings:CreateRow("Settings", "Door Title")
			title:Setup("Generic")
			title:SetSize(300, 32)
			title:SetValue(data["title"] or nil)
	end;

vgui.Register("nutDoorManager", PANEL, "DFrame")