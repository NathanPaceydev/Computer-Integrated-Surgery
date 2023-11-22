% CMPE 330 Assignment 2.
% Question 3. Functional Code
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% markerReconstruction - Reconstructs a point in CK frame from two detector image points
%
% Syntax: [point_CK, REM] = markerReconstruction(point_A, point_B)
%
% Inputs:
%    point_A - 3x1 vector representing a point in A detector frame
%    point_B - 3x1 vector representing a point in B detector frame
%
% Outputs:
%    point_CK - 3x1 vector representing the reconstructed point in CK frame
%    REM - Residual Error Metric
%
function [reconstructed_point, REM] = markerReconstruction(point_A_image, point_B_image)
    % can use the detector image points to construct lines intersecting the
    % sources and determine the orginal points (markers) by finding
    % intersections of line from source A and source B
    
    % Define the X-ray sources for A and B detectors
    SA = [-100/sqrt(2); 100/sqrt(2); 0];
    SB = [100/sqrt(2); 100/sqrt(2); 0];
    
    % Define transformation matrices from image frames to CK frame
    T_A_to_CK = inv(frameTransformation('A')); % Assuming frameTransformation gives CK to A
    T_B_to_CK = inv(frameTransformation('B')); % Assuming frameTransformation gives CK to B
    
    % Transform points from image frames to CK frame
    point_A_CK = T_A_to_CK * [point_A_image; 1];
    point_B_CK = T_B_to_CK * [point_B_image; 1];
    
    % Normalize homogeneous coordinates
    point_A_CK = point_A_CK(1:3) / point_A_CK(4);
    point_B_CK = point_B_CK(1:3) / point_B_CK(4);
    
    % Define direction vectors for the lines from the sources through the points
    VA = point_A_CK - SA;
    VB = point_B_CK - SB;
    
    % Normalize direction vectors
    VA = VA / norm(VA);
    VB = VB / norm(VB);
    
    % Find the intersection of the two lines
    [reconstructed_point, error] = intersection_two_lines(SA, VA, SB, VB);
    
    % Compute Residual Error Metric (REM)
    REM = error;
end
