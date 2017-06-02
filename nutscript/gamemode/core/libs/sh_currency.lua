nut.currency = nut.currency or {}
nut.currency.symbol = nut.currency.symbol or "$"
nut.currency.sin = nut.currency.sin or "доллар"
nut.currency.sec = nut.currency.sec or "доллара"
nut.currency.plu = nut.currency.plu or "долларов"

function nut.currency.set(symbol, sing, sec, plu)
	nut.currency.symbol = symbol
	nut.currency.sin = sing
	nut.currency.sec = sec
	nut.currency.plu = plu
end

function nut.currency.get(amount)
	local sec = {
		"2",
		"3",
		"4"
	}
	local sing = {
		"12",
		"13",
		"14"
	}
	if (string.Right(amount, 1) == "1" and string.Right(amount, 2) ~= "11") then
		return nut.currency.symbol..amount.." "..nut.currency.sin
	elseif table.HasValue(sec, string.Right(amount, 1)) and !table.HasValue(sing, string.Right(amount, 2)) then
		return nut.currency.symbol..amount.." "..nut.currency.sec
	else
		return nut.currency.symbol..amount.." "..nut.currency.plu
	end
end

function nut.currency.spawn(pos, amount, angle)
	if (!pos) then
		print("[Nutscript] Can't create currency entity: Invalid Position")
	elseif (!amount or amount < 0) then
		print("[Nutscript] Can't create currency entity: Invalid Amount of money")
	end

	local money = ents.Create("nut_money")
	money:SetPos(pos)
	-- double check for negative.
	money:setNetVar("amount", math.Round(math.abs(amount)))
	money:SetAngles(angle or Angle(0, 0, 0))
	money:Spawn()
	money:Activate()

	return money
end

function GM:OnPickupMoney(client, moneyEntity)
	if (moneyEntity and moneyEntity:IsValid()) then
		local amount = moneyEntity:getAmount()

		client:getChar():giveMoney(amount)
		client:notifyLocalized("moneyTaken", nut.currency.get(amount))
	end
end

do
	local character = nut.meta.character

	function character:hasMoney(amount)
		if (amount < 0) then
			print("Negative Money Check Received.")	
		end

		return self:getMoney() >= amount
	end

	function character:giveMoney(amount)
		self:setMoney(self:getMoney() + amount)

		return true
	end

	function character:takeMoney(amount)
		amount = math.abs(amount)
		self:giveMoney(-amount)

		return true
	end
end