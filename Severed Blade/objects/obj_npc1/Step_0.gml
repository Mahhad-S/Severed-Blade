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