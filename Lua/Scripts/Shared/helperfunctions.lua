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

function Javiermagic.CheckRaycast(simPosition, dir, collision)
	local lastBody = nil
    Game.World.RayCast(function(fixture, point, normal, fraction)
        lastBody = fixture.Body
        return fraction
    end, simPosition, simPosition + dir, collision)

    return lastBody

end

function Javiermagic.FindBody(pos)
    -- special thanks to EvilFactory for point-raycasting LUA code
    local simPosition = Submarine.GetRelativeSimPositionFromWorldPosition(pos, Submarine.MainSub, Submarine.MainSub)
    local collision = bit32.bor(Physics.CollisionCharacter, Physics.CollisionItem)
    collision = bit32.bor(collision, Physics.CollisionProjectile)
    
    local directions = { Vector2(0, 1), Vector2(1, 0), Vector2(0, -1), Vector2(-1, 0) }
    local lastBody = nil
    
    for key, dir in pairs(directions) do
        lastBody = Javiermagic.CheckRaycast(simPosition, dir, collision)
        if (lastBody) then return lastBody end
    
    end
    
    return lastBody
end


if not CLIENT then
    Hook.Add("Think", "Javiermagic.magichand", function()

        for client in Client.ClientList do
            if Javiermagic.HasAffliction(client.Character, "magichand") then


                local specialVelocity
                local userCharacter = client.Character
                local cursorPos = Javiermagic.GetClientCursor(client)
                local body = Javiermagic.FindBody(cursorPos)
                if not body then return end

                if (userCharacter.IsKeyDown(InputType.Shoot)) then
                    if LuaUserData.IsTargetType(body.UserData, "Barotrauma.Limb") then
                        local limb = body.UserData
                        local character = limb.character
                    
                        if (character == userCharacter) then return end
                        character.Stun = 4
                        
                        specialVelocity = (cursorPos - character.WorldPosition) * 0.4
                        limb.body.LinearVelocity = specialVelocity
                    
                        
                    end
                    
                    if LuaUserData.IsTargetType(body.UserData, "Barotrauma.Item") then
                        local item = body.UserData
                    
                        specialVelocity = (cursorPos - item.WorldPosition) * 0.1
                        item.body.LinearVelocity = specialVelocity
                    end
                end
            end
        end

    end)
end

local manaAccumulator = {}

function Javiermagic.DrainMana(character, amount)
    local clientId = Util.FindClientCharacter(character)
    if clientId == nil then
        return false
    end
    manaAccumulator[clientId] = (manaAccumulator[clientId] or 0) + amount

    if manaAccumulator[clientId] >= 1 then
        local mana = Javiermagic.GetAfflictionStrength(character, "mana") or 0
        if mana < 1 then
            return false
        else
            Javiermagic.SetAffliction(character, "mana", mana - 1)
            manaAccumulator[clientId] = manaAccumulator[clientId] - 1
            return true
        end
    end
    return true
end

function Javiermagic.SpawnProjectile(item, position, rotation, character)
    local client = Util.FindClientCharacter(character)
    local targetposition = Javiermagic.GetClientCursor(client)
    local prefab = ItemPrefab.GetItemPrefab(item)
    Entity.Spawner.AddItemToSpawnQueue(prefab, position, nil, nil, function(newitem)
        newitem.body.SmoothRotate(rotation, 999, false)
        newitem.body.LinearVelocity = (targetposition - position) * 0.1
        local projectile = newitem.GetComponentString("Projectile")
        local limbs = {}
        for limb in character.AnimController.Limbs do
            table.insert(limbs, limb)
        end
        projectile.Shoot(character, newitem.WorldPosition, newitem.WorldPosition, rotation, limbs, nil, 1, 0)
    end)

end

function Javiermagic.GetRotation(pos1, pos2) -- inouts are vector2
    local deltaX = pos2.X - pos1.X
    local deltaY = pos2.Y - pos1.Y

    local angle = math.atan(deltaY, deltaX)

    local degrees = math.deg(angle)

    if degrees < 0 then
        degrees = degrees + 360
    end

    return degrees
end

-- Helper function to get characters within a specified radius
function Javiermagic.GetCharactersInRadius(radius, position)
    local charactersInRange = {}
    for targetcharacter in Character.CharacterList do
        if not targetcharacter.IsDead then
            local targetPosition = targetcharacter.WorldPosition
            local distance = Vector2.Distance(position, targetPosition)
            if distance <= radius then
                table.insert(charactersInRange, targetcharacter)
            end
        end
    end
    return charactersInRange
end

function Javiermagic.GetClosestLimb(pos, character)
    local distanceThreshold = 100
    local selectedlimb = nil
    local limbs = {}
    
    if character and character.AnimController and character.AnimController.Limbs then
        for _, limb in ipairs(character.AnimController.Limbs) do
            if Vector2.Distance(pos, limb.WorldPosition) < distanceThreshold then
                local limbDistance = Vector2.Distance(pos, limb.WorldPosition)
                table.insert(limbs, {limb = limb, distance = limbDistance})
            end
        end

        -- Sort limbs by distance after populating the list
        table.sort(limbs, function(a, b) return a.distance < b.distance end)

        if #limbs > 0 then
            selectedlimb = limbs[1].limb
        end
    end

    return selectedlimb, limbs
end


-- Helper function to refund mana for a spell
function Javiermagic.RefundMana(spell, client)
    local character = client.Character
    if not character then return end

    local manaUsage = spell.manausage or 0
    local currentMana = Javiermagic.GetAfflictionStrength(character, "mana") or 0

    Javiermagic.SetAffliction(character, "mana", currentMana + manaUsage)
end

--item.SmoothRotate(rotation, 999, false)
--item.Use(false, character, nil, "This", character)
