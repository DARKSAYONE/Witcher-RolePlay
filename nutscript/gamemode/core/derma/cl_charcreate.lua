local PANEL = {}
	function PANEL:Init()
		if (IsValid(nut.gui.charCreate)) then
			nut.gui.charCreate:Remove()
		end

		nut.gui.charCreate = self

		self:SetSize(ScrW() * 0.45, ScrH() * 0.66)
		self:SetPos(ScrW() * 0.3 + 100, ScrH() * 0.2)		
		
		self.back = self:Add("DPanel")
		self.back:SetWide(self:GetWide())
		self.back:SetTall(self:GetTall()+430)
		self.back.Paint = function(this, w, h)
		
		local gradient = nut.util.getMaterial("hgn/cru/hud/cru_menu2")
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(0, 0, w-15, h*1.7)		
		end

		self.notice = self:Add("nutNoticeBar")
		self.notice:SetPos(25, 15)
		self.notice:setType(4)
		self.notice:setText(L"charCreateTip")
		self.notice:SetWide(self:GetWide() - 65)

		self.payload = {}
		self.lastY = self.notice:GetTall() + 8
	end

	function PANEL:addLabel(text)
		local label = self:Add("DLabel")
		label:SetPos(25, self.lastY)
		label:SetFont("nutMenuButtonFont")
		label:SetText(L(text))
		label:SizeToContents()
		label:SetTextColor(color_white)
		label:SetExpensiveShadow(2, Color(0, 0, 0, 200))

		self.lastY = self.lastY + label:GetTall() + 8

		return label
	end

	function PANEL:addTextBox()
		local textBox = self:Add("DTextEntry")
		textBox:SetFont("nutMenuButtonLightFont")
		textBox:SetWide(self:GetWide() - 60)
		textBox:SetPos(25, self.lastY)
		textBox:SetTall(36)

		self.lastY = self.lastY + textBox:GetTall() + 8

		return textBox
	end

	function PANEL:setUp(faction)
		self.faction = faction
		self.payload.faction = self.faction
		
		for k, v in SortedPairsByMemberValue(nut.char.vars, "index") do
			if (!v.noDisplay and k != "__SortedIndex") then
				if (v.shouldDisplay) then
					if (v.shouldDisplay(self) == false) then
						continue
					end
				end

				self:addLabel(k)

				if (v.onDisplay) then
					local panel = v.onDisplay(self, self.lastY)

					if (IsValid(panel)) then
						self.lastY = self.lastY + panel:GetTall() + 8

						if (v.onPostSetup) then
							v.onPostSetup(panel, faction, self.payload)
						end
					end
				elseif (type(v.default) == "string") then
					local textBox = self:addTextBox()
					textBox.OnTextChanged = function(this)
						self.payload[k] = this:GetText()
					end

					if (v.onPostSetup) then
						v.onPostSetup(textBox, faction, self.payload)
					end
				end
			end
		end
	end
vgui.Register("nutCharCreate", PANEL, "DScrollPanel")