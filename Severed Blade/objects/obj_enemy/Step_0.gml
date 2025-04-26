var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

move_and_collide(_hor * moveSpd, _ver * moveSpd, [tilemap, obj_enemy]);

escapeDelay = max(escapeDelay-1, 0);

if (dead) 
{
	image_alpha -= 0.05;
	image_blend = c_red;
	if (image_alpha <= 0) instance_destroy();
}

