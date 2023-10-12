% CMPE 330 Assignment 1
% Question 8 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

function [R, H] = RotationAboutFrameAxis(axis, angle)
    % make axis a lowercase char to check input
    axis = lower(axis);

    % Validate the input axis
    if ~ismember(axis, ['x', 'y', 'z'])
        disp('Invalid axis. Use ''x'', ''y'', or ''z''.');
    end
    
    % Convert the angle to radians
    angle = deg2rad(angle);
    
    % Create the rotation matrix in 3x3 format
    % for the respective axis chosen
    switch axis
        case 'x'
            R = [1, 0, 0; 0, cos(angle), -sin(angle); 0, sin(angle), cos(angle)];
        case 'y'
            R = [cos(angle), 0, sin(angle); 0, 1, 0; -sin(angle), 0, cos(angle)];
        case 'z'
            R = [cos(angle), -sin(angle), 0; sin(angle), cos(angle), 0; 0, 0, 1];
    end
    
    % Create the homogeneous rotation matrix in 4x4 format
    H = eye(4);
    % set the first 3 rows/cols to R
    H(1:3, 1:3) = R; 
end
