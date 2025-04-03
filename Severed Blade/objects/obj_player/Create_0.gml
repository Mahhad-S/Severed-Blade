state = PlayerStateFree;
lastState = state;

collisionMap = layer_tilemap_get_id(layer_get_id("Wall"));

image_speed = 0;
xspd = 0;
yspd = 0;
speedWalk = 1;

spriteWalk = spr_player_walk;
spriteIdle = spr_player_idle;
localFrame = 0;

if (variable_global_exists("targetX") && global.targetX != -1) {
	x = global.targetX;
	y = global.targetY;
	direction = global.targetDirection;
}