function [Ix, Iy] = imgradients(image)
    xH = [-2 -1 0 1 2];
    yH = [-2;-1;0;1;2];

    Ix = filter2(xH, image);
    Iy = filter2(yH, image);
end