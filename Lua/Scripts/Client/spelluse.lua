if not CLIENT then return end

Hook.Add("keyUpdate", "Javiermagic.keyupdate", function()
    local UseKey = Javiermagic.config.SpellKey
    local character = Character.Controlled
    local activeSpell = Javiermagic.GetActiveSpell(character)
    if activeSpell then
        local spellData = Javiermagic.spell[activeSpell]
        local inputType = spellData.inputType or "single"
        if inputType == "single" and PlayerInput.KeyHit(UseKey) then
            -- Send the active spell and client information to the server
            local message = Networking.Start("Javiermagic.useSpell")
            message.WriteString(activeSpell)
            Networking.Send(message)
        elseif inputType == "hold" and PlayerInput.KeyDown(UseKey) then
            -- Send the active spell and client information to the server
            local message = Networking.Start("Javiermagic.useSpell")
            message.WriteString(activeSpell)
            Networking.Send(message)
        elseif inputType == "toggle" and PlayerInput.KeyHit(UseKey) then
            -- Send the active spell and client information to the server
            local message = Networking.Start("Javiermagic.useSpell")
            message.WriteString(activeSpell)
            Networking.Send(message)
        end
    end
end)