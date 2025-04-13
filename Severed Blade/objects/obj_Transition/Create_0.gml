enum TRANS_TYPE {
	SLIDE,
	FADE,
	PUSH,
	STAR,
	WIPE
}

width = display_get_gui_width();
height = display_get_gui_height();
heighthalf = (height * 0.5) + 20;
percent = 0;
leading = OUT;