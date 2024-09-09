
-- This file contains a bunch of useful functions that see heavy use in the other scripts.


-- Neurotrauma functions

function NT.DislocateLimb(character,limbtype,strength)
    strength = strength or 1
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "dislocation1"
    limbtoaffliction[LimbType.LeftLeg] = "dislocation2"
    limbtoaffliction[LimbType.RightArm] = "dislocation3"
    limbtoaffliction[LimbType.LeftArm] = "dislocation4"
    if limbtoaffliction[limbtype] == nil then return end
    Javiermagic.AddAffliction(character,limbtoaffliction[limbtype],strength)
end
function NT.BreakLimb(character,limbtype,strength)
    strength = strength or 5
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "rl_fracture"
    limbtoaffliction[LimbType.LeftLeg] = "ll_fracture"
    limbtoaffliction[LimbType.RightArm] = "ra_fracture"
    limbtoaffliction[LimbType.LeftArm] = "la_fracture"
    limbtoaffliction[LimbType.Head] = "h_fracture"
    limbtoaffliction[LimbType.Torso] = "t_fracture"
    if limbtoaffliction[limbtype] == nil then return end
    Javiermagic.AddAffliction(character,limbtoaffliction[limbtype],strength)

    if strength > 0 and NTConfig.Get("NT_fracturesRemoveCasts",true) then
        Javiermagic.SetAfflictionLimb(character,"gypsumcast",limbtype,0)
    end
