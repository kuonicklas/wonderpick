// DRAW BACKGROUND
var background_yscale = GetHeight() / sprite_get_height(sOptionBackground);
var background_xscale = GetWidth() / sprite_get_width(sOptionBackground);
draw_sprite_ext(sOptionBackground, is_mouse_entered && !oPickScreenManager.PromptExists(), left_edge_x, y, background_xscale, background_yscale, 0, c_white, 1);

// DRAW POINT REQUIREMENT
// setup
var point_scale = 0.5;
var point_width = sprite_get_width(sPoint) * point_scale;
var padding = 8;
var text_width = string_width(string(cost));
var total_width = point_width + padding + text_width;
var start_x = room_width / 2 - total_width / 2;
var draw_y = y + top_edge_padding / 2;

// draw
draw_sprite_ext(sPoint, 0, start_x + sprite_get_xoffset(sPoint) * point_scale, draw_y, point_scale, point_scale, 0, c_white, 1);

draw_set_color(c_dkgray);
if (oPointsTracker.GetPoints() < cost){
    draw_set_color(c_red);
}
draw_set_halign(fa_left);
draw_set_valign(fa_center);
draw_text(start_x + point_width + padding, draw_y, string(cost));