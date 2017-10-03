function res = threshold_features(features, threshold)
    for i = 1:size(features, 1)
        for h_index = 1:128
            features(i, h_index) = min([features(i, h_index) threshold]);
        end
    end
    res = features;
end