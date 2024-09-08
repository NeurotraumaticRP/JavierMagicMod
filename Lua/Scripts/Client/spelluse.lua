if not CLIENT then return end

Hook.Add("keyUpdate", "Javiermagic.keyupdate", function()
    local UseKey = Javiermagic.config.SpellKey
    if PlayerInput.KeyHit(UseKey) then
        local character = Character.Controlled
        local activeSpell = Javiermagic.GetActiveSpell(character)
        if activeSpell then
            -- Send the active spell and client information to the server
            local message = Networking.Start("Javiermagic.useSpell")
            message.WriteString(activeSpell)
            Networking.Send(message)
        end
    end
end)