end
function NT.SurgicallyAmputateLimb(character,limbtype,strength,traumampstrength)
    strength = strength or 100
    traumampstrength = traumampstrength or 0
    
    limbtype = Javiermagic.NormalizeLimbType(limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "srl_amputation"
    limbtoaffliction[LimbType.LeftLeg] = "sll_amputation"
    limbtoaffliction[LimbType.RightArm] = "sra_amputation"
    limbtoaffliction[LimbType.LeftArm] = "sla_amputation"
    limbtoaffliction[LimbType.Head] = "sh_amputation"
    if limbtoaffliction[limbtype] == nil then return end
    Javiermagic.SetAffliction(character,limbtoaffliction[limbtype],strength)

    limbtoaffliction[LimbType.RightLeg] = "trl_amputation"
    limbtoaffliction[LimbType.LeftLeg] = "tll_amputation"
    limbtoaffliction[LimbType.RightArm] = "tra_amputation"
    limbtoaffliction[LimbType.LeftArm] = "tla_amputation"
    limbtoaffliction[LimbType.Head] = "th_amputation"
    Javiermagic.SetAffliction(character,limbtoaffliction[limbtype],traumampstrength)
end
function NT.TraumamputateLimb(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "gate_ta_rl"
    limbtoaffliction[LimbType.LeftLeg] = "gate_ta_ll"
    limbtoaffliction[LimbType.RightArm] = "gate_ta_ra"
    limbtoaffliction[LimbType.LeftArm] = "gate_ta_la"
    limbtoaffliction[LimbType.Head] = "gate_ta_h"
    if limbtoaffliction[limbtype] == nil then return end
    Javiermagic.AddAfflictionLimb(character,limbtoaffliction[limbtype],limbtype,10)
end
function NT.TraumamputateLimbMinusItem(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "gate_ta_rl_2"
    limbtoaffliction[LimbType.LeftLeg] = "gate_ta_ll_2"
    limbtoaffliction[LimbType.RightArm] = "gate_ta_ra_2"
    limbtoaffliction[LimbType.LeftArm] = "gate_ta_la_2"
    limbtoaffliction[LimbType.Head] = "gate_ta_h"
    if limbtoaffliction[limbtype] == nil then return end
    Javiermagic.AddAfflictionLimb(character,limbtoaffliction[limbtype],limbtype,10)
end
function NT.ArteryCutLimb(character,limbtype,strength)
    strength=strength or 5
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "rl_arterialcut"
    limbtoaffliction[LimbType.LeftLeg] = "ll_arterialcut"
    limbtoaffliction[LimbType.RightArm] = "ra_arterialcut"
    limbtoaffliction[LimbType.LeftArm] = "la_arterialcut"
    limbtoaffliction[LimbType.Head] = "h_arterialcut"
    limbtoaffliction[LimbType.Torso] = "t_arterialcut"
    if limbtoaffliction[limbtype] == nil then return end
    Javiermagic.AddAffliction(character,limbtoaffliction[limbtype],strength)
end


function NT.LimbIsDislocated(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "dislocation1"
    limbtoaffliction[LimbType.LeftLeg] = "dislocation2"
    limbtoaffliction[LimbType.RightArm] = "dislocation3"
    limbtoaffliction[LimbType.LeftArm] = "dislocation4"
    if limbtoaffliction[limbtype] == nil then return false end
    return Javiermagic.HasAffliction(character,limbtoaffliction[limbtype],1)
end
function NT.LimbIsBroken(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "rl_fracture"
    limbtoaffliction[LimbType.LeftLeg] = "ll_fracture"
    limbtoaffliction[LimbType.RightArm] = "ra_fracture"
    limbtoaffliction[LimbType.LeftArm] = "la_fracture"
    if limbtoaffliction[limbtype] == nil then return false end
    return Javiermagic.HasAffliction(character,limbtoaffliction[limbtype],1)
end
function NT.LimbIsArterialCut(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "rl_arterialcut"
    limbtoaffliction[LimbType.LeftLeg] = "ll_arterialcut"
    limbtoaffliction[LimbType.RightArm] = "ra_arterialcut"
    limbtoaffliction[LimbType.LeftArm] = "la_arterialcut"
    limbtoaffliction[LimbType.Head] = "h_arterialcut"
    limbtoaffliction[LimbType.Torso] = "t_arterialcut"
    if limbtoaffliction[limbtype] == nil then return false end
    return Javiermagic.HasAffliction(character,limbtoaffliction[limbtype],1)
end
function NT.LimbIsAmputated(character,limbtype)
    return 
        NT.LimbIsTraumaticallyAmputated(character,limbtype) or
        NT.LimbIsSurgicallyAmputated(character,limbtype)
end
function NT.LimbIsTraumaticallyAmputated(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "trl_amputation"
    limbtoaffliction[LimbType.LeftLeg] = "tll_amputation"
    limbtoaffliction[LimbType.RightArm] = "tra_amputation"
    limbtoaffliction[LimbType.LeftArm] = "tla_amputation"
    limbtoaffliction[LimbType.Head] = "th_amputation"
    if limbtoaffliction[limbtype] == nil then return false end
    return Javiermagic.HasAffliction(character,limbtoaffliction[limbtype],0.1)
end
function NT.LimbIsSurgicallyAmputated(character,limbtype)
    local limbtoaffliction = {}
    limbtoaffliction[LimbType.RightLeg] = "srl_amputation"
    limbtoaffliction[LimbType.LeftLeg] = "sll_amputation"
    limbtoaffliction[LimbType.RightArm] = "sra_amputation"
    limbtoaffliction[LimbType.LeftArm] = "sla_amputation"
    limbtoaffliction[LimbType.Head] = "sh_amputation"
    if limbtoaffliction[limbtype] == nil then return false end
    return Javiermagic.HasAffliction(character,limbtoaffliction[limbtype],0.1)
end

function NT.Fibrillate(character,amount)

    -- tachycardia (increased heartrate) ->
    -- fibrillation (irregular heartbeat) ->
    -- cardiacarrest

    -- fetch values
    local tachycardia = Javiermagic.GetAfflictionStrength(character,"tachycardia",0)
    local fibrillation = Javiermagic.GetAfflictionStrength(character,"fibrillation",0)
    local cardiacarrest = Javiermagic.GetAfflictionStrength(character,"cardiacarrest",0)

    -- already in cardiac arrest? don't do anything
    if cardiacarrest > 0 then return end

    -- determine total amount of fibrillation, then determine afflictions from that
    local previousAmount = tachycardia/5
    if fibrillation > 0 then previousAmount = 20 + fibrillation end
    local newAmount = previousAmount + amount

    -- 0-20: 0-100% tachycardia
    -- 20-120: 0-100% fibrillation
    -- >120: cardiac arrest

    if newAmount < 20 then
        -- 0-20: 0-100% tachycardia
        tachycardia = newAmount*5
        fibrillation = 0
    elseif newAmount < 120 then
        -- 20-120: 0-100% fibrillation
        tachycardia = 0
        fibrillation = newAmount-20
    else
        -- >120: cardiac arrest
        tachycardia = 0
        fibrillation = 0
        Javiermagic.SetAffliction(character,"cardiacarrest",10)
    end

    Javiermagic.SetAffliction(character,"tachycardia",tachycardia)
    Javiermagic.SetAffliction(character,"fibrillation",fibrillation)
end

HF = {} -- Helperfunctions

function Javiermagic.Lerp(a, b, t)
	return a + (b - a) * t
end

function Javiermagic.Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function Javiermagic.Clamp(num, min, max)
    if(num<min) then
        num = min 
    elseif(num>max) then 
        num = max 
    end
    return num
end

-- returns num if num > min, else defaultvalue
function Javiermagic.Minimum(num, min, defaultvalue)
    if(num<min) then num=(defaultvalue or 0) end
    return num
end

-- /// affliction magic ///
------------------------------
function Javiermagic.GetAfflictionStrength(character,identifier,defaultvalue)
    if character==nil or character.CharacterHealth==nil then return defaultvalue end

    local aff = character.CharacterHealth.GetAffliction(identifier)
    local res = defaultvalue or 0
    if(aff~=nil) then
        res = aff.Strength
    end
    return res
end

function Javiermagic.GetAfflictionStrengthLimb(character,limbtype,identifier,defaultvalue)
    if character==nil or character.CharacterHealth==nil or character.AnimController==nil then return defaultvalue end
    local limb = character.AnimController.GetLimb(limbtype)
    if limb==nil then return defaultvalue end
    
    local aff = character.CharacterHealth.GetAffliction(identifier,limb)
    local res = defaultvalue or 0
    if(aff~=nil) then
        res = aff.Strength
    end
    return res
end

function Javiermagic.HasAffliction(character,identifier,minamount)
    if character==nil or character.CharacterHealth==nil then return false end

    local aff = character.CharacterHealth.GetAffliction(identifier)
    local res = false
    if(aff~=nil) then
        res = aff.Strength >= (minamount or 0.5)
    end
    return res
end

function Javiermagic.HasAfflictionLimb(character,identifier,limbtype,minamount)
    local limb = character.AnimController.GetLimb(limbtype)
    if limb==nil then return false end
    local aff = character.CharacterHealth.GetAffliction(identifier,limb)
    local res = false
    if(aff~=nil) then
        res = aff.Strength >= (minamount or 0.5)
    end
    return res
end

-- this might be overkill, but a lot of people have reported dislocation fixing issues
function Javiermagic.HasAfflictionExtremity(character,identifier,limbtype,minamount)
    local aff = nil
    
    if(limbtype == LimbType.LeftArm or limbtype == LimbType.LeftForearm or limbtype == LimbType.LeftHand) then
        aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.LeftArm))
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.LeftForearm)) end
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.LeftHand)) end
    elseif(limbtype == LimbType.RightArm or limbtype == LimbType.RightForearm or limbtype == LimbType.RightHand) then
        aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.RightArm))
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.RightForearm)) end
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.RightHand)) end
    elseif(limbtype == LimbType.LeftLeg or limbtype == LimbType.LeftThigh or limbtype == LimbType.LeftFoot) then
        aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.LeftLeg))
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.LeftThigh)) end
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.LeftFoot)) end
    elseif(limbtype == LimbType.RightLeg or limbtype == LimbType.RightThigh or limbtype == LimbType.RightFoot) then
        aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.RightLeg))
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.RightThigh)) end
        if(aff==nil) then aff = character.CharacterHealth.GetAffliction(identifier,character.AnimController.GetLimb(LimbType.RightFoot)) end
    end
    
    local res = false
    if(aff~=nil) then
        res = aff.Strength >= (minamount or 0.5)
    end
    return res
