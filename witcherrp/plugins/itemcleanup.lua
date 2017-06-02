PLUGIN.name = "Item Cleanup"
PLUGIN.author = "Dremek"
PLUGIN.desc = "Cleans up items after a period of time."

if (SERVER) then
	timer.Create( "itemcleanup", 1800, 0, function()
		for k, itm in pairs( ents.FindByClass( "nut_item" ) ) do
			if ( itm.lifetime ) then
				if ( itm.lifetime == true ) then
					itm:Remove()
				end
			else
				itm.lifetime = true
			end
		end
	end)
	timer.Create( "culturecleanup", 1800, 0, function()
		for k, itm in pairs( ents.FindByClass( "nut_culture" ) ) do
			if ( itm.lifetime ) then
				if ( itm.lifetime == true ) then
					itm:Remove()
				end
			else
				itm.lifetime = true
			end
		end
	end)
end

nut.command.add("itemclean", {
	adminOnly = true,
	onRun = function (client, arguments)
		for k, itm in pairs( ents.FindByClass( "nut_item" ) ) do
			if ( itm.lifetime ) then
				if ( itm.lifetime == true ) then
					itm:Remove()
				end
			else
				itm.lifetime = true
			end
		end
	end
})