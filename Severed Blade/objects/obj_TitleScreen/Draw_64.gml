if (titleVisible > 0) {
	draw_sprite(spr_title, 0, 0, -RESOLUTION_H + titleVisible * RESOLUTION_H);
	
	draw_set_alpha(titleVisible * abs(sin(get_timer() * 0.000001  * pi)));
	draw_sprite(spr_title, 1, 0, 0);
	draw_set_alpha(1.0);
}

if (slotVisible > 0) {
	draw_set_alpha(slotVisible);
	for (var _slot = 0; _slot <= 2; _slot++) {
		//Draw the boxes
		var _y = 64 + _slot * 192;
		var _x = 640;
		var _img = 2;
		if (slotSelected == _slot) {
			_img = 3;
			draw_sprite_ext(spr_pointer, 0, _x, _y + 144, 5, 5, 0, c_white, 1);
		}
		scr_NineSliceBoxStretched(spr_textBoxes, _x, _y, 1248, _y + 192, _img);
		
		//Draw the save data (if exists)
		draw_set_font(f_text);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
		if (slotData[_slot] == -1) { //empty save slot
			draw_text_transformed(_x + 16, _y + 64, "Start new game", 4, 4, 0);	
		} else {
			draw_text_transformed(_x + 16, _y + 64,RoomToAreaName(slotData[_slot][? "room"]), 4, 4, 0);
		}
	}
	draw_set_alpha(1.0);
}