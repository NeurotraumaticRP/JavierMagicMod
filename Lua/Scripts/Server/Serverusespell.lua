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
        if (spellData.NTRequired == nil or spellData.NTRequired) and not HasNT then
            print("Neurotrauma is required to cast this spell.")
            return
        end
        local mana = Javiermagic.GetAfflictionStrength(character, "mana") or 0
        if spellData.manausage then 
            if mana < spellData.manausage then
                return
            else
                -- Deduct mana from the character
                Javiermagic.SetAffliction(character, "mana", mana - spellData.manausage)
            end
        end
        -- Apply the spell effect
        Javiermagic.CharacterUseSpell(client, activeSpell)
    else
        print("Client does not have the talent for the spell: " .. tostring(activeSpell))
    end
end)

-- Add a hook to constantly drain mana for toggle spells
Hook.Add("think", "Javiermagic.manaDrain", function()
    for _, client in pairs(Client.ClientList) do
        local character = client.Character
        if character then
            for spellName, spellData in pairs(Javiermagic.spell) do
                if spellData.inputType == "toggle" and spellData.active then
                    if not Javiermagic.DrainMana(character, 1) then
                        spellData.active = false
                        spellData.toggleOff(client)
                    end
                end
            end
        end
    end
end)