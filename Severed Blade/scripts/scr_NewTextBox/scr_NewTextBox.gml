function scr_NewTextBox(){
	var _obj;
	if (instance_exists(obj_text)) _obj = obj_text_queue; else _obj = obj_text;
	with (instance_create_layer(0, 0, "Instances", _obj)) {
		message = argument[0]; 
		if (instance_exists(other)) originInstance = other.id else originInstance = noone;
		if (argument_count > 1) background = argument[1]; else background = 1;
		if (argument_count > 2) {
			//trim markers from responses
			var _array=argument[2];

			for(var _i=0;_i<array_length(_array)  ;_i++)
			{
			 responses[_i]=_array[_i];
			}
			for (var i = 0; i < array_length(responses); i++) {
				var _markerPosition = string_pos(":", responses[i]);
				responseScript[i] = string_copy(responses[i], 1, _markerPosition - 1);
				responseScript[i] = real(responseScript[i]);
				responses[i] = string_delete(responses[i], 1, _markerPosition);
				//breakpoint = 10; //check variables
			}
		} else {
			responses = [-1];
			responseScript = [-1];
		}
	}
	with (obj_player) {
		if (state != PlayerStateLocked) {
			lastState = state;
			state = PlayerStateLocked;
		}
	}
	
}