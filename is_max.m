function val = is_max(values, res, row, column, half_width)
for yIndex = (row - half_width):(row + half_width)
    for xIndex = (column - half_width):(column + half_width)
        not_curr = (yIndex ~= row || xIndex ~= column);
        greater_than = values(yIndex, xIndex) > values(row, column);
        if(not_curr && greater_than)
            val = 0;
            return
        end
    end
end
val = 1;
end