/// @desc Initialise & Globals
randomize();

global.gamePaused = false;
global.textSpeed = 0.75;
global.targetRoom = -1;
global.targetX = -1;
global.targetY = -1;
global.targetDirection = 0;

/*  Doesn't work properly. 
	Leave commented unless you want to try fixing it
	Goes with obj_camera
	
global.iCamera = instance_create_layer(0,0,layer,obj_camera); 

*/
surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);