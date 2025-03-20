function scr_PlayerStateFree(){
	//set sprite
	mask_index = sprite[DOWN]
	if yspd == 0{
		if xspd > 0 {face = RIGHT};
		if xspd < 0 {face = LEFT};
	}
	if xspd > 0 && face == LEFT {face = RIGHT};
	if xspd < 0 && face == RIGHT {face = LEFT};

	if xspd == 0{
		if yspd > 0 {face = DOWN};
		if yspd < 0 {face = UP};
	}
	if yspd > 0 && face == UP {face = DOWN};
	if yspd < 0 && face == DOWN {face = UP};

	sprite_index = sprite[face];

	//collisions
	if place_meeting(x + xspd, y, obj_wall) == true {
		xspd = 0
	}

	if place_meeting(x, y + yspd, obj_wall) == true {
		yspd = 0
	}

	if place_meeting(x + xspd, y, obj_npc1) == true {
		xspd = 0
	}

	if place_meeting(x, y + yspd, obj_npc1) == true {
		yspd = 0
	}
	

	//move player
	x += xspd;
	y += yspd;

	//animate
	if xspd == 0 && yspd == 0 {
		image_index = 0;
	}
	
	//activate key logic
	if (activate_key) {
		//1. Check for an entity to activate
		var _activateX = lengthdir_x(10, direction);
		var _activateY = lengthdir_y(10, direction);
		activate = instance_position(x+_activateX, y+_activateY, obj_entity);
		//2. If there is nothing, or there is something, but it has no script - nothing
		if (activate == noone || activate.entityActivateScript == -1) {
			 state = scr_PlayerStateFree;
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