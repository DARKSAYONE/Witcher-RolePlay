local bows = {
	"nut_bow_long",
	"nut_crossbow",
	"nut_bow_nilf",
	"nut_bow_ash"		
}

function PLUGIN:SetupBattleMenu(menu)
	if LocalPlayer():battle_hasTarget(100) then
		local target = LocalPlayer():battle_hasTarget(100)
		--if !LocalPlayer():battle_beingAttacked() then
			menu:addButton("Удар", function()								
				netstream.Start("battle_attack", target)
			end)
			menu:addButton("Удар (прицельный)", function(this)
				local limb = {
					["Голова"] = "голову",
					["Шея"] = "шею",
					["Пах"] = "пах",
					["Живот"] = "живот",
					["Грудь"] = "грудь",
					["Правая рука"] = "правую руку",
					["Левая рука"] = "левую руку",
					["Правая нога"] = "правую ногу",
					["Левая нога"] = "левую ногу"
				}
				local limbs = this:Add("DMenu")
				for k, v in pairs(limb) do					
					limbs:AddOption(k, function()
						netstream.Start("battle_attack_aim", target, v, k)
					end)
				end
				
				limbs:Open()
			end)
			
			menu:addButton("Остановить", function()
				netstream.Start("battle_stop", target)
			end)
		--end
	end
		menu:addButton("Реакция", function()
			netstream.Start("battle_reflex")
		end)

			menu:addButton("Уворот", function()
				netstream.Start("battle_dodge")
			end)
			
			if LocalPlayer():battle_getWeapon() > 0 or LocalPlayer():battle_wearingShield() then
				menu:addButton("Блок", function()
					netstream.Start("battle_block")
				end)
			end
			
			menu:addButton("Побег", function()
				netstream.Start("battle_leave")
			end)
	
	if table.HasValue(bows, LocalPlayer():GetActiveWeapon():GetClass()) and LocalPlayer():battle_hasTarget(1500) and !LocalPlayer():battle_hasTarget(150) and LocalPlayer():GetActiveWeapon():Ammo1() > 0 then
		local target = LocalPlayer():battle_hasTarget(1500)
		menu:addButton("Выстрел", function()				
			netstream.Start("battle_shoot", target)
		end)
		menu:addButton("Выстрел (прицельный)", function(this)
			local limb = {
				["Голова"] = "голову",
				["Шея"] = "шею",
				["Пах"] = "пах",
				["Живот"] = "живот",
				["Грудь"] = "грудь",
				["Правая рука"] = "правую руку",
				["Левая рука"] = "левую руку",
				["Правая нога"] = "правую ногу",
				["Левая нога"] = "левую ногу"
			}
			local limbs = this:Add("DMenu")
			for k, v in pairs(limb) do					
				limbs:AddOption(k, function()
					LocalPlayer():GetActiveWeapon():TakePrimaryAmmo(1)
					netstream.Start("battle_shoot_aim", target, v, k)
				end)
			end
			
			limbs:Open()
		end)
	end
end

function PLUGIN:SetupBattleMenu_attack(menu)
	local player = LocalPlayer()
	menu:addLabel("Реакция", math.Round(player:getChar():getAttrib("stm", 0) / 3 + player:getChar():getAttrib("str", 0) / 3 + player:getChar():getAttrib("end", 0) / 3))
	menu:addLabel("Остановить", math.Round(player:getChar():getAttrib("str", 0) / 3.5 + player:getChar():getAttrib("stm", 0) / 3.5 + player:getChar():getAttrib("melee", 0) / 3.5))
	menu:addLabel("Точность (Рукопаш.)", math.Round(15 + player:getChar():getAttrib("melee", 0) / 1.5 + player:getChar():getAttrib("stm", 0) / 3))
	menu:addLabel("Точность (Одноруч.)", math.Round(10 + player:getChar():getAttrib("onehanded", 0) / 1.5 + player:getChar():getAttrib("stm", 0) / 3))
	menu:addLabel("Точность (Двуруч.)", math.Round(player:getChar():getAttrib("twohanded", 0) / 1.5 + player:getChar():getAttrib("stm", 0) / 3))
	menu:addLabel("Точность (Стрельба)", math.Round(15 + player:getChar():getAttrib("bow", 0) / 2 + player:getChar():getAttrib("stm", 0) / 4 + player:getChar():getAttrib("str", 0) / 4))
	menu:addLabel("Крит (Рукопаш.)", math.Round(player:getChar():getAttrib("melee", 0) / 20).."%")
	menu:addLabel("Крит (Одноруч.)", math.Round(player:getChar():getAttrib("onehanded", 0) / 20).."%")
	menu:addLabel("Крит (Двуруч.)", math.Round(player:getChar():getAttrib("twohanded", 0) / 20).."%")
	menu:addLabel("Крит (Стрельба)", math.Round(player:getChar():getAttrib("bow", 0) / 20).."%")
end

