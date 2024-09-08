Javiermagic.spell = {}

-- Define the Javiermagic.spell table
Javiermagic.spell = {}

-- Function to get the cursor position and create an explosion
Javiermagic.spell["explosion"] = {
    manausage = 50,
    cast = function(client)
        -- Get the cursor position
        local cursorPosition = Javiermagic.GetClientCursor(client)
        
        -- Create an explosion at the cursor position
        Game.Explode(cursorPosition, 30, 100, 100, 100, 100, 0, 0)
    end
}