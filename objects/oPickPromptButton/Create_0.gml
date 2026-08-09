// NOTE: the x and y position is unadjusted for camera position! treat it as the "position relative to the gui layer"
// for use in room position comparisons, you must add the camera position.
is_mouse_entered = false;
mouse_left_pressed_x = 0;
mouse_left_pressed_y = 0;

right_edge_x = x + button_width;
bottom_edge_y = y + button_height;

function MouseIsEntered(_mouse_x, _mouse_y){
    return _mouse_x >= x && _mouse_x <= right_edge_x &&
        _mouse_y >= camera_get_view_y(view_camera[0]) + y && _mouse_y <= camera_get_view_y(view_camera[0]) + bottom_edge_y;
}