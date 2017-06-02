local PANEL = {}
	function PANEL:Init()
		nut.gui.battle = self
		self:SetSize(ScrW()/2, 300)
		self:SetPos(ScrW()/2 - self:GetWide()/2, ScrH()/1.5)
		self:SetKeyBoardInputEnabled(false)
		self:MakePopup()
		self:SetZPos(999)
		self:SetMouseInputEnabled(true)
				
		self.title = self:Add("DLabel")
		self.title:SetTall(22)
		self.title:Dock(TOP)
		self.title:SetFont("nutMediumFont")
		self.title:SetText("Действия")
		self.title:SetContentAlignment(5)
		self.title:SetTextInset(44, 0)
		self.title:SetTextColor(Color(250, 250, 250))
		self.title:SetExpensiveShadow(1, Color(0, 0, 0, 175))
		
		self.tabs = self:Add("DHorizontalScroller")
		self.tabs:SetWide(0)
		self.tabs:SetTall(50)
		self.tabs:Dock(TOP)
		
		self.title1 = self:Add("DLabel")
		self.title1:SetTall(22)
		self.title1:Dock(TOP)
		self.title1:SetFont("nutMediumFont")
		self.title1:SetText("Прибавки")
		self.title1:SetContentAlignment(5)
		self.title1:SetTextInset(44, 0)
		self.title1:SetTextColor(Color(250, 250, 250))
		self.title1:SetExpensiveShadow(1, Color(0, 0, 0, 175))
		
		self.att = self:Add("DPanel")
		self.att:Dock(FILL)
		self.att:DockMargin(4, 4, self:GetWide()/2 + 2 , 4)
		
		self.att.scroll = self.att:Add("DScrollPanel")
		self.att.scroll:Dock(FILL)
		
		self.att.num = {}
		
		self.att.title = self.att:Add("DLabel")
		self.att.title:Dock(TOP)
		self.att.title:SetText("Атака")
		self.att.title:SetFont("nutBattleFont")
		self.att.title:SetContentAlignment(8)
		
		--[[self.att.text = self.att:Add("DLabel")
		self.att.text:Dock(FILL)
		self.att.text:SetText("Урон: "..LocalPlayer():battle_getWeaponDamage().."\nШанс попадания: 0%\nШанс критического удара: 0%\nТип урона: -")
		self.att.text:SetFont("nutBattleFont")
		self.att.text:SetContentAlignment(7)]]

		
		self.def = self:Add("DPanel")
		self.def:Dock(FILL)
		self.def:DockMargin(2 + self:GetWide()/2, 4, 4, 4)
		
		
		self.def.scroll = self.def:Add("DScrollPanel")
		self.def.scroll:Dock(FILL)
		
		self.def.num = {}
		
		self.def.title = self.def:Add("DLabel")
		self.def.title:Dock(TOP)
		self.def.title:SetText("Защита")
		self.def.title:SetFont("nutBattleFont")
		self.def.title:SetContentAlignment(8)
				
		
		
		function self.att:addLabel(text, value)
		
			local label = self.scroll:Add("DLabel")
			label:SetFont("nutBattleFont")
			label:Dock(TOP)
			label:DockMargin(8, 2, 0, 0)
			label:SetContentAlignment(7)
			label.Think = function()
				label:SetText(text..": "..value)
			end			
			
			self.num[#self.num + 1] = label
			
			return label
		end
		hook.Run("SetupBattleMenu_attack", self.att)
		
		function self.def:addLabel(text, value)
		
			local label = self.scroll:Add("DLabel")
			label:SetFont("nutBattleFont")
			label:Dock(TOP)
			label:DockMargin(8, 2, 0, 0)
			label:SetContentAlignment(7)
			label.Think = function()
				label:SetText(text..": "..value)
			end			
			
			self.num[#self.num + 1] = label
			
			return label
		end
		
		hook.Run("SetupBattleMenu_defence", self.def)
		self.tabs.items = {}
		hook.Run("SetupBattleMenu", self)
	end

	local function paintButton(button, w, h)
		local alpha = 0

		if (button.Depressed or button.m_bSelected) then
			alpha = 5
		elseif (button.Hovered) then
			alpha = 2
		end

		surface.SetDrawColor(255, 255, 255, alpha)
		surface.DrawRect(0, 0, w, h)
	end

	function PANEL:addButton(name, callback)
		local function paintTab(tab, w, h)
			if (self.activeTab == tab) then
				surface.SetDrawColor(ColorAlpha(nut.config.get("color"), 200))
				surface.DrawRect(0, h - 8, w, 8)
			elseif (tab.Hovered) then
				surface.SetDrawColor(0, 0, 0, 150)
				surface.DrawRect(0, 0, w, h)
			end
		end

		surface.SetFont("nutMenuButtonLightFont")
		local w = surface.GetTextSize(name)

		local tab = self.tabs:Add("DButton")
			tab:SetSize(0, self.tabs:GetTall())
			tab:SetText(name)
			tab:SetPos(self.tabs:GetTall(), 0)
			tab:SetTextColor(Color(250, 250, 250))
			tab:SetFont("nutBattleFont")
			tab:SetExpensiveShadow(1, Color(0, 0, 0, 150))
			tab:SizeToContentsX()
			tab:SetWide(w + 32)
			tab.Paint = paintTab
			tab.DoClick = function(this)
				if (callback) and (LocalPlayer().nextclick or 0) <= CurTime() then
					callback(this)
					LocalPlayer().nextclick = CurTime() + 2
				end
			end
		self.tabs:AddPanel(tab)

		self.tabs:SetWide(math.min(self.tabs:GetWide() + tab:GetWide(), ScrW()))
		self.tabs:SetPos((ScrW() * 0.5) - (self.tabs:GetWide() * 0.5), 0)
		self.tabs.items[name] = tab
		return tab
	end
	
	function PANEL:Paint(w, h)
		nut.util.drawBlur(self)

		surface.SetDrawColor(nut.config.get("color"))
		surface.DrawRect(0, 0, w, 22)
		
		surface.SetDrawColor(nut.config.get("color"))
		surface.DrawRect(0, 72, w, 22)

		surface.SetDrawColor(255, 255, 255, 5)
		surface.DrawRect(0, 0, w, h)
	end
vgui.Register("nutBattle", PANEL, "EditablePanel")