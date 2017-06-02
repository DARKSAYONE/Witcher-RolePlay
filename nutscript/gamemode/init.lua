-- Include NutScript content.
resource.AddWorkshop("207739713")

-- Include features from the Sandbox gamemode.
DeriveGamemode("sandbox")
-- Define a global shared table to store NutScript information.
nut = nut or {util = {}, meta = {}}

-- Send the following files to players.
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("core/sh_util.lua")
AddCSLuaFile("shared.lua")

-- Include utility functions, data storage functions, and then shared.lua
include("core/sh_util.lua")
include("core/sv_data.lua")
include("shared.lua")

-- Connect to the database using SQLite, mysqloo, or tmysql4.
nut.db.connect(function()
	-- Create the SQL tables if they do not exist.
	nut.db.loadTables()
	nut.log.loadTables()
	
	MsgC(Color(0, 255, 0), "NutScript has connected to the database.\n")
end)

-- Resources that are required for players to download are here.
resource.AddFile("materials/nutscript/gui/vignette.png")
resource.AddFile("resource/fonts/fontello.ttf")
resource.AddFile("resource/fonts/witcher.ttf")
resource.AddFile("whistle.wav")
resource.AddFile("talk.wav")
concommand.Add("nut_setowner", function(client, command, arguments)
    if (!IsValid(client)) then
        MsgC(Color(255, 0, 0), "** 'nut_setowner' has been deprecated in NutScript 1.1\n")
        MsgC(Color(255, 0, 0), "** Instead, please install an admin mod and use that instead.\n")
    end
end)

resource.AddWorkshop("109643223") -- 3d2d
resource.AddWorkshop("104604943") -- bodygroup tool
resource.AddWorkshop("104479467") -- door tool
resource.AddWorkshop("104634865") -- no colide world
resource.AddWorkshop("207739713") -- ns content
resource.AddWorkshop("104691717") -- pac3
resource.AddWorkshop("309796347") -- box vis
resource.AddWorkshop("104479831") -- stacker
resource.AddWorkshop("130414613") -- persistent
resource.AddWorkshop("493751477") -- light entities
resource.AddWorkshop("236035765") -- letho
resource.AddWorkshop("242284049") -- triss
resource.AddWorkshop("237641104") -- zoltan
resource.AddWorkshop("672126440") -- plants
resource.AddWorkshop("236113181") -- error hider
resource.AddWorkshop("522764555") -- animals
resource.AddWorkshop("111626188") -- dark messiah npc
resource.AddWorkshop("131759821") -- vjbase
resource.AddWorkshop("156318356") -- lotr models
resource.AddWorkshop("148521442") -- leanna and xana
resource.AddWorkshop("675824914") -- hl2melee
resource.AddWorkshop("104604709") -- animation tool
resource.AddWorkshop("235587037") -- werefolf
resource.AddWorkshop("104603291") -- extended spawnmenu
resource.AddWorkshop("220336312") -- permaprops
resource.AddWorkshop("325822607") -- crussaria 8
resource.AddWorkshop("325791215") -- crussaria 2
resource.AddWorkshop("325795125") -- crussaria 3
resource.AddWorkshop("325814596") -- crussaria 5
resource.AddWorkshop("325800231") -- crussaria 4
resource.AddWorkshop("325817446") -- crussaria 6
resource.AddWorkshop("325818901") -- crussaria 7
resource.AddWorkshop("325787997") -- crussaria 1
resource.AddWorkshop("308933874") -- morr swep fix
resource.AddWorkshop("546724344") -- medieval fantasy weapons
resource.AddWorkshop("701755651") -- wrp
resource.AddWorkshop("701879639") -- wrp2
resource.AddWorkshop("701888930") -- wrp4
resource.AddWorkshop("701895147") -- wrp5
resource.AddWorkshop("701901204") -- wrp6
resource.AddWorkshop("701908560") -- wrp7
resource.AddWorkshop("701884403") -- wrp3 
resource.AddWorkshop("761028434") -- wrp8
resource.AddWorkshop("112806637") -- legs
resource.AddWorkshop("501043374") -- brigandine
resource.AddWorkshop("564627364") -- plague doktor
resource.AddWorkshop("458351576") -- lepotitsa
resource.AddWorkshop("308932848") -- morbroadswords
resource.AddWorkshop("308933454") -- morrlongswords
resource.AddWorkshop("308933573") -- morrclub
resource.AddWorkshop("308933743") -- morrshort
resource.AddWorkshop("308933844") -- morrstaff
resource.AddWorkshop("119472883") -- morraxes
resource.AddWorkshop("119229978") -- morrbows
resource.AddWorkshop("118802819") -- morrdaggers
resource.AddWorkshop("708225419") -- ladder
resource.AddWorkshop("185609021") -- atmos
resource.AddWorkshop("104607712") -- extended properties
resource.AddWorkshop("744017535") -- nombat witcher
resource.AddWorkshop("270169947") -- nombat
resource.AddWorkshop("419153126") -- harry potter wands
resource.AddWorkshop("276347850") -- medieval props
resource.AddWorkshop("483169700") -- skyrim snpc
resource.AddWorkshop("124824365") -- nordic dungeons props
resource.AddWorkshop("512787089") -- bloodstone npc
resource.AddWorkshop("308933663") -- morrshields
resource.AddWorkshop("741271527") -- chivlary footsteps
resource.AddWorkshop("754047205") -- rp_medieval_v2
resource.AddWorkshop("754079586") -- rp_medieval_v2 content 2
resource.AddWorkshop("754059901") -- rp_medieval_v2 content 1 
resource.AddWorkshop("756218185") -- Witcher 2 Soldiers
resource.AddWorkshop("116049816") -- GOT knights
resource.AddWorkshop("505432866") -- Yenefer
resource.AddWorkshop("505431747") -- Triss
resource.AddWorkshop("501440567") -- Ciri