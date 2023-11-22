% CMPE 330 Assignment 2.
% Question 5. Testing File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% testTargetRegistration - Script to test the target registration

% Define the marker points in CT frame (from the provided information)
M1CT = [0, -40, -10]';
M2CT = [-60, -10, 20]';
M3CT = [-30, -40, 50]';


% Define the tumor center in CT frame (from the provided information)
TCCT = [-30, 20, 20]';

% Define the marker points in CK frame (from the provided information)
M1CK = [30, -30, 0]';
M2CK = [-30, 0, 30]';
M3CK = [0, -30, 60]';

% Define the tumor center in CK frame (from the provided information)
% This is the expected result of the target registration
TCCK_ground_truth = [0, 30, 30]';

% Run the target registration
TCCK_computed = targetRegistration(TCCT, M1CT, M2CT, M3CT, M1CK, M2CK, M3CK);

% Display results
fprintf('----------------------------------------\nTest 1. Target point Registration\n');
fprintf('Computed target point in CK frame: [%.3f, %.3f, %.3f]\n', TCCK_computed);
fprintf('Ground truth target point in CK frame: [%.3f, %.3f, %.3f]\n', TCCK_ground_truth);

% Compute error between computed and ground truth
error = norm(TCCK_computed - TCCK_ground_truth);
fprintf('Error between computed and ground truth: %.3f\n', error);


% run the registration with each Marker point in CT to generate Ck pair
M1CK_computed = targetRegistration(M1CT, M1CT, M2CT, M3CT, M1CK, M2CK, M3CK);
M2CK_computed = targetRegistration(M2CT, M1CT, M2CT, M3CT, M1CK, M2CK, M3CK);
M3CK_computed = targetRegistration(M3CT, M1CT, M2CT, M3CT, M1CK, M2CK, M3CK);

% Display results
fprintf('----------------------------------------\nTest 2. Markers in CK Registration\n');
fprintf('Computed M1 in CK frame: [%.3f, %.3f, %.3f]\n', M1CK_computed);
fprintf('Ground truth target point in CK frame: [%.3f, %.3f, %.3f]\n', M1CK);
% Compute error between computed and ground truth
error = norm(M1CK_computed - M1CK);
fprintf('Error between computed and ground truth: %.3f\n', error);

fprintf('\nComputed M2 in CK frame: [%.3f, %.3f, %.3f]\n', M2CK_computed);
fprintf('Ground truth target point in CK frame: [%.3f, %.3f, %.3f]\n', M2CK);
% Compute error between computed and ground truth
error = norm(M2CK_computed - M2CK);
fprintf('Error between computed and ground truth: %.3f\n', error);

fprintf('\nComputed M3 in CK frame: [%.3f, %.3f, %.3f]\n', M3CK_computed);
fprintf('Ground truth target point in CK frame: [%.3f, %.3f, %.3f]\n', M3CK);
% Compute error between computed and ground truth
error = norm(M3CK_computed - M3CK);
fprintf('Error between computed and ground truth: %.3f\n', error);

