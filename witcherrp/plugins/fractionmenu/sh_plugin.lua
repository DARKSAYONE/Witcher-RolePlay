PLUGIN.name = "Factions Control"
PLUGIN.author = "Neon, AleXXX_007"
PLUGIN.desc = "Меню управления фракцией."

PLUGIN.ranks = PLUGIN.ranks or {}
PLUGIN.users = PLUGIN.users or {}

PLUGIN.ranks["Суперадминистратор"] = 100
PLUGIN.ranks["Лидер"] = 50
PLUGIN.ranks["Капитан"] = 45
PLUGIN.ranks["Лейтенант"] = 40
PLUGIN.ranks["Сержант"] = 30
PLUGIN.ranks["Рядовой"] = 20
PLUGIN.ranks["Рекрут"] = 10

local defaultfaction = FACTION_CITIZEN

local playerMeta = FindMetaTable("Player")

function playerMeta:GetUserRank()
	return self:getNetVar("factiongroup", "Рекрут")---PLUGIN.users[self:getChar():getID()].rank or "newbie"--self:GetNWString("usergroup", "user")
end

function PLUGIN:IsAllowed(a, b)
	--print(a,b)
	if (type(a) == "Player") then
		a = self.ranks[string.lower(a:GetUserRank())]
	else
		a = self.ranks[string.lower(a)]
	end

	if (type(b) == "Player") then
		b = self.ranks[string.lower(b:GetUserRank())]
	else
		b = self.ranks[string.lower(b)]
	end
	if (a and b) then
		return a >= b
	end

	return true
end

local PLUGIN = PLUGIN

function PLUGIN:LoadData()
	local data = self:getData()
	if data.ranks then self.ranks = data.ranks end
	self.users = data.users or {}
end

function PLUGIN:SaveData()
	local data = {}
	data.ranks = self.ranks
	data.users = self.users
	self:setData(data)
end

function PLUGIN:PlayerSpawn(client)
	if nut.char.loaded[client.getNetVar(client, "char")] then
		local id = client:getChar():getID()
		self:SetUserRank(nil, self.users[id], client)
		--client:setNetVar("usergroup", self.users[id] or "newbie")
		--client:ChatPrint("You are currently in the '"..client:GetUserGroup().."' group of the server.")
	end
end

function PLUGIN:SetUserRank(steamid, group, client)
	if (!group) then
		group = "Рекрут"
	end

	group = string.lower(group)
	if (self.ranks[group]) then
		if (IsValid(client)) then
			self.users[client:getChar():getID()] = group
			client:setNetVar("factiongroup", self.users[client:getChar():getID()])
			--client:ChatPrint("Ваше текущее звание во фракции: '"..client:GetUserRank().."'")
		end
	else
		client:ChatPrint("[WitcherRP] Обнаружена ошибка в модуле factionmenu [#88]! Обратитесь к администратору.")
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

function PLUGIN:AddToFaction(client, faction)
	if (IsValid(client)) then
		PLUGIN:SetUserRank(nil, "Рекрут", client)
		client:getChar():setFaction(faction)
	end
end
function PLUGIN:RemoveFromFaction(client)
	if IsValid(client) then
		self:SetUserRank(nil, "Рекрут", client)
		local character = client:getChar()
		character:setFaction(defaultfaction)
		character:setModel(table.Random(nut.faction.indices[defaultfaction].models))
		character.vars.faction = nut.faction.indices[defaultfaction].uniqueID
	end
end

nut.util.include("cl_derma.lua")
nut.util.include("sh_commands.lua")