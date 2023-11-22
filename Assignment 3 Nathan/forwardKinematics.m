% CMPE 330 Assignment 3
% Inverse Kinematics - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

function [TPx, TPy, TPz] = forwardKinematics(z, theta, d)
    % use d and z to find TPz
    TPz = z+d*cosd(45);
    
    % use d and theta to find TPy and TPx
    TPy = d*sind(45)* sin(theta);
    TPx = d*sind(45)* cos(theta);

end