end

function Javiermagic.SetAffliction(character,identifier,strength,aggressor,prevstrength)
    Javiermagic.SetAfflictionLimb(character,identifier,LimbType.Torso,strength,aggressor,prevstrength)
end

-- the main "mess with afflictions" function
function Javiermagic.SetAfflictionLimb(character,identifier,limbtype,strength,aggressor,prevstrength)
    local prefab = AfflictionPrefab.Prefabs[identifier]
    local resistance = character.CharacterHealth.GetResistance(prefab)
    if resistance >= 1 then return end

    local strength = strength*character.CharacterHealth.MaxVitality/100/(1-resistance)
    local affliction = prefab.Instantiate(
        strength
        ,aggressor)

    character.CharacterHealth.ApplyAffliction(character.AnimController.GetLimb(limbtype),affliction,false)

    -- turn target aggressive if damaging
--    if(aggressor ~= nil and character~=aggressor) then 
--        if prevstrength == nil then prevstrength = 0 end
--
--        local dmg = affliction.GetVitalityDecrease(character.CharacterHealth,strength-prevstrength)
--
--        if (dmg ~= nil and dmg > 0) then
--            MakeAggressive(aggressor,character,dmg)
--        end
--    end

    
end

function Javiermagic.ApplyAfflictionChange(character,identifier,strength,prevstrength,minstrength,maxstrength)
    strength = Javiermagic.Clamp(strength,minstrength,maxstrength)
    prevstrength = Javiermagic.Clamp(prevstrength,minstrength,maxstrength)
    if (prevstrength~=strength) then
        Javiermagic.SetAffliction(character,identifier,strength)
    end
end

