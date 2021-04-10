function [X,Y] = UAV_Patch(position, heading, size)

    forward = [cos(heading); sin(heading)];
    left = [cos(heading + pi/2); sin(heading + pi/2)];
    
    
    nose = position(:) + size * forward;
    leftwing = position(:) + size/4 * left;
    rightwing = position(:) - size/4 * left;
    
    X = [nose(1); leftwing(1); rightwing(1); nose(1)];
    Y = [nose(2); leftwing(2); rightwing(2); nose(2)];
end