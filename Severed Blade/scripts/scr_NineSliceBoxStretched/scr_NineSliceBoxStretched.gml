function scr_NineSliceBoxStretched(){
	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _index = argument5;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1
	
	//Middle
	draw_sprite_part_ext(argument0, _index, _size, _size, 1, 1, _x1+_size, _y1+_size, _w-(_size*2), _h-(_size*2), c_white, draw_get_alpha());
	
	//Corners
	//top left
	draw_sprite_part(argument0, _index, 0, 0, _size, _size, _x1, _y1);
	//top right
	draw_sprite_part(argument0, _index, _size*2, 0, _size, _size, _x1+_w-_size, _y1);
	//bottom left
	draw_sprite_part(argument0, _index, 0, _size*2, _size, _size, _x1, _y1+_h-_size);
	//bottom right
	draw_sprite_part(argument0, _index, _size*2, _size*2, _size, _size, _x1+_w-_size, _y1+_h-_size);
	
	//Edges
	//left edge
	draw_sprite_part_ext(argument0, _index, 0, _size, _size, 1, _x1, _y1+_size, 1, _h-(_size*2), c_white, draw_get_alpha);
	//right edge
	draw_sprite_part_ext(argument0, _index, _size*2, _size, _size, 1, _x1+_w-_size, _y1+_size, 1, _h-(_size*2), c_white, draw_get_alpha);
	//top edge
	draw_sprite_part_ext(argument0, _index, _size, 0, 1, _size, _x1+_size, _y1, _w-(_size*2), 1, c_white, draw_get_alpha);
	//bottom edge
	draw_sprite_part_ext(argument0, _index, _size, _size*2, 1, _size, _x1+_size, _y1+_h-(_size), _w-(_size*2), 1, c_white, draw_get_alpha);
}

function wrap_text(_string, _font, _width) {
    var _wrapped = "";
    var _line = "";
    var _words = string_split(_string, " ");

    draw_set_font(_font);

    for (var i = 0; i < array_length(_words); i++) {
        var _testLine = _line + _words[i] + " ";
        if (string_width(_testLine) > _width) {
            _wrapped += _line + "#"; // "#" = line break
            _line = _words[i] + " ";
        } else {
            _line = _testLine;
        }
    }

    _wrapped += _line;
    return _wrapped;
}
