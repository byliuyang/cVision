image = rgb2gray(imread('images/NotreDame1.jpg'));

feature_width = 16;
[x, y, confidence, scale, orientation] = get_interest_points(image, feature_width);
features = get_features(image, x, y, feature_width);

corners   = detectHarrisFeatures(image);
strongest = selectStrongest(corners, size(x, 1));
[hog2, validPoints,ptVis] = extractHOGFeatures(image,strongest);
figure;
imshow(image);
hold on;
plot(ptVis, 'Color','green');