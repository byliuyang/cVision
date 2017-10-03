function new_features = create_histogram(features, theta, weighted_Im, top,left,y_cell,x_cell, count, cell_width)
    histogram_start = y_cell * 32 + x_cell * 8;
    for y_index = 1:cell_width
        for x_index = 1:cell_width
%              [y_cell x_cell top left count y_index x_index cell_width (y_cell * 32 + x_cell * 8)]
%             y_cell * 32 + x_cell * 8
            degrees = theta(top + y_index, left + x_index);
            direction = get_direction(degrees);
            last_count = features(count, histogram_start + direction);
            features(count, histogram_start + direction) = last_count + weighted_Im(y_index, x_index);
        end
    end
%     direction = get_direction()
    new_features = features;
end