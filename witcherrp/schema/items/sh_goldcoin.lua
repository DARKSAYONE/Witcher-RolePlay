ITEM.name = "Большой кошель с оренами"
ITEM.category = "misc"
ITEM.desc = "Большого размера кошель со завенящими оренами внутри."
ITEM.model = "models/items/jewels/purses/big_purse.mdl"
ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.functions.use = {
	name = "Открыть",
	icon = "icon16/coins.png",
	onRun = function(item)
		local amount = math.random(25, 35)
		item.player:getChar():giveMoney(amount)
		item.player:EmitSound("hgn/crussaria/items/itm_gold_up.wav")
		item.player:ChatPrint("В кошельке было ".. amount .." монет.")
		return true
	end
}