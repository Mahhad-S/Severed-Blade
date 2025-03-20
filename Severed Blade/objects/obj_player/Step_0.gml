//Input Recognition
right_key = keyboard_check(vk_right) ||  keyboard_check(ord("D"));
left_key = keyboard_check(vk_left) ||  keyboard_check(ord("A"));
up_key = keyboard_check(vk_up) ||  keyboard_check(ord("W"));
down_key = keyboard_check(vk_down) ||  keyboard_check(ord("S"));
activate_key = keyboard_check_pressed(vk_space);
menu_key = keyboard_check_pressed(vk_tab);

input_dir = point_direction(0,0,right_key-left_key,down_key-up_key);
input_mag = (right_key - left_key != 0) || (down_key - up_key != 0);

//Movement
xspd = lengthdir_x(input_mag * speedWalk, input_dir);
yspd = lengthdir_y(input_mag * speedWalk, input_dir);

x += xspd;
y += yspd;

//Update -Sprite Index
var _oldSprite = sprite_index;
if (input_mag != 0)
{
	direction = input_dir;
	sprite_index = spriteWalk;
} else sprite_index = spriteIdle;
if (_oldSprite != sprite_index) localFrame = 0;

//Update Image Index
PlayerAnimateSprite();


depth = -bbox_bottom;

