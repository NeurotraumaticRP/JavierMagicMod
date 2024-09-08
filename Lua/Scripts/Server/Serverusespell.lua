if CLIENT then return end

Networking.Receive("Javiermagic.useSpell", function(message, client)
    print("Server received spell use request")
    local activeSpell = message.ReadString()
    Javiermagic.CharacterUseSpell(client, activeSpell)
end)