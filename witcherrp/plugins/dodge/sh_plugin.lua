PLUGIN.name = "Dodge"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Allows players to dodge."
if (SERVER) then
	hook.Add("KeyPress","DashBackward",function(ply,key)
		if key != IN_WALK then return end
		if ply:OnGround() and ply:KeyDown(IN_BACK) and !ply:Crouching() and (ply.nextDodge or 0) <= CurTime() then
			ply.nextDodge = CurTime() + 1
			local skill = ply:getChar():getAttrib("stm", 0)
			local value = ply:getLocalVar("stm", 0) - 40 + skill/10
			if (value <= 0) then
				return
			end
			local power = 700 + skill*5
			ply:leaveSequence()
			ply:setLocalVar("stm", value)
			ply:getChar():updateAttrib("stm", 0.01)
			ply:ViewPunch(Angle(-5, 0, 0));
			ply:SetLocalVelocity((ply:GetForward() * -1) * power);
			ply:EmitSound("physics/flesh/flesh_impact_hard".. math.random(1, 6) ..".wav", 75)
		end
	end)
	
	hook.Add("KeyPress","DashForward",function(ply,key)
		if key != IN_WALK then return end
		if ply:OnGround() and ply:KeyDown(IN_FORWARD) and !ply:Crouching() and (ply.nextDodge or 0) <= CurTime() then
			ply.nextDodge = CurTime() + 1
			local skill = ply:getChar():getAttrib("stm", 0)
			local value = ply:getLocalVar("stm", 0) - 40 + skill/10
			if (value <= 0) then
				return
			end
			local power = 700 + skill*5
			ply:leaveSequence()
			ply:setLocalVar("stm", value)
			ply:getChar():updateAttrib("stm", 0.01)
			ply:ViewPunch(Angle(5, 0, 0));
			ply:SetLocalVelocity((ply:GetForward() * 1) * power);
			ply:EmitSound("physics/flesh/flesh_impact_hard".. math.random(1, 6) ..".wav", 75)
		end
		if not ply:OnGround() then
			return
		end
	end)
	
	hook.Add("KeyPress","DashRight",function(ply,key)
		if key != IN_WALK then return end
		if ply:OnGround() and ply:KeyDown(IN_MOVERIGHT) and !ply:Crouching() and (ply.nextDodge or 0) <= CurTime()  then
			ply.nextDodge = CurTime() + 1
			local skill = ply:getChar():getAttrib("stm", 0)
			local value = ply:getLocalVar("stm", 0) - 40 + skill/10
			if (value <= 0) then
				return
			end
			local power = 700 + skill*5
			ply:leaveSequence()
			ply:setLocalVar("stm", value)
			ply:getChar():updateAttrib("stm", 0.01)
			ply:ViewPunch(Angle(0, 0, 10));
			ply:SetLocalVelocity((ply:GetRight() * 1) * power);
			ply:EmitSound("physics/flesh/flesh_impact_hard".. math.random(1, 6) ..".wav", 75)
		end
		if not ply:OnGround() then
			return
		end
	end)	
	hook.Add("KeyPress","DashLeft",function(ply,key)
		if key != IN_WALK then return end
		if ply:OnGround() and ply:KeyDown(IN_MOVELEFT) and !ply:Crouching() and (ply.nextDodge or 0) <= CurTime()  then
			ply.nextDodge = CurTime() + 1
			local skill = ply:getChar():getAttrib("stm", 0)
			local value = ply:getLocalVar("stm", 0) - 40 + skill/10
			if (value <= 0) then
				return
			end
			local power = 700 + skill*5
			ply:leaveSequence()
			ply:setLocalVar("stm", value)
			ply:getChar():updateAttrib("stm", 0.01)
			ply:ViewPunch(Angle(0, 0, -10));
			ply:SetLocalVelocity((ply:GetRight() * -1) * power);
			ply:EmitSound("physics/flesh/flesh_impact_hard".. math.random(1, 6) ..".wav", 75)
		end
		if not ply:OnGround() then
			return
		end
	end)	
end