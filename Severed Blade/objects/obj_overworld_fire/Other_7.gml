var mushroom = instance_place(x, y, obj_mushroom);
if (mushroom != noone) {
    with (mushroom) {
        instance_destroy();
    }
}

// Then destroy the fire animation itself
instance_destroy();