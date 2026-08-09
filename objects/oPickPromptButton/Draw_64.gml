if (is_mouse_entered){
    draw_set_color(c_white);
    draw_set_alpha(0.25);
    draw_rectangle(x, y, right_edge_x, bottom_edge_y, false);
    draw_set_alpha(1);
}
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(text_x, text_y, text);