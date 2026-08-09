var time_between_flips_in_sec = 0.75;
var initial_time_between_flips_in_steps = game_get_speed(gamespeed_fps) * time_between_flips_in_sec;
time_between_flips_in_steps = initial_time_between_flips_in_steps;
time_multiplier = 1;
card_to_flip = 0;
flip_sequence = oFlipScreenManager.GetCards();

// shift selected card to last position
var selected_card = flip_sequence[selected_card_idx];
var flip_sequence_length = array_length(flip_sequence);
for (var i = selected_card_idx, size = flip_sequence_length; i < size - 1; ++i){
    flip_sequence[i] = flip_sequence[i + 1];
}
flip_sequence[flip_sequence_length - 1] = selected_card;

event_perform(ev_alarm, 0);