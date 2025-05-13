if (statue_message_timer > 0) {
    var prefix = statue_message_prefix;
    var item = statue_message;

    var padding = 8;

    // Set font before measuring
    draw_set_font(f_text);

    // Text size measurements
    var prefix_width = string_width(prefix) * 0.7;
    var item_width = string_width(item) * 0.7;
    var total_width = prefix_width + item_width;
    var text_height = string_height(prefix) * 0.7;

    var box_width = total_width + padding * 2;
    var box_height = text_height + padding * 2;

    var box_x = display_get_gui_width() / 2 - box_width / 2;
    var box_y = 12;

    // Draw the box sprite scaled to fit the text
    draw_sprite_ext(spr_box, 0, box_x, box_y, box_width / sprite_get_width(spr_box), box_height / sprite_get_height(spr_box), 0, c_white, 1);

    // Now center the text inside the box
    var text_start_x = box_x + (box_width - total_width) / 2;
    var text_y = box_y + box_height / 2;

    draw_set_valign(fa_middle);
    draw_set_halign(fa_left);

    // Draw prefix
    draw_set_color(c_white);
    draw_text_transformed(text_start_x, text_y, prefix, 0.7, 0.7, 0);

    // Draw item name
    draw_set_color(c_yellow);
    draw_text_transformed(text_start_x + prefix_width, text_y, item, 0.7, 0.7, 0);
}
