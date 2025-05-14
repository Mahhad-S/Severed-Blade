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

// Ensure global.opened_chests exists
if (!variable_global_exists("opened_chests")) {
    global.opened_chests = ds_map_create();
}

// Persistent chest state check
var roomKey = room;
var posKey = string(x) + "," + string(y);

if (ds_map_exists(global.opened_chests, roomKey)) {
    var list = global.opened_chests[? roomKey];
    if (ds_list_find_index(list, posKey) != -1) {
        chestOpened = true;
        chestTriggered = true;
        image_index = 3; // Final frame
        image_speed = 0;
    }
}
