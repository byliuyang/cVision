function [res, count] = nonmax_suppression(values, feature_width)
    value_size = size(values);
    height = value_size(1);
    width = value_size(2);
    res = zeros(height, width);
    half_width = feature_width / 2;
    threshold = 0.1;
    threshold_val = max(max(values)) * threshold;
    count = 0;
    for row = half_width:height - half_width
        for column = half_width:width - half_width
            if values(row, column) >= threshold_val
                res(row, column) = is_max(values, row, column, half_width);
                count = count + res(row, column);
            end
        end
    end
end