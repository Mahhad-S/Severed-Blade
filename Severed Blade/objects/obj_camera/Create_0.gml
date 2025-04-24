/// @desc Set Up Camera
cam = view_camera[0];
follow = obj_player;
buff = 32;
viewWidthHalf = camera_get_view_width(cam) * 0.5;
viewHeightHalf = camera_get_view_height(cam) * 0.5;
xTo = xstart;
yTo = ystart;
display_set_gui_size(320,180);

shakeLenght = 0;
shakeMagnitude = 0;
shakeRemain = 0;
