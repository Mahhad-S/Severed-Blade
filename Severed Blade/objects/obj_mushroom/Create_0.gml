/// obj_mushroom ▶ Create Event
if (variable_global_exists("burned_mushrooms")) {
    var roomKey = room;
    if (ds_map_exists(global.burned_mushrooms, roomKey)) {
        var list   = global.burned_mushrooms[? roomKey];
        var posKey = string(x) + "," + string(y);
        if (ds_list_find_index(list, posKey) != -1) {
            instance_destroy();
            exit; // stop any further Create code
        }
    }
}
