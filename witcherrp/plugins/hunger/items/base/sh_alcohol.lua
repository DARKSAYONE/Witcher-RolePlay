ITEM.name = "Alcohol"
ITEM.desc = "Simple."
ITEM.category = "Alcohol"
ITEM.model = "models/props/furnitures/gob/l6_jar_oil/l6_jar_oil.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.force = 0
ITEM.thirst = 0
ITEM.hunger = 0
ITEM.fatigue = 0
ITEM.quantity = 1

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local quantity = item:getData("quantity", item.quantity or 1)
		draw.SimpleText(quantity, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

ITEM.functions.Eat = {
	onRun = function(item)
		local client = item.player
		local quantity = item:getData("quantity", item.quantity)
		if item.hunger ~= 0 then client:getChar():restoreHunger(item.hunger) end
		if item.thirst ~= 0 then client:getChar():restoreThirst(item.thirst) end
		if item.fatigue ~= 0 then client:getChar():restoreFatigue(item.fatigue) end
		if item.force > 0 then client:getChar():addDrunk(math.Round(item.force / (item.quantity or 1))) end
		if item.force < 0 then client:getChar():removeDrunk(-math.Round(item.force / (item.quantity or 1))) end
		item:setData("quantity", item:getData("quantity", item.quantity or 0) - 1)
		client:EmitSound("witcherrp/drink/openbottle"..math.random(1, 5)..".ogg")
		timer.Simple(0.5, function()			
			client:EmitSound("witcherrp/drink/drink"..math.random(1, 3)..".ogg")
			timer.Simple(0.5, function()
				client:EmitSound("witcherrp/drink/smallow"..math.random(1, 5)..".ogg")
			end)
		end)
		if item:getData("quantity") < 1 then
			client:getChar():getInv():add("water_empty")
			return true
		end
		return false
	end,
	onCanRun = function(item)
		return (!item.empty)
	end,
	icon = "icon16/cup.png",
	name = "Употребить"
}

function ITEM:onInstanced()
	if !self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end