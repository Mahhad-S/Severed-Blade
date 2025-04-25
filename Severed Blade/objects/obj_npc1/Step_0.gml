if (direction >= 306 or direction <= 45) {
	sprite_index = spr_npc1_left;
	image_xscale = -1;
}
if (direction >= 46 && direction <= 135) {
	sprite_index = spr_npc1_up;
	image_xscale = 1;
}
if (direction >= 136 && direction <= 225) {
	sprite_index = spr_npc1_left;
	image_xscale = 1;
}
if (direction >= 226 && direction <= 305) {
	sprite_index = spr_npc1_down;
	image_xscale = 1;
}

if place_meeting(x, y, obj_player) == true {
	path_speed = 0;
	image_speed = 0;
} else {
	path_speed = 0.5
	image_speed = 1;
}