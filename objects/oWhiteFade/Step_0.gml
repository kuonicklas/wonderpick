if (fade_to_white){
    white_alpha += fade_rate;
}
else{
    white_alpha -= fade_rate;
}
if (white_alpha > 1 || white_alpha < 0){
    callback();
    instance_destroy();
}