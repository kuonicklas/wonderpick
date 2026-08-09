flip_time_remaining = max(0, flip_time_remaining - 1);
if (is_flipping && flip_time_remaining <= time_to_flip_in_steps / 2){
    is_flipping = false;
    image_index = image_index == 0 ? card_value : 0;
}

image_xscale = (cos(flip_time_remaining / time_to_flip_in_steps * 2 * pi) + 1) / 2 * original_image_scale;

is_mouse_entered = mouse_x > x - sprite_width / 2 && mouse_x < x + sprite_width / 2 &&
        mouse_y > y - sprite_height / 2 && mouse_y < y + sprite_height / 2;
if (mouse_check_button_released(mb_left) && is_mouse_entered){
    if (is_flippable){
        Flip();
    }
    onclick_callback(); // do callback after flipping just in case it disables flipping.
}
