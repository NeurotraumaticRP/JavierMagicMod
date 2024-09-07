
-- Main frame for the GUI, takes the whole screen but is invisible and cannot be focused
local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
frame.CanBeFocused = false
    
-- TextBlock to display text in the middle right of the screen
local textBlock = GUI.TextBlock(GUI.RectTransform(Vector2(0.2, 0.05), frame.RectTransform, GUI.Anchor.CenterRight), "Sample Text", nil, nil, GUI.Alignment.Center)
textBlock.RectTransform.AbsoluteOffset = Point(0, -textBlock.Rect.Height / 2) -- Adjust to center vertically

    

    
-- Ensure the GUI is updated correctly in the game and sub editor screen
Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)