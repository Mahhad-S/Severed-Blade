// @desc Draw UI 

// Draw coins we have 
var _xx, _yy; 

// Coin Icon 
_xx = 8;
_yy = 31;
draw_sprite(sCoinUI,0, _xx,_yy); 

// Coin text 
draw_set_colour(c_black);
draw_set_font(fnt_default);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

_xx += sprite_get_width(sCoinUI) + 4;
_yy = 14; 
var _str = string(global.playerMoney);
draw_text(_xx+1, _yy, _str);
draw_text(_xx+1, _yy, _str);
draw_text(_xx, _yy+1, _str);
draw_text(_xx, _yy-1, _str);
draw_set_colour(c_white);
draw_text(_xx, _yy, _str); 
