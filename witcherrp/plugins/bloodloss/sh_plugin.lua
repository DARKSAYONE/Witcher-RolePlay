local PLUGIN = PLUGIN;

PLUGIN.name = "Bleeding"
PLUGIN.author = "---==ANONIM-TEC==---, AleXXX_007"
PLUGIN.desc = "Adds chance to give a bleeding while getting damage."

nut.flag.add("B", "Иммунитет к критическим эффектам.")

nut.emotes.splintstart = {
	"начинает накладывать себе шину.",
	"достает шину и начинает накладывать ее на свою ногу.",
	"прикладывает шину и фиксирует конечность.",
	"чуть присев, начинает фиксировать поврежденную конечность шиной."
}

nut.emotes.splintend = {
	"фиксирует шину красивым узелком.",
	"фиксирует шину кривым узелком.",
	"заканчивает накладывать шину.",
	"крепко фиксирует шину на поврежденной конечности."
}

nut.emotes.splintstart1 = {
	"начинает накладывать шину на ногу раненого.",
	"достает шину и начинает накладывать ее на ногу раненого.",
	"прикладывает шину и фиксирует конечность.",
	"присев, начинает фиксировать поврежденную конечность раненого шиной."
}

nut.emotes.splintstop = {
	"прерывает наложение шины и сворачивает ее.",
	"прекращает накладывать шину и убирает ее.",
	"не закончив наложение шины, снимает ее с поврежденной конечности и сворачивает в рулон."
}

nut.emotes.bandagestart = {
	"начинает перевязку.",
	"достает бинт и начинает перевязываться.",
	"наматывает бинт себе на руку.",
	"приседает и начинает перевязывать свою ногу."
}

nut.emotes.bandagestart1 = {
	"начинает перевязку.",
	"достает бинт и начинает перевязывать плечо раненого.",
	"наматывает бинт на руку раненого.",
	"приседает и начинает перевязывать ногу раненого."
}

nut.emotes.bandagestop = {
	"прерывает перевязку и сворачивает бинт.",
	"прекращает наматывать бинт и убирает его.",
	"не закончив перевязки, снимает бинт с раны и сворачивает его в рулон."
}

nut.emotes.bandageend = {
	"завязывает бинт красивым узелком.",
	"завязывает бинт кривым узелком.",
	"заканчивает перевязку.",
	"заправляет конец бинта под повязку."
}

nut.emotes.pinch = {
	"зажимает рану на своем плече.",
	"шипя от боли, прижимает рукой рану на боку.",
	"зажмуривается от боли и зажимает глубокий порез на бедре.",
	"со всей силы зажимает ладонями рану, стараясь не допустить дальнейшей потери крови.",
	"падает на колено от боли в области живота и со всей силы пытается зажать ладонями ранение."
}

nut.emotes.breaklegs = {
	"вдруг чувствует резкую боль в колене и падает на землю.",
	"слышит хруст в своей ноге и падает вниз.",
	"вдруг падает на землю из-за резкой боли в стопе.",
}

nut.command.add("pinch", {
	onRun = function(client, arguments)
		if client:getChar():getData("bleeding", false) then
			if (client.nextPinch or 0) <= CurTime() then
				client.nextPinch = CurTime() + 30
				client:getChar():setData("bleeding_level", client:getChar():getData("bleeding_level", 0) - 1)
				timer.Simple(1, function()
					client:emote("pinch")
				end)
			end			
		end		
	end
})
--[[nut.command.add("broke", {
	onRun = function(client, arguments)
		client:getChar():setData("brokenLegs", 0)
	end
})


function PLUGIN:PlayerTick(player, moveData)
	if player:Alive() and player:getChar() then
		if player:getChar():getData("brokenLegs", 0) > CurTime() and !player:IsProne() then
			player:ConCommand("prone")
		end
	end
end
]]
if (CLIENT) then
	function PLUGIN:RenderScreenspaceEffects()
		if (LocalPlayer():getChar()) then
			local infect = LocalPlayer():getChar():getData("bleeding");

			if (LocalPlayer():getChar() and LocalPlayer():Alive()) then
				if infect == true then
						
					local effect = {}
					effect["$pp_colour_addr"] = 0.1
					effect["$pp_colour_mulr"] = 0.3
					

					DrawMotionBlur(0.1, 0.2, 0.3)
					DrawColorModify(effect) 
				end;	
			end;
		end;
	end;
	
	function PLUGIN:PlayerBindPress(player, bind, pressed)
		if (string.find(bind, "impulse 100")) and player:getChar():getData("bleeding") then
			player:ConCommand("say /pinch")
			return true
		end
	end
	
