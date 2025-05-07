function inventory_GUI() {
    // —————— Layout setup ——————
    var margin      = 12;
    var boxWidth    = RESOLUTION_W * 0.25;
    var boxX        = margin;
    var guiX        = boxX + boxWidth + margin;
    var guiY        = margin;
    var guiW        = RESOLUTION_W - guiX - margin;
    var guiH        = RESOLUTION_H - margin * 2;

    // two-column split
    var leftW       = guiW * 0.5;
    var rightX      = guiX + leftW;
    var listStartY  = guiY + 40;
    var detailY     = guiY + 40;
    var itemSpacing = 24;
    var iconSize    = 32;

    // grab inventory & length
    var inv   = global.inventory;
    var count = array_length(inv);

    // clamp selected_index into [0…count-1], or zero if no items
    if (count > 0) {
        global.selected_index = clamp(global.selected_index, 0, count - 1);
    } else {
        global.selected_index = 0;
    }

    // —————— Draw list of item names (right panel) ——————
    draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    if (count > 0) {
        for (var i = 0; i < count; i++) {
		    var it   = inv[i];
		    if (it == noone) continue;

		    // compute the y position once
		    var nameY = listStartY + i * itemSpacing - 24;

		    // 1) draw pointer on the selected line
		    if (i == global.selected_index) {
		        // draw pointer 8px to the left of the text
		        draw_sprite(spr_pointer, 0, rightX + 16, nameY + 19);
		        draw_set_color(c_yellow);
		    } else {
		        draw_set_color(c_white);
		    }

		    draw_text(rightX + 8, nameY, it.name);
		}
    } else {
        draw_text(rightX - 64, listStartY + itemSpacing, "Inventory is empty...");
    }

    // —————— Draw details (left panel) ——————
    if (count > 0) {
        var sel = inv[ global.selected_index ];
        // draw icon
		if (sel.icon != -1) {
            var sprW = sprite_get_width(sel.icon);
            var sprH = sprite_get_height(sel.icon);
            draw_sprite_ext(
                sel.icon, 0,
                guiX + 36, detailY - 24,
                iconSize / sprW, iconSize / sprH,
                0, c_white, 1
            );
        }
		
        // description — wrapped to leftW width, shifted up by 4px
        var descX = guiX + 8;
        var descY = detailY + iconSize + 8 - 20;  // <- subtract 4px here
        var maxW  = leftW - 16;
        var lineY = descY;                        // start lineY at the new, higher descY

        // split into words
        var words   = string_split(sel.itemDescription, " ");
        var current = "";

        // center‐align
		draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);

        var centerX = descX + maxW * 0.5;

        for (var w = 0; w < array_length(words); w++) {
            var test = (current == "" ? words[w] : current + " " + words[w]);
            if (string_width(test) > maxW) {
                // flush the current line
                draw_text(centerX, lineY, current);
                // advance Y by line‐height of the font
                lineY += string_height(current);
                current = words[w];
            } else {
                current = test;
            }
        }
        // draw any leftover
        if (current != "") {
            draw_text(centerX, lineY, current);
        }

        // restore alignment
        draw_set_halign(fa_left);
    }

    // restore color
    draw_set_color(c_white);
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
    var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;

    // --- Layout parameters for party member status boxes ---
    var inner_margin      = 10;
    var content_x         = gui_x + inner_margin;
    var content_y         = gui_y + inner_margin;
    var content_width     = gui_width - inner_margin * 2;
    
    // how many members?
    var count             = array_length(global.party);
    var party_box_height  = (gui_height - inner_margin * 2) / count;
    var party_box_spacing = 2;

    // --- Loop through global.party and draw each member’s status ---
    for (var i = 0; i < count; i++) {
        var member = global.party[i];
        var y_pos  = content_y + i * (party_box_height + party_box_spacing);

        // Draw sprite (using the 'idle' pose from your sprites struct)
        var sprite_size = 16;
        var sprite_x    = content_x + 24;
        var sprite_y    = y_pos + (party_box_height - sprite_size) * 0.5;
        draw_sprite_ext(member.sprites.idle, 0,
                        sprite_x + 9, sprite_y + 15,
                        0.5, 0.5, 0, c_white, 1);

        // Text layout
        var text_x      = sprite_x + sprite_size + 12;
        var availableW  = (content_x + content_width) - text_x;
        var colWidth    = availableW / 3;
        var col1_x      = text_x;
        var col2_x      = text_x + colWidth + 15;
        var col3_x      = text_x + colWidth * 2 + 15;
        var line_height = 8;

        // Name
        draw_text_transformed(text_x - 28, y_pos,
                              member.name, 0.75, 0.75, 0);

        // First row: HP / EP / ATK
        var stat_y = y_pos + 5 + line_height;
        draw_text_transformed(col1_x, stat_y,
                              "HP: " + string(member.hp) + "/" + string(member.hpMax),
                              0.5, 0.5, 0);
        draw_text_transformed(col2_x, stat_y,
                              "EP: " + string(member.ep) + "/" + string(member.epMax),
                              0.5, 0.5, 0);
        draw_text_transformed(col3_x, stat_y,
                              "ATK: " + string(member.ATK),
                              0.5, 0.5, 0);

        // Second row: DEF / SPD
        stat_y += line_height;
        draw_text_transformed(col1_x, stat_y,
                              "DEF: " + string(member.DEF),
                              0.5, 0.5, 0);
        draw_text_transformed(col2_x, stat_y,
                              "SPD: " + string(member.SPD),
                              0.5, 0.5, 0);

        // Divider line
        if (i < count - 1) {
            var line_y = y_pos + party_box_height - 5;
            draw_set_color(c_gray);
            draw_line(content_x, line_y,
                      content_x + content_width, line_y);
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

        // --- Draw Pointer if selected ---
        if (i == global.equipSlotSelected) {
            draw_set_color(c_yellow);
            draw_sprite(spr_pointer, 0, content_x, sprite_y + 18); // pointer on left
        }

        // --- Draw Member Idle Sprite (scaled down) ---
        if (variable_struct_exists(member, "sprites") && variable_struct_exists(member.sprites, "idle") && sprite_exists(member.sprites.idle)) {
            draw_sprite_ext(member.sprites.idle, 0, sprite_x, sprite_y, sprite_scale, sprite_scale, 0, c_white, 1);
        }

        // --- Draw Member Name ---
        draw_set_color(c_white);
        draw_set_halign(fa_left);

        var name_offset_x = 8;
        var sprite_display_width = sprite_size * sprite_scale;
        var sprite_display_height = sprite_size * sprite_scale;

        draw_text(sprite_x + sprite_display_width + name_offset_x, sprite_y + sprite_display_height / 4, member.name);
    }
}

