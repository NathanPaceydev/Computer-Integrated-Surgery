% CMPE 330 Assignment 2.
% Question 2. Testing File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% testXrayProjector - Script to test the X-ray projector

% Define test points in CK frame
% 1. use the origin as it should mapp to the origin in both A & B frames
P1_CK = [0; 0; 0]; 

% 2. use the z unit vector as it should become (0,0,2)
P2_CK = [0; 0; 1];

% 3. use the y unit vector from A in Ck to maps to (0,0,0) in A
P3_CK = [-1/(2^0.5); 1/(2^0.5); 0];

% 4. use the y unit vector from B in Ck to maps to (0,0,0) in B
P4_CK = [1/(2^0.5); 1/(2^0.5); 0];


% Project points onto A and B detectors and Display Results

% 1. Origin Projection Test
fprintf('----------------------------------------\nTest 1. Origin Projection Test\n');
[point_A1, point_B1] = xrayProjector(P1_CK);
fprintf('Origin [0,0,0] in CK in Xray A detector frame: [%.3f, %.3f, %.3f]\n', point_A1);
fprintf('\n');
fprintf('Origin [0,0,0] in CK in Xray B detector frame: [%.3f, %.3f, %.3f]\n', point_B1);
fprintf('\n');

% 2. z-unit vector Projection Test
fprintf('----------------------------------------\nTest 2. z-unit vector Projection Test\n');
[point_A2, point_B2] = xrayProjector(P2_CK);
fprintf('z unit vector [0,0,1] in CK in Xray A detector frame: [%.3f, %.3f, %.3f]\n', point_A2);
fprintf('\n');
fprintf('z unit vector [0,0,1] in CK in Xray B detector frame: [%.3f, %.3f, %.3f]\n', point_B2);
fprintf('\n');

% 3. Y-unit vector from A Projection Test
fprintf('----------------------------------------\nTest 3. Y-unit vector from A Projection Test\n');
[point_A3, point_B3] = xrayProjector(P3_CK);
fprintf('[%.3f, %.3f, %.3f] Y_A unit vector in CK, in Xray A detector frame: [%.3f, %.3f, %.3f]\n',P3_CK, point_A3);
fprintf('\n');
fprintf('[%.3f, %.3f, %.3f]  Y_A unit vectorin CK, in Xray B detector frame: [%.3f, %.3f, %.3f]\n',P3_CK, point_B3);
fprintf('\n');

% 4. Y-unit vector from B Projection Test
fprintf('----------------------------------------\nTest 4. Y-unit vector from B Projection Test\n');
[point_A4, point_B4] = xrayProjector(P4_CK);
fprintf('[%.3f, %.3f, %.3f] Y_B unit vector in Xray A detector frame: [%.3f, %.3f, %.3f]\n',P4_CK, point_A4);
fprintf('\n');
fprintf('[%.3f, %.3f, %.3f]  Y_B unit vector in Xray B detector frame: [%.3f, %.3f, %.3f]\n',P4_CK, point_B4);
fprintf('\n');

