PLUGIN.name = "Pac Flag"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Добавляет 'P' флаг, разрешающий использовать PAC3. Также добавляет возможность запрета доступа к PAC3."

nut.flag.add("P", "Доступ к редактору PAC3.")

hook.Add( "PrePACEditorOpen", "FlagCheck", function( client )
   if not client:getChar():hasFlags("P") then
       return false
   end
end )

nut.command.add("pacban", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function (client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])		
		pace.Ban(target)
		client:notify("Игроку "..target:Name().." теперь запрещено использовать PAC3.")
	end
})

nut.command.add("pacunban", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function (client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])		
		pace.Unban(target)
		client:notify("Игроку "..target:Name().." теперь разрешено использовать PAC3.")
	end
})