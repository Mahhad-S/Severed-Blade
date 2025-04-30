function inventory_GUI(){
	
    var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;

    var column_width = gui_width / 2;
    var left_x = gui_x;
    var right_x = gui_x + column_width;
    var column_y = gui_y;

    draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    // Draw title
    draw_text(120, 28, "Inventory Screen");
	
    // Draw all inventory items in the right column
    var item_spacing = 20;
    var start_y = column_y + 10;

    if (array_length(global.inventory) > 0) {
        for (var i = 0; i < array_length(global.inventory); i++) {
            var item = global.inventory[i];
            if (item != noone) {
                // Highlight selected item
                if (i == global.selected_index) {
                    draw_set_color(c_yellow);
                } else {
                    draw_set_color(c_white);
                }

                draw_text(right_x-65, start_y+25 + (i * item_spacing), item.name);
            }
        }

        // Draw selected item details in the left column
        var sel_item = global.inventory[global.selected_index];
        if (sel_item != noone) {
            // Draw icon
            if (sel_item.icon != -1) {
                draw_sprite(sel_item.icon, 0, left_x + 20, column_y + 35);
            }

            // Draw description
            var desc_y = column_y + 100;
            draw_set_color(c_white);
            draw_text(left_x + 20, desc_y, sel_item.itemDescription);
        }
    } else {
        draw_set_color(c_white);
        draw_text(right_x-50, start_y+60, "Inventory is empty...");
    }
	
}

function magic_GUI(){
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Magic Screen");
}

function status_GUI() {
    // --- Define the inner area based on the right box dimensions ---
    // (These values match the ones used in your pause menu drawing code.)
    var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;
    
    // --- Example party data ---
    // The main character is first, followed by any additional team members.
    var party = [
        { name: global.party[0].name, 
			hp: global.party[0].hp,
			maxHP: global.party[0].hpMax, 
			ep: 50,  
			maxEP: 50,  
			atk: 10, 
			def: 15, 
			spd: 10, 
			sprites: spr_player_idle},
        { name: "Mage",
			hp:  60, 
			maxHP:  60, 
			ep: 80,  
			maxEP: 80,  
			atk: 10, 
			def:  8, 
			spd: 12, 
			sprites: spr_player_idle},
        { name: "Warrior",
			hp: 120, 
			maxHP: 120, 
			ep: 30,  
			maxEP: 30,  
			atk: 25, 
			def: 20, 
			spd:  8, 
			sprites: spr_player_idle },
		{ name: "Janitor",  
			hp: 120, 
			maxHP: 120, 
			ep: 30,  
			maxEP: 30,  
			atk: 25, 
			def: 20, 
			spd:  8, 
			sprites: spr_player_idle },
    ];
    
    // --- Layout parameters for party member status boxes ---
    // These boxes are drawn within the right-side GUI box.
    var inner_margin      = 10;  // margin inside the right box
    var content_x         = gui_x + inner_margin;
    var content_y         = gui_y + inner_margin;
    var content_width     = gui_width - inner_margin * 2;
    var party_box_height  = (gui_height - inner_margin * 2) / array_length(party);  // height for each party member’s status block (adjust as needed)
    var party_box_spacing = 2;  // spacing between status blocks
    
    // --- Loop through party array and draw each member’s status ---
    for (var i = 0; i < array_length(party); i++) {
        var member = party[i];
        var y_pos = content_y + i * (party_box_height + party_box_spacing);
        
        // 2. Draw a placeholder for the character sprite
        var sprite_size = 16;
        var sprite_x = content_x + 24;
        var sprite_y = y_pos + (party_box_height - sprite_size) * 0.5;
        
        draw_sprite_ext(member.sprites, 0, sprite_x + 9, sprite_y + 15, 0.5, 0.5, 0, c_white, 1);
        
        // 3. Draw the character’s stats to the right of the sprite
        var text_x = sprite_x + sprite_size + 12;
        var availableWidth = (content_x + content_width) - text_x;
        var colWidth = availableWidth / 3;
        var col1_x = text_x;
        var col2_x = text_x + colWidth + 15;
        var col3_x = text_x + colWidth * 2 + 15;
		var line_height = 8;
        
        draw_text_transformed(text_x - 28, y_pos, member.name, 0.75, 0.75, 0);
        
		var stat_y = y_pos + 5 + line_height;
        draw_text_transformed(col1_x, stat_y, "HP: " + string(member.hp) + "/" + string(member.maxHP), 0.5, 0.5, 0);
        draw_text_transformed(col2_x, stat_y, "EP: " + string(member.ep) + "/" + string(member.maxEP), 0.5, 0.5, 0);
        draw_text_transformed(col3_x, stat_y, "ATK: " + string(member.atk), 0.5, 0.5, 0);
        
        // --- Second row of stats: DEF, SPD ---
        stat_y += line_height;
        draw_text_transformed(col1_x, stat_y, "DEF: " + string(member.def), 0.5, 0.5, 0);
        draw_text_transformed(col2_x, stat_y, "SPD: " + string(member.spd), 0.5, 0.5, 0);
		
		// 4. Draw a dividing horizontal line below each member's status block (except after the last one)
        if (i < array_length(party) - 1) {
            // The line's y coordinate is at the bottom edge of the block.
            var line_y = y_pos + party_box_height - 5;
            draw_set_color(c_gray); // Change to any preferred line color
            draw_line(content_x, line_y, content_x + content_width, line_y);
            draw_set_color(c_white);
        }
    }
}


