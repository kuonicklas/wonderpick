var steps_ratio = steps_accumulated / steps_to_move;
var ratio_moved = -(cos(pi * steps_ratio) - 1) / 2;


for (var i = 0, size = array_length(card_end_positions); i < size; ++i){
    oFlipScreenManager.GetCards()[i].x = lerp(room_width / 2, card_end_positions[i].xpos, ratio_moved);
    oFlipScreenManager.GetCards()[i].y = lerp(room_height / 2, card_end_positions[i].ypos, ratio_moved);
}
++steps_accumulated;

if (steps_accumulated >= steps_to_move){
    oFlipScreenManager.EnableCards();
    instance_destroy();
}