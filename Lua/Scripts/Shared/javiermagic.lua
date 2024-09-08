Javiermagic.spell = {}

-- Define the Javiermagic.spell table
Javiermagic.spell = {}

-- Function to get the cursor position and create an explosion
Javiermagic.spell["explosion"] = {
    id = "explosionspell",
    manausage = 50,
    cast = function(client)
        -- Get the cursor position
        local cursorPosition = Javiermagic.GetClientCursor(client)
        
        -- Create an explosion at the cursor position
        Game.Explode(cursorPosition, 30, 100, 100, 100, 100, 0, 0)
    end
}

Javiermagic.spell["givemana"] = {
    id = "manaspell",
    manausage = 0,
    cast = function(client)
        local character = client.Character
        local prevmana = HF.GetAfflictionStrength(character,"mana") or 0
        HF.SetAffliction(character,"mana",prevmana + 10)
    end
}

Javiermagic.spell["givemaxmana"] = {
    id = "maxmanaspell",
    manausage = 0,
    cast = function(client)
        local character = client.Character
        local prevmana = HF.GetAfflictionStrength(character,"maxmana") or 0
        HF.SetAffliction(character,"maxmana",prevmana + 10)
    end
}