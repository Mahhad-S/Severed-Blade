//Input Recognition
right_key = keyboard_check(vk_right) ||  keyboard_check(ord("D"));
left_key = keyboard_check(vk_left) ||  keyboard_check(ord("A"));
up_key = keyboard_check(vk_up) ||  keyboard_check(ord("W"));
down_key = keyboard_check(vk_down) ||  keyboard_check(ord("S"));
activate_key = keyboard_check_pressed(vk_space);
menu_key = keyboard_check_pressed(vk_tab);

input_dir = point_direction(0,0,right_key-left_key,down_key-up_key);
input_mag = (right_key - left_key != 0) || (down_key - up_key != 0);

if (!global.gamePaused) script_execute(state);
depth = -bbox_bottom;

