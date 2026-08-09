function ShuffleArray(array){
    for (var i = 0, size = array_length(array); i < size - 1; ++i){
        var random_pos = round(random_range(i, size - 1));
        var temp = array[i];
        array[i] = array[random_pos];
        array[random_pos] = temp;
    }
}