function equipment2_GUI () {
	// --- Define the inner area based on the right box dimensions ---
	var margin     = 12;
    var box_width  = RESOLUTION_W * 0.25;
    var box_x      = margin;
    var gui_x      = box_x + box_width + margin;
    var gui_y      = margin;
    var gui_width  = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;

    var content_margin = 16;
    var content_x = gui_x + content_margin;
    var content_y = gui_y + content_margin;
    var content_width = gui_width - content_margin * 2;

    var categories = ["Head", "Body", "Weapon"];
    var spacing_x = 64;

    draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(content_x, content_y, "Select Slot");

    for (var i = 0; i < 3; i++) {
    var x_pos = content_x + i * spacing_x;

    if (i == global.equipmentCategoryIndex) {
        draw_set_color(c_yellow);
        draw_sprite(spr_pointer, 0, x_pos + 8, content_y + 44);
    } else {
        draw_set_color(c_white);
    }

    draw_text(x_pos, content_y + 24, categories[i]);
}

    // Draw item list
	if (global.equipSlotSelected >= 0 && global.equipSlotSelected < array_length(global.party)) {
	    var list_y_start = content_y + 64;
	    var list_spacing_y = 32;

	    var member = global.party[global.equipSlotSelected];
	    var category = string_lower(categories[global.equipmentCategoryIndex]);

	    var equipped_item = -1;
	    if (category == "head")    equipped_item = member.equipment.head;
	    if (category == "body")    equipped_item = member.equipment.body;
	    if (category == "weapon")  equipped_item = member.equipment.weapon;

	    for (var j = 0; j < array_length(global.equipmentListFiltered); j++) {
	        var item = global.equipmentListFiltered[j];
	        var y_pos = list_y_start + j * list_spacing_y;

	        if (j == global.equipmentListIndex) {
	            draw_set_color(c_yellow);
	            draw_sprite(spr_pointer, 0, content_x + 24, y_pos + 20);
	            draw_set_color(c_white);
	        }

	        draw_text(content_x + 16, y_pos, item.name);

	        if (item == equipped_item) {
			    // Measure the text width in the current font
			    var text_w = string_width(item.name);

			    // X starts at the same place as the text, plus its width, plus 8px gap
			    var ptr_x  = content_x + 16 + text_w + 8;

			    // Y offset (adjust as needed for vertical centering)
			    var ptr_y  = y_pos + 8;

			    draw_sprite(spr_equip_pointer, 0, ptr_x, ptr_y);
			}
	    }
	}
}

function setting_GUI() {
    var margin = 12;
    var box_width = RESOLUTION_W * 0.25;
    var box_x = margin;
    var gui_x = box_x + box_width + margin;
    var gui_y = margin;
    var gui_width = RESOLUTION_W - gui_x - margin;
    var gui_height = RESOLUTION_H - margin * 2;

    var left_offset = gui_x + (gui_width - 120) * 0.5;
    var top_offset = gui_y + 36;
    
    // Titles
    draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);

    draw_text(left_offset, gui_y + 10, "Settings");

    var settings = ["Music Volume", "Sound Effects", "Screen Size"];
    var values = [
        string_format(global.musicVolume * 100, 0, 0) + "%",
        string_format(global.sfxVolume * 100, 0, 0) + "%",
        global.fullscreen ? "Fullscreen" : "Windowed"
    ];

    // Draw each setting
    for (var i = 0; i < array_length(settings); i++) {
        var setting_y = top_offset + i * 30;

        // Highlight selected option
        if (i == global.settingOptionSelected) {
            draw_set_color(c_yellow);
			draw_sprite(spr_pointer, 0, left_offset + 5, setting_y + 18);
        }
        draw_set_color(c_white);
        
        draw_text(left_offset, setting_y, settings[i] + ": " + values[i]);
    }

    // Reset draw color
    draw_set_color(c_white);
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
