ENT.Type = "anim"
ENT.PrintName = "Растение"
ENT.Author = "AleXXX_007"
ENT.Category = "NutScript"
ENT.Spawnable = true
ENT.AdminOnly = true

if (CLIENT) then
	function ENT:Draw()
		local mypos = self:GetPos()
		local dist = LocalPlayer():GetPos():Distance(mypos)

		if(dist < 5000) then
			self.Entity:DrawModel()
		end
	end
end


function ENT:Initialize()
	if (SERVER) then
	local chance = math.random(1, 7)
	if chance == 1 then
		self:SetModel("models/aoc_trees/aoc_lowveg1.mdl")
	elseif chance == 2 then
		self:SetModel("models/aoc_trees/aoc_lowveg1.mdl")
	elseif chance == 3 then
		self:SetModel("models/aoc_trees/aoc_lowveg12.mdl")
	elseif chance == 4 then
		self:SetModel("models/aoc_trees/aoc_lowveg16.mdl")
	elseif chance == 5 then
		self:SetModel("models/aoc_trees/aoc_lowveg19.mdl")
	elseif chance == 6 then
		self:SetModel("models/aoc_trees/aoc_lowveg3.mdl")
	else
		self:SetModel("models/aoc_trees/aoc_lowveg4.mdl")
	end		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:SetModelScale(1)
		self:SetNetworkedBool("Usable", true)
		self:SetPersistent(true)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end

function ENT:Use(activator)
	local common = {
	"verbena", --antialcohol, сила
	"mirt", --алкоголь
	"pautinnik", --дурман, кошка
	"voronglaz", --дурман
	"giacinia", --алкоголь, выносливость
	"seed_onion",
	"seed_potato",
	"seed_pumpkin",
	"seed_tomato",
	"seed_wheat",
	"seed_flax",
	"seed_grape"
	}
	local uncommon = {
	"balissa",--специя
	"chemerica", --алкоголь
	"berberika",--специя, кошка
	"shibalci", -- каменная кожа
	"petrushka", --antialcohol	
	}
	local rare = {
	"sporin", -- выносливость
	"plesen", -- ловкость, сила
	"mandragora",--алкоголь
	"omela",--алкоголь
	"han", -- хил, сила
	}
	local skill = activator:getChar():getAttrib("frm")
	if skill == nil then
		skill = 0
	end
	local skilltime = math.random(6, 10) - skill/20
	local chance = math.random(1, 100) + skill/2
	if activator:KeyDown(IN_DUCK) and self:GetNetworkedBool("Usable") == true then
		self:SetNetworkedBool("Usable", false)
		activator:setAction("Собираем растение...", skilltime)
		activator:doStaredAction(self, function()
		local com = table.Random(common)
		local unc = table.Random(uncommon)
		local rar = table.Random(rare)
		local com1 = table.Random(common)
		local unc1 = table.Random(uncommon)
		local rar1 = table.Random(rare)
			if (activator:getChar():getInv():findEmptySlot(1, 1)) then
				if chance >= 50 and chance < 75 then
					activator:getChar():getInv():add(com)
					activator:notify("Вы собрали растение")
				elseif chance >= 75 and chance <90 then
					activator:getChar():getInv():add(unc)
					activator:notify("Вы собрали растение")
				elseif chance >= 90 and chance <100 then
					activator:getChar():getInv():add(rar)
					activator:notify("Вы собрали растение")
				elseif chance >= 100 and chance < 110 then
					activator:getChar():getInv():add(com)
					activator:getChar():getInv():add(com1)
					activator:notify("Вы собрали растения")
				elseif chance >= 110 and chance < 120 then
					activator:getChar():getInv():add(com)
					activator:getChar():getInv():add(unc)
					activator:notify("Вы собрали растения")
				elseif chance >= 120 and chance < 130 then
					activator:getChar():getInv():add(unc)
					activator:getChar():getInv():add(unc1)
					activator:notify("Вы собрали растения")
				elseif chance >= 130 and chance < 140 then
					activator:getChar():getInv():add(unc)
					activator:getChar():getInv():add(rar)
					activator:notify("Вы собрали растения")
				elseif chance >=140 and chance <= 150 then
					activator:getChar():getInv():add(rar)
					activator:getChar():getInv():add(rar1)
					activator:notify("Вы собрали растения")
				else
					activator:notify("Вам не удалось собрать растение!")
				end
			else
				activator:notify("Вам не хватает места в инвентаре!")
				self:SetNetworkedBool("Usable", true)
				return
			end
			activator:getChar():updateAttrib("frm", math.random(0.02, 0.05))
			self:SetModelScale(0.5)
			timer.Simple(math.random(180, 600), function()
				self:SetNetworkedBool("Usable", true)
				self:SetModelScale(1)
				local chance1 = math.random(1, 7)
				if chance1 == 1 then
					self:SetModel("models/aoc_trees/aoc_lowveg1.mdl")
				elseif chance1 == 2 then
					self:SetModel("models/aoc_trees/aoc_lowveg1.mdl")
				elseif chance1 == 3 then
					self:SetModel("models/aoc_trees/aoc_lowveg12.mdl")
				elseif chance1 == 4 then
					self:SetModel("models/aoc_trees/aoc_lowveg16.mdl")
				elseif chance1 == 5 then
					self:SetModel("models/aoc_trees/aoc_lowveg19.mdl")
				elseif chance1 == 6 then
					self:SetModel("models/aoc_trees/aoc_lowveg3.mdl")
				else
					self:SetModel("models/aoc_trees/aoc_lowveg4.mdl")
				end	
			end)
		end, skilltime, function()
			self:SetNetworkedBool("Usable", true)
			if (IsValid(activator)) then
				activator:setAction()
			end
		end)
	elseif !activator:KeyDown(IN_DUCK) then
		activator:notify("Вы должны присесть, чтобы собрать растение.")
	else
		activator:notify("Растение еще не выросло!")
	end
end
function ENT:OnRemove()
	self:SetNetworkedBool("Usable", true)
end