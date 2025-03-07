draw_self();

var _x = xstart - 7;
var _y = ystart + 32;
var _w = 40;
var _h = 8;

draw_sprite_stretched(spr_health_bar, 0, _x, _y, _w, _h);
draw_sprite_stretched_ext(spr_health_bar, 1, _x, _y, _w * (data.hp / data.total_hp), _h, c_red, 1);