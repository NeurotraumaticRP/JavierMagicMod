if CLIENT then
    -- List of learned spells
    local learnedSpells = {}

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
                Javiermagic.SetActiveSpell(character, spellName)
                textbutton.TextColor = Color.Green
            end

            -- Update the colors of all buttons
            for child in list.Content.Children do
                if child.UserData == spellName then
                    child.TextColor = Color.Green
                else
                    child.TextColor = Color.White
                end
            end

            return true
        end

        textbutton.UserData = spellName
        return textbutton
    end

    -- Main frame for the GUI, takes the whole screen but is invisible and cannot be focused
    local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
    frame.CanBeFocused = false

    -- ListBox to display the spells
    local spellList = GUI.ListBox(GUI.RectTransform(Vector2(0.1, 0.6), frame.RectTransform, GUI.Anchor.CenterRight))
    spellList.RectTransform.AbsoluteOffset = Point(0, 25)
    spellList.Visible = false

    -- Hook to populate the spell list and handle key input
    Hook.Add("Think", "populateSpellList", function()
        if PlayerInput.KeyHit(Javiermagic.config.Spellgui) and GUI.KeyboardDispatcher.Subscriber == nil then
            local character = Character.Controlled
            learnedSpells = {}

            -- Check for each talent that has a spell
            for spellName, spellData in pairs(Javiermagic.spell) do
                if character.HasTalent(spellData.id) then
                    table.insert(learnedSpells, spellName)
                end
            end

            spellList.ClearChildren()
            if spellList.Visible then
                spellList.Visible = false
            else
                spellList.Visible = true
                local activeSpell = Javiermagic.GetActiveSpell(character)
                for _, spellName in ipairs(learnedSpells) do
                    local color = (activeSpell == spellName) and Color.Green or Color.White
                    CreateSpellLabel(spellList.Content, spellName, color, "GUIButtonLarge", nil, nil, nil)
                end
                Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
                    frame.AddToGUIUpdateList()
                end)
            end
        end
    end)
end