function equipment_GUI() {
	// Exit early if party doesn't exist
    if (!is_array(global.party)) {
        return;
    }

    // === Layout Variables ===
    var margin = 12;
    var box_width = RESOLUTION_W * 0.25;
    var box_x = margin;
    var gui_x = box_x + box_width + margin;
    var gui_y = margin;
    var gui_width = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;

    // === Inner Content Area ===
    var content_margin = 8;
    var content_x = gui_x + content_margin;
    var content_y = gui_y + content_margin;
    var content_width = gui_width - content_margin * 2;
    var content_height = gui_height - content_margin * 2;

    // === Draw Title ===
    draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(120, 28, "Equipment Screen");

    // === Draw Party Member List ===
    var start_y = content_y + 32;
    var spacing_y = 64; // Vertical space between party members

    for (var i = 0; i < array_length(global.party); i++) {
	    var member = global.party[i];

	    var sprite_size = 64;
	    var sprite_scale = 0.5;
	    var sprite_x = content_x + 8 + 32;
	    var sprite_y = start_y + (i * spacing_y);

	    // --- Draw Member Idle Sprite (scaled down) ---
	    if (variable_struct_exists(member, "sprites") && variable_struct_exists(member.sprites, "idle") && sprite_exists(member.sprites.idle)) {
	        draw_sprite_ext(member.sprites.idle, 0, sprite_x, sprite_y, sprite_scale, sprite_scale, 0, c_white, 1);
	    }

	    // --- Draw Member Name ---
	    draw_set_halign(fa_left);

	    var name_offset_x = 8;
	    var sprite_display_width = sprite_size * sprite_scale;
	    var sprite_display_height = sprite_size * sprite_scale;

	    draw_text(sprite_x + sprite_display_width + name_offset_x, sprite_y + sprite_display_height / 4, member.name);
	}
}

function equipment_detail_GUI () {
	// --- Define the inner area based on the right box dimensions ---
	var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;
}

function setting_GUI() {
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Setting Screen");
}

