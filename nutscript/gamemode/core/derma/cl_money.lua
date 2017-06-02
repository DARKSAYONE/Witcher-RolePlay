local PANEL = {}

function PANEL:Init()
	self:SetSize(256, 128)
	
	local text = self:Add("DLabel")

	text:SetText("Ваши деньги: "..nut.currency.get(LocalPlayer():getChar():getMoney()))
	text:Dock(TOP)
	text:SetTextColor(color_white)
	text:SetFont("nutGenericFont")
	
	local text1 = self:Add("DLabel")

	text1:SetText("Деньги \nв контейнере: ")
	text1:SizeToContentsY(text1:GetContentSize() + 2)
	text1:Dock(BOTTOM)
	text1:SetTextColor(color_white)
	text1:SetFont("nutGenericFont")
end


vgui.Register("nutMoney", PANEL, "DFrame")
