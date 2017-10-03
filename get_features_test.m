image = rgb2gray(imread('images/NotreDame1.jpg'));
feature_width = 16;
[x, y, confidence, scale, orientation] = get_interest_points(image, feature_width);
get_features(image, x, y, feature_width);