function Javiermagic.ApplyAfflictionChangeLimb(character,limbtype,identifier,strength,prevstrength,minstrength,maxstrength)
    strength = Javiermagic.Clamp(strength,minstrength,maxstrength)
    prevstrength = Javiermagic.Clamp(prevstrength,minstrength,maxstrength)
    if (prevstrength~=strength) then
        Javiermagic.SetAfflictionLimb(character,identifier,limbtype,strength)
    end
end

function Javiermagic.ApplySymptom(character,identifier,hassymptom,removeifnot)    
    if(not hassymptom and not removeifnot) then return end
    
    local strength = 0
    if(hassymptom) then strength = 100 end
    
    if(removeifnot or hassymptom) then 
        Javiermagic.SetAffliction(character,identifier,strength)
    end
end

function Javiermagic.ApplySymptomLimb(character,limbtype,identifier,hassymptom,removeifnot)    
    if(not hassymptom and not removeifnot) then return end
    
    local strength = 0
    if(hassymptom) then strength = 100 end
    
    if(removeifnot or hassymptom) then 
        Javiermagic.SetAfflictionLimb(character,identifier,limbtype,strength)
    end
end

function Javiermagic.AddAfflictionLimb(character,identifier,limbtype,strength,aggressor)
    local prevstrength = Javiermagic.GetAfflictionStrengthLimb(character,limbtype,identifier,0)
    Javiermagic.SetAfflictionLimb(character,identifier,limbtype,
    strength+prevstrength,
    aggressor,prevstrength)
end

function Javiermagic.AddAffliction(character,identifier,strength,aggressor)
    local prevstrength = Javiermagic.GetAfflictionStrength(character,identifier,0)
    Javiermagic.SetAffliction(character,identifier,
    strength+prevstrength,
    aggressor,prevstrength)
end

function Javiermagic.AddAfflictionResisted(character,identifier,strength,aggressor)
    local prevstrength = Javiermagic.GetAfflictionStrength(character,identifier,0)
    strength = strength * (1-Javiermagic.GetResistance(character,identifier))
    Javiermagic.SetAffliction(character,identifier,
    strength+prevstrength,
    aggressor,prevstrength)
end

function Javiermagic.GetResistance(character,identifier)
    local prefab = AfflictionPrefab.Prefabs[identifier]
    if character == nil or character.CharacterHealth == nil or prefab==nil then return 0 end
    return character.CharacterHealth.GetResistance(prefab)
end

-- /// misc ///

function PrintChat(msg)
    if SERVER then
        -- use server method
        Game.SendMessage(msg, ChatMessageType.Server) 
    else
        -- use client method
        Game.ChatBox.AddMessage(ChatMessage.Create("", msg, ChatMessageType.Server, nil))
    end
    
end

function Javiermagic.DMClient(client,msg,color)
    if SERVER then
        if(client==nil) then return end

        local chatMessage = ChatMessage.Create("", msg, ChatMessageType.Server, nil)
        if(color~=nil) then chatMessage.Color = color end
        Game.SendDirectChatMessage(chatMessage, client)
    else
        PrintChat(msg)
    end
end

function Javiermagic.Chance(chance)
    return math.random() < chance
end

function Javiermagic.BoolToNum(val,trueoutput)
    if(val) then return trueoutput or 1 end
    return 0
end

function Javiermagic.GetSkillLevel(character,skilltype)
    return character.GetSkillLevel(Identifier(skilltype))
end

function Javiermagic.GetBaseSkillLevel(character,skilltype)
    if character == nil or character.Info == nil or character.Info.Job == nil then return 0 end
    return character.Info.Job.GetSkillLevel(Identifier(skilltype))
end

function Javiermagic.GetSkillRequirementMet(character,skilltype,requiredamount)
    local skilllevel = Javiermagic.GetSkillLevel(character,skilltype)
    if NTConfig.Get("NT_vanillaSkillCheck",false) then
        return Javiermagic.Chance(Javiermagic.Clamp((100-(requiredamount-skilllevel))/100,0,1))
    end
    return Javiermagic.Chance(Javiermagic.Clamp(skilllevel/requiredamount,0,1))
end

function Javiermagic.GetSurgerySkillRequirementMet(character,requiredamount)
    local skilllevel = Javiermagic.GetSurgerySkill(character)
    if NTConfig.Get("NT_vanillaSkillCheck",false) then
        return Javiermagic.Chance(Javiermagic.Clamp((100-(requiredamount-skilllevel))/100,0,1))
    end
    return Javiermagic.Chance(Javiermagic.Clamp(skilllevel/requiredamount,0,1))
end