function load_GUI() {
    // Define the inner area based on the right box dimensions.
    var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;
    
    // Center a 312-pixel wide load slot region within the right box.
    var left_offset = gui_x + (gui_width - 240) * 0.5;
    var top_offset  = gui_y + 20;
    
    // Use the same fade variable for slot visibility.
    draw_set_alpha(1.0);
    
    // Loop through available load slots.
    for (var slot = 0; slot < global.loadSlotCount; slot++) {
         var _x = left_offset + 55;
         var _y = top_offset + slot * 48 - 13;
         var _img = 2;
         if (global.loadSlotSelected == slot) {
             _img = 3;
             draw_sprite(spr_pointer, 0, _x + 2, _y + 32);
         }
         scr_NineSliceBoxStretched(spr_textBoxes, _x, _y, _x + 160, _y + 48, _img);
         
         draw_set_font(f_text);
         draw_set_halign(fa_left);
         draw_set_valign(fa_top);
         draw_set_color(c_white);
         if (global.loadSlotData[slot] == -1) {
             draw_text(_x + 8, _y + 16, "Empty Slot");
         } else {
             draw_text(_x + 8, _y + 16, RoomToAreaName(global.loadSlotData[slot][? "room"]));
         }
    }
    draw_set_alpha(1.0);
}



function save_GUI() {
    // Define the inner area used by the pause menu's right base box.
    var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;  // same as your pause menu left box width
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;
    
    // We want our slot boxes to look similar to the title screen.
    // Here we center a 312-pixel wide slot region within the pause right box.
    var left_offset = gui_x + (gui_width - 240) * 0.5;
    var top_offset  = gui_y + 20;
    
    // Use the fade variable for slot visibility (similar to title screen code)
    draw_set_alpha(1.0);
    
    // Loop through all available save slots.
    for (var slot = 0; slot < global.saveSlotCount; slot++) {
         // Each slot box is 48 pixels tall, with a vertical spacing of 48 (adjust as needed).
         var _x = left_offset + 55;
         var _y = top_offset + slot * 48 - 13;
         var _img = 2;  // default box design index
         if (global.saveSlotSelected == slot) {
             _img = 3;  // highlighted box index
             // Draw the pointer to the left of the slot box.
             draw_sprite(spr_pointer, 0, _x + 2, _y + 32);
         }
         // Draw the slot box using your nine-slice function.
         scr_NineSliceBoxStretched(spr_textBoxes, _x, _y, _x + 160, _y + 48, _img);
         
         // Draw the slot's text.
         draw_set_font(f_text);
         draw_set_halign(fa_left);
         draw_set_valign(fa_top);
         draw_set_color(c_white);
         if (global.saveSlotData[slot] == -1) {
             draw_text(_x + 8, _y + 16, "Empty Slot");
         } else {
             draw_text(_x + 8, _y + 16, RoomToAreaName(global.saveSlotData[slot][? "room"]));
         }
    }
    draw_set_alpha(1.0);
}


function exit_GUI() {
    // Fade out the background
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, RESOLUTION_W, RESOLUTION_H, false);
    draw_set_alpha(1);

    var margin = 16;
    var padding = 16;

    // Prompt text
    var prompt_text = "Do you want to save before quitting?";
    var text_width = string_width(prompt_text);
    var text_height = string_height(prompt_text);

    // Button width
    var option_spacing = 64;
    var option_height = string_height("Yes");

    // Calculate total width and height of the prompt box
    var box_width = max(text_width + padding * 2, 256);
    var box_height = text_height + option_height + padding * 3;

    var box_x = (RESOLUTION_W - box_width) * 0.5;
    var box_y = (RESOLUTION_H - box_height) * 0.5;

    // Draw the background panel
    draw_sprite_stretched(spr_box, 0, box_x, box_y, box_width, box_height);

    // Set text settings
    draw_set_font(f_text);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Draw prompt text
    var prompt_y = box_y + padding + text_height / 2;
    draw_set_color(c_white);
    draw_text(box_x + box_width / 2, prompt_y, prompt_text);

    // Draw options
    var option_y = prompt_y + text_height + padding;
    var yes_x = box_x + box_width * 0.3;
    var no_x = box_x + box_width * 0.7;

    if (global.exitOptionSelected == 0) {
        draw_set_color(c_yellow);
        draw_text(yes_x, option_y, "Yes");
        draw_set_color(c_white);
        draw_text(no_x, option_y, "No");
    } else {
        draw_set_color(c_white);
        draw_text(yes_x, option_y, "Yes");
        draw_set_color(c_yellow);
        draw_text(no_x, option_y, "No");
    }

    draw_set_halign(fa_left); // Reset
    draw_set_valign(fa_top);
}
