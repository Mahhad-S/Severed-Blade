function inventory_GUI(){
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Inventory Screen");
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
        { name: "Hero",     hp: 100, maxHP: 100, ep: 50,  maxEP: 50,  atk: 20, def: 15, spd: 10, sprites: spr_player_idle},
        { name: "Mage",     hp:  60, maxHP:  60, ep: 80,  maxEP: 80,  atk: 10, def:  8, spd: 12, sprites: spr_player_idle},
        { name: "Warrior",  hp: 120, maxHP: 120, ep: 30,  maxEP: 30,  atk: 25, def: 20, spd:  8, sprites: spr_player_idle },
		{ name: "Janitor",  hp: 120, maxHP: 120, ep: 30,  maxEP: 30,  atk: 25, def: 20, spd:  8, sprites: spr_player_idle },
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
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Equipment Screen");
}

function setting_GUI() {
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Setting Screen");
}

function load_GUI() {
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Load Screen");
}

function save_GUI() {
	draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
	draw_text(120, 28, "Save Screen");
	//with (obj_game) instance_destroy();
    //SaveGame();
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
