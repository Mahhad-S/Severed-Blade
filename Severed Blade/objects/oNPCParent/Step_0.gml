// If the NPC is not already moving, choose a random direction
if (!place_meeting(x + lengthdir_x(2, direction), y + lengthdir_y(2, direction), obj_wall)) {
    speed = 0.5; // Ensure speed is set
} else {
    direction = choose(0, 90, 180, 270); // Pick a new direction
}

// Calculate horizontal and vertical speed based on direction
var hspd = lengthdir_x(speed, direction);
var vspd = lengthdir_y(speed, direction);

// Move only if there's no collision
if (!place_meeting(x + hspd, y + vspd, obj_wall)) {
    x += hspd;
    y += vspd;
} else {
    // Change direction if NPC hits a solid object
    direction = choose(0, 90, 180, 270);
}

// Update sprite based on movement direction
if (direction == 0) sprite_index = spr_walk_left;  // Moving Right
if (direction == 90) sprite_index = spr_walk_up;  // Moving Down
if (direction == 180) sprite_index = spr_walk_right; // Moving Left
if (direction == 270) sprite_index = spr_walk_down;   // Moving Up
