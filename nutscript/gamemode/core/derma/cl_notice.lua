local PANEL = {}
	local gradient = nut.util.getMaterial("vgui/gradient-d")

	function PANEL:Init()
		self:SetSize(256, 36)
		self:SetContentAlignment(5)
		self:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self:SetFont("nutMediumFont")
		self:SetTextColor(color_white)
	end

	function PANEL:Paint(w, h)
	local gradient = nut.util.getMaterial("hgn/cru/hud/cru_menu2_option")
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(gradient)
	surface.DrawTexturedRect(0, 0, w, h)
	end
vgui.Register("nutNotice", PANEL, "DLabel")