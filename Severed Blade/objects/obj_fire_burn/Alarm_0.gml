/// obj_fire_burn ▶ Alarm[0]
if (burn_target != noone && instance_exists(burn_target)) {
    // 1) Build our keys
    var roomKey = room;  // current room ID
    var posKey  = string(burn_target.x) + "," + string(burn_target.y);

    // 2) Ensure there’s a list for this room
    if (!ds_map_exists(global.burned_mushrooms, roomKey)) {
        ds_map_add(global.burned_mushrooms, roomKey, ds_list_create());
    }
    var list = global.burned_mushrooms[? roomKey];

    // 3) Add this position if it’s not already in there
    if (ds_list_find_index(list, posKey) == -1) {
        ds_list_add(list, posKey);
    }

    // 4) Now destroy the mushroom
    with (burn_target) {
        instance_destroy();
    }
}

// Finally, destroy the fire itself
instance_destroy();
