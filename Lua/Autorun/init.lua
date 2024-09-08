Javiermagic = {}

local path = table.pack(...)[1]
Javiermagic.Path = path
-- shared
dofile(Javiermagic.Path .. "/Lua/Scripts/Shared/javiermagic.lua")
dofile(Javiermagic.Path .. "/Lua/Scripts/Shared/helperfunctions.lua")
-- client side
if CLIENT then 
    dofile(Javiermagic.Path .. "/Lua/Scripts/Client/gui.lua")
    dofile(Javiermagic.Path .. "/Lua/Scripts/Client/config.lua")
    dofile(Javiermagic.Path .. "/Lua/Scripts/Client/spelluse.lua")
end
-- server side
if not CLIENT then 
    dofile(Javiermagic.Path .. "/Lua/Scripts/Server/Serverusespell.lua")
end