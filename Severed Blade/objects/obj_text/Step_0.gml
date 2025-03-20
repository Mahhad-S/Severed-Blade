lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1, x1Target, lerpProgress);
x2 = lerp(x2, x2Target, lerpProgress);

//Cecyle through responses
keyUp = keyboard_check(vk_up) ||  keyboard_check(ord("W"));
keyDown = keyboard_check(vk_down) ||  keyboard_check(ord("S"));
responseSelected += (keyDown - keyUp);
var _max = array_length(responses) - 1;
var _min = 0;
if (responseSelected > _max) responseSelected = _min;
if (responseSelected > _min) responseSelected = _max;

if (keyboard_check_pressed(vk_space)) {
	var _messageLength = string_length(message);
	if (textProgress >= _messageLength) {
		if (responses[0] != -1) {
			with (originInstance) scr_DialogueResponses(other.responseScript[other.responseSelected]);
		}
		instance_destroy();
		if (instance_exists(obj_text_queue)) {
			with (obj_text_queue) ticket--;	
		} else {
			with (obj_player) state = lastState;
		}
	} else {
		if (textProgress > 2) {
			textProgress = _messageLength;		
		}
	}
}