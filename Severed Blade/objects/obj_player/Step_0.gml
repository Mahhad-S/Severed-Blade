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

// Determine facing direction for block interaction
if (right_key) faceDir = 0;
if (up_key) faceDir = 1;
if (left_key) faceDir = 2;
if (down_key) faceDir = 3;

if (!global.gamePaused) {
    script_execute(state);
}

// Block pushing logic
if (interact_key) {
    var _checkDir = faceDir * 90;
    var _checkX = x + lengthdir_x(interactDist, _checkDir);
    var _checkY = y + lengthdir_y(interactDist, _checkDir);
    var _pushBlockInst = instance_place(_checkX, _checkY, obj_pushblock);
    
    if (instance_exists(_pushBlockInst) && !_pushBlockInst.sliding) {
        _pushBlockInst.sliding = true;
        _pushBlockInst.faceDir = faceDir;

        // Move the push block
        var _moveX = _pushBlockInst.x + lengthdir_x(moveSpeed, _pushBlockInst.faceDir * 90);
        var _moveY = _pushBlockInst.y + lengthdir_y(moveSpeed, _pushBlockInst.faceDir * 90);

        // Check if the new position is clear of collisions with obj_wall
        if (!tilemap_get_at_pixel(global.collisionMap, _moveX, _moveY)){  // Use 'obj_wall' here
            // Save the new position
            _pushBlockInst.x = _moveX;
            _pushBlockInst.y = _moveY;

            // Optionally, store the position for future use
            _pushBlockInst.savedX = _moveX;
            _pushBlockInst.savedY = _moveY;
            
            // Save the push block's position globally for room transition
            global.savedPushBlockX = _moveX;
            global.savedPushBlockY = _moveY;
        }
    }
}