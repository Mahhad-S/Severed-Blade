if (instance_exists(obj_player) && position_meeting(obj_player.x, obj_player.y, id)) {
    
    if (!transitionStarted) {
        var door = instance_position(x, y, obj_doorParent); // Check if there's a door at this location
        
        if (instance_exists(door)) {
            // Found a door — start door animation and freeze player
            with (obj_player) state = PlayerStateLocked;
            
            doorOpening = true;
            transitionStarted = true;
            door.image_index = 0;
            door.image_speed = 0.2; // Adjust for animation speed
        } else {
            // No door — do normal transition immediately
            start_transition();
        }
    }

    // Wait for door animation to finish
    if (doorOpening) {
        var door = instance_position(x, y, obj_doorParent);
        if (instance_exists(door) && door.image_index >= 3) {
            doorOpening = false;
            start_transition();
        }
    }
}
