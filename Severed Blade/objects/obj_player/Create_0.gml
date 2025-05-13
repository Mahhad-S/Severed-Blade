state = PlayerStateFree;
lastState = state;

collisionMap = layer_tilemap_get_id(layer_get_id("Wall"));

image_speed = 0;
xspd = 0;
yspd = 0;
speedWalk = 1;

jumpInit = false;
jumpTimer = 0;

is_pushing = false;

spriteWalk = spr_player_walk;
spriteWalk = spr_player_walk;
spriteIdle = spr_player_idle;
localFrame = 0;

interactDist = 4;
moveSpeed = 4;

// Loot message
statue_message_timer = 0;

// Prevent reactivation
statueTriggered = false;


// Priority: Load file position > Room transition
if (variable_global_exists("playerXLoad") && global.playerXLoad != -1) {
    x = global.playerXLoad;
    y = global.playerYLoad;
    
	if (variable_global_exists("targetDirection")) {
        direction = global.targetDirection;
    }
	
    global.playerXLoad = -1;
    global.playerYLoad = -1;
} else if (variable_global_exists("targetX") && global.targetX != -1) {
    x = global.targetX;
    y = global.targetY;
    
	if (variable_global_exists("targetDirection")) {
        direction = global.targetDirection;
    }
}
