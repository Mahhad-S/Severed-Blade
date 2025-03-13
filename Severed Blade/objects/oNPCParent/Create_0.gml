// Set initial movement direction randomly
direction = choose(0, 90, 180, 270);
speed = 0.5; // Default movement speed

// Assign default walking sprites (these can be overridden in child objects)
spr_walk_right = spr_npc_walk_right;
spr_walk_left = spr_npc_walk_left;
spr_walk_up = spr_npc_walk_up;
spr_walk_down = spr_npc_walk_down;

// Placeholder for idle sprite (can be replaced later)
spr_idle = spr_npc_idle;

