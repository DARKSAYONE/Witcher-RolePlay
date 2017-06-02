ITEM.name = "Зелье"
ITEM.category = "Зелья"
ITEM.desc = "Склянка со странной жидкостью, отдающей алкоголем."
ITEM.model = "models/toussaint_bottle8.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.quantity = 0

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local quantity = item:getData("quantity", item.quantity or 1)
		draw.SimpleText(quantity, "nutIconFont", 4, y, Color(255, 255, 255, 255))
	end
end

ITEM.functions.use = {
	name = "Выпить",
	icon = "icon16/cup.png",
	onRun = function(item)
		local client = item.player		
		client:emote("drink")
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
	end
}

function ITEM:onInstanced()
	if !self:getData("quantity") then
		self:setData("quantity", self.quantity)
	end
end