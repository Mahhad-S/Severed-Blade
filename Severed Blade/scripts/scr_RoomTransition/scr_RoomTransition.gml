function RoomTransition(){
	if (!instance_exists(obj_Transition)) {
		with (instance_create_depth(0,0,-9999,obj_Transition)) {
			type = argument[0];
			target = argument[1];
		}
	}
}