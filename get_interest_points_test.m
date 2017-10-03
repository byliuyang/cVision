close all;

figure;
show_interest_points(rgb2gray(imread('data/Notre Dame/921919841_a30df938f2_o.jpg')), 2,0, 10);
show_interest_points(checkerboard, 2,1, 1);

function show_interest_points(I, rows,last, marker_size)
    I = im2single(I);
    [x, y, confidence, scale, orientation] = get_interest_points(I, 12);

    positions = horzcat(x, y);
    
    count = size(x);

    subplot(rows, 2, last * 2 + 1);
    imshow(insertMarker(I, positions, 'size', marker_size));

    subplot(rows, 2, last * 2 + 2);
    imshow(I); hold on;
    points = detectHarrisFeatures(I);
    plot(points.selectStrongest(count(1)));
    subplot(rows, 2, 2);
end
