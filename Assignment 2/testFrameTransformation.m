% CMPE 330 Assignment 2.
% Question 1. Testing File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% testFrameTransformation - Script to test the frame transformation from CK to A or B

% Define test points in CK frame (as column vectors)
% Chosen such that they are easy to verify after transformation

PA_CK = [100/(2^0.5); -100/(2^0.5); 0; 1];  % Center of A detector in CK
SA_CK = [-100/(2^0.5); 100/(2^0.5); 0; 1]; % Source of A detector in CK

% Test transformation to frame A
targetFrame = 'A';
T_CK_to_A = frameTransformation(targetFrame);
fprintf('\nTransformation Matrix T_CK->A\n');
disp(T_CK_to_A);
P1_A = T_CK_to_A * PA_CK;
P2_A = T_CK_to_A * SA_CK;

% Display results for frame A
fprintf('\n----------------------------------------\n Test 1. Detector A Center in A Frame\n');
fprintf('Center of A in CK [%.3f, %.3f, %.3f]\n', PA_CK(1:3));
fprintf('Center of A in A Frame:[%.3f, %.3f, %.3f]\n', round(P1_A(1:3)',2));

fprintf('\n----------------------------------------\n Test 2. Source A in A Frame\n');
fprintf('Source A in CK [%.3f, %.3f, %.3f]\n', SA_CK(1:3));
fprintf('Source of A in A Frame:[%.3f, %.3f, %.3f]\n', round(P2_A(1:3)',2));
fprintf('\n----------------------------------------\n');

% Test transformation to frame B
PB_CK = [-100/(2^0.5); -100/(2^0.5); 0; 1];  % Center of A detector in CK
SB_CK = [100/(2^0.5); 100/(2^0.5); 0; 1];

targetFrame = 'B';
T_CK_to_B = frameTransformation(targetFrame);
fprintf('\nTransformation Matrix T_CK->B\n');
disp(T_CK_to_B);
P1_B = T_CK_to_B * PB_CK;
P2_B = T_CK_to_B * SB_CK;

% Display results for frame B
fprintf('\n----------------------------------------\n Test 3. Detector B Center in B Frame\n');
fprintf('Center of B in CK [%.3f, %.3f, %.3f]\n', PB_CK(1:3));
fprintf('Center of B in B Frame:[%.3f, %.3f, %.3f]', round(P1_B(1:3)',2));

fprintf('\n----------------------------------------\n Test 4. Source Center in B Frame\n');
fprintf('Source B in CK [%.3f, %.3f, %.3f]\n', SB_CK(1:3));
fprintf('Source of B in B Frame:[%.3f, %.3f, %.3f]\n', round(P2_B(1:3)',2));


