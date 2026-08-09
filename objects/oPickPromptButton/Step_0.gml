is_mouse_entered = MouseIsEntered(mouse_x, mouse_y);

if (is_mouse_entered && mouse_check_button_released(mb_left) &&
    MouseIsEntered(mouse_left_pressed_x, mouse_left_pressed_y)){
    callback();
}
if (mouse_check_button_pressed(mb_left)){
    mouse_left_pressed_x = mouse_x;
    mouse_left_pressed_y = mouse_y;
}