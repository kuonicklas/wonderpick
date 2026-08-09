is_mouse_entered = MouseIsEntered(mouse_x, mouse_y);
distance_since_left_pressed += sqrt(power(mouse_x - last_mouse_x, 2) + power(mouse_y - last_mouse_y, 2));

if (is_mouse_entered && mouse_check_button_released(mb_left) &&
    MouseIsEntered(mouse_left_pressed_x, mouse_left_pressed_y) &&
    !oPickScreenManager.PromptExists() && distance_since_left_pressed < 8 &&
    oPointsTracker.GetPoints() >= cost){
    oPickScreenManager.CreatePrompt(id);
}
if (mouse_check_button_pressed(mb_left)){
    // used to check that a click only counts if it was (1) pressed on the option, (2) released on the option
    // however, the click is "complete" only when the mouse is released.
    mouse_left_pressed_x = mouse_x;
    mouse_left_pressed_y = mouse_y;
    distance_since_left_pressed = 0;
}

last_mouse_x = mouse_x;
last_mouse_y = mouse_y;