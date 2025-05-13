// Input Recognition
right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
left_key = keyboard_check(vk_left) || keyboard_check(ord("A"));
up_key = keyboard_check(vk_up) || keyboard_check(ord("W"));
down_key = keyboard_check(vk_down) || keyboard_check(ord("S"));
activate_key = keyboard_check_pressed(vk_space);
menu_key = keyboard_check_pressed(vk_tab);
interact_key = keyboard_check_pressed(ord("F"));

input_dir = point_direction(0, 0, right_key - left_key, down_key - up_key);
input_mag = (right_key - left_key != 0) || (down_key - up_key != 0);

if (!global.gamePaused) {
    script_execute(state);
}

if (right_key) faceDir = 0;
if (up_key) faceDir = 1;
if (left_key) faceDir = 2;
if (down_key) faceDir = 3;

// Block pushing logic
if (interact_key) {
    var _checkDir = faceDir * 90;
    var _checkX = x + lengthdir_x(interactDist, _checkDir);
    var _checkY = y + lengthdir_y(interactDist, _checkDir);
    var _pushBlockInst = instance_place(_checkX, _checkY, obj_pushblock);
    
    if (instance_exists(_pushBlockInst) && !_pushBlockInst.sliding) {
        _pushBlockInst.sliding = true;
        _pushBlockInst.faceDir = faceDir;


        var _moveX = _pushBlockInst.x + lengthdir_x(moveSpeed, _pushBlockInst.faceDir * 90);
        var _moveY = _pushBlockInst.y + lengthdir_y(moveSpeed, _pushBlockInst.faceDir * 90);

        // Check if the new position is clear of collisions with obj_wall
        if (!tilemap_get_at_pixel(global.collisionMap, _moveX, _moveY)){  // Use 'obj_wall' here
            // Save the new position
            _pushBlockInst.x = _moveX;
            _pushBlockInst.y = _moveY;


            _pushBlockInst.savedX = _moveX;
            _pushBlockInst.savedY = _moveY;
            

            global.savedPushBlockX = _moveX;
            global.savedPushBlockY = _moveY;
        }
    }
}

if (place_meeting(x, y, obj_statue) && activate_key && !statueTriggered) {
    statueTriggered = true; // Prevent repeat activation
	global.fire_magic_unlocked = true;

    // Display message setup
    statue_message_prefix = "You have unlocked ";
    statue_message = "Fire Magic!";
    statue_message_timer = 90; // Display for 90 frames

    show_debug_message(global.fire_magic_unlocked);
}


if (statue_message_timer > 0) {
    statue_message_timer -= 1;
}

if (global.fire_magic_unlocked && activate_key) {
    // 1) find an adjacent mushroom…
    var target = noone;
    var offsets = [ [16,0], [-16,0], [0,16], [0,-16] ];
    for (var i = 0; i < array_length(offsets); i++) {
        var ox = offsets[i][0], oy = offsets[i][1];
        if (place_meeting(x+ox, y+oy, obj_mushroom)) {
            target = instance_place(x+ox, y+oy, obj_mushroom);
            break;
        }
    }
    // 2) if we found one, spawn fire just above it:
    if (target != noone) {
	    var fire = instance_create_depth(
	    target.x,
	    target.y - 4,         // your vertical offset
	    target.depth + 1,     // <-- depth just in front of the mushroom
	    obj_fire_burn
	);
	fire.burn_target = target;
	fire.alarm[0]   = room_speed * 2;
	}
}





