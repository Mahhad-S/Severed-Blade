if (place_meeting(x, y, obj_player)) {
	room_goto(target_room);
	obj_player.x = target_x;
	obj_player.y = target_y;
}