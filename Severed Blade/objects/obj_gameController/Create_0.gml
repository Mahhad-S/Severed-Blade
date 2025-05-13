/// @desc Initialize Global State (runs once only)
//persistent = true;

randomize();

if (!variable_global_exists("gameSaveSlot")) global.gameSaveSlot = 0;
if (!variable_global_exists("gamePaused")) global.gamePaused = false;
if (!variable_global_exists("textSpeed")) global.textSpeed = 0.75;
if (!variable_global_exists("targetRoom")) global.targetRoom = -1;
if (!variable_global_exists("targetX")) global.targetX = -1;
if (!variable_global_exists("targetY")) global.targetY = -1;
if (!variable_global_exists("targetDirection")) global.targetDirection = 0;
if (!variable_global_exists("exitPromptActive")) global.exitPromptActive = false;
if (!variable_global_exists("exitOptionSelected")) global.exitOptionSelected = 0;
if (!variable_global_exists("pauseSubmenu")) global.pauseSubmenu = "Status";
if (!variable_global_exists("justOpenedPrompt")) global.justOpenedPrompt = false;
if (!variable_global_exists("playerXLoad")) global.playerXLoad = -1;
if (!variable_global_exists("playerYLoad")) global.playerYLoad = -1;
if (!variable_global_exists("fire_magic_unlocked")) global.fire_magic_unlocked = false;

global.loopingSFXInstances = array_create(0);
global.musicInstances = array_create(0);

global.iCamera = instance_create_layer(0,0,"Instances",obj_camera);
global.item_manager = instance_create_layer(0, 0, "Instances", obj_item_manager);
global.iUI = instance_create_layer(0, 0, "Instances", obj_UI);
global.iwall = instance_create_layer(0, 0, "Instances", obj_game);

surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);
