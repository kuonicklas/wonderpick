draw_set_color(c_white);
draw_sprite(sPointsGui, 0, 0, 0);

// points
var point_width = sprite_get_width(sPoint);
var h_points_padding = 8; // space between each point
var points_y = 30;
var points_start_x = (room_width / 2) - (0.5 * (global.max_points - 1) * (h_points_padding + point_width));

for (var i = 0, sec_remaining = oPointsTracker.GetTotalAccumulatedTimeInSec(); i < global.max_points; ++i){
    var point_x = points_start_x + (i * (h_points_padding + point_width));
    var point_value = min(sec_remaining / global.sec_per_point, 1);
    draw_sprite_ext(sPoint, 1, point_x, points_y, 1, 1, 0, c_white, 0.1);
    draw_sprite_radial(sPoint, 0, point_value, point_x, points_y, 1, 1, c_white, point_value < 1 ? 0.5 : 1);
    sec_remaining = max(0, sec_remaining - global.sec_per_point);
}

// time to next point
if (oPointsTracker.GetTotalAccumulatedTimeInSec() == global.sec_per_point * global.max_points){
    return;
}
var total_sec_to_next_point = global.sec_per_point - floor(oPointsTracker.GetTotalAccumulatedTimeInSec() % global.sec_per_point);
var sec_to_next_point = total_sec_to_next_point % 60;
var mins_to_next_point = ((total_sec_to_next_point - sec_to_next_point) % (60 * 60)) / 60;
var hrs_to_next_point = (total_sec_to_next_point - sec_to_next_point - mins_to_next_point * 60) / (60 * 60);
var time_to_next_point_string =
    (hrs_to_next_point > 0 ? string(hrs_to_next_point) + "hr" : "") +
    (mins_to_next_point > 0 ? " " + string(mins_to_next_point) + "min" : "") +
    (sec_to_next_point > 0 ? " " + string(sec_to_next_point) + "s" : "");

draw_set_color(c_dkgray);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(room_width / 2, points_y + (point_width / 2) + 4 ,time_to_next_point_string);