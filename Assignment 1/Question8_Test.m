% CMPE 330 Assignment 1
% Question 8 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

fprintf("Question 8 output:\n\n");

% Test cases
% Test 1: Rotate 90 deg in x-axis
disp('Test Case 1: Rotate 90 degrees about the x-axis');
[R1, H1] = RotationAboutFrameAxis('x', 90);
disp('Rotation Matrix (3x3):');
disp(R1);
disp('Homogeneous Rotation Matrix (4x4):');
disp(H1);

% Test Case 2: Rotate 45 degrees about the y-axis
disp('Test Case 2: Rotate 45 degrees about the y-axis');
[R2, H2] = RotationAboutFrameAxis('y', 45);
disp('Rotation Matrix (3x3):');
disp(R2);
disp('Homogeneous Rotation Matrix (4x4):');
disp(H2);

% Test Case 3: Rotate 60 degrees about the z-axis
disp('Test Case 3: Rotate 60 degrees about the z-axis');
[R3, H3] = RotationAboutFrameAxis('z', 60);
disp('Rotation Matrix (3x3):');
disp(R3);
disp('Homogeneous Rotation Matrix (4x4):');
disp(H3);
