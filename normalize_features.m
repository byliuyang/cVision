function res = normalize_features(features)
    max_mg = max(max(features));
    for i = 1:size(features, 1)
        for h_index = 1:128
            features(i, h_index) = features(i, h_index) / max_mg;
        end
    end
    res = features;
end