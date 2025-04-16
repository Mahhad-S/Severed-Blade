// Hide this object in the title screen (if needed)
visible = (room != rm_title);

// Process input only when the game is paused
if (global.gamePaused)
{
    // ----- Exit Prompt Handling -----
    if (global.exitPromptActive)
    {	
		if (global.justOpenedPrompt)
	    {
	        global.justOpenedPrompt = false; // Prevent confirming on the same frame
	    }
	    else
	    {
			global.pauseSubmenu = "Exit"; 
		
	        // Navigation for exit prompt ("Yes" = 0, "No" = 1)
	        var exitLeft   = keyboard_check_pressed(vk_left)   || keyboard_check_pressed(ord("A"));
	        var exitRight = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
	        global.exitOptionSelected += (exitLeft - exitRight);

	        // Wrap selection between 0 and 1 (only two options)
	        if (global.exitOptionSelected < 0)
	            global.exitOptionSelected = 1;
	        if (global.exitOptionSelected > 1)
	            global.exitOptionSelected = 0;

	        // Confirm selection with Space:
	        if (keyboard_check_pressed(vk_space))
	        {
	            if (global.exitOptionSelected == 0)
	            {
	                // "Yes" is selected: Save before exiting
	                SaveGame();   // Your save function call
	                game_end();   // Exit the game
	            }
	            else
	            {
	                // "No" is selected: Just exit
	                game_end();
	            }
	        }
        
	        // Cancel exit prompt when Escape is pressed (leaves the pause menu open)
	        if (keyboard_check_pressed(vk_escape))
	        {
	            global.exitPromptActive = false;
				pauseOptionSelected = 0;
				global.pauseSubmenu = "Status";
	        }
		}
    }
    // ----- Main Pause Menu Handling -----
    else
    {
        // Navigation for pause menu
        var keyUp   = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));
        var keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
        pauseOptionSelected  += (keyDown - keyUp);

        // Ensure pauseOptionSelected stays within available options
        var optionCount = array_length(pauseOption);
        if (pauseOptionSelected >= optionCount)
            pauseOptionSelected = 0;
        if (pauseOptionSelected < 0)
            pauseOptionSelected = optionCount - 1;

        // Activation input: change submenu or activate exit prompt when Space is pressed
        if (keyboard_check_pressed(vk_space))
        {
            if (pauseOptionSelected == 7)
            {
                // When "Exit" is selected activate the exit prompt overlay
                global.exitPromptActive = true;
                global.exitOptionSelected = 0;  // Default selection ("Yes")
				global.justOpenedPrompt = true; // NEW FLAG
            }
            else
            {
                // Change content on the right according to pause option selection
                switch (pauseOptionSelected)
                {
                    case 0: global.pauseSubmenu = "Status"; break;
                    case 1: global.pauseSubmenu = "Inventory"; break;
                    case 2: global.pauseSubmenu = "Magic"; break;
                    case 3: global.pauseSubmenu = "Equipment"; break;
                    case 4: global.pauseSubmenu = "Save"; break;
                    case 5: global.pauseSubmenu = "Load"; break;
                    case 6: global.pauseSubmenu = "Setting"; break;
                }
            }
        }
        
        // Close the pause menu with Escape (only if exit prompt isn't active)
		show_debug_message("pauseOptionSelected: " + string(pauseOptionSelected));
		show_debug_message("global.exitPromptActive: " + string(global.exitPromptActive));

        if (keyboard_check_pressed(vk_escape))
        {   
			if (!global.exitPromptActive) {
				pauseOptionSelected = 0;
				global.pauseSubmenu = "Status";
			}
        }
    }
}
