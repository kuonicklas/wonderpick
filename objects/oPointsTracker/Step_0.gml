if (global.IsDebugMode){
    if (keyboard_check_pressed(ord("A"))){
        AddPoints(1);
    }
    if (keyboard_check_pressed(ord("S"))){
        var sec_to_subtract = min(global.sec_per_point, GetTotalAccumulatedTimeInSec());
        SubtractTime(sec_to_subtract);
    }
}