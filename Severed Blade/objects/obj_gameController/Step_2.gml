/// @desc Pause Toggle
if (keyboard_check_pressed(vk_escape)) 
&& (!instance_exists(obj_Transition)) 
&& (instance_exists(obj_UI) && obj_UI.visible) 
&& (!global.exitPromptActive)
{
	global.gamePaused = !global.gamePaused;

	if (global.gamePaused) {
		with (all) {
			if (!variable_instance_exists(id, "gamePausedImageSpeed")) {
				gamePausedImageSpeed = image_speed;
			}
			image_speed = 0;
		}
	} 
	else {
		with (all) {
			if (variable_instance_exists(id, "gamePausedImageSpeed")) {
				image_speed = gamePausedImageSpeed;
			}
		}
	}
}
