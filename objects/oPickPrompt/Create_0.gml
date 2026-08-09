oPickScreenManager.prompt_exists = true;
is_prompt_disabled = false;

function DoYesButton(){
    if (!is_prompt_disabled){
        is_prompt_disabled = true;
        oPickScreenManager.SelectPick(pick_option_id);
    }
}

function DoNoButton(){
    if (!is_prompt_disabled){
        ExitPrompt();
    }
}

function ExitPrompt(){
    instance_destroy(oPickPromptButton);
    instance_destroy();
}

// setup draw event stuff
// non-temporary variables are used by the draw event

// point line (the first line; the one containing the cost)
point_scale = 0.35;
var point_width = sprite_get_width(sPoint) * point_scale;
var point_text_padding = 8;
point_icon_text = string(pick_option_id.cost) + ".";
var text_width = string_width(point_icon_text);
var point_icon_width = point_width + point_text_padding + text_width;
point_text = "This option costs ";
var point_text_width = string_width(point_text);
var point_line_width = point_text_width + point_icon_width;
point_text_start_x = room_width / 2 - point_line_width / 2;
point_icon_start_x = point_text_start_x + point_text_width;
point_icon_draw_x = point_icon_start_x + sprite_get_xoffset(sPoint) * point_scale;
point_icon_text_start_x = point_text_start_x + point_text_width + point_width + point_text_padding;
var point_line_height = string_height(point_text);

// question line
question_text = "Are you sure?";

var question_text_width = string_width(question_text);
var question_text_height = string_height(question_text);
question_text_x = room_width / 2 - question_text_width / 2;

// calculate total height, then calculate the y values of all elements
var line_padding = 0;
var line_to_button_padding = 4;
var inter_button_padding = 4;
var intra_button_padding = 2;
var button_text_left_indent = 4;
var button_height = intra_button_padding + string_height("Yes") + intra_button_padding;
var total_prompt_height = point_line_height + line_padding + question_text_height +
    line_to_button_padding + button_height + inter_button_padding + button_height;
point_line_y = global.window_length / 2 - total_prompt_height / 2;
question_text_y = point_line_y + point_line_height + line_padding;
point_icon_y = point_line_y + point_line_height / 2;
var yes_button_y = question_text_y + question_text_height + line_to_button_padding;
var no_button_y = yes_button_y + button_height + inter_button_padding;
var max_line_width = max(point_line_width, question_text_width);
var button_x = room_width / 2 - max_line_width / 2;

// buttons
// yes button
var yes_button_callback = function(){
    oPickPrompt.DoYesButton();
}
var yes_button_variables = {
    text : "Yes",
    text_y : yes_button_y + intra_button_padding,
    text_x : button_x + intra_button_padding + button_text_left_indent,
    button_width : max_line_width,
    button_height : button_height,
    callback : yes_button_callback
}
instance_create_layer(button_x, yes_button_y, global.Layers.Gui, oPickPromptButton, yes_button_variables);

// no button
var no_button_callback = function(){
    oPickPrompt.DoNoButton();
}
var no_button_variables = {
    text : "No",
    text_y : no_button_y + intra_button_padding,
    text_x : button_x + intra_button_padding + button_text_left_indent,
    button_width : max_line_width,
    button_height : button_height,
    callback : no_button_callback
}
instance_create_layer(button_x, no_button_y, global.Layers.Gui, oPickPromptButton, no_button_variables);