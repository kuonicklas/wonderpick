// record time to file
ini_write_real("time", "accumulated_time_in_sec", GetTotalAccumulatedTimeInSec());
ini_write_real("time", "datetime_of_last_exit", date_current_datetime());
ini_close();