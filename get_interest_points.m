% Local Feature Stencil Code
% Written by James Hays for CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'feature_width', in pixels, is the local feature width. It might be
%   useful in this function in order to (a) suppress boundary interest
%   points (where a feature wouldn't fit entirely in the image, anyway)
%   or (b) scale the image filters being used. Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.

function [x, y, confidence, scale, orientation] = get_interest_points(image, feature_width)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCONNCOMP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% Placeholder that you can delete -- random points
% x = ceil(rand(500,1) * size(image,2));
% y = ceil(rand(500,1) * size(image,1));

image = im2single(image);

xH = [-2 -1 0 1 2];
yH = [-2;-1;0;1;2];

% gX = imfilter(gH, xH);
% gY = imfilter(gH, yH);

Ix = filter2(xH, image);

Iy = filter2(yH, image);

Ix_square = Ix.^2;
Iy_square = Iy.^2;
Ixy = Ix.*Iy;

gH = fspecial('Gaussian', 6, 10);
Ix_square = filter2(gH, Ix_square);
Iy_square = filter2(gH, Iy_square);
Ixy = filter2(gH, Ixy);


image_size = size(image);
height = image_size(1);
width = image_size(2);

alpha = 0.05;

R = Ix_square.*Iy_square - Ixy.^2 - ((Ix_square + Iy_square).^2).*alpha;

[is_interesting, count] = nonmax_suppression(R, feature_width);

x = zeros(count, 1);
y = zeros(count, 1);

index = 1;

for yIndex = 1:height
    for xIndex = 1:width
       if is_interesting(yIndex, xIndex) == 1
           x(index) = xIndex;
           y(index) = yIndex;
           index = index + 1;
       end
    end
end

confidence = 3;
scale = 4;
orientation = 5;
end

