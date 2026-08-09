// background
draw_set_color(c_black);
draw_set_alpha(0.75);
draw_rectangle(0, 0, global.window_length, global.window_length, false);
draw_set_alpha(1);

// prompt
// point line
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(point_text_start_x, point_line_y, point_text);
draw_sprite_ext(sPoint, 0, point_icon_draw_x,
    point_icon_y, point_scale, point_scale, 1, c_white, 1);
draw_text(point_icon_text_start_x, point_line_y, point_icon_text);

// question line
draw_text(question_text_x, question_text_y, question_text);