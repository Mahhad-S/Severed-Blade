pauseOption = ["Status", "Inventory", "Magic", "Equipment", "Save", "Load", "Setting", "Exit"];
pauseOptionSelected = 0;

global.pauseSubmenu = "Status";
global.exitPromptActive = false;
global.exitOptionSelected = 0;
global.activateExitPrompt = false;

// Global variables for the slot GUI
global.saveSlotCount = 3;
global.loadSlotCount = 3;
global.equipSlotCount = 4;

global.saveSlotSelected = 0;
global.loadSlotSelected = 0;
global.equipSlotSelected = 0;

// Arrays to store slot data – use -1 for an empty slot.
// You could load these from file or initialize them later.
global.saveSlotData = array_create(global.saveSlotCount, -1);
global.loadSlotData = array_create(global.loadSlotCount, -1);

// Debounce flags for save/load
global.saveJustOpenedPrompt = false;
global.loadJustOpenedPrompt = false;
global.equipmentJustOpenedPrompt = false;

// A fade variable (like you used in your title screen) can control slot visibility.
slotVisible = 0.0;  // local or global, as desired

// Equipment Menu variables
equipment_selected_index = 0; // Which party member is highlighted
equipment_submenu_open = false; // If true, inside a character's equipment submenu

// --- Settings Values ---
global.sfxVolume   = 1.0; // Range: 0.0 to 1.0
global.fullscreen  = false;

// --- Settings Menu Navigation ---
global.settingOptionSelected = 0; // 0 = Music, 1 = SFX, 2 = Screen Size
global.settingOptionCount = 3;    // Total options
