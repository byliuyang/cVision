% Directions
%
% 4     3     2
% 5           1
% 6     7     8

function direction = get_direction(degrees)
    if degrees >= -22.5 && degrees < 22.5
        direction = 1;
    elseif degrees >= 22.5 && degrees < 67.5
        direction = 2;
    elseif degrees >= 67.5 && degrees < 112.5
        direction = 3;
    elseif degrees >= 112.5 && degrees < 157.5
        direction = 4;
    elseif (degrees >= 157.5 && degrees <= 180) || (degrees < -157.5 && degrees >= -180)
        direction = 5;
    elseif degrees >= -157.5 && degrees < -112.5
        direction = 6;
    elseif degrees >= -112.5 && degrees < -67.5
        direction = 7;
    elseif degrees >= -67.5 && degrees < -22.5
        direction = 8;
    end
end

