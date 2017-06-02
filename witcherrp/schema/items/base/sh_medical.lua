ITEM.name = "Медицина"
ITEM.desc = "Simple."
ITEM.category = "Медицина"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.healSeconds = 10
ITEM.health = 0
ITEM.sound = "hgn/crussaria/items/itm_clothing_up.wav"

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
		client:getChar():updateAttrib("mdc", amount*0.0025)
	end
end

ITEM.functions.Use = { 
	name = "Использовать",
	icon = "icon16/add.png",
	onRun = function(item)
	local client = item.player;
	local char = client:getChar()
			Heal(client,client,item.health, item.healSeconds)
			client:EmitSound(item.sound, 60, 100)
			
	return true
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
			Heal(client,target,item.health, item.healSeconds)
			target:EmitSound(item.sound, 60, 100)
			return true
	end
	
	return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}