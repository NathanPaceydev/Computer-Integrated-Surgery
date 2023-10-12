% CMPE 330 Assignment 1
% Question 9 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

function T = FrameTransformationToHome(Ov, v1, v2, v3)
    % Translation matrix 
    % Create the homogeneous transformation matrix
    T = eye(4);
    
    % Set the rotation and translation components
    % This matrix represents the Homogeneous Rotation Matrix times the inverse
    % Translation Matix
    T(1:3, 1) = v1;
    T(1:3, 2) = v2;
    T(1:3, 3) = v3;
    T(1:3, 4) = Ov;
end


   
end