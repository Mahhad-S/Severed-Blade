if (escapeDelay > 0)
{
	draw_set_font(f_text_battle);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text(x+8,bbox_top,"?");
}
draw_self();