else

	timer.Create("bleeding_tick", 5, 0,
	
	function()
	
		for _, client in ipairs(player.GetAll()) do
		
			local char = client:getChar()
			
			if (client:Alive() and char) then	
			
				if char:getData( "bleeding" ) == true then
					
					local d = DamageInfo()
					d:SetDamage(1+(char:getData("bleeding_level", 0)*0.1))
					if d:GetDamage() >= client:Health() then
						client:TakeDamage(1+(char:getData("bleeding_level")*0.1))
						return
					end
					client:TakeDamageInfo(d)
				
					char:setData( "bleeding_level", char:getData("bleeding_level", 0) + 0.5 );
					
					local effectdata = EffectData()					
					local pos, ang = client:GetBonePosition(client:LookupBone("ValveBiped.Bip01_Spine4"))
					effectdata:SetStart(pos)
					effectdata:SetOrigin(pos)
					effectdata:SetAttachment(client:LookupBone("ValveBiped.Bip01_Spine4"))
					effectdata:SetEntity(client)
					effectdata:SetMagnitude( 1 )
					effectdata:SetRadius( 1 )
					util.Effect( "BloodImpact", effectdata, true, true )
					
					util.Decal( "blood", client:GetPos() + Vector(math.random(1,30),-math.random(1,30),0), client:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
					util.Decal( "blood", client:GetPos() + Vector(-math.random(1,30),math.random(1,25),0), client:GetPos() - Vector(math.random(15,25),math.random(15,25),50))
					util.Decal( "blood", client:GetPos() + Vector(math.random(1,35),-math.random(1,35),0), client:GetPos() - Vector(math.random(25,35),math.random(25,35),50))
					util.Decal( "blood", client:GetPos() + Vector(-math.random(1,35),math.random(1,35),0), client:GetPos() - Vector(math.random(25,35),math.random(25,35),50))
					util.Decal( "blood", client:GetPos() + Vector(math.random(1,30),math.random(1,30),0), client:GetPos() - Vector(math.random(1,10),math.random(1,10),50))
					break
					
				end;
				
			end;
			
		end;
	end	
	)

	function PLUGIN:EntityTakeDamage( target, dmginfo )

		if target:IsPlayer() and !target:getChar():hasFlags("B") and (dmginfo:IsBulletDamage() or dmginfo:IsDamageType( DMG_SLASH ) or dmginfo:IsDamageType( DMG_CLUB )) then 
			if (math.random(1, 20) == 1) then
				target:getChar():setData( "bleeding", true)
			end
		end
		
		--if target:IsPlayer() and dmginfo:IsFallDamage() and math.random(1, 10) == 1 and !target:getChar():hasFlags("B") and dmginfo:IsDamageType(DMG_CRUSH) then
		--	target:getChar():setData("brokenLegs", CurTime() + 600)
		--	target:ConCommand("prone")
		--	target:emote("breaklegs")
		--end		
	end;
	
	function PLUGIN:ScalePlayerDamage(player, hitGroup, dmginfo)
		--if (hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG) and math.random(1, 10) and !target:getChar():hasFlags("B") then
		--	player:getChar():setData("brokenLegs", CurTime() + 600)
		--	player:ConCommand("prone")
		--	player:emote("breaklegs")
		--end
	end	
end