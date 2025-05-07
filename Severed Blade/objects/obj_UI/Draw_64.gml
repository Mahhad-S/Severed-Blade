if (global.gamePaused) {
    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(0, 0, RESOLUTION_W, RESOLUTION_H, false);
    draw_set_alpha(1.0);

    var margin = 12;
    var box_width = RESOLUTION_W * 0.25;
    var box_x = margin;
    var box_y = margin;
    var option_height = 8;
    var option_padding = 8;

    var option_count = array_length(pauseOption);
    var box_height = (option_height + option_padding) * option_count + option_padding;

    draw_sprite_stretched(spr_box, 0, box_x, box_y, box_width, box_height);

    draw_set_font(f_text);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);

    for (var i = 0; i < option_count; i++) {
        var text = pauseOption[i];
        var text_x = box_x + 16;
        var text_y = box_y + option_padding + i * (option_height + option_padding) + option_height / 2;

        if (i == pauseOptionSelected) {
		    var pointer_x = text_x + 8;
		    var pointer_y = text_y + 12;
		    draw_sprite_ext(spr_pointer, 0, pointer_x, pointer_y, 1, 1, 0, c_white, 1);
		    draw_set_color(c_yellow);
		} else {
		    draw_set_color(c_white);
		}
		draw_text(text_x, text_y, text);
    }
	draw_set_color(c_white);
	
	var gui_x = box_x + box_width + margin;
	var gui_y = margin;
	var gui_width = RESOLUTION_W - gui_x - margin;
	var gui_height = RESOLUTION_H - margin * 2;
	
	draw_sprite_stretched(spr_box, 0, gui_x, gui_y, gui_width, gui_height);
	
	switch (global.pauseSubmenu) {
	    case "Inventory": inventory_GUI(); break;
	    case "Magic": magic_GUI(); break;
	    case "Status": status_GUI(); break;
	    case "Equipment":
			if (global.inEquipmentPartySelect) {
		        equipment_GUI(); // shows party member list
		    } else {
		        equipment2_GUI(); // detailed submenu
		    }
			break;
		case "Save": save_GUI(); break;
	    case "Load": load_GUI(); break;
	    case "Setting": setting_GUI(); break;
		case "Exit": exit_GUI(); break;
	}
	
    draw_set_color(c_white);
    draw_set_alpha(1.0);
	
	var hudMargin = 12;
    var iconSize  = 16;  
    // bottom-left: x = margin; y = screen height minus margin minus icon height
    var iconX = hudMargin;
    var iconY = RESOLUTION_H - hudMargin - iconSize;

    // draw the coin icon
    draw_sprite_ext(
        spr_Coin, 0,
        iconX, iconY,
        1, 1,     // no scale
        0, c_white, 1
    );

    // draw the coin count next to it
    draw_set_font(f_text);              
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_yellow);
    draw_text(
        iconX + iconSize + 4,             // 4px gap after icon
        iconY + iconSize * 0.5,           // vertically centered on icon
        string(global.playerMoney)
    );
    draw_set_color(c_white);
}


