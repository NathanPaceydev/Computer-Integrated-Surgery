% CMPE 330 Assignment 2.
% Question 1. Functional Code
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% frameTransformation - Generates the frame transformation from CK to A or B
%
% Syntax: T_CK_to_X = frameTransformation(frame)
%
% Inputs:
%    frame - String, specify 'A' for transforming to frame A, 'B' for frame B
%
% Outputs:
%    T_CK_to_X - 4x4 homogeneous transformation matrix
%
function T_CK_to_X = frameTransformation(frame)
    
    if nargin < 1
        error('Please specify the target frame (A or B).');
    end
    
    % Define rotation angles for frames A and B in radians
    theta_A = 45 * (pi / 180);  % +45 degrees for frame A
    theta_B = -45 * (pi / 180); % -45 degrees for frame B
    
    % Define rotation matrices for frames A and B
    R_A = [cos(theta_A), -sin(theta_A), 0;
           sin(theta_A), cos(theta_A), 0;
           0, 0, 1];
       
    R_B = [cos(theta_B), -sin(theta_B), 0;
           sin(theta_B), cos(theta_B), 0;
           0, 0, 1];

  
    % linear translation from OCK to OA
    O_V_A = [100/(2^0.5);-100/(2^0.5);0];
    O_V_B = [-100/(2^0.5);-100/(2^0.5);0];

    
    % Define the base vectors for frames A and B in CK frame
    v1_A = R_A(:, 1);
    v2_A = R_A(:, 2);
    v3_A = R_A(:, 3);
    
    v1_B = R_B(:, 1);
    v2_B = R_B(:, 2);
    v3_B = R_B(:, 3);
    
    % Use the FrameTransformationToHome function to generate transformation matrices
    if strcmpi(frame, 'A')
        inverse_T_CK_to_X = FrameTransformationToHome(O_V_A, v1_A, v2_A, v3_A);
        T_CK_to_X = inv(inverse_T_CK_to_X);

    elseif strcmpi(frame, 'B')
        inverse_T_CK_to_X = FrameTransformationToHome(O_V_B, v1_B, v2_B, v3_B);
        T_CK_to_X = inv(inverse_T_CK_to_X);
        
    else
        error('Invalid frame specified. Please specify either ''A'' or ''B''.');
    end
end

