draw_sprite_stretched(spr_box, 0, x, y, widthFull, heightFull);

// Get the camera's Y position to adjust the pointer
var camera_y = camera_get_view_y(view_camera[0]);
var camera_x = camera_get_view_x(view_camera[0]);

draw_set_color(c_white);
draw_set_font(f_text_battle);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = (description != -1);
var _scrollPush = max(0, hover - (visibleOptionsMax - 1));

for (l = 0; l < (visibleOptionsMax + _desc); l++) {
	if (l >= array_length(options)) break;
	draw_set_color(c_white);
	if (l == 0) && (_desc) {
		draw_text(x + xmargin, y + ymargin, description);	
	} else {
		var _optionToShow = l - _desc + _scrollPush;
		var _str = options[_optionToShow][0];
		if (hover == _optionToShow - _desc) {
			draw_set_color(c_yellow);
		}
		if (options[_optionToShow][3] == false) draw_set_color(c_gray);
	draw_text(x +xmargin, y + ymargin + l * heightLine, _str);
	}
}


// Draw the pointer at the correct Y position, considering the camera and menu offset
draw_sprite(spr_pointer, 0, camera_x  + xmargin + 20, camera_y + ymargin + ((hover - _scrollPush) * heightLine) + 127);
if (visibleOptionsMax < array_length(options)) && (hover < array_length(options) - 1)
{
	draw_sprite(spr_downArrow, 0, x + widthFull * 0.5, y + heightFull - 7);
}