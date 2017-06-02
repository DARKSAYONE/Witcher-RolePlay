local gradient = nut.util.getMaterial("vgui/gradient-r.vtf")
local glow = surface.GetTextureID("particle/Particle_Glow_04_Additive")

local PANEL = {}
function PANEL:Init()

	if (IsValid(nut.gui.intro)) then
		nut.gui.intro:Remove()
	end

	nut.gui.intro = self
	self:SetSize(ScrW(), ScrH())
	self:SetZPos(9999)

	timer.Simple(0.1, function()
		if (!IsValid(self)) then
			return
		end
	end)

	self.authors = self:Add("DLabel")
	self.authors:SetText("Biba RolePlay Community представляет")
	self.authors:SetFont("nutIntroMediumFont")
	self.authors:SetTextColor(color_white)
	self.authors:SetAlpha(0)
	
	self.authors:AlphaTo(255, 2, 0, function()
		self.authors:AlphaTo(0, 2, 2.5, function()
			self.authors:SetText("Разработка AleXXX_007 aka Биба")
			self.authors:SizeToContents()
			self.authors:CenterHorizontal()
			
			self.helpers = self:Add("DLabel")
			self.helpers:SetText("При поддержке Nito[1337-1488], Rovere, DrodA, Volыna, Phoenix the Emperor, Kiro и многих-многих других")
			self.helpers:SetFont("nutIntroMediumFont")
			self.helpers:SetTextColor(color_white)
			self.helpers:SizeToContents()
			self.helpers:MoveBelow(self.authors, 10)
			self.helpers:CenterHorizontal()
			self.helpers:SetAlpha(0)
			self.helpers:AlphaTo(255, 3, 0.5)

			self.authors:AlphaTo(255, 3, 0.5, function()
				if (self.sound) then
					self.sound:FadeOut(8)
					self.sound:FadeOut(8)
				end

				self.helpers:AlphaTo(0, 3, 1)
				self.authors:AlphaTo(0, 3, 1, function()

					self.cover:MoveTo(self.name:GetWide(), 0, 3, 1, nil, function()
						self.delta = 0
			
						self.schema:AlphaTo(255, 5, 1)
					end)
				end)
			end)
		end)
	end)
	self.authors:SizeToContents()
	self.authors:Center()
	self.authors:SetZPos(99)

	self.name = self:Add("DLabel")
	self.name:SetText("Witcher\nRolePlay")
	self.name:SetFont("nutIntroTitleFont")
	self.name:SetTextColor(color_white)
	self.name:SizeToContents()
	self.name:Center()
	self.name:SetPos(self.name.x, ScrH() * 0.3)
	self.name:SetExpensiveShadow(2, color_black)

	self.schema = self:Add("DLabel")
	self.schema:SetText("NutScript 1.1")
	self.schema:SetFont("nutIntroBigFont")
	self.schema:SizeToContents()
	self.schema:Center()
	self.schema:MoveBelow(self.name, 10)
	self.schema:SetAlpha(0)
	self.schema:SetExpensiveShadow(2, color_black)

	self.cover = self.name:Add("DPanel")
	self.cover:SetSize(ScrW(), self.name:GetTall())
	self.cover.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.SetMaterial(gradient)
		surface.DrawTexturedRect(0, 0, 100, h)

		surface.DrawRect(100, 0, ScrW(), h)
	end
	self.cover:SetPos(-100, 0)

	timer.Simple(15, function()
		if (IsValid(self)) then
			self.canContinue = true
			self:addContinue()
		end
	end)
end

function PANEL:addContinue()
	self.info = self:Add("DLabel")
	self.info:Dock(BOTTOM)
	self.info:SetTall(36)
	self.info:DockMargin(0, 0, 0, 32)
	self.info:SetText("Нажмите пробел, чтобы продолжить...")
	self.info:SetFont("nutIntroSmallFont")
	self.info:SetContentAlignment(2)
	self.info:SetAlpha(0)
	self.info:AlphaTo(255, 1, 5, function()
		self.info.Paint = function(this)
			this:SetAlpha(math.abs(math.cos(RealTime() * 0.8) * 255))
		end
	end)
	self.info:SetExpensiveShadow(1, color_black)
end

function PANEL:Think()
	if (IsValid(self.info) and input.IsKeyDown(KEY_SPACE) and self.canContinue and !self.closing) then
		self.closing = true
		self:AlphaTo(0, 2.5, 0, function()
			self:Remove()
		end)
	end
end

function PANEL:OnRemove()
	if (self.sound) then
		self.sound:Stop()
		self.sound = nil

		if (IsValid(nut.gui.char)) then
			nut.gui.char:playMusic()
		end
	end
	Derma_Query(L"contentWarning", L"contentTitle", L"yes", function()
		gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=636040723")
	end, L"no")
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(0, 0, 0)
	surface.DrawRect(0, 0, w, h)
	
end
vgui.Register("nutIntro", PANEL, "EditablePanel")