function PLUGIN:SetupBattleMenu_defence(menu)
	local player = LocalPlayer()
	menu:addLabel("Здоровье", player:battle_getHealthPoints().."/"..player:battle_getMaxHealthPoints())
	menu:addLabel("Проворство", math.Round(player:battle_getDodgeChance() / player:getChar():getData("ArmorType", 1)))
	--menu:addLabel("Побег", math.Round(player:battle_getDodgeChance() / player:getChar():getData("ArmorType", 1)))
	menu:addLabel("Блок (Рукопаш.)", math.Round(15 + player:getChar():getAttrib("melee", 0)/2 + player:getChar():getData("end", 0)/5 + player:getChar():getData("str", 0)/5))
	menu:addLabel("Блок (Одноруч.)", math.Round(15 + player:getChar():getAttrib("onehanded", 0)/2 + player:getChar():getData("stm", 0)/5 + player:getChar():getData("str", 0)/5))
	menu:addLabel("Блок (Двуруч.)", math.Round(15 + player:getChar():getAttrib("twohanded", 0)/2 + player:getChar():getData("stm", 0)/5 + player:getChar():getData("str", 0)/5))
	menu:addLabel("Блок (Щиты)", math.Round(25 + player:getChar():getAttrib("shield", 0)/2 + player:getChar():getAttrib("end", 0)/5 + player:getChar():getData("str", 0)/5))
	menu:addLabel("Броня (Колющ.)", (LocalPlayer():battle_getArmorDefence()[DMG_CLUB] or 0 ).."%")
	menu:addLabel("Броня (Режущ.)", (LocalPlayer():battle_getArmorDefence()[DMG_SLASH] or 0 ).."%")
	menu:addLabel("Броня (Дроб.)", (LocalPlayer():battle_getArmorDefence()[DMG_CRUSH] or 0 ).."%")	
end

function PLUGIN:DrawCharInfo(client, character, info)
	local COLOR_HP = Color((255 / client:battle_getMaxHealthPoints()) * (client:battle_getMaxHealthPoints() - client:battle_getHealthPoints()), (255 / client:battle_getMaxHealthPoints()) * client:battle_getHealthPoints(), 0, 255)
	info[#info + 1] = {"Очки Здоровья: "..client:battle_getHealthPoints().."/".. client:battle_getMaxHealthPoints(), COLOR_HP}
end


hook.Add("BuildHelpMenu", "nutBattleHelp", function(tabs)
	tabs["Бой"] = function(node)
			local body = "<font size='+3'>Основы</font><p>Чтобы выбрать какое-либо действие, нужно нажать клавишу 'С', глядя на цель, если это атака. При нажатии одной из кнопок действий, в чат будет отправлено число, определяющее силу данного действия. Все рассчеты происходят автоматически без вмешательства игрока или администратора.</p> <p>РП бой происходит по ходам. Поочередность ходов определяется действием 'Реакция' по убыванию выпавших чисел. Вмешаться в уже идущий бой можно только после двух кругов действий (когда каждый участник хода выполнил действие в свой ход).</p>"
			body = body.."<font size='+3'>Атака и защита</font><p>При атаке одним персонажем другого происходит сравнение двух значений - Точности атаки и Проворства или Стойкости обороняющегося. Если Точность больше Проворства или Стойкости, то атака успешно проходит, нанося урон обороняющемуся. Если Проворство или Стойкость больше значения Точности, то обороняющийся уклонился или заблокировал удар. При равных значениях действия повторяются.</p>"
			body = body.."<font size='+3'>Урон</font><p>При успешных атаках противника Ваш персонаж будет получать ранения разной степени тяжести. Следует в полной мере отыгрывать полученные ранения, исходя из количества нанесенного урона. </p><p>0 - 4 - мелкая царапина или синяк.</p><p>4 - 8 - царапина или слабый ушиб.</p><p>8 - 12 - кровоточащая рана или ушиб.</p><p>12 - 16 - глубокая рана или сильный ушиб.</p><p>16 - 20 - глубокая рана с повреждением кости, перелом.</p><p>20+ - отсечение конечности, взрыв ее вследствие дробящего урона, очень сильное повреждение. В любом из случаев конечность выводится из строя.</p>"
			body = body.."<font size='+3'>Побег</font><p>Персонаж может сбежать из боя, использовав действие 'Побег'. ОДИН из участников боя может попробовать остановить его, использовав действие 'Остановить'. При успешном побеге персонаж покидает бой. При неудачном побеге бой продолжается. Персонаж может попробовать сбежать снова только через 3 круга ходов.</p><p>Также действие 'Остановить' можно использовать для остановки бегущего персонажа. Дабы убежать, он должен использовать действие 'Побег'.</p>"
			body = body.."<font size='+3'>Блок</font><p>Персонаж может попробовать заблокировать удар с помощью своего оружия, щита или рук. При блоке без оружия урон наносится в левую или правую руку персонажа. Кидается /roll, больше 50 - правая.</p>"
			body = body.."<font size='+3'>Прицельная атака</font><p>Вы можете совершить прицельный удар в выбранную часть тела оппонента. В этом случае Вы гарантированно попадете в цель, но показатель точности атаки будет снижен.</p>"
		return body
	end
end)