local PLUGIN = PLUGIN

local PANEL = {}
	local ICON_USER = "icon16/user.png"
	local ICON_HEART = "icon16/heart.png"
	local ICON_WRENCH = "icon16/wrench.png"
	local ICON_STAR = "icon16/star.png"
	local ICON_SHIELD = "icon16/shield.png"
	local menuWidth, menuHeight = 0.5, 0.5
	local removeGuiMenu = true

	function PANEL:Init()
		nut.gui.faction = self
		self:SetPos(ScrW() * 0.25, ScrH() * 0.25)
		self:SetSize(ScrW() * menuWidth, ScrH() * menuHeight)
		self:MakePopup()
		self:ShowCloseButton(false)
		self:SetTitle("Фракция '"..team.GetName(LocalPlayer():Team()).."'")

		self.list = self:Add("DCategoryList")
		self.list:Dock(FILL)
		self.list:SetDrawBackground(true)

		self.catCommands = self.list:Add("Действия")
		self.catCommands:SetExpanded(true)

		for k, v in SortedPairs(PLUGIN.commands) do
			if (!LocalPlayer():Alive() and !v.allowDead) then
				continue
			end
			if (PLUGIN:IsAllowed(LocalPlayer(), v.group)) then
				local button = self.catCommands:Add("DButton")
				button:SetText(v.text or k)
				button:Dock(TOP)
				button:DockMargin(2, 2, 2, 2)
				button.DoClick = function(panel)
					local menu = DermaMenu()
						for _, client in SortedPairs(player.GetAll()) do
							if (PLUGIN:IsAllowed(LocalPlayer(), client)) then
								if v.onAll and client:Team() == FACTION_CITIZEN then
									local icon = ICON_USER

									if (client:IsSuperAdmin()) then
										icon = ICON_SHIELD
									elseif (client:IsAdmin()) then
										icon = ICON_STAR
									elseif (client:IsUserGroup("operator")) then
										icon = ICON_WRENCH
									elseif (client:IsUserGroup("donator")) then
										icon = ICON_HEART
									end
									v.onMenu( menu, icon, client, k )
								elseif LocalPlayer():Team() == client:Team() and !v.onAll then
									local icon = ICON_USER

									if (client:IsSuperAdmin()) then
										icon = ICON_SHIELD
									elseif (client:IsAdmin()) then
										icon = ICON_STAR
									elseif (client:IsUserGroup("operator")) then
										icon = ICON_WRENCH
									elseif (client:IsUserGroup("donator")) then
										icon = ICON_HEART
									end
									v.onMenu( menu, icon, client, k )
								end
							end
						end
					menu:Open()
				end
			end
		end
		self.catUsers = self.list:Add("Члены фракции")
		self.catUsers:SetExpanded(true)
	
		for k, v in SortedPairs(player.GetAll()) do
			if LocalPlayer():Team() == v:Team() then
				local button = self.catUsers:Add("DButton")
				button:SetText(v:Name())
				button:Dock(TOP)
				button:DockMargin(2, 2, 2, 2)
			end
		end
	end

	function PANEL:Think()
		if (!self:IsActive()) then
			self:MakePopup()
		end
	end
vgui.Register("nut_faction", PANEL, "DFrame")

function PLUGIN:CreateMenuButtons(tabs)--menu, addButton)
	if LocalPlayer():Team() != FACTION_CITIZEN then
		tabs["Фракция"] = function(panel)
			if (!IsValid(nut.gui.faction)) then
				panel:Add("nut_faction")
			end
		end
	end
end