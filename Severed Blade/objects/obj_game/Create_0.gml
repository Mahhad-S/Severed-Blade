/// @desc Initialise & Globals
randomize();

global.gameSaveSlot = 0;

global.gamePaused = false;
global.textSpeed = 0.75;
global.targetRoom = -1;
global.targetX = -1;
global.targetY = -1;
global.targetDirection = 0;

global.iCamera = instance_create_layer(0,0,layer,obj_camera); 
surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);