function Javiermagic.GetSurgerySkill(character)
    if NTSP ~= nil and NTConfig.Get("NTSP_enableSurgerySkill",false) then 
        return math.max(
            5,
            Javiermagic.GetSkillLevel(character,"surgery"),
            Javiermagic.GetSkillLevel(character,"medical")/4)
     end

    return Javiermagic.GetSkillLevel(character,"medical")
end

function Javiermagic.GiveSkill(character,skilltype,amount)
    if character ~= nil and character.Info ~= nil then
        character.Info.IncreaseSkillLevel(Identifier(skilltype), amount)
    end
end

-- amount = vitality healed
function Javiermagic.GiveSkillScaled(character,skilltype,amount)
    if character ~= nil and character.Info ~= nil then
        Javiermagic.GiveSkill(character,skilltype,amount*0.001/math.max(Javiermagic.GetSkillLevel(character,skilltype),1))
    end
end

function Javiermagic.GiveItem(character,identifier)
    -- hostside only
    if Game.IsMultiplayer and CLIENT then return end
    -- XXX: this is a workaround for a race condition where `Entity.Spawner` is
    -- initialized after Luatrauma invokes our `<LuaHook>`s.
    if not Entity.Spawner then
        -- Reschedule it to run on the next frame... hopefully it will be initialized then
        Timer.Wait(function()
            Javiermagic.GiveItem(character,identifier)
        end, 35)
        return
    end
    -- This needs to be done on the next tick because Barotrauma processes
    -- the spawn queue before the remove queue, which could result in the
    -- item container overflowing.
    Timer.Wait(function()
        local prefab = ItemPrefab.GetItemPrefab(identifier)
        Entity.Spawner.AddItemToSpawnQueue(prefab, character.WorldPosition, nil, nil, function(item)
            character.Inventory.TryPutItem(item, nil, {InvSlotType.Any})
        end)
    end,35)
end

function Javiermagic.GiveItemAtCondition(character,identifier,condition)
	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	if not Entity.Spawner then
		Timer.Wait(function()
			Javiermagic.GiveItemAtCondition(character,identifier,condition)
		end, 35)
		return
	end
	
	-- use server spawn method
	Timer.Wait(function()
		local prefab = ItemPrefab.GetItemPrefab(identifier)
		Entity.Spawner.AddItemToSpawnQueue(prefab, character.WorldPosition, nil, nil, function(item)
			item.Condition = condition
			character.Inventory.TryPutItem(item, nil, {InvSlotType.Any})
		end)
	end, 35)
end

-- for use with items
function Javiermagic.SpawnItemPlusFunction(identifier,func,params,inventory,targetslot,position)
	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	
	if not Entity.Spawner then
		Timer.Wait(function()
			Javiermagic.SpawnItemPlusFunction(identifier,func,params,inventory,targetslot,position)
		end, 35)
		return
	end
    if params == nil then params = {} end
    
	-- use server spawn method
	Timer.Wait(function()
		local prefab = ItemPrefab.GetItemPrefab(identifier)
		Entity.Spawner.AddItemToSpawnQueue(prefab, position or inventory.Container.Item.WorldPosition, nil, nil, function(newitem)
            if inventory~=nil then
                inventory.TryPutItem(newitem, targetslot,true,true,nil)
            end
            params["item"]=newitem
            if func ~= nil then func(params) end
        end)
	end,35)
end

-- for use with characters
function Javiermagic.GiveItemPlusFunction(identifier,func,params,character)
	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	
	if not Entity.Spawner then
		Timer.Wait(function()
			local prefab = ItemPrefab.GetItemPrefab(identifier)
			Javiermagic.GiveItemPlusFunction(identifier,func,params,character)
		end, 35)
		return
	end
	
    if params == nil then params = {} end

	-- use server spawn method
	Timer.Wait(function()
		local prefab = ItemPrefab.GetItemPrefab(identifier)
		Entity.Spawner.AddItemToSpawnQueue(prefab, character.WorldPosition, nil, nil, function(newitem)
            if character.Inventory~=nil then
                character.Inventory.TryPutItem(newitem, nil, {InvSlotType.Any})
            end
            params["item"]=newitem
            func(params)
        end)
	end,35)
end

function Javiermagic.SpawnItemAt(identifier,position)
	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	
	if not Entity.Spawner then
		Timer.Wait(function()
			Javiermagic.SpawnItemAt(identifier,position)
		end, 35)
		return
	end
	
	local prefab = ItemPrefab.GetItemPrefab(identifier)
	
	-- use server spawn method
	Timer.Wait(function()
		local prefab = ItemPrefab.GetItemPrefab(identifier)
		Entity.Spawner.AddItemToSpawnQueue(prefab, position, nil, nil, nil)
	end,35)
end

