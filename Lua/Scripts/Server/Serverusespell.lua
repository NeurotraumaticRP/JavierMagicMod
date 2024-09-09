if CLIENT then return end

Networking.Receive("Javiermagic.useSpell", function(message, client)
    local activeSpell = message.ReadString()
    -- Assign the character associated with the client, if it exists
    local character = client.Character
    if not character then
        print("Client does not have an associated character.")
        return
    end

    -- Check if the character has the talent for the spell
    local spellData = Javiermagic.spell[activeSpell]
    if spellData and character.HasTalent(spellData.id) then

        local mana = Javiermagic.GetAfflictionStrength(character, "mana") or 0
        if spellData.manausage then 
            if mana < spellData.manausage then
                return
            else
                -- Deduct mana from the character
                Javiermagic.SetAffliction(character, "mana", mana - spellData.manausage)
            end
            Javiermagic.CharacterUseSpell(client, activeSpell)
        end
        Javiermagic.CharacterUseSpell(client, activeSpell)
    else
        print("Client does not have the talent for the spell: " .. tostring(activeSpell))
    end
end)