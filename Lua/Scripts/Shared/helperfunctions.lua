-- Table to store client cursor positions
Javiermagic.ClientCursors = {}

-- Helper function to get client cursor position
function Javiermagic.GetClientCursor(client)
    return Javiermagic.ClientCursors[client]
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