// game settings
randomise();
gpu_set_texfilter(true); // enable interpolation
global.IsDebugMode = true;

// layers
InitializeLayers();
global.window_length = 700;

// default window and camera size
room_width = global.window_length;
room_height = global.window_length;

view_enabled = true;	// enable manual view controls
view_visible[0] = true;	// choose a view to use
view_xport[0] = 0;	// where to draw the viewport
view_yport[0] = 0;
view_wport[0] = global.window_length;	// size of the viewport
view_hport[0] = global.window_length;
view_camera[0] = camera_create_view(0, 0, global.window_length, global.window_length);	// create a camera that views the entire room

window_set_size(global.window_length, global.window_length);

surface_resize(application_surface, room_width, global.window_length);	// resize application surface

// setup pick screen
instance_create_layer(0, 0, global.Layers.Main, oPickScreenManager);

function GoToFlipRoom(){
    room_goto(rFlipRoom);
}