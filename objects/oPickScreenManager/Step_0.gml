// move camera
if (camera_is_moving){
    --time_to_move_camera_remaining;
    var move_progress_ratio = 1 - power(1 - (1 - time_to_move_camera_remaining/time_to_move_camera_in_steps), 4);
    camera_set_view_pos(view_camera[0], 0, camera_original_y + (camera_goal_y - camera_original_y) * move_progress_ratio);
    if (time_to_move_camera_remaining <= 0){
        camera_is_moving = false;
    }
}

if (!PromptExists()){
    // swipe
    var camera_delta = mouse_last_position_y - display_mouse_get_y();
    if (mouse_check_button(mb_left)){
        camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]) + camera_delta);
        ResetCameraMovement();
    }
    
    // set slip
    if (mouse_check_button_released(mb_left)){
        slippery_speed = camera_delta * 0.5;
    }
    
    // apply slip
    camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]) + slippery_speed);
    slippery_speed *= slippery_decay_factor;
    if (abs(slippery_speed) < 0.01){
        ResetCameraMovement();
    }
    
    // mouse wheel controls
    if (mouse_wheel_up()){
        camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]) - 64);
        ResetCameraMovement();
    }
    else if (mouse_wheel_down()){
        camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]) + 64);
        ResetCameraMovement();
    }
    
    // clamp
    camera_set_view_pos(view_camera[0], 0, clamp(camera_get_view_y(view_camera[0]), 0, room_height - camera_get_view_height(view_camera[0])));
}

mouse_last_position_y = display_mouse_get_y();