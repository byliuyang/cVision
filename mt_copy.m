function mg = mt_copy(Im, y_start, x_start, feature_height, feature_width)
    mg = zeros(feature_height, feature_width);
    for y = 1:feature_height
        for x = 1:feature_width
            mg(y, x) = Im(y_start + y, x_start + x);
        end
    end
end