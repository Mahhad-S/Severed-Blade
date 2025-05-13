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
			if exitLeft set_sfx_ingame(sfx_changeTab);
			if exitRight set_sfx_ingame(sfx_changeTab);
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
					set_sfx_ingame(sfx_click);
	                SaveGame();   // Your save function call
	                game_end();   // Exit the game
	            }
	            else
	            {
	                // "No" is selected: Just exit
					set_sfx_ingame(sfx_click);
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
				set_sfx_ingame(sfx_changeTab);
                global.saveSlotSelected = (global.saveSlotSelected - 1 + global.saveSlotCount) mod global.saveSlotCount;
            }
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
				set_sfx_ingame(sfx_changeTab);
                global.saveSlotSelected = (global.saveSlotSelected + 1) mod global.saveSlotCount;
            }

            // Confirm save
            if (keyboard_check_pressed(vk_space))
            {	
				set_sfx_ingame(sfx_click);
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
				set_sfx_ingame(sfx_changeTab);
                global.loadSlotSelected = (global.loadSlotSelected - 1 + global.loadSlotCount) mod global.loadSlotCount;
            }
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
				set_sfx_ingame(sfx_changeTab);
                global.loadSlotSelected = (global.loadSlotSelected + 1) mod global.loadSlotCount;
            }

            // Confirm load
            if (keyboard_check_pressed(vk_space))
			{	
				set_sfx_ingame(sfx_click);
			    global.gameSaveSlot = global.loadSlotSelected;

			    // --- UNPAUSE FIRST ---
			    global.gamePaused = false;
			    instance_activate_all();

			    // Then load the game
				instance_destroy(obj_gameController);
				instance_destroy(obj_UI);
			    LoadGame(global.gameSaveSlot);
			}

            // X to go back to the main pause menu
	        if (keyboard_check_pressed(ord("X"))) {
	            global.pauseSubmenu   = "Status";
	            pauseOptionSelected   = 0;
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
	else if(global.pauseSubmenu == "Equipment")
	{
		// ── PARTY MEMBER SELECT ──
	    if (global.inEquipmentPartySelect) {
	        if (keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"))) {
				set_sfx_ingame(sfx_changeTab);
	            global.equipSlotSelected = (global.equipSlotSelected - 1 + array_length(global.party)) mod array_length(global.party);
	        }
	        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
				set_sfx_ingame(sfx_changeTab);
	            global.equipSlotSelected = (global.equipSlotSelected + 1) mod array_length(global.party);
	        }
	        if (keyboard_check_pressed(vk_space)) {
				set_sfx_ingame(sfx_click);
	            global.inEquipmentPartySelect    = false;
	            global.equipmentListFiltered     = [];
	            global.equipmentListIndex        = -1;
	            global.equipmentCategoryIndex    = 0;
	        }
	    }
	    // ── SLOT/CATEGORY & ITEM LIST (mutually exclusive) ──
	    else {
	        // CATEGORY SELECT (list hidden)
	        if (!is_array(global.equipmentListFiltered) 
	            || array_length(global.equipmentListFiltered) == 0) 
	        {
	            if (keyboard_check_pressed(vk_left)  || keyboard_check_pressed(ord("A"))) {
					set_sfx_ingame(sfx_changeTab);
	                global.equipmentCategoryIndex = (global.equipmentCategoryIndex + 2) mod 3;
	            }
	            if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
					set_sfx_ingame(sfx_changeTab);
	                global.equipmentCategoryIndex = (global.equipmentCategoryIndex + 1) mod 3;
	            }
	            if (keyboard_check_pressed(vk_space)) {
					set_sfx_ingame(sfx_click);
	                var slot       = ["Head","Body","Weapon"][global.equipmentCategoryIndex];
	                var partyIndex = clamp(global.equipSlotSelected, 0, array_length(global.party)-1);
	                var mClass     = global.party[partyIndex].class;
	                global.equipmentListFiltered = filter_equippable_items(mClass, slot);
	                global.equipmentListIndex    = 0;
	            }
	            if (keyboard_check_pressed(ord("Z"))) {
	                // back to party select
	                global.inEquipmentPartySelect = true;
	                global.equipmentListFiltered  = [];
	                global.equipmentListIndex     = -1;
	            }
	        }
	        // ITEM LIST NAVIGATION (list visible)
	        else {
	            if (keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"))) {
	                global.equipmentListIndex = max(global.equipmentListIndex - 1, 0);
	            }
	            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
	                global.equipmentListIndex = min(
	                    global.equipmentListIndex + 1,
	                    array_length(global.equipmentListFiltered) - 1
	                );
	            }
	            if (keyboard_check_pressed(vk_space)
	                && array_length(global.equipmentListFiltered) > 0)
	            {
	                var item = global.equipmentListFiltered[global.equipmentListIndex];
	                equip_item_to_party_member(global.equipSlotSelected, item);
	            }
	            if (keyboard_check_pressed(ord("Z"))) {
	                // back to category select
	                global.equipmentListFiltered = [];
	                global.equipmentListIndex    = -1;
	            }
	        }
	    }
    
		// Navigate settings
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
			set_sfx_ingame(sfx_changeTab);
            global.equipSlotSelected = (global.equipSlotSelected - 1 + array_length(global.party))
                              mod array_length(global.party);
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
			set_sfx_ingame(sfx_changeTab);
		    global.equipSlotSelected = (global.equipSlotSelected + 1)
		                              mod array_length(global.party);
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
			set_sfx_ingame(sfx_click);
			global.gamePaused = false;
			global.pauseSubmenu = "Status";
			pauseOptionSelected = 0;
		}
	}
	
    
	else if (global.pauseSubmenu == "Setting")
    {
        // --- Setting submenu logic ---

        // Navigate settings
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
			set_sfx_ingame(sfx_changeTab);
            global.settingOptionSelected = (global.settingOptionSelected - 1 + global.settingOptionCount) mod global.settingOptionCount;
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
			set_sfx_ingame(sfx_changeTab);
            global.settingOptionSelected = (global.settingOptionSelected + 1) mod global.settingOptionCount;
        }

        // Adjust settings with Left/Right
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")))
        {
            switch (global.settingOptionSelected)
            {
                case 0:
                    global.musicVolume = clamp(global.musicVolume - 0.05, 0, 1);
                    break;
                case 1:
                    global.sfxVolume = clamp(global.sfxVolume - 0.05, 0, 1);
					for (var i = array_length(global.loopingSFXInstances) - 1; i >= 0; i--) {
						var inst = global.loopingSFXInstances[i][0];
						var volScale = global.loopingSFXInstances[i][1];

						if (audio_is_playing(inst)) {
							var finalVol = global.masterVolume * global.sfxVolume * volScale;
							audio_sound_gain(inst, finalVol, 0);
						} else {
							// Clean up stopped sounds
							array_delete(global.loopingSFXInstances, i, 1);
						}
					}
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
                    break;
                case 1:
                    global.sfxVolume = min(1, global.sfxVolume + 0.05);
					for (var i = array_length(global.loopingSFXInstances) - 1; i >= 0; i--) {
						var inst = global.loopingSFXInstances[i][0];
						var volScale = global.loopingSFXInstances[i][1];

						if (audio_is_playing(inst)) {
							var finalVol = global.masterVolume * global.sfxVolume * volScale;
							audio_sound_gain(inst, finalVol, 0);
						} else {
							// Clean up stopped sounds
							array_delete(global.loopingSFXInstances, i, 1);
						}
					}
                    break;
                case 2:
                    global.fullscreen = !global.fullscreen;
                    window_set_fullscreen(global.fullscreen);
                    break;
            }
        }
		
		// Press Z to step BACK to the main menu, but keep “Settings” highlighted
	    if (keyboard_check_pressed(ord("Z"))) {
	        global.pauseSubmenu = "Setting";
	        pauseOptionSelected = 6;
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
	else if (global.pauseSubmenu == "Inventory") 
	{
		var count = array_length(global.inventory);

        // move selection up
        if (count > 0 && (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")))) {
			set_sfx_ingame(sfx_changeTab);
            global.selected_index = (global.selected_index - 1 + count) mod count;
        }
        // move selection down
        if (count > 0 && (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")))) {
			set_sfx_ingame(sfx_changeTab);
            global.selected_index = (global.selected_index + 1) mod count;
        }

        // X to go back to the main pause menu
        if (keyboard_check_pressed(ord("X"))) {
            global.pauseSubmenu   = "Status";
            pauseOptionSelected   = 0;
        }
	}
	
    // ----- Main Pause Menu Handling -----
	else
    {
        // Navigation for pause menu
        var keyUp   = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));
        var keyDown = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
		if (keyUp) set_sfx_ingame(sfx_changeTab, 1 , false);
		if (keyDown) set_sfx_ingame(sfx_changeTab, 1, false);
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
				set_sfx_ingame(sfx_click, 1, false);
                // Change content on the right according to pause option selection
                switch (pauseOptionSelected)
                {
                    case 0: global.pauseSubmenu = "Status"; break;
                    case 1: global.pauseSubmenu = "Inventory"; break;
                    case 2: global.pauseSubmenu = "Magic"; break;
                    case 3: 
						global.pauseSubmenu = "Equipment"; 
						global.equipmentJustOpenedPrompt = true;
						break;
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
