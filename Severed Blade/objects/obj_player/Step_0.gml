right_key = keyboard_check(vk_right) ||  keyboard_check(ord("D"));
left_key = keyboard_check(vk_left) ||  keyboard_check(ord("A"));
up_key = keyboard_check(vk_up) ||  keyboard_check(ord("W"));
down_key = keyboard_check(vk_down) ||  keyboard_check(ord("S"));

activate_key = keyboard_check_pressed(vk_space);
item_key = keyboard_check_pressed(vk_control);

xspd = (right_key - left_key) * move_spd;
yspd = (down_key - up_key) * move_spd;

if (!global.gamePaused) script_execute(state);

depth = -bbox_bottom;