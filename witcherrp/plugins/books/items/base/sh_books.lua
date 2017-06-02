ITEM.name = "Book Base"
ITEM.desc = "A book."
ITEM.category = "Литература"
ITEM.model = "models/toussaint_books9.mdl"
ITEM.contents = ""
ITEM.iconCam = {
	pos = Vector(-14.447836875916, 0, 3.60706782341),
	ang = Angle(0, -0, 0),
	fov = 45
}


ITEM.functions.Read = {
	onClick = function(item)
		local frame = vgui.Create("DFrame")
		frame:SetSize(540, 680)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()
		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		frame.html:SetHTML([[<html><body style="background-color: #ECECEC; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">]]..item.contents..[[</body></html>]])
	end,
	onRun = function(item, client)
		local client = item.player
		client:EmitSound("hgn/crussaria/items/itm_book_open.wav")
		return false
	end,
	icon = "icon16/book_open.png"
}
ITEM.permit = "lit"