% Local Feature Stencil Code
% Written by James Hays for CS 4476/6476 @ Georgia Tech

% 'features1' and 'features2' are the n x feature dimensionality features
%   from the two images.
% If you want to include geometric verification in this stage, you can add
% the x and y locations of the features as additional inputs.
%
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index
%   in features2. 
% 'Confidences' is a k x 1 matrix with a real valued confidence for every
%   match.
% 'matches' and 'confidences' can empty, e.g. 0x2 and 0x1.
function [matches, confidences] = match_features(features1, features2)

% This function does not need to be symmetric (e.g. it can produce
% different numbers of matches depending on the order of the arguments).

% To start with, simply implement the "ratio test", equation 4.18 in
% section 4.1.3 of Szeliski. For extra credit you can implement various
% forms of spatial verification of matches.

% Placeholder that you can delete. Random matches and confidences
matches = zeros(1, 2);

count = 1;
confidences = ones(1,1);

threshold = 0.78;

distances = zeros(size(features1, 1), size(features2, 1));
for i1 = 1: size(features1, 1)
    for i2 = 1: size(features2, 1)
        distance = abs(features1(i1, :) - features2(i2, :));
        distances(i1, i2) = sqrt(sum(distance));
    end
end

for i = 1: size(features1, 1)
    [sorted_distances, sorted_indices] = sort(distances(i, :));
    closest_feature = sorted_distances(1);
    second_closest_feature = sorted_distances(2);
    ratio = closest_feature / max([second_closest_feature 0.00000001]);
    if ratio < threshold
        matches(count, 1) = i;
        matches(count, 2) = sorted_indices(1);
        confidences(count) = 1 / ratio;
        count = count + 1;
    end
end

% Sort the matches so that the most confident onces are at the top of the
% list. You should probably not delete this, so that the evaluation
% functions can be run on the top matches easily.
[confidences, ind] = sort(confidences, 'descend');
matches = matches(ind,:);