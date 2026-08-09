// get the positions of cards when arranged as rows.
// returns an array of structs of xpos and ypos.
// the xpos is oriented around the center automatically. a ypos offset can be provided, however.
function GetCardPositions(num_cards, cards_per_row, inter_card_padding, card_scale, y_offset){
    function Position(_xpos, _ypos)constructor{
        xpos = _xpos;
        ypos = _ypos;
    }
    
    var card_width = sprite_get_width(sCard);
    var card_height = sprite_get_height(sCard);
    var card_scaled_height = card_height * card_scale;
    var card_scaled_width = card_width * card_scale;
    var num_card_rows = floor(num_cards / cards_per_row) + (num_cards % cards_per_row > 0);
    
    var card_positions = array_create(num_cards);
    var cards_remaining = num_cards;
    for (var r = 0; r < num_card_rows; ++r){
        var row_size = min(cards_remaining, cards_per_row);
        cards_remaining -= cards_per_row;
        var row_start_x = (room_width / 2) - (0.5 * (row_size - 1) * (inter_card_padding + card_scaled_width));
        
        for (var i = 0; i < row_size; ++i){
            var card_x = row_start_x + (i * (inter_card_padding + card_scaled_width));
            var card_y = y_offset + (card_scaled_height / 2) + (card_scaled_height + inter_card_padding) * r;
            var card_idx = r * cards_per_row + i;
            card_positions[card_idx] = new Position(card_x, card_y);
        }
    }
    return card_positions;
}