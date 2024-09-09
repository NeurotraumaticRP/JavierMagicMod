Javiermagic.spell = {}

-- Define the Javiermagic.spell table
Javiermagic.spell = {}

-- Function to get the cursor position and create an explosion
Javiermagic.spell["explosion"] = {
    id = "explosionspell",
    manausage = 50,
    inputType = "single", -- Default input type
    cast = function(client)
        -- Get the cursor position
        local cursorPosition = Javiermagic.GetClientCursor(client)
        
        -- Create an explosion at the cursor position
        Javiermagic.SpawnItemAt("magicexplosion", cursorPosition)
    end
}

Javiermagic.spell["givemana"] = {
    id = "manaspell",
    manausage = 0,
    inputType = "single", -- Default input type
    cast = function(client)
        local character = client.Character
        local prevmana = Javiermagic.GetAfflictionStrength(character, "mana") or 0
        Javiermagic.SetAffliction(character, "mana", prevmana + 10)
    end
}

Javiermagic.spell["givemaxmana"] = {
    id = "maxmanaspell",
    manausage = 0,
    inputType = "single", -- Default input type
    cast = function(client)
        local character = client.Character
        local prevmana = Javiermagic.GetAfflictionStrength(character, "maxmana") or 0
        Javiermagic.SetAffliction(character, "maxmana", prevmana + 10)
    end
}

Javiermagic.spell["sever"] = {
    id = "severspell",
    manausage = 100,
    NTRequired = true,
    inputType = "single", -- Default input type
    cast = function(client)
        local targetdistances = {}
        local character = client.Character
        local cursorPosition = Javiermagic.GetClientCursor(client)
        
        -- Add proximity threshold (e.g., 500 units as an example)
        local proximityThreshold = 500 
        
        for targetcharacter in Character.CharacterList do
            if targetcharacter ~= character and not targetcharacter.IsDead then
                local targetPosition = targetcharacter.WorldPosition
                
                -- Calculate distance between cursor and character
                local distance = Vector2.Distance(cursorPosition, targetPosition)
                if distance <= proximityThreshold then
                    table.insert(targetdistances, {target = targetcharacter, distance = distance})
                end
            end
        end
        -- Sort the remaining characters by distance
        table.sort(targetdistances, function(a, b) return a.distance < b.distance end)
        if #targetdistances > 0 then
            local target = targetdistances[1].target
            if target then
                local limbtypes = {LimbType.LeftArm, LimbType.RightArm, LimbType.LeftLeg, LimbType.RightLeg}
                local selectedlimb = limbtypes[math.random(#limbtypes)]
                local limbtype = selectedlimb
                NT.TraumamputateLimb(target,limbtype)
            end
        end
    end
}

Javiermagic.spell["magichand"] = {
    id = "magichand",
    manausage = 0.1,
    NTRequired = false,
    inputType = "toggle", -- Toggle input type
    active = false, -- Track whether the spell is active or not
    toggleOn = function(client)
        local spell = Javiermagic.spell["magichand"]
        spell.active = true -- Set the spell as active
        local character = client.Character
        if not character then return end

        -- Apply the "magichand" affliction to the character
        Javiermagic.SetAffliction(character, "magichand", 10)
        print("Magic Hand activated")
    end,
    toggleOff = function(client)
        local spell = Javiermagic.spell["magichand"]
        spell.active = false -- Set the spell as inactive
        local character = client.Character
        if not character then return end

        -- Remove the "magichand" affliction from the character
        Javiermagic.SetAffliction(character, "magichand", 0)
        print("Magic Hand deactivated")
    end,
    cast = function(client)
        local spell = Javiermagic.spell["magichand"]

        -- Toggle between on and off based on the current state
        if spell.active then
            spell.toggleOff(client)
        else
            spell.toggleOn(client)
        end
    end
}
