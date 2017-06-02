ITEM.name = "Карта"
ITEM.desc = "Карта окрестностей Майенны"
ITEM.model = "models/maps.mdl"
ITEM.category = "misc"

ITEM.functions.View = {
	name = "Осмотреть",
	icon = "icon16/map.png",
	onClick = function(item)
		local frame = vgui.Create("DFrame")
		frame:SetSize(840, 850)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()
		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		frame.html:SetHTML([[<html>
			<body style="background-color: #ECECEC; color: #282B2D; font-family: 'Book Antiqua', Palatino, 'Palatino Linotype', 'Palatino LT STD', Georgia, serif; font-size 16px; text-align: justify;">
				<center>
				 <img src="http://i82.fastpic.ru/big/2016/0924/2b/09bed63793b38d7cc5c91acc93eaaf2b.png"></img>
				</center>
			</body>
		</html>]])
	end,
	onRun = function(item)
		item.player:EmitSound("hgn/crussaria/devices/parchment_open.wav")
		if !IsValid(item.entity) then
			item.player:emote("map")
		end
		return false
	end
}