function Javiermagic.ForceArmLock(character,identifier)

	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	
	if not Entity.Spawner then
		Timer.Wait(function()
			Javiermagic.ForceArmLock(character,identifier)
		end, 35)
		return
	end
	
    local handindex = 6
    if(identifier=="armlock2") then handindex = 5 end
    
    -- drop previously held item
    local previtem = character.Inventory.GetItemAt(handindex)
    if(previtem ~= nil) then 
        previtem.Drop(character,true)
    end

    Timer.Wait(function()
		local prefab = ItemPrefab.GetItemPrefab(identifier)
		Entity.Spawner.AddItemToSpawnQueue(prefab, character.WorldPosition, nil, nil, function(newitem)
            if character.Inventory~=nil and identifier == "armlock1" then
                character.Inventory.TryPutItem(newitem, nil, {InvSlotType.RightHand})
            elseif character.Inventory~=nil and identifier == "armlock2" then
                character.Inventory.TryPutItem(newitem, nil, {InvSlotType.LeftHand})
            end
        end)
	end,35)
end

function Javiermagic.RemoveItem(item)
	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	
    if item == nil or item.Removed then return end
	
	if not Entity.Spawner then
		Timer.Wait(function()
			Javiermagic.RemoveItem(item)
		end, 35)
    return end
	
	-- use server remove method
	Entity.Spawner.AddEntityToRemoveQueue(item)
end

function Javiermagic.RemoveCharacter(character)
    -- this is the entirely same function as RemoveItem right now
    Javiermagic.RemoveItem(character)
    
--[[
    if character == nil or character.Removed then return end
    
    if SERVER then
        -- use server remove method
        Entity.Spawner.AddEntityToRemoveQueue(character)
    else
        -- use client remove method
        character.Remove()
    end
]]
    
end

function Javiermagic.StartsWith(String,Start)
    return string.sub(String,1,string.len(Start))==Start
end

function Javiermagic.SplitString (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

-- this function is dumb and you shouldn't use it
function Javiermagic.TableSize(table)
    return #table
end

function Javiermagic.HasAbilityFlag(character,flagtype)
    return character.HasAbilityFlag(flagtype)
end

function Javiermagic.MakeAggressive(aggressor,target,damage)
    
    -- this shit isnt working!!!!
    -- why is this shit not working!?!?!?!
    
--    if(aggressor==nil) then print("no aggressor") else print("aggressor: "..aggressor.Name) end
--    if(target==nil) then print("no target") else print("target: "..target.Name) end
--    if(damage==nil) then print("no damage") else print("damage: "..damage) end
--    
--    if ((damage ~= nil and damage <= 0.5) or target==nil or aggressor==nil or target.AIController==nil or aggressor==target) then return end
--    
--    if damage == nil then damage = 5 end
--        
--    local AttackResult = LuaUserData.CreateStatic("Barotrauma.AttackResult")
--    local res = AttackResult.__new(Round(damage),nil)
--    target.AIController.OnAttacked(aggressor,res)
 
end

function Javiermagic.CharacterToClient(character)

    if not SERVER then return nil end

    for key,client in pairs(Client.ClientList) do
        if client.Character == character then 
            return client
        end
    end

    return nil
end

function Javiermagic.ClientFromName(name)

    if not SERVER then return nil end

    for key,client in pairs(Client.ClientList) do
        if client.Name == name then 
            return client
        end
    end

    return nil
end

function Javiermagic.LimbTypeToString(type)
    if(type==LimbType.Torso) then return "Torso" end
    if(type==LimbType.Head) then return "Head" end
    if(type==LimbType.LeftArm or type==LimbType.LeftForearm or type==LimbType.LeftHand) then return "Left Arm" end
    if(type==LimbType.RightArm or type==LimbType.RightForearm or type==LimbType.RightHand) then return "Right Arm" end
    if(type==LimbType.LeftLeg or type==LimbType.LeftThigh or type==LimbType.LeftFoot) then return "Left Leg" end
    if(type==LimbType.RightLeg or type==LimbType.RightThigh or type==LimbType.RightFoot) then return "Right Leg" end
    return "???"
end

function Javiermagic.GameIsPaused()
    if SERVER then return false end

    return Game.Paused
end

function Javiermagic.TableContains(table, value)
    if not table then return end
    for i, v in ipairs(table) do
        if v == value then
            return true
        end
    end

    return false
end

function Javiermagic.PutItemInsideItem(container,identifier,index)
	-- hostside only
	if Game.IsMultiplayer and CLIENT then return end
	
	if not Entity.Spawner then
		Timer.Wait(function()
			Javiermagic.PutItemInsideItem(container,identifier,index)
		end, 35)
    return end
	
    if index==nil then index = 0 end

    local inv = container.OwnInventory
    if inv == nil then return end

    local previtem = inv.GetItemAt(index)
    if previtem ~= nil then
        inv.ForceRemoveFromSlot(previtem, index)
        previtem.Drop()
    end
	-- use server spawn method
    Timer.Wait(function()
        local prefab = ItemPrefab.GetItemPrefab(identifier)
        Entity.Spawner.AddItemToSpawnQueue(prefab, container.WorldPosition, nil, nil, function(item)
            inv.TryPutItem(item, nil, {index}, true, true)
        end)
    end,35)
end

function Javiermagic.CanPerformSurgeryOn(character)
    return Javiermagic.HasAffliction(character,"analgesia",1) or Javiermagic.HasAffliction(character,"sym_unconsciousness",0.1)
end

-- converts thighs, feet, forearms and hands into legs and arms
function Javiermagic.NormalizeLimbType(limbtype) 
    if 
        limbtype == LimbType.Head or 
        limbtype == LimbType.Torso or 
        limbtype == LimbType.RightArm or
        limbtype == LimbType.LeftArm or
        limbtype == LimbType.RightLeg or
        limbtype == LimbType.LeftLeg then 
        return limbtype end

    if limbtype == LimbType.LeftForearm or limbtype==LimbType.LeftHand then return LimbType.LeftArm end
    if limbtype == LimbType.RightForearm or limbtype==LimbType.RightHand then return LimbType.RightArm end

    if limbtype == LimbType.LeftThigh or limbtype==LimbType.LeftFoot then return LimbType.LeftLeg end
    if limbtype == LimbType.RightThigh or limbtype==LimbType.RightFoot then return LimbType.RightLeg end

    if limbtype == LimbType.Waist then return LimbType.Torso end

    return limbtype
end

-- returns an unrounded random number
function Javiermagic.RandomRange(min,max) 
    return min+math.random()*(max-min)
end

function Javiermagic.LimbIsExtremity(limbtype) 
    return limbtype~=LimbType.Torso and limbtype~=LimbType.Head
end

function Javiermagic.HasTalent(character,talentidentifier) 

    local talents = character.Info.UnlockedTalents

    for value in talents do
        if value.Value == talentidentifier then return true end
    end

    return false
end

function Javiermagic.CharacterDistance(char1,char2) 
    return Javiermagic.Distance(char1.WorldPosition,char2.WorldPosition)
end

function Javiermagic.Distance(v1,v2)
    return Vector2.Distance(v1,v2)
end

function Javiermagic.GetOuterWearIdentifier(character) 
    return Javiermagic.GetCharacterInventorySlotIdentifer(character,4)
end
function Javiermagic.GetInnerWearIdentifier(character) 
    return Javiermagic.GetCharacterInventorySlotIdentifer(character,3)
end
function Javiermagic.GetHeadWearIdentifier(character) 
    return Javiermagic.GetCharacterInventorySlotIdentifer(character,2)
end

function Javiermagic.GetCharacterInventorySlotIdentifer(character,slot) 
    local item = character.Inventory.GetItemAt(slot)
    if item==nil then return nil end
    return item.Prefab.Identifier.Value
end

function Javiermagic.GetItemInRightHand(character) 
    return Javiermagic.GetCharacterInventorySlot(character,6)
end
function Javiermagic.GetItemInLeftHand(character) 
    return Javiermagic.GetCharacterInventorySlot(character,5)
end
function Javiermagic.GetOuterWear(character) 
    return Javiermagic.GetCharacterInventorySlot(character,4)
end
function Javiermagic.GetInnerWear(character) 
    return Javiermagic.GetCharacterInventorySlot(character,3)
end
function Javiermagic.GetHeadWear(character) 
    return Javiermagic.GetCharacterInventorySlot(character,2)
end

function Javiermagic.GetCharacterInventorySlot(character,slot) 
    return character.Inventory.GetItemAt(slot)
end

function Javiermagic.ItemHasTag(item,tag)
    if item==nil then return false end
    return item.HasTag(tag)
end

function Javiermagic.CauseOfDeathToString(cod) 
    local res = nil

    if cod.Affliction ~= nil and -- from affliction
    cod.Affliction.CauseOfDeathDescription ~= nil then
        res = cod.Affliction.CauseOfDeathDescription
    else -- from type
        res = tostring(cod.Type)
    end

    return res or ""
end

function Javiermagic.CombineArrays(arr1,arr2)
    local res = {}
    for _,v in ipairs(arr1) do
        table.insert(res, v) end
    for _,v in ipairs(arr2) do
        table.insert(res, v) end
    return res
end

Javiermagic.EndocrineTalents =
{"aggressiveengineering","crisismanagement","cannedheat",
"doubleduty","firemanscarry","fieldmedic","multitasker",
"aceofalltrades","stillkicking","drunkensailor","trustedcaptain",
"downwiththeship","physicalconditioning","beatcop","commando",
"justascratch","intheflow","collegeathletics"}
function Javiermagic.ApplyEndocrineBoost(character,talentlist)
    talentlist=talentlist or Javiermagic.EndocrineTalents
        
    -- gee i sure do love translating c# into lua
    local targetCharacter = character
    if (targetCharacter.Info == nil) then return end
    local talentTree = TalentTree.JobTalentTrees[character.Info.Job.Prefab.Identifier.Value] if talentTree == nil then return end
    -- for the sake of technical simplicity, for now do not allow talents to be given if the character could unlock them in their talent tree as well
    local disallowedTalents = {}
    for subtree in talentTree.TalentSubTrees do for stage in subtree.TalentOptionStages do for talent in stage.Talents do
        table.insert(disallowedTalents,talent.Identifier.Value)
    end end end

    local characterTalents = {}
    for talent in targetCharacter.Info.UnlockedTalents do
        table.insert(characterTalents,talent.Value)
    end

    local viableTalents = {}
    for talent in talentlist do
        if not Javiermagic.TableContains(disallowedTalents,talent) and not Javiermagic.TableContains(characterTalents,talent) then
            table.insert(viableTalents,talent)
        end
    end
    
    if #viableTalents <= 0 then return end

    local talent = viableTalents[math.random(#viableTalents)]

    targetCharacter.GiveTalent(Identifier(talent), true);

end

function Javiermagic.JobMemberCount(jobidentifier)
    local res = 0
    for _, character in pairs(Character.CharacterList) do
        if (character.IsHuman and not character.IsDead and character.Info.Job ~= nil) then
            if character.Info.Job.Prefab.Identifier.Value == jobidentifier then
                res = res + 1
            end
        end
    end
    return res
end

function Javiermagic.SendTextBox(header,msg,client)
    if SERVER then
        Game.SendDirectChatMessage(header, msg, nil, 7, client)
    else
        GUI.MessageBox(header, msg)
    end
end

function Javiermagic.ReplaceString(original,find,replace)
    return string.gsub(original,find,replace)
end

function Javiermagic.Explode(entity,range,force,damage,structureDamage,itemDamage,empStrength,ballastFloraStrength)
    
    range = range or 0
    force = force or 0
    damage = damage or 0
    structureDamage = structureDamage or 0
    itemDamage = itemDamage or 0
    empStrength = empStrength or 0
    ballastFloraStrength = ballastFloraStrength or 0

    Game.Explode(entity.WorldPosition, range, force, damage, structureDamage, itemDamage, empStrength, ballastFloraStrength)

    Javiermagic.SpawnItemAt("ntvfx_explosion",entity.WorldPosition)
end

function Javiermagic.GetText(identifier)
    local text = TextManager.Get(identifier)
    if text ~= nil then return text.Value end
    return identifier
end

function Javiermagic.Magnitude(vector)
    return ((vector.X^2)+(vector.Y^2))^0.5
end

function Javiermagic.Clone(object)
    return json.parse(json.serialize(object))
end

function Javiermagic.ReplaceItemIdentifier(item,newIdentifier,keepCondition)
    -- keep track of where to put the new item
    local previousSpot = nil
    local previousInventory = item.ParentInventory
    if previousInventory then
        previousSpot = previousInventory.FindIndex(item)
    end

    -- make sure to transfer over contained items into the new item
    local containedItems = {}
    if item.OwnInventory ~= nil then
        for containedItem in item.OwnInventory.AllItems do
            table.insert(containedItems,{item=containedItem,slot=item.OwnInventory.FindIndex(containedItem)})
        end
    end
    
    local funcParams = {containedItems=containedItems}
    if keepCondition then
        funcParams.condition = item.Condition
    end

    Timer.Wait(function()
        Javiermagic.SpawnItemPlusFunction(newIdentifier,function(params)
            for containedItem in params.containedItems do
                params.item.OwnInventory.TryPutItem(containedItem.item,containedItem.slot,true,false,nil)
            end
            if params.condition ~= nil then params.item.Condition = params.condition end
        end,funcParams,previousInventory,previousSpot,item.WorldPosition)
        Javiermagic.RemoveItem(item)
    end,1)

end

function Javiermagic.GetVelocity(character)
    if (not character)
    or (not character.AnimController)
    or (not character.AnimController.MainLimb)
    or (not character.AnimController.MainLimb.body) then return Vector2(0,0) end
    
    return character.AnimController.MainLimb.body.LinearVelocity
end