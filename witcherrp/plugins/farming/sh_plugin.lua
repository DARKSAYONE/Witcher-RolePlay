PLUGIN.name = "Farming System"
PLUGIN.author = "DrodA & AleXXX_007"
PLUGIN.desc = "New Brand Farming System."
function PLUGIN:SaveData()
	local savedTable = {}

	for k, v in ipairs(ents.GetAll()) do
		if (v:GetClass() == "nut_culture") then
			table.insert(savedTable, {
				pos = v:GetPos(),
				ang = v:GetAngles(),
				model = v:GetModel(),
				spawn = v:getNetVar("spawn"),
				grow = v:getNetVar("grow"),
				uid = v.uid,
				})
		end
	end

	self:setData(savedTable)
end

function PLUGIN:LoadData()
	local savedTable = self:getData() or {}

	for k, v in ipairs(savedTable) do
		local culture = ents.Create("nut_culture")
		culture:SetPos(v.pos)
		culture:SetAngles(v.ang)
		culture:setNetVar("spawn", v.spawn)
		culture:setNetVar("grow", v.grow)
		culture:Spawn()
		culture:Activate()
		culture:SetModel(v.model)
		culture.uid = v.uid
	end
end