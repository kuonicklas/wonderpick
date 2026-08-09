// flip card
flip_sequence[card_to_flip].Flip();
++card_to_flip;

time_between_flips_in_steps *= time_multiplier;

if (card_to_flip == array_length(flip_sequence) - 1){
    // suspenseful final flip
    time_between_flips_in_steps *= 2;
}
else if (card_to_flip >= array_length(flip_sequence)){
    // end of deck reached
    oFlipScreenManager.FlippingCompleted(array_last(flip_sequence));
    return;
}
alarm_set(0, time_between_flips_in_steps)