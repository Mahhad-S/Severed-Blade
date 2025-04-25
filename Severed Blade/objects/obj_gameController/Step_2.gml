/// @desc Pause Toggle
if (keyboard_check_pressed(vk_escape)) 
&& (!instance_exists(obj_Transition)) 
&& (instance_exists(obj_UI) && obj_UI.visible) 
&& (!global.exitPromptActive)
{
	global.gamePaused = !global.gamePaused;

	if (global.gamePaused) {
		instance_deactivate_all(true);
		instance_activate_object(obj_player);
		instance_activate_object(obj_UI);
	} 
	else {
		instance_activate_all()
	}
}
