function CreateAndMoveCards(){
    // fetch card values
    var card_values = oPersistentPickData.pick_values;
    instance_destroy(oPersistentPickData);
    
    // calculate card end positions
    var cards_per_row = 3;
    var num_of_rows = floor(global.pick_deck_size / cards_per_row) + (global.pick_deck_size % cards_per_row > 0);
    var inter_card_padding = 32;
    var card_total_height = sprite_get_height(sCard) * num_of_rows +
        inter_card_padding * (num_of_rows - 1);
    var y_offset = room_height / 2 - card_total_height / 2;
    var card_end_positions = GetCardPositions(global.pick_deck_size, cards_per_row, inter_card_padding, 1, y_offset);
    
    // create cards in middle
    ShuffleArray(card_values);  // shuffle
    cards = array_create(global.pick_deck_size);
    for (var i = 0, size = array_length(cards); i < size; ++i){
        var card_variables = {
            card_value : card_values[i],
            original_image_scale : 1,
            starts_flipped : false,
            is_flippable : false
        };
        var new_card = instance_create_layer(room_width / 2, room_height / 2, global.Layers.Card, oCard, card_variables);
        cards[i] = new_card;
    }
    
    // move cards
    instance_create_layer(0, 0, global.Layers.Main, oCardMover, {
        card_end_positions : card_end_positions
    });
}

function EnableCards(){
    for (var i = 0, size = array_length(cards); i < size; ++i){
        cards[i].onclick_callback = CardSelected;
    }
}

function CardSelected(){
    var card_id = id;   // this function will bind to the card (bc it was not assigned to a member variable), thus the id is the card's
    var card_idx = array_find_index(oFlipScreenManager.GetCards(), function(_element){return _element == id});
    instance_create_layer(0, 0, global.Layers.Main, oFlipAnimation, {selected_card_idx : card_idx});
}

function GetCards(){
    return cards;
}

function FlippingCompleted(_selected_card){
    // remove animation from callback
    for (var i = 0, size = array_length(cards); i < size; ++i){
        cards[i].onclick_callback = function(){};
    }
    is_flipping_completed = true;
    _selected_card.layer = global.Layers.Gui;
}

// re-initialize layers
InitializeLayers();
layer = global.Layers.Card;

cards = array_create(global.pick_deck_size);
is_flipping_completed = false;

var decoy_card_callback = function(){
    oFlipScreenManager.CreateAndMoveCards();
    instance_destroy();
}
instance_create_layer(room_width / 2, room_height / 2, global.Layers.Main, oCard, {
    is_flippable : false,
    onclick_callback : decoy_card_callback
});

// fade in
instance_create_layer(0, 0, global.Layers.Gui, oWhiteFade, {fade_to_white : false});