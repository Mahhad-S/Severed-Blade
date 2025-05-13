//Make sure not to switch image
image_speed = 0;
image_index = 0;

//Chest variables
chestTriggered = false;
chestOpened = false;

//Randomized Loot
loot_key = "";
loot_item = undefined;

//Loot message
loot_message = "";
loot_message_timer = 0;

chest_id = string(x) + "_" + string(y); // Or a manually set ID

if (!variable_struct_exists(global.chest_states, chest_id)) {
    global.chest_states[chest_id] = false;
}
chestOpened = global.chest_states[chest_id];
