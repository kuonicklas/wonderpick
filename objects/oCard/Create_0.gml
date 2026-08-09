enum CardValue{
    ReallyBad = 1,
    Bad = 2,
    Neutral = 3,
    Good = 4,
    ReallyGood = 5
}

image_speed = 0;
image_yscale = original_image_scale;
image_index = starts_flipped ? card_value : 0;
// bind to self
// this is meant to solve the problem of instance_destroy() destroying the object that created the callback, not this object.
onclick_callback = method(id, onclick_callback);

flip_time_remaining = 0;
var time_to_flip_in_sec = 0.25;
time_to_flip_in_steps = game_get_speed(gamespeed_fps) * time_to_flip_in_sec;
is_flipping = false;
is_mouse_entered = false;

function Flip(){
    flip_time_remaining = time_to_flip_in_steps;
    is_flipping = true;
}

function IsFlipped(){
    return image_index == card_value;
}