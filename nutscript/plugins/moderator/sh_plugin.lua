PLUGIN.name = "Moderator"
PLUGIN.author = "Chessnut (NS 1.0), Neon (NS 1.1), AleXXX_007"
PLUGIN.desc = "Provides a simple administration mod."

PLUGIN.ranks = PLUGIN.ranks or {}
PLUGIN.users = PLUGIN.users or {}
PLUGIN.bans = PLUGIN.bans or {}

local playerMeta = FindMetaTable("Player")

function playerMeta:GetUserGroup()
	return self:GetNWString("usergroup", "user")
end

function PLUGIN:IsAllowed(a, b)
	if (type(a) == "Player") then
		a = self.ranks[string.lower(a:GetUserGroup())]
	else
		a = self.ranks[string.lower(a)]
	end

	if (type(b) == "Player") then
		b = self.ranks[string.lower(b:GetUserGroup())]
	else
		b = self.ranks[string.lower(b)]
	end

	if (a and b) then
		return a >= b
	end

	return true
end

local PLUGIN = PLUGIN

-- Admin chat
nut.chat.register("adm", {
	onCanSay =  function(speaker, text)
		if !speaker:IsAdmin() then
			return false
		end
	end,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 50, 50), " [Админ] ", speaker, color_white, ": "..text)
	end,
	onCanHear = function(speaker, listener)
		if !listener:IsAdmin() then
			return false
		end
	end,
	prefix = {"/adm"},
	noSpaceAfter = true,
	filter = "ooc"
})

playerMeta.ModIsAdmin = playerMeta.ModIsAdmin or playerMeta.IsAdmin
playerMeta.ModIsSuperAdmin = playerMeta.ModIsSuperAdmin or playerMeta.IsSuperAdmin

PLUGIN.timeData = {
	{"г", 60*60*24*365, "год", "года", "лет"},
	{"мес", 60*60*24*30, "месяц", "месяца", "месяцев"},
	{"н", 60*60*24*7, "неделю", "недели", "недель"},
	{"д", 60*60*24, "день", "дня", "дней"},
	{"ч", 60*60, "час", "часа", "часов"},
	{"м", 60, "минуту", "минуты", "минут"},
	{"с", 1, "секунду", "секунды", "секунд"}
}

function PLUGIN:SecondsToFormattedString(time)
	local banstring = ""
	for ind, d in ipairs(self.timeData) do
		local subs = math.floor(time/d[2])
		local geg = math.fmod(subs, 10)
		
		if (subs > 0 ) then
			time = time - subs*d[2]
			
			if (geg == 1) and !(math.fmod(subs, 100) == 11) then
				banstring = banstring .. subs .. " " .. d[3]
			elseif (geg > 1) and (geg < 5) and !(math.fmod(subs, 100) >= 12 and math.fmod(subs, 100) <=14) then
				banstring = banstring .. subs .. " " .. d[4]
			else
				banstring = banstring .. subs .. " " .. d[5]
			end
			if ind != #self.timeData then
				banstring = banstring .. " "
			end
		end
	end
	return banstring
end

function playerMeta:IsSuperAdmin()
	return PLUGIN:IsAllowed(self, "superadmin") or self:ModIsSuperAdmin()
end

function playerMeta:IsAdmin()
	return PLUGIN:IsAllowed(self, "admin") or self:ModIsAdmin()
end

function PLUGIN:SaveData()
	local data = {}

	data.ranks = self.ranks
	data.users = self.users
	data.bans = self.bans
	self:setData(data)
end

function PLUGIN:LoadData()
	local data = self:getData()

	if !data.ranks then
		data.ranks = {}
		data.ranks["owner"] = 100
		data.ranks["superadmin"] = 75
		data.ranks["admin"] = 50
		data.ranks["operator"] = 25
		data.ranks["user"] = 0
	else self.ranks = data.ranks end
	self.users = data.users
	self.bans = data.bans
end

-- Permanent ranks, please do not edit this directly.
/*PLUGIN.ranks.owner = 100
PLUGIN.ranks.superadmin = 75
PLUGIN.ranks.admin = 50
PLUGIN.ranks.operator = 25
PLUGIN.ranks.user = 0*/
PLUGIN.ranks["owner"] = 100
PLUGIN.ranks["superadmin"] = 75
PLUGIN.ranks["admin"] = 50
PLUGIN.ranks["operator"] = 25
PLUGIN.ranks["user"] = 0

function PLUGIN:PlayerSpawn(client)
	if (!client:getNetVar("modInit")) then
		self:SetUserGroup(client:SteamID(), self.users[client:SteamID()] or "user", client)
		local group = {
			["user"] = "Пользователь",
			["operator"] = "Оператор",
			["admin"] = "Администратор",
			["superadmin"] = "Суперадминистратор",
			["owner"] = "Владелец"
		}
		client:ChatPrint("Вы находитесь в группе сервера '"..group[client:GetUserGroup()].."'. Приятной игры.")
		client:setNetVar("modInit", true)
	end
end

function PLUGIN:SetUserGroup(steamID, group, client)
	if (!group) then
		error("No rank was provided.")
	end

	group = string.lower(group)

	if (self.ranks[group]) then
		self.users[steamID] = group

		if (IsValid(client)) then
			client:SetUserGroup(group)
		end

		local data = self:getData()
		data.users = self.users
		self:setData(data)
	end
end

function PLUGIN:CreateRank(group, immunity)
	self.ranks[group] = immunity
	local data = self:getData()
	data.users = self.ranks
	self:setData(data)
end

function PLUGIN:RemoveRank(group)
	for k, v in pairs(self.ranks) do
		if (nut.util.StringMatches(group, k)) then
			self.ranks[k] = nil
			local data = self:getData()
			data.users = self.users
			self:setData(data)
			return true, k
		end
	end

	return false
end

function PLUGIN:BanPlayer(steamID, time, reason)
	local client

	reason = reason or "Без причины"
	time = math.max(time or 0, 0)

	local expireTime = os.time() + time

	if (time == 0) then
		expireTime = 0
	end

	self.bans[steamID] = {expire = expireTime, reason = reason}

	for k, v in ipairs(player.GetAll()) do
		if (v:SteamID() == steamID) then
			client = v
		end
	end
	if (IsValid(client)) then
		if (time == 0) then
			time = "перманентно"
		else
			time = "на "..self:SecondsToFormattedString(time)
		end

		client:Kick("Вы были заблокированы на "..time.." по причине: "..reason)
	end
	local data = self:getData()
	data.bans = self.bans
	self:setData(data)
end

function PLUGIN:UnbanPlayer(steamID)
	local found = (self.bans[steamID] != nil)
	self.bans[steamID] = nil

	if (found) then
		local data = self:getData()
		data.bans = self.bans
		self:setData(data)
	end

	return found
end

gameevent.Listen("player_connect")

function PLUGIN:player_connect(data)
	local ban = self.bans[data.networkid]

	if (ban and (ban.expire == 0 or ban.expire >= os.time())) then
		local time = "истечет "..self:SecondsToFormattedString(math.floor(ban.expire - os.time()))

		if (ban.expire == 0) then
			time = "не истечет никогда"
		end

		game.ConsoleCommand("kickid "..data.userid.." Вы заблокированы на этом сервере по причине: "..ban.reason..". Ваша блокировка "..time.."\n")
	else
		self.bans[data.networkid] = nil
	end
end

nut.util.include("sh_commands.lua")
nut.util.include("cl_derma.lua")

function PLUGIN:PlayerNoClip(client)
	if (!self:IsAllowed(client, "operator")) then
		return false
	end
end