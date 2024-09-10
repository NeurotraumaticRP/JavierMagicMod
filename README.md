# JavierMagicMod
JavierMagicMod is a mod for Barotrauma that allows players to use various magical spells. This mod includes a system for defining and using spells, managing mana, and integrating with the game's talent system.

## Installation

1. Download the mod and extract it to your Barotrauma `LocalMods` directory.
2. Enable the mod in the game

## Usage

### Casting Spells

- Press `K` to cast the currently selected spell.
- Press `L` to open the spell selection GUI.
- These can be changed in `config.lua`

### Mana Management

- Mana and max mana are managed as afflictions in the game.
- The mana bar is updated in real-time based on the character's current mana and max mana.

## Adding Custom Spells

Follow these steps to add your own custom spells to the mod:

### Step 1: Define Spell and Function in `javiermagic.lua`

Open `Lua/Scripts/Shared/javiermagic.lua` and define your spell in the `Javiermagic.spell` table. Each spell should have an `id`, `manausage`, `inputType`, and `cast` function. Optionally, you can define `toggleOn` and `toggleOff` functions for toggle spells.

Example:
```lua
Javiermagic.spell["yourspell"] = {
    id = "yourspell",
    manausage = 10,
    inputType = "single", -- or "toggle" or "hold"
    cast = function(client)
        local character = client.Character
        if not character then return end
        -- Your spell logic here
        -- example
        local cursor = Javiermagic.GetClientCursor(client)

        Game.Explode(cursor, 100, 100, 100, 100, 100)
    end,
}
```

### Step 2: Add Talent in `Talents.xml`

Open `Talents.xml` and add a new talent for your spell. Make sure the `identifier` matches the one defined in `javiermagic.lua`.

Example:
```xml
<Talent identifier="yourspell">
    <Icon texture="Content/UI/TalentsIcons3.png" sheetindex="0,4" sheetelementsize="128,128" />
    <Description tag="talentdescription.yourspell" />
</Talent>
```

### Step 3: Add Talent Name and Description in `English.xml`

Open `English.xml` and add the name and description for your talent.

Example:
```xml
<talentname.yourspell>Your Spell</talentname.yourspell>
<talentdescription.yourspell>This is your custom spell.</talentdescription.yourspell>
```

### Step 4 (Optional): Add Item to Obtain Talent

If you want to add an item that grants the talent, open `items.xml` and define the item. Make sure to set the `Talent` attribute to the identifier of your spell.

Example:
```xml
<Item name="Spell book" identifier="spellbook" category="Misc" cargocontaineridentifier="metalcrate" allowasextracargo="true" Tags="smallitem,skillbook" maxstacksize="8" scale="0.5" impactsoundtag="impact_soft">
    <InventoryIcon texture="Content/Items/JobGear/TalentGear.png" sourcerect="123,368,38,56" origin="0.5,0.5" />
    <Sprite texture="Content/Items/JobGear/TalentGear.png" sourcerect="107,74,32,38" depth="0.6" origin="0.5,0.5" />
    <Body width="28" height="36" density="20" />
    <Holdable slots="Any,RightHand+LeftHand" aimable="false" aimpos="40,-20" handle1="5,0" aimangle="260" swingamount="0,3" swingspeed="0.5" swingwhenaiming="true" msg="ItemMsgPickUpSelect">
      <StatusEffect type="OnSecondaryUse" target="This" Condition="-10.0" />
      <StatusEffect type="OnSecondaryUse" target="This,Character" disabledeltatime="true">
        <Conditional Condition="lte 0" />
        <GiveTalentInfo talentidentifiers="yourspell" /> <!-- doesnt need to be a book, just needs to give talent -->
        <RemoveItem />
      </StatusEffect>
    </Holdable>
  </Item>
```

### Step 5 (Optional): Add XML Stuff for Effects

If your spell has specific effects that require additional XML definitions, add them to the appropriate XML files. For example, if your spell applies a custom affliction, add the affliction to `Afflictions.xml`.

Example:
```xml
<affliction name="Your Spell Effect" identifier="yourspelleffect" limbspecific="false" indicatorlimb="Torso" maxstrength="1000">
    <icon texture="Content/UI/MainIconsAtlas.png" sourcerect="896,640,128,128" color="127,0,255,255" origin="0,0"/>
</affliction>
```

## Contributing

If you have any suggestions or improvements, feel free to create a pull request or open an issue on the GitHub repository.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.