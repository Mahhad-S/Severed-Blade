pauseOption = ["Status", "Inventory", "Magic", "Equipment", "Save", "Load", "Setting", "Exit"];
pauseOptionSelected = 0;

global.pauseSubmenu = "Status";
global.exitPromptActive = false;
global.exitOptionSelected = 0;
global.activateExitPrompt = false;

// Global variables for the slot GUI
global.saveSlotCount = 3;
global.loadSlotCount = 3;

global.saveSlotSelected = 0;
global.loadSlotSelected = 0;

// Arrays to store slot data – use -1 for an empty slot.
// You could load these from file or initialize them later.
global.saveSlotData = array_create(global.saveSlotCount, -1);
global.loadSlotData = array_create(global.loadSlotCount, -1);

// Debounce flags for save/load
global.saveJustOpenedPrompt = false;
global.loadJustOpenedPrompt = false;

// A fade variable (like you used in your title screen) can control slot visibility.
slotVisible = 0.0;  // local or global, as desired
