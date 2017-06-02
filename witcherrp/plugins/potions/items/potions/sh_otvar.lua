ITEM.name = "Отвар"
ITEM.category = "Зелья"
ITEM.desc = "Целебный отвар, ускоряющий заживление ран."
ITEM.model = "models/toussaint_bottle9.mdl"
ITEM.quantity = 2

local function Heal(client, target, amount, seconds)
	hook.Run("OnPlayerHeal", client, target, amount, seconds)
	
	if (client:Alive() and target:Alive()) then
	local medic = client:getChar():getAttrib("mdc")
	local id = "nutHeal_"..FrameTime()
		timer.Create(id, 1, seconds, function()
			if (!target:IsValid() or !target:Alive()) then
				timer.Destroy(id)	
			end
			target:SetHealth(math.Clamp(target:Health() + ((amount+(medic/5))/seconds), 0, target:GetMaxHealth()))
			if target:getChar():getData("bleeding") then
				target:getChar():setData("bleeding_level", target:getChar():getData("bleeding_level") - 1)
			end
		end)
	end
end

ITEM:hook("use", function(item)
	local client = item.player
	Heal(client, client, 100, 30)
end)
