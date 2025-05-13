if (place_meeting(x, y, obj_player) && !chestTriggered) {
    if (keyboard_check_pressed(vk_space)) {
        chestTriggered = true;

        if (!chestOpened) {
            // --- RANDOM LOOT LOGIC ---
            var keys = variable_struct_get_names(global.item_list);
            loot_item = global.item_list.katana;

            var found = false;
            inventory_add(loot_item);

            show_debug_message("Looted: " + loot_item.name);
			loot_message_prefix = "You got ";
			loot_message_item = loot_item.name;
			loot_message_timer = 45;

            // Start chest opening animation
            image_speed = 0.2; // Tune as needed
            chestOpened = true;
        }
    }
}

// Stop the animation when it finishes
if (chestOpened && image_index >= 3) {
    image_speed = 0;
    image_index = 3; // Lock to final frame
}

if (loot_message_timer > 0) {
    loot_message_timer -= 1;
}