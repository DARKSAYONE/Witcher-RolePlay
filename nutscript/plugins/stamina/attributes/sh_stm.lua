ATTRIBUTE.name = "Ловкость"
ATTRIBUTE.desc = "Влияет на скорость бега."

function ATTRIBUTE:onSetup(client, value)
	client:SetRunSpeed(nut.config.get("runSpeed") + value)
end