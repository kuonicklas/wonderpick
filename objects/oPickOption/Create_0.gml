// roll picks
pick_values = array_create(global.pick_deck_size);
for (var i = 0; i < global.pick_deck_size; ++i){
    var roll = random(1);
    var j = 0;
    if (array_length(pick_distribution) < global.pick_deck_size){
        throw ("Pick distribution is smaller than expected!");
    }
    var sum = pick_distribution[i][j].probability;
    while (roll > sum){
        ++j;
        if (j >= array_length(pick_distribution[i])){
            throw ("Exhausted all pick chances!");
        }
        sum += pick_distribution[i][j].probability;
    }
    pick_values[i] = pick_distribution[i][j].card_value;
}

// shuffle picks
ShuffleArray(pick_values);

// get card positions
top_edge_padding = 64;
var cards_per_row = 3;
var inter_card_padding = 24;
var card_scale = 0.625;
var card_positions = GetCardPositions(global.pick_deck_size, cards_per_row, inter_card_padding, card_scale, y + top_edge_padding);

if (array_length(card_positions) != global.pick_deck_size){
    throw("Card position array is not the same size as the pick deck size!");
}

// create cards
cards = array_create(global.pick_deck_size);
for (var i = 0, size = array_length(cards); i < size; ++i){
    var card_variables = {
        card_value : pick_values[i],
        original_image_scale : card_scale,
        starts_flipped : true,
        is_flippable : false
    };
    var new_card = instance_create_layer(card_positions[i].xpos, card_positions[i].ypos, global.Layers.Card, oCard, card_variables);
    cards[i] = new_card;
}

// get dimensions of entire pick option
// calculate height
var other_edge_padding = 32;
var card_scaled_height = sprite_get_height(sCard) * card_scale;
var card_scaled_width = sprite_get_width(sCard) * card_scale;
var num_card_rows = floor(global.pick_deck_size / cards_per_row) + (global.pick_deck_size % cards_per_row > 0);
total_height = top_edge_padding +
    card_scaled_height * num_card_rows +
    inter_card_padding * (num_card_rows - 1) +
    other_edge_padding;

// calculate width
var content_width = cards_per_row * card_scaled_width + (cards_per_row - 1) * inter_card_padding;
left_edge_x = (room_width / 2) - (0.5 * content_width) - other_edge_padding;
right_edge_x = (room_width / 2) + (0.5 * content_width) + other_edge_padding;
total_width = right_edge_x - left_edge_x;

function GetHeight() {
    return total_height;
}

function GetWidth(){
    return total_width;
}

function GetLeftEdgeX(){
    return left_edge_x;
}

function MouseIsEntered(_mouse_x, _mouse_y){
    return _mouse_x >= left_edge_x && _mouse_x <= right_edge_x && _mouse_y >= y && _mouse_y <= y + total_height;
}

// misc
is_mouse_entered = false;
mouse_left_pressed_x = 0;
mouse_left_pressed_y = 0;
distance_since_left_pressed = 0;
last_mouse_x = mouse_x;
last_mouse_y = mouse_y;