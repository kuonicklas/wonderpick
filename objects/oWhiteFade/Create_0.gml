// fades to white, or fades in from white. determined by a bool set from creation.

white_alpha = fade_to_white ? 0 : 1;
time_to_fade_in_sec = 1;
fade_rate = time_to_fade_in_sec / game_get_speed(gamespeed_fps);
