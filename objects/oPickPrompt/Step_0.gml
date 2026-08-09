if (!is_prompt_disabled && mouse_check_button_pressed(mb_left) && (mouse_x < oPickOption.GetLeftEdgeX() || mouse_x > oPickOption.GetLeftEdgeX() + oPickOption.GetWidth())){
    ExitPrompt();
}