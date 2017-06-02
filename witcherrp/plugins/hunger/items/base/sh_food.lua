ITEM.name = "Food base"
ITEM.desc = "A food."
ITEM.category = "food"
ITEM.model = "models/props_lab/bindergraylabel01b.mdl"
ITEM.hunger = 0
ITEM.thirst = 0
ITEM.fatigue = 0
ITEM.drunk = 0
ITEM.empty = false
ITEM.quantity = 1
ITEM.permit = "food"
ITEM.emptyItem = ""
if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local quantity = item:getData("quantity", item.quantity or 1)
		draw.SimpleText(quantity, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

ITEM.functions.Eat = {
	onRun = function(item)
		local client = item.player
		if item.hunger ~= 0 then client:getChar():restoreHunger(item.hunger) end
		if item.thirst ~= 0 then client:getChar():restoreThirst(item.thirst) end
		if item.fatigue ~= 0 then client:getChar():restoreFatigue(item.fatigue) end
		if item.drunk > 0 then client:getChar():addDrunk(item.drunk) end
		if item.drunk < 0 then client:getChar():removeDrunk(-item.drunk) end
		item:setData("quantity", item:getData("quantity") - 1)
		client:EmitSound("witcherrp/eat/eating"..math.random(1, 4)..".ogg")
		timer.Simple(0.45, function()			
			client:EmitSound("witcherrp/eat/eating"..math.random(1, 4)..".ogg")
			timer.Simple(0.25, function()
				client:EmitSound("witcherrp/drink/smallow"..math.random(1, 5)..".ogg")
			end)
		end)
		if item:getData("quantity") < 1 then
			if !item.emptyItem then
				client:getChar():getInv():add(item.uniqueID.."_empty")
			else
				client:getChar():getInv():add(item.emptyItem)
			end
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