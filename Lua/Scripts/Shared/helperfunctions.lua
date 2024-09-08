-- Table to store client cursor positions
Javiermagic.ClientCursors = {}
-- Table to store active spells for each character
Javiermagic.activeSpells = {}

-- Helper function to get client cursor position
function Javiermagic.GetClientCursor(client)
    return Javiermagic.ClientCursors[client]
end

-- Function to get the active spell for a character
function Javiermagic.GetActiveSpell(character)
    return Javiermagic.activeSpells[character]
end

-- Function to set the active spell for a character
function Javiermagic.SetActiveSpell(character, spellName)
    Javiermagic.activeSpells[character] = spellName
end

-- Function to use the active spell for a character
function Javiermagic.CharacterUseSpell(client, activeSpell)
    local spell = Javiermagic.spell[activeSpell]
    if spell and spell.cast then
        spell.cast(client)
    else
        print("Spell not found or invalid: " .. tostring(activeSpell))
    end
end

if not CLIENT then
    Networking.Receive("Javiermagic.receiveCursorWorldPosition", function (message, client)
        local position = Vector2(message.ReadDouble(), message.ReadDouble())
        Javiermagic.ClientCursors[client] = position
    end)
end

if CLIENT then
    Hook.Add("think", "Javiermagic.cursorposition", function ()
        local pos
        if Character.Controlled ~= nil then
            pos = Character.Controlled.CursorWorldPosition
        end
        if pos ~= nil then
            local message = Networking.Start("Javiermagic.receiveCursorWorldPosition")
            message.WriteDouble(pos.X)
            message.WriteDouble(pos.Y)
            Networking.Send(message)
        end
        
        return true
    end)
end