ITEM.name = "Аптечка"
ITEM.category = "Медицина"
ITEM.desc = "Сверток, в котором находится несколько бинтов и припарка."
ITEM.model = "models/items/provisions/food_ratio/food_ratio02.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.permit = "misc"
ITEM.isHealthkit = true
ITEM.quantity = 1

ITEM.healSeconds = 10
ITEM.health = 0
ITEM.sound = "hgn/crussaria/items/itm_clothing_up.wav"

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local quantity = item:getData("quantity", item.quantity or 1)
		draw.SimpleText(quantity, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end


local function Heal(client, target, amount, seconds)
	if (client:Alive() and target:Alive()) then
	local medic = client:getChar():getAttrib("mdc")
	local id = "nutHeal_"..FrameTime()
		if target:getChar():getData("bleeding", false) then
			target:getChar():setData("bleeding", false)
			target:getChar():setData("bleeding_level", math.Round(target:getChar():getData("bleeding_level", 0) / 2))
		end
		if target:getChar():getData("brokenLegs", 0) > CurTime() then
			target:getChar():setData("brokenLegs", CurTime() + (target:getChar():getData("brokenLegs", 0) - CurTime()) / 2)
		end
		timer.Create(id, 1, seconds, function()
			if (!target:IsValid() or !target:Alive()) then
				timer.Destroy(id)	
			end
			target:SetHealth(math.Clamp(target:Health() + ((amount+(medic/5))/seconds), 0, target:GetMaxHealth()))
		end)
	end
end

ITEM.functions.Use = { 
	name = "Использовать",
	icon = "icon16/add.png",
	onRun = function(item)
	local client = item.player;
	local char = client:getChar()
			Heal(client, client, item.health, item.healSeconds)
			client:getChar():updateAttrib("mdc", amount*0.001)
			client:EmitSound(item.sound, 60, 100)
			item:setData("quantity", item:getData("quantity") - 1)
			if item:getData("quantity") == 0 then
				return true
			end
			return false
	end,
	
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

ITEM.functions.UseOn = { 
	name = "Использовать на ...",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
	local char = item.player:getChar()
	local client = item.player
	local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
	local target = trace.Entity

	if (target and target:IsValid() and target:IsPlayer() and target:Alive()) then
		Heal(client, target,item.health, item.healSeconds)
		target:EmitSound(item.sound, 60, 100)
		item:setData("quantity", item:getData("quantity") - 1)
		if item:getData("quantity") == 0 then
			return true
		end
		return false
	end
	
	return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onInstanced()
	if !self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end