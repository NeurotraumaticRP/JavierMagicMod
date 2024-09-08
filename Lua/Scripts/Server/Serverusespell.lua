if CLIENT then return end

Networking.Receive("Javiermagic.useSpell", function(message, client)
    print("Server received spell use request")
    local activeSpell = message.ReadString()
    local character = client.Character

    -- Check if the character has the talent for the spell
    local spellData = Javiermagic.spell[activeSpell]
    if spellData and character.HasTalent(spellData.id) then
        Javiermagic.CharacterUseSpell(client, activeSpell)
    else
        print("Client does not have the talent for the spell: " .. tostring(activeSpell))
    end
end)