enum PickType{
    Cost1 = 0,
    Cost2 = 1,
    Cost3 = 2
}

global.pick_deck_size = 5;

// the pick distribution is an array of size global.pick_deck_size.
// each entry is an array of PickChance that adds to probability 1. If a probability is omitted,
// it will be auto-calculated as the remainder of the probability space (i.e. the chance that the prior cards aren't chosen).
// this means that only the final PickChance can have an auto-calculated probability.
function CreatePickOption(_x, _y, _layer, pick_type){
    var cost = 0;
    var pick_distribution = array_create(global.pick_deck_size);
    switch (pick_type){
        case PickType.Cost3:
            cost = 3;
            pick_distribution[0] = [new PickChance(CardValue.ReallyGood)];
            pick_distribution[1] = [new PickChance(CardValue.ReallyGood, 0.05), new PickChance(CardValue.Good)];
            pick_distribution[2] = [new PickChance(CardValue.Good, 0.2), new PickChance(CardValue.Neutral)];
            pick_distribution[3] = [new PickChance(CardValue.Good, 0.2), new PickChance(CardValue.Neutral)];
            pick_distribution[4] = [new PickChance(CardValue.Bad, 0.5), new PickChance(CardValue.ReallyBad)];
            break;
        case PickType.Cost2:
            cost = 2;
            pick_distribution[0] = [new PickChance(CardValue.Good)];
            pick_distribution[1] = [new PickChance(CardValue.Bad, 0.25), new PickChance(CardValue.Good, 0.25), new PickChance(CardValue.Neutral)];
            pick_distribution[2] = [new PickChance(CardValue.Bad, 0.25), new PickChance(CardValue.Good, 0.25), new PickChance(CardValue.Neutral)];
            pick_distribution[3] = [new PickChance(CardValue.Neutral, 0.1), new PickChance(CardValue.Bad)];
            pick_distribution[4] = [new PickChance(CardValue.ReallyBad)];
            break;
        case PickType.Cost1:
            cost = 1;
            pick_distribution[0] = [new PickChance(CardValue.Good, 0.1), new PickChance(CardValue.Bad, 0.2), new PickChance(CardValue.Neutral)];
            pick_distribution[1] = [new PickChance(CardValue.Good, 0.1), new PickChance(CardValue.Bad, 0.2), new PickChance(CardValue.Neutral)];
            pick_distribution[2] = [new PickChance(CardValue.Good, 0.1), new PickChance(CardValue.Bad, 0.2), new PickChance(CardValue.Neutral)];
            pick_distribution[3] = [new PickChance(CardValue.Bad)];
            pick_distribution[4] = [new PickChance(CardValue.ReallyBad)];
            break;
        default:
            throw ("Creating a PickOption of unknown pick type!");
    }
    
    // validate and create
    if (cost > global.max_points){
        throw ("Pick cost exceeds max points!");
    }
    for (var i = 0; i < global.pick_deck_size; ++i){
        if (array_length(pick_distribution[i]) == 0){
            throw("Pick slot " + string(i) + ": no pick chances specified!");
        }
        
        for (var j = 0, sum = 0, distribution_size = array_length(pick_distribution[i]); j < distribution_size; ++j){
            if (pick_distribution[i][j].probability == -1){
                if (j != distribution_size - 1){
                    throw("Pick slot " + string(i) + ", chance number" + string(j) + ": probability value expected");
                }
                pick_distribution[i][j].probability = 1 - sum;
            }
            if (pick_distribution[i][j].probability <= 0 || pick_distribution[i][j].probability > 1){
                throw("Pick slot " + string(i) + ", chance number" + string(j) + ": invalid value of " + string(pick_distribution[i][j].probability));
            }
            sum += pick_distribution[i][j].probability;
            if (sum > 1){
                throw("Pick slot " + string(i) + ": total probability exceeds 1");
            }
        }
    }
    var pick_variables = {
        cost : cost,
        pick_distribution : pick_distribution
    }
    return instance_create_layer(_x, _y, _layer, oPickOption, pick_variables);
}

// probability of '-1' is placeholder for 'the remainder'
function PickChance(_card_value, _probability = -1) constructor{
    card_value = _card_value;
    probability = _probability;
}