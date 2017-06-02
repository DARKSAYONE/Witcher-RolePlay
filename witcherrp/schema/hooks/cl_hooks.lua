
surface.CreateFont("consolas", {
	font = "Consolas", 
	size = 16, 
	weight = 0,
	blursize 	= 0,
	scanlines	= 0,
	antialias 	= false,
	underline 	= false,
	shadow 		= true,
})

local col_green = Color(0, 255, 0)

local title = "Terminal debug system [v 0.3 - NS]"

local _n = "\n----------------------\n"

local X_SIZE, Y_SIZE = 800, 400
function debug_menu()
	local _FRAME = vgui.Create("DFrame")

	local _SHEET = _FRAME:Add("DColumnSheet")
	_SHEET:Dock( FILL )

	_FRAME:SetPos(ScrW() / 5, ScrH() / 3.2)
	_FRAME:SetSize(X_SIZE, Y_SIZE)
	_FRAME:SetTitle(title)
	_FRAME:MakePopup()

	local _PANEL2 = _SHEET:Add("DPanel")
	_PANEL2:Dock( FILL )
	_PANEL2.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0 ) )
	end

	local _FPS = _PANEL2:Add("DLabel")
	_FPS:SetFont("consolas")
	_FPS:Dock(BOTTOM)
	_FPS:SetTextColor(col_green)
	_FPS:SetText(" ")
	_FPS.Think = function(this)
		if ((this.nextTime or 0) < CurTime()) then
			this:SetText(
				"; FPS: "..math.Round( 1/RealFrameTime() )..
				"\n; PING: "..LocalPlayer():Ping()..
				"\n; PACKET LOOSE: "..LocalPlayer():PacketLoss()
				)
			this.nextTime = CurTime() + 0.02

			_FPS:SizeToContents()
		end
	end

	local _NUT_ALLENTS = _PANEL2:Add("DLabel")
	_NUT_ALLENTS:SetFont("consolas")
	_NUT_ALLENTS:Dock(TOP)
	_NUT_ALLENTS:SetTextColor(col_green)
	_NUT_ALLENTS:SetText(" ")
	local nuts = {}
	for k, v in pairs(ents.FindByClass("nut_*")) do
		nuts[v:GetClass()] = (nuts[v:GetClass()] or 0) + 1
	end
	PrintTable(nuts)

	local _PL = player.GetAll()
	_NUT_ALLENTS.Think = function(this)
		if ((this.nextTime or 0) < CurTime()) then
			this:SetText(
				"; _SERVER ; "..GetHostName()..
				_n.."; _ALL_ENTS ; "..#ents.GetAll()..
				"\n; _ALL_NUT_ENTS ; "..#ents.FindByClass("nut_*")..
				_n.."; _NUT_ITEMS ; "..#ents.FindByClass("nut_item")..
				"\n; _NUT_ITEM_INSTANCE ; "..tostring(nut.item.instances)..
				_n.."; _PL ; "..#_PL
				)			
			this.nextTime = CurTime() + 0.02
			_NUT_ALLENTS:SizeToContents()
		end
	end

	_SHEET:AddSheet( "NUT graph", _PANEL2, "icon16/application_xp_terminal.png" )
end
concommand.Add("debug.menu", debug_menu)

function SCHEMA:PrePlayerDraw(player)
	local pos = player:GetPos()
	local dist = LocalPlayer():GetPos():Distance(pos)
	if dist > 4000 then
		return true
	end
end

local color = {}
color["$pp_colour_addr"] = 0
color["$pp_colour_addg"] = 0
color["$pp_colour_addb"] = 0
color["$pp_colour_brightness"] = -0.01
color["$pp_colour_contrast"] = 1
color["$pp_colour_colour"] = 1.2
color["$pp_colour_mulr"] = 0
color["$pp_colour_mulg"] = 0
color["$pp_colour_mulb"] = 0

function SCHEMA:RenderScreenspaceEffects()
	DrawColorModify(color)
end

function SCHEMA:GetColorModify()
	return color
end

netstream.Hook("plyData", function(...)
	vgui.Create("nutData"):setData(...)
end)

netstream.Hook("voicePlay", function(sounds, volume, index)
	if (index) then
		local client = Entity(index)

		if (IsValid(client)) then
			nut.util.emitQueuedSounds(client, sounds, nil, nil, volume)
		end
	else
		nut.util.emitQueuedSounds(LocalPlayer(), sounds, nil, nil, volume)
	end

end)

function SCHEMA:SetupQuickMenu(menu)
	menu:addButton("Настройка музыки", function()
		if (nut.gui.nmconfig and nut.gui.nmconfig:IsVisible()) then
			nut.gui.nmconfig:Close()
			nut.gui.nmconfig = nil
		end

		nut.gui.nmconfig = vgui.Create("nutNMConfig")
	end)
	
	menu:addButton("Шрифты", function()
		if (nut.gui.fontsel and nut.gui.fontsel:IsVisible()) then
			nut.gui.fontsel:Close()
			nut.gui.fontsel = nil
		end

		nut.gui.fontsel = vgui.Create("nutFontSel")
	end)
end

local PANEL = {}
function PANEL:Init()
	self:SetTitle("Настройка громкости музыки")
	self:SetSize(300, 100)
	self:Center()
	self:MakePopup()

	self.list = self:Add("DPanel")
	self.list:Dock(FILL)
	self.list:DockMargin(0, 0, 0, 0)

	local cfg = self.list:Add("DNumSlider")
	cfg:Dock(TOP)
	cfg:SetText("Громкость") // Set the text above the slider
	cfg:SetMin(0)				 // Set the minimum number you can slide to
	cfg:SetMax(100)				// Set the maximum number you can slide to
	cfg:SetDecimals(0)			 // Decimal places - zero for whole number
	cfg:SetConVar("nombat_volume") // Changes the ConVar when you slide
	cfg:DockMargin(10, 0, 0, 5)
	
	local change = self.list:Add("DButton")
	change:Dock(TOP)
	change:SetText("Сменить композицию")
	change:SetConsoleCommand("nombat_debug_switch_both")

end
vgui.Register("nutNMConfig", PANEL, "DFrame")

NUT_CVAR_FONT = CreateClientConVar("nut_font", "Ведьмак", true)

local PANEL = {}
function PANEL:Init()
	self:SetTitle("Настройка шрифтов")
	self:SetSize(300, 60)
	self:Center()
	self:MakePopup()

	self.list = self:Add("DPanel")
	self.list:Dock(FILL)
	self.list:DockMargin(0, 0, 0, 0)

	local cfg = self.list:Add("DComboBox")
	cfg:Dock(TOP)
	cfg:AddChoice("Ведьмак")
	cfg:AddChoice("Стандартный")
	cfg:SetValue(NUT_CVAR_FONT:GetString())
	
	function cfg:OnSelect( index, value, data )
		if index == 1 then
			RunConsoleCommand("nut_font", "Ведьмак")
		elseif index == 2 then
			RunConsoleCommand("nut_font", "Стандартный")
		end
		timer.Simple(0, function()
			hook.Run("LoadFonts", "")
		end)
	end
end
vgui.Register("nutFontSel", PANEL, "DFrame")