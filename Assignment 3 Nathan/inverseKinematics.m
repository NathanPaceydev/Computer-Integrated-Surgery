% CMPE 330 Assignment 3
% Inverse Kinematics - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

function [theta, d, z] = inverseKinematics(TP)
    alpha = 45; % given needle angle of elivation

    % calculate the rotation about the z axis to align to TP
    theta = atan2(TP(2),TP(1));

    % use theta to find the distance that the needle depth should be
    d = ((TP(1)^2+TP(2)^2)^0.5)/(cosd(alpha));
    
    % use the difference in z coordinate of target point and z of the
    % needle to find the translation in z
    z = TP(3) - d*cosd(alpha);

end