Javiermagic = {}

local path = table.pack(...)[1]
Javiermagic.Path = path
HasNT = false

Timer.Wait(function() -- wait for neuro to load

if NT then 
    HasNT = true
    print("Neurotrauma found, extra features will be available")
else
    print("Neurotrauma not found, this is fine but some features will not be available")
end
-- shared
dofile(Javiermagic.Path .. "/Lua/Scripts/Shared/javiermagic.lua")
dofile(Javiermagic.Path .. "/Lua/Scripts/Shared/helperfunctions.lua")
dofile(Javiermagic.Path .. "/Lua/Scripts/Shared/neurofunctions.lua")
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

end, 1000)