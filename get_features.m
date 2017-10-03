% Local Feature Stencil Code
% Written by James Hays for CS 4476/6476 @ Georgia Tech

% Returns a set of feature descriptors for a given set of interest points. 

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'feature_width', in pixels, is the local feature width. You can assume
%   that feature_width will be a multiple of 4 (i.e. every cell of your
%   local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations you can add input arguments.

% 'features' is the array of computed features. It should have the
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_features(image, x, y, feature_width)
% To start with, you might want to simply use normalized patches as your
% local feature. This is very simple to code and works OK. However, to get
% full credit you will need to implement the more effective SIFT descriptor
% (See Szeliski 4.1.2 or the original publications at
% http://www.cs.ubc.ca/~lowe/keypoints/)

% Your implementation does not need to exactly match the SIFT reference.
% Here are the key properties your (baseline) descriptor should have:
%  (1) a 4x4 grid of cells, each feature_width/4. 'cell' in this context
%    nothing to do with the Matlab data structue of cell(). It is simply
%    the terminology used in the feature literature to describe the spatial
%    bins where gradient distributions will be described.
%  (2) each cell should have a histogram of the local distribution of
%    gradients in 8 orientations. Appending these histograms together will
%    give you 4x4 x 8 = 128 dimensions.
%  (3) Each feature should be normalized to unit length
%
% You do not need to perform the interpolation in which each gradient
% measurement contributes to multiple orientation bins in multiple cells
% As described in Szeliski, a single gradient measurement creates a
% weighted contribution to the 4 nearest cells and the 2 nearest
% orientation bins within each cell, for 8 total contributions. This type
% of interpolation probably will help, though.

% You do not have to explicitly compute the gradient orientation at each
% pixel (although you are free to do so). You can instead filter with
% oriented filters (e.g. a filter that responds to edges with a specific
% orientation). All of your SIFT-like feature can be constructed entirely
% from filtering fairly quickly in this way.

% You do not need to do the normalize -> threshold -> normalize again
% operation as detailed in Szeliski and the SIFT paper. It can help, though.

% Another simple trick which can help is to raise each element of the final
% feature vector to some power that is less than one.

%Placeholder that you can delete. Empty features.
    features = zeros(size(x,1), 128);
    cell_width = feature_width / 4;
    threshold = 1;
    
    gH = fspecial('Gaussian', [feature_width feature_width], 2);
    Ig = imfilter(image, gH);
    [Ix,Iy] = imgradients(Ig);
    Im = sqrt(Ix.^2 + Iy.^2);
    theta = radtodeg(atan2(Iy, Ix));
    
    fall_off_H = fspecial('Gaussian', [feature_width feature_width], 1);
    
    num_points = size(x, 1);
    
    for i = 1:num_points
        y_start = y(i) - 2 * cell_width;
        x_start = x(i) - 2 * cell_width;
        for y_cell = 0:3
            top = y_start + y_cell * cell_width;

            weighted_Im = mt_copy(Im, y_start, x_start, feature_width, feature_width);
            weighted_Im = imfilter(weighted_Im, fall_off_H);
            for x_cell = 0:3
                left = x_start + x_cell * cell_width;
                features = create_histogram(features, theta, weighted_Im, top,left,y_cell,x_cell, i, cell_width);
            end
        end
    end
    features = normalize_features(features);
    features = threshold_features(features, threshold);
    features = normalize_features(features);
end

