// create pick screen cryptids
instance_create_layer(0, 0, global.Layers.Main, oPointsTracker);
instance_create_layer(0, 0, global.Layers.Gui, oPointsGui);

// swipe controls
mouse_last_position_y = display_mouse_get_y();
slippery_speed = 0;
slippery_decay_factor = 0.9;

// pick options
num_of_pick_options = 3;

var pick_top_edge_padding = 100;
var pick_bottom_edge_padding = 32;
var inter_pick_padding = 16;
for (var i = 0, pick_position_y = pick_top_edge_padding; i < num_of_pick_options; ++i){
    CreatePickOption(0, pick_position_y, global.Layers.Main, num_of_pick_options - 1 - i);
    pick_position_y += oPickOption.GetHeight() + inter_pick_padding;
}

// misc
room_height = pick_top_edge_padding + num_of_pick_options * (oPickOption.GetHeight() + inter_pick_padding);
prompt_exists = false;

function PromptExists(){
    return prompt_exists;
}

function CreatePrompt(_pick_option_id){
    var prompt_variables = {
        pick_option_id : _pick_option_id
    }
    instance_create_layer(0, 0, global.Layers.Gui, oPickPrompt, prompt_variables);
    MoveCameraToPickOption(_pick_option_id);
}

var time_to_move_camera_in_secs = 1;
time_to_move_camera_in_steps = game_get_speed(gamespeed_fps) * time_to_move_camera_in_secs;
time_to_move_camera_remaining = 0;
camera_original_y = 0;
camera_goal_y = 0;
camera_is_moving = false;

function MoveCameraToPickOption(_pick_option_id){
    ResetCameraMovement();
    camera_original_y = camera_get_view_y(view_camera[0]);
    camera_goal_y = _pick_option_id.y + _pick_option_id.GetHeight() / 2 - global.window_length / 2;
    camera_goal_y = clamp(camera_goal_y, 0, room_height - global.window_length);
    time_to_move_camera_remaining = time_to_move_camera_in_steps;
    camera_is_moving = true;
}

function ResetCameraMovement(){
    slippery_speed = 0;
    camera_is_moving = false;
}

function SelectPick(_pick_id){
    oPointsTracker.SubtractPoints(_pick_id.cost);
    instance_create_layer(0, 0, global.Layers.Main, oPersistentPickData, {pick_values : _pick_id.pick_values});
    instance_create_layer(0, 0, global.Layers.Gui, oWhiteFade, {
        fade_to_white : true,
        callback : oController.GoToFlipRoom
    });
}