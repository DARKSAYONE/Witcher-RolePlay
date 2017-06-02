PLUGIN.name = "Revive"
PLUGIN.author = "_FR_Starfox64 (NS 1.0), Neon (NS 1.1), AleXXX_007"
PLUGIN.desc = "Players never dies! They just lose consciousness."

nut.emotes.succrevive = {
	"спустя некоторое время возни с ранениями, успешно приводит в чувство раненого.",
	"долго провозившись, зашивает последнюю рану и перебинтовывает ее. Сразу после этого раненый очнулся.",
	"предварительно оказав первую помощь, легонько бьет по щекам раненого, приводя его в чувство.",
	"вытирает пот со лба, закончив возиться с раненым. Через некоторое время он приходит в чувства."
}

nut.emotes.failrevive = {
	"вдруг осознает, что раненый не дышит, а пульс не прощупывается. Раненый мертв.",
	"случайно задевает рукой рану, что вызывает обильное кровотечение и смерть раненого.",
	"убивает раненого своей некомпетентной медицинской 'помощью'.",
	"понимает, что раненый скончался."
}

nut.emotes.death = {
	"здох",
	"падает вниз, предварительно закатив глаза.",
	"от полученных ранений падает без сознания.",
	"теряет сознание от болевого шока и падает.",
	"теряет равновесие и падает на землю, затем теряет сознание.",
	"закрывает глаза из-за отсутствия сил и теряет сознание."
}

local PLUGIN = PLUGIN

local charMeta = nut.meta.character
if (SERVER) then
	function charMeta:decreaseAttribs(chnc, force)
		local chance = math.random(1, 100)
		local attribs = {}
		for k, v in SortedPairsByMemberValue(nut.attribs.list, "name") do
			local value = self:getAttrib(k, 0)
			if value > 0 and chance <= chnc then
				local val = value * 0.01 * (100 - force)
				attribs[k] = value - val
				self:setAttrib(k, val)
			end
		end
		self:setData("lostAttribs", attribs)
	end

	function charMeta:restoreAttribs(force)
		local attribs = self:getData("lostAttribs")
		if !attribs then return end
		for k, v in pairs(self:getData("lostAttribs")) do
			local value = self:getAttrib(k, 0) + (v * 0.01 * force)
			self:setAttrib(k, value)
			attribs[k] = nil
		end
		self:setData("lostAttribs", nil)
	end
end

nut.command.add("respawn", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function (client, arguments)
	local target
		if arguments[1] == nil then
			target = client
		end	
		if !target then
			target = nut.command.findPlayer(client, arguments[1])
		end
		if target:getChar() then
			local check, pos
			for k,v in ipairs(ents.FindByClass("prop_ragdoll")) do
				if (IsValid(v.player) and v.player == target) then
					check = true
					pos = v:GetPos()
				end
			end
			if check then
				target:UnSpectate()
				target:Spawn()
				target:SetPos(pos)
				target:getChar():restoreAttribs(100)
				target:notify("Вы были возрождены!")
				client:notify("Персонаж ".. target:getChar():getName() .." был возрожден.")
			else
				client:notify("Персонаж ".. target:getChar():getName() .." находится в добром здравии и не может быть возрожден.")
			end
		end
	end
})

if CLIENT then
	local owner, w, h, ceil, ft, clmp
	ceil = math.ceil
	clmp = math.Clamp
	local aprg, aprg2 = 0, 0
	function nut.hud.drawDeath()
		owner = LocalPlayer()
		ft = FrameTime()
		w, h = ScrW(), ScrH()

		if (owner:getChar()) then
			if (owner:Alive()) then
				if (aprg != 0) then
					aprg2 = clmp(aprg2 - ft*1.3, 0, 1)
					if (aprg2 == 0) then
						aprg = clmp(aprg - ft*.7, 0, 1)
					end
				end
			else
				if (aprg2 != 1) then
					aprg = clmp(aprg + ft*.5, 0, 1)
					if (aprg == 1) then
						aprg2 = clmp(aprg2 + ft*.4, 0, 1)
					end
				end
			end
		end

		if (IsValid(nut.char.gui) and nut.gui.char:IsVisible() or !owner:getChar()) then
			return
		end

		surface.SetDrawColor(25, 0, 0, ceil((aprg^.5) * 155))
		surface.DrawRect(-1, -1, w+2, h+2)
		local tx, ty = nut.util.drawText("Вы без сознания.", w/2, h/10, ColorAlpha(color_white, aprg2 * 255), 1, 1, "nutDynFontMedium", aprg2 * 255)
	end
	
	netstream.Hook("nut_DeadBody", function( index )
		local ragdoll = Entity(index)

		if IsValid(ragdoll) then
			ragdoll.isDeadBody = true
		end
	end)
else
	function PLUGIN:PlayerSpawn( client )
		client:UnSpectate()
		if not client:getChar() then 
			return 
		end

		if IsValid(SCHEMA.Corpses[client]) then
			SCHEMA.Corpses[client]:Remove()
		end
	end

	--[[
		Purpose: Called when the player has died with a valid character.
	--]]

	SCHEMA.Corpses = SCHEMA.Corpses or {}

	function SCHEMA:DoPlayerDeath( client, attacker, dmg )
		if not client:getChar() then 
			return 
		end
		
		client:getChar():decreaseAttribs(20, math.random(10, 20))
		client:ChatPrint("Некоторые навыки Вашего персонажа были понижены!")
		client:emote("death")
		client:getChar():setData( "bleeding", false);
		client:getChar():setData( "bleeding_level", 0);
		
		SCHEMA.Corpses[client] = ents.Create("prop_ragdoll")
		SCHEMA.Corpses[client]:SetPos(client:GetPos())
		SCHEMA.Corpses[client]:SetModel(client:GetModel())
		SCHEMA.Corpses[client]:Spawn()
		SCHEMA.Corpses[client]:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		local phys = SCHEMA.Corpses[client]:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:ApplyForceCenter(client:GetVelocity() * 15);
			phys:SetMass(200)
		end
		SCHEMA.Corpses[client].player = client
		SCHEMA.Corpses[client]:SetNWFloat("Time", CurTime() + nut.config.deathTime)
		SCHEMA.Corpses[client]:SetNWBool("Body", true)

		timer.Simple(0.5, function()
			netstream.Start(nil, "nut_DeadBody", SCHEMA.Corpses[client]:EntIndex())
		end)

		hook.Run("GenerateEvidences", client, SCHEMA.Corpses[client], attacker, dmg)
		client:getChar():resetParts()
		client:Spectate(OBS_MODE_CHASE)
		client:SpectateEntity(SCHEMA.Corpses[client])
		timer.Simple(0.01, function()
			if(client:GetRagdollEntity() != nil and client:GetRagdollEntity():IsValid()) then
				client:GetRagdollEntity():Remove()
			end
		end)
	end
	
	function PLUGIN:EntityTakeDamage(entity, dmg)
		if entity.player and dmg:GetDamage() > 30 and dmg:GetAttacker():IsPlayer() then
			entity.player:setNetVar("deathTime", CurTime())
			local corpse = ents.Create("prop_ragdoll")
			corpse:SetPos(entity:GetPos())
			corpse:SetModel(entity:GetModel())
			corpse:SetAngles(entity:GetAngles())
			corpse:Spawn()
			timer.Simple(180, function()
				corpse:Remove()
			end)
		end
	end
	
	function RevivePlayer(client)
		local check, pos
		for k,v in ipairs(ents.FindByClass("prop_ragdoll")) do
			if (IsValid(v.player) and v.player == client) then
				check = true
				pos = v:GetPos()
				
				break
			end
		end
		if !check then return end
		
		client:UnSpectate()
		client:Spawn()
		client:SetPos(pos)
	end
	
	function PLUGIN:KeyRelease(client, key)
		if (key == IN_USE) then
			local tr = util.TraceLine({
			 start  = client:GetShootPos(),
			 endpos = client:GetShootPos() + client:GetAimVector() * 84,
			 filter = client,
			 mask   = MASK_SHOT
			})
			if tr.Hit and IsValid(tr.Entity) and IsValid(tr.Entity.player) then
				if (client:KeyDown(IN_WALK)) then
					client:ConCommand("say /charsearch")
					return
				end
				local text = "Вы пытаетесь привести в чувство "
				local text1 = "Вас пытаются привести в чувство..."
				local item
				local add = client:getChar():getAttrib("mdc", 0) / 4
				for k, v in pairs(client:getChar():getInv():getItems()) do
					if v.isHealthkit then
						item = v
						add = add + v.health / 2
						text = "Вы пытаетесь оказать первую помощь "
						text1 = "Вам пытаются оказать первую помощь..."
						break
					end
				end
				if add >= 30 then
					client:ChatPrint("Вы не сомневаетесь в успешности операции.")
				elseif add < 30 and add >= 20 then
					client:ChatPrint("Вы понимаете, что существует малый шанс случайно умертвить раненого.")
				elseif add < 20 and add >= 10 then
					client:ChatPrint("Вы осознаете, что рискуете, приводя в чувство раненого.\nВозможно, это убьет его.")
				else
					client:ChatPrint("Вы очень сильно рискуете, приводя в чувство раненого.\nЭто с очень большим шансом убьет его.")
				end
				local force = math.random(1, 100) + add
				local entity = tr.Entity
				entity.nutBeingGetUp = true
				entity.player:setAction(text1, 5)

				client:setAction(text .. entity.player:getChar():getName()..".", 5)
				client:doStaredAction(entity, function()
					if force >= 30 then
						client:emote("succrevive")
						if item then
							item:setData("quantity", item:getData("quantity") - 1)
						end
						entity.nutBeingGetUp = false
						RevivePlayer(entity.player)
						entity.player:getChar():restoreAttribs(math.min(force, 100))
						entity.player:SetHealth(math.min(50 * 0.01 * force, 100))
					else
						client:emote("failrevive")
						entity.player:setNetVar("deathTime", CurTime())
						if item then
							item:setData("quantity", item:getData("quantity") - 1)
						end
						local corpse = ents.Create("prop_ragdoll")
						corpse:SetPos(entity:GetPos())
						corpse:SetModel(entity:GetModel())
						corpse:SetAngles(entity:GetAngles())
						corpse:Spawn()
					end
				end, 5, function()
					if (IsValid(entity)) then
						entity.nutBeingGetUp = false
						entity.player:setAction()
					end

					if (IsValid(client)) then
						client:setAction()
					end
				end)				
			end
		end
	end
end