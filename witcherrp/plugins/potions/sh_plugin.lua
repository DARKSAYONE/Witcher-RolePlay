PLUGIN.name = "Potions"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Adds useful potions."

nut.emotes.drink = {
	"открывает бутылочку, подносит ее ко рту и делает глоток.",
	"вскрывает сосуд с характерным звуком, затем выпивает часть содержимого.",
	"раскупоривает склянку и выпивает часть содержимого.",
	"достает бутылочку, вскрывает ее и делает пару глотков.",
	"выпивает содержимое сосуда, предварительно открыв его."
}

hook.Add("SetupMove", "RunBuff", function(player, movedata)
	if player:getLocalVar("speedBuff", 0) > 0 then
		player:SetRunSpeed(nut.config.get("runSpeed") + player:getLocalVar("speedBuff", 0))
	end
end)
if (CLIENT) then
	function PLUGIN:RenderScreenspaceEffects()
		if LocalPlayer():getLocalVar("nightPotion", 0) > 0 then
			local color = {}
			color["$pp_colour_addr"] = 0
			color["$pp_colour_addg"] = 0
			color["$pp_colour_addb"] = 0
			color["$pp_colour_brightness"] = -0.01 + (0.71 * 0.01 * LocalPlayer():getLocalVar("nightPotion", 0))
			color["$pp_colour_contrast"] = 1
			color["$pp_colour_colour"] = 1.2 - (1.1 * 0.01 * LocalPlayer():getLocalVar("nightPotion", 0))
			color["$pp_colour_mulr"] = 0
			color["$pp_colour_mulg"] = 0
			color["$pp_colour_mulb"] = 0
			DrawColorModify(color)
		end
	end
end