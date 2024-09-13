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
    inputType = "hold", -- Default input type
    cast = function(client)
        local character = client.Character
        local prevmana = Javiermagic.GetAfflictionStrength(character, "mana") or 0
        Javiermagic.SetAffliction(character, "mana", prevmana + 10)
    end
}

Javiermagic.spell["givemaxmana"] = {
    id = "maxmanaspell",
    manausage = 0,
    inputType = "hold", -- Default input type
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
        local character = client.Character
        local cursorPosition = Javiermagic.GetClientCursor(client)
        
        -- Define the proximity threshold (e.g., 500 units as an example)
        local proximityThreshold = 500 
        
        -- Get characters within the specified radius
        local charactersInRange = Javiermagic.GetCharactersInRadius(proximityThreshold, cursorPosition)
        
        -- Sort the characters by distance
        table.sort(charactersInRange, function(a, b)
            return Vector2.Distance(cursorPosition, a.WorldPosition) < Vector2.Distance(cursorPosition, b.WorldPosition)
        end)
        
        if #charactersInRange > 0 then
            local target = charactersInRange[1]
            if target then
                -- Get the closest limb and all limbs
                local _, limbs = Javiermagic.GetClosestLimb(cursorPosition, target)

                local allamputated = true
                local limb = nil
                for _, limbData in ipairs(limbs) do
                    local selectedlimb = limbData.limb
                    selectedlimb = Javiermagic.NormalizeLimbType(selectedlimb.type)
                    if not NT.LimbIsAmputated(target, selectedlimb) then
                        allamputated = false
                        limb = selectedlimb
                        break
                    end
                end

                local spell = Javiermagic.spell["sever"]
                if allamputated then 
                    print("all amputated")
                    Javiermagic.RefundMana(spell, client) 
                    return 
                end
                if limb == LimbType.Head and not NT.LimbIsArterialCut(target,limb) then
                    NT.ArteryCutLimb(target,limb,100)
                    return
                elseif NT.LimbIsArterialCut(target,limb) then Javiermagic.RefundMana(spell, client) return end
                NT.TraumamputateLimb(target, limb)
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

Javiermagic.spell["lightningbolt"] = {
    id = "lightningbolt",
    manausage = 20,
    NTRequired = false,
    inputType = "single",
    active = false,
    cast = function(client)
        local position = client.Character.WorldPosition + Vector2(0, 50)
        local position2 = Javiermagic.GetClientCursor(client)
        local rotation = Javiermagic.GetRotation(position, position2)
        local character = client.Character
        Javiermagic.SpawnProjectile("LightningBolt", position, rotation, character)
    end
}
