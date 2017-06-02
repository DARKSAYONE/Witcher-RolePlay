local PLUGIN = PLUGIN
PLUGIN.name = "Campfire"
PLUGIN.author = "---==ANONIM-TEC==--- & AleXXX_007"
PLUGIN.desc = "Adds working campfire with tinder box to make them."

nut.config.add("campfireLifeTime", 300, "Сколько времени будет гореть костер.", nil, {
	data = {min = 1, max = 3600},
	category = "Костер"
})
