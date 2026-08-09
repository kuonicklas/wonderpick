accumulated_time_in_sec = 0;
datetime_of_last_update = date_current_datetime();
global.hours_per_point = 12;
global.max_points = 3;
global.sec_per_point = 60 * 60 * global.hours_per_point;
max_accumulated_time_in_sec = global.sec_per_point * global.max_points;

ini_open("data.ini");
if (ini_section_exists("time")){
	// get previous time
	var prev_accumulated_time_in_sec = ini_read_real("time", "accumulated_time_in_sec", -1);
	if (prev_accumulated_time_in_sec == -1){
		show_error("unable to retrieve accumulated time!", true);
	}
	var datetime_of_last_exit = ini_read_real("time","datetime_of_last_exit", -1);
	if (datetime_of_last_exit == -1){
		show_error("unable to retrieve time of last exit!", true);
	}
	var sec_elapsed_since_last_exit = date_second_span(date_current_datetime(), datetime_of_last_exit);
	accumulated_time_in_sec = prev_accumulated_time_in_sec + sec_elapsed_since_last_exit;
    accumulated_time_in_sec = min(accumulated_time_in_sec, max_accumulated_time_in_sec);
}

function GetTotalAccumulatedTimeInSec(){
    // add time elapsed since last check (only update when fetched)
    accumulated_time_in_sec += date_second_span(date_current_datetime(), datetime_of_last_update);
    datetime_of_last_update = date_current_datetime();
    accumulated_time_in_sec = min(accumulated_time_in_sec, max_accumulated_time_in_sec);
	return accumulated_time_in_sec;
}

function HasAccumulatedAtLeast(seconds){
	return GetTotalAccumulatedTimeInSec() >= seconds;
}

function SubtractTime(seconds){
	if (!HasAccumulatedAtLeast(seconds)){
		show_error("tried to subtract more time than accumulated!", true);
	}
	accumulated_time_in_sec = GetTotalAccumulatedTimeInSec();
	accumulated_time_in_sec -= seconds;
}

function AddTime(seconds){
    accumulated_time_in_sec = GetTotalAccumulatedTimeInSec();
    accumulated_time_in_sec = min(accumulated_time_in_sec + seconds, max_accumulated_time_in_sec);
}

function GetPoints(){
    return floor(GetTotalAccumulatedTimeInSec() / global.sec_per_point);
}

function SubtractPoints(points){
    if (GetPoints() < points){
        throw ("Tried to deduct more points than possessed!");
    }
    SubtractTime(global.sec_per_point * points);
}

function AddPoints(points){
    AddTime(points * global.sec_per_point);
}