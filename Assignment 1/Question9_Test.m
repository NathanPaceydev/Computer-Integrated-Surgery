% CMPE 330 Assignment 1
% Question 9 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

fprintf("Question 9 output:\n\n");

% Test 1: Pure Translation (2,2,-2)
Ov = [2; 2; -2];
v1 = [1; 0; 0];
v2 = [0; 1; 0];
v3 = [0; 0; 1];
T = FrameTransformationToHome(Ov, v1, v2, v3);
% Display the transformation matrix
disp('Test Case 1: Pure Translation (2,2,-2)');
disp(T);

% Test 2 Pure Translation (0.5, -12, 72.5)
Ov = [0.5; -12; 72.5];
v1 = [1; 0; 0];
v2 = [0; 1; 0];
v3 = [0; 0; 1];
T = FrameTransformationToHome(Ov, v1, v2, v3);
% Display the transformation matrix
disp('Test Case 2: Pure Translation (0.5, -12, 72.5)');
disp(T);

% Test 3 Pure Rotation 45 deg about x-axis
Ov = [0; 0; 0];
v1 = [1; 0; 0];
v2 = [0; cosd(45); -sind(45)];
v3 = [0; sind(45); cosd(45)];
T = FrameTransformationToHome(Ov, v1, v2, v3);
% Display the transformation matrix
disp('Test Case 3: Pure Rotation 45 deg about x-axis');
disp(T);

% Test 4 Pure Rotation 60 deg about y-axis
Ov = [0; 0; 0];
v1 = [cosd(60); 0; sind(60)];
v2 = [0; 1; 0];
v3 = [-sind(60); 0; cosd(60)];
T = FrameTransformationToHome(Ov, v1, v2, v3);
% Display the transformation matrix
disp('Test Case 4: Pure Rotation 60 deg about y-axis');
disp(T);

% Test 5 Combination Translate (1,2,3) in x,y,z Rotation 60 deg about z-axis
Ov = [1; 2; 3];
v1 = [0.866; -0.5; 0];
v2 = [0.5; 0.866; 0];
v3 = [0; 0; 1];
T = FrameTransformationToHome(Ov, v1, v2, v3);
% Display the transformation matrix
disp('Test Case 5: Translate (1,2,3) & Rotation 60 deg about z-axis');
disp(T);

% Test 6 Combination Translate (5,5,5) in x,y,z Rotation 45 deg about
% z-axis then 30 deg about x-axis
Ov = [5; 5; 5];
% Rotation about the z-axis by 45 degrees
angle_z_degrees = 45;
v1_z = [cosd(angle_z_degrees); -sind(angle_z_degrees); 0];
v2_z = [sind(angle_z_degrees); cosd(angle_z_degrees); 0];
v3_z = [0; 0; 1];
% Rotation about the x-axis by 30 degrees
angle_x_degrees = 30;
R_x = [1, 0, 0; 0, cosd(angle_x_degrees), -sind(angle_x_degrees); 0, sind(angle_x_degrees), cosd(angle_x_degrees)];
v1 = R_x * v1_z;
v2 = R_x * v2_z;
v3 = R_x * v3_z;
T = FrameTransformationToHome(Ov, v1, v2, v3);
% Display the transformation matrix
disp('Test Case 6: Translation (5,5,5) and Rotation 45 deg in z and 30 deg in x');
disp(T);
