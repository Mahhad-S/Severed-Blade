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
	else if (global.pauseSubmenu == "Save")
    {
        if (global.saveJustOpenedPrompt) {
		    for (var i = 0; i < global.saveSlotCount; i++) {
		        var filename = "save" + string(i) + ".sav";
		        if (file_exists(filename)) {
		            global.saveSlotData[i] = LoadJSONFromFile(filename);
		        } else {
		            global.saveSlotData[i] = -1;
		        }
		    }
		    global.saveJustOpenedPrompt = false;
		}
        else
        {
            // Navigate slots
            if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
                global.saveSlotSelected = (global.saveSlotSelected - 1 + global.saveSlotCount) mod global.saveSlotCount;
            }
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
                global.saveSlotSelected = (global.saveSlotSelected + 1) mod global.saveSlotCount;
            }

            // Confirm save
            if (keyboard_check_pressed(vk_space))
            {
                global.gameSaveSlot = global.saveSlotSelected;
                SaveGame();
				
				// Immediately reload that saved slot into the GUI
			    var slot = global.gameSaveSlot;
			    var filename = "save" + string(slot) + ".sav";
			    if (file_exists(filename)) {
			        global.saveSlotData[slot] = LoadJSONFromFile(filename);
			    }
            }

            // Press X to go back to main pause menu
			if (keyboard_check_pressed(ord("X")))
			{
			    global.pauseSubmenu = "Status";
			    pauseOptionSelected = 0;
			}

			// Press Escape to close the whole pause menu
			if (keyboard_check_pressed(vk_escape))
			{
			    global.gamePaused = false;
			    global.pauseSubmenu = "Status";
			    pauseOptionSelected = 0;
			}
        }
    }
	else if (global.pauseSubmenu == "Load")
    {
        if (global.loadJustOpenedPrompt) {
		    // Load the save files into the slot data array
		    for (var i = 0; i < global.loadSlotCount; i++) {
		        var filename = "save" + string(i) + ".sav";
		        if (file_exists(filename)) {
		            global.loadSlotData[i] = LoadJSONFromFile(filename);
		        } else {
		            global.loadSlotData[i] = -1;
		        }
		    }
		    global.loadJustOpenedPrompt = false;
		}
        else
        {
            // Navigate slots
            if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
                global.loadSlotSelected = (global.loadSlotSelected - 1 + global.loadSlotCount) mod global.loadSlotCount;
            }
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
                global.loadSlotSelected = (global.loadSlotSelected + 1) mod global.loadSlotCount;
            }

            // Confirm load
            if (keyboard_check_pressed(vk_space))
			{
			    global.gameSaveSlot = global.loadSlotSelected;

			    // --- UNPAUSE FIRST ---
			    global.gamePaused = false;
			    instance_activate_all();

			    // Then load the game
				instance_destroy(obj_gameController);
				instance_destroy(obj_UI);
			    LoadGame(global.gameSaveSlot);
			}

            // Press X to go back to main pause menu
			if (keyboard_check_pressed(ord("X")))
			{
			    global.pauseSubmenu = "Status";
			    pauseOptionSelected = 0;
			}

			// Press Escape to close the whole pause menu
			if (keyboard_check_pressed(vk_escape))
			{
			    global.gamePaused = false;
			    global.pauseSubmenu = "Status";
			    pauseOptionSelected = 0;
			}
        }
    }
	else if (global.pauseSubmenu == "Setting")
    {
        // --- Setting submenu logic ---

        // Navigate settings
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            global.settingOptionSelected = (global.settingOptionSelected - 1 + global.settingOptionCount) mod global.settingOptionCount;
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            global.settingOptionSelected = (global.settingOptionSelected + 1) mod global.settingOptionCount;
        }

        // Adjust settings with Left/Right
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")))
        {
            switch (global.settingOptionSelected)
            {
                case 0:
                    global.musicVolume = clamp(global.musicVolume - 0.05, 0, 1);
                    audio_master_gain(global.musicVolume);
                    break;
                case 1:
                    global.sfxVolume = max(0, global.sfxVolume - 0.05);
                    audio_master_gain(global.sfxVolume);
                    break;
                case 2:
                    global.fullscreen = !global.fullscreen;
                    window_set_fullscreen(global.fullscreen);
                    break;
            }
        }
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")))
        {
            switch (global.settingOptionSelected)
            {
                case 0:
                    global.musicVolume = min(1, global.musicVolume + 0.05);
                    audio_master_gain(global.musicVolume);
                    break;
                case 1:
                    global.sfxVolume = min(1, global.sfxVolume + 0.05);
                    audio_master_gain(global.sfxVolume);
                    break;
                case 2:
                    global.fullscreen = !global.fullscreen;
                    window_set_fullscreen(global.fullscreen);
                    break;
            }
        }

        // Back to main menu with X
        if (keyboard_check_pressed(ord("X")))
        {
            global.pauseSubmenu = "Status";
            pauseOptionSelected = 0;
        }

        // Close pause menu with Escape
        if (keyboard_check_pressed(vk_escape))
        {
            global.gamePaused = false;
            global.pauseSubmenu = "Status";
            pauseOptionSelected = 0;
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
                    case 4:
	                    global.pauseSubmenu = "Save";
	                    global.saveJustOpenedPrompt = true;
	                    break;
	                case 5:
	                    global.pauseSubmenu = "Load";
	                    global.loadJustOpenedPrompt = true;
	                    break;
                    case 6: global.pauseSubmenu = "Setting"; break;
                }
            }
        }
        
        // Close the pause menu with Escape (only if exit prompt isn't active)
        if (keyboard_check_pressed(vk_escape))
        {   
			if (!global.exitPromptActive) {
				pauseOptionSelected = 0;
				global.pauseSubmenu = "Status";
			}
        }
    }
}
