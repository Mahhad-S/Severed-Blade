// In your obj_player Create event:
jumpInit  = false;
jumpTimer = 0;

// ------------------------------------------------------
function PlayerStateJump() {
    PlayerAnimateJump();
}


function PlayerStateFree(){
	if (keyboard_check_pressed(vk_space) && input_mag != 0) {
        // 1) Are we standing on an endpoint?
        var ep = instance_position(x, y, obj_jump_end);
        if (ep != noone) {
            // 2) Find the OTHER endpoint with the same pairID
            var dest = noone;
            with (obj_jump_end) {
                if (pairID == ep.pairID && id != ep.id) {
                    dest = id;
                    break;
                }
            }
            if (dest != noone) {
                // 3) Decide which cardinal dir to press
                var dx = dest.x - x;
                var dy = dest.y - y;
                var needed_dir = (abs(dx) >= abs(dy))
                    ? (dx > 0 ? 0   : 180)   // left/right jump
                    : (dy > 0 ? 270  : 90);  // up/down jump

                // 4) If they are holding that dir, switch to Jump
                if (input_dir == needed_dir) {
                    state = PlayerStateJump;
                    return; // skip the rest of Free this frame
                }
            }
        }
    }
	
	xspd = lengthdir_x(input_mag * speedWalk, input_dir);
	yspd = lengthdir_y(input_mag * speedWalk, input_dir);

	xspd = ceil(abs(xspd)) * sign(xspd);
	yspd = ceil(abs(yspd)) * sign(yspd);
	
	PlayerCollision();

	//Update -Sprite Index
	var _oldSprite = sprite_index;
	if (input_mag != 0)
	{
		direction = input_dir;
		sprite_index = spriteWalk;
	} else sprite_index = spriteIdle;
	if (_oldSprite != sprite_index) localFrame = 0;

	//Update Image Index
	PlayerAnimateSprite();
	
	if (activate_key) {
        //1. Check for an entity to activate
        var _activateX = lengthdir_x(10, direction);
        var _activateY = lengthdir_y(10, direction);
        activate = instance_position(x+_activateX, y+_activateY, obj_entity);
        //2. If there is nothing, or there is something, but it has no script - nothing
        if (activate == noone || activate.entityActivateScript == -1) {
             state = PlayerStateFree;
        } else {
        //3. otherwise, there is something and it has a script, activate
            scr_ExecuteArray(activate.entityActivateScript, activate.entityActivateArgs);
            
        //4. if the thing we activate is an NPC, make it face towards us
            if (activate.entityNPC) {
                with (activate) {
                    direction = point_direction(x, y, other.x, other.y);
                    image_index = CARDINAL_DIR; 
                }
            }
        }
    }	
}

function PlayerStateLocked(){
    image_speed = 0;
}

function PlayerStateTransition() {
	PlayerCollision();
	PlayerAnimateSprite();
}