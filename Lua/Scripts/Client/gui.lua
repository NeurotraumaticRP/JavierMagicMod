if CLIENT then
    -- List of learned spells
    local learnedSpells = {}

    -- Ensure Character.Controlled is not nil before proceeding
    if not Character.Controlled then return end

    -- Main frame for the GUI, takes the whole screen but is invisible and cannot be focused
    local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
    frame.CanBeFocused = false
    

    -- Function to create a text label for each spell
    local function CreateSpellLabel(list, spellName, color, style, size, anchor, rect_transform)
        local textbutton = GUI.Button(GUI.RectTransform(size or Vector2(1, 0.1), rect_transform or list.RectTransform, anchor or GUI.Anchor.TopCenter), spellName, GUI.Alignment.Center, style, Color.Transparent)
        textbutton.TextColor = color or Color.White
        textbutton.CanBeSelected = true
        textbutton.CanBeFocused = true
        textbutton.TextBlock.AutoScaleHorizontal = true
        textbutton.TextBlock.AutoScaleVertical = true

        textbutton.OnClicked = function()
            local character = Character.Controlled
            local activeSpell = Javiermagic.GetActiveSpell(character)

            if activeSpell == spellName then
                -- Deactivate the spell if it is already active
                Javiermagic.SetActiveSpell(character, nil)
                textbutton.TextColor = Color.White
            else
                -- Activate the new spell and deactivate the previous one
                for button in list.Children do
                    button.TextColor = Color.White
                end
                Javiermagic.SetActiveSpell(character, spellName)
                textbutton.TextColor = Color.Green
            end

            -- Update the colors of all buttons

            -- Add the frame to the GUI update list to ensure the changes are reflected
            frame.AddToGUIUpdateList()

            return true
        end

        textbutton.UserData = spellName
        return textbutton
    end

    -- ListBox to display the spells
    local spellList = GUI.ListBox(GUI.RectTransform(Vector2(0.1, 0.6), frame.RectTransform, GUI.Anchor.CenterRight))
    spellList.RectTransform.AbsoluteOffset = Point(0, 25)
    spellList.Visible = false

    -- ProgressBar to display mana
    local manaBar = GUI.ProgressBar(GUI.RectTransform(Vector2(0.07, 0.025), frame.RectTransform, GUI.Anchor.BottomRight), 0)
    manaBar.RectTransform.AbsoluteOffset = Point(38, 200)
    manaBar.Color = Color(28, 102, 186, 255)
    manaBar.BarSize = 0.5

    -- Function to update the spell list
    local function UpdateSpellList()
        local character = Character.Controlled
        learnedSpells = {}

        -- Check for each talent that has a spell
        for spellName, spellData in pairs(Javiermagic.spell) do
            if character.HasTalent(spellData.id) then
                table.insert(learnedSpells, spellName)
            end
        end

        spellList.ClearChildren()
        local activeSpell = Javiermagic.GetActiveSpell(character)
        for _, spellName in ipairs(learnedSpells) do
            local color = (activeSpell == spellName) and Color.Green or Color.White
            CreateSpellLabel(spellList.Content, spellName, color, "GUIButtonLarge", nil, nil, nil)
        end
    end

    -- Hook to handle key input and toggle spell list visibility
    Hook.Add("Think", "populateSpellList", function()
        if PlayerInput.KeyHit(Javiermagic.config.Spellgui) and GUI.KeyboardDispatcher.Subscriber == nil then
            if spellList.Visible then
                spellList.Visible = false
            else
                UpdateSpellList()
                spellList.Visible = true
            end
            frame.AddToGUIUpdateList()
        end
    end)

    -- Hook to update the mana bar
    Hook.Add("Think", "manabarupdate", function()
        local character = Character.Controlled
        if character then
            local mana = HF.GetAfflictionStrength(character, "mana") or 0
            local maxmana = HF.GetAfflictionStrength(character, "maxmana") or 100
            if mana > maxmana then
                mana = maxmana
            end
            if maxmana == 0 then
                maxmana = 100
            end
            manaBar.BarSize = (mana / maxmana) or 0
            frame.AddToGUIUpdateList()
        end
    end)
end