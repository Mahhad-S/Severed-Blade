function PlayerStateFree(){
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
	
}

function PlayerStateTransition() {
	PlayerCollision();
	PlayerAnimateSprite();
}