% CMPE 330 Assignment 3
% Robot Frame Calibration - Testing  file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

% declare Markers as given
M1 = [50,0,-100];
M2 = [0,0,-100];
M3 = [0,0,-50];

% define other given constants
alpha_deg = 45;
sigma = 0;% mm
d = 50; % mm

% Test 1. Ground Truth tests:
[x, y, z, O, alpha] = robotFrameCalibration(M1, M2, M3, alpha_deg, sigma, d);
disp('Test 1. Ground Truth tests in mm:');
fprintf('x: [%.2f, %.2f, %.2f]\n', x);
fprintf('y: [%.2f, %.2f, %.2f]\n',y);
fprintf('z: [%.2f, %.2f, %.2f]\n', z);
fprintf('O: [%.2f, %.2f, %.2f]\n', O);
fprintf('alpha (in degrees): %.2f\n\n', rad2deg(alpha));

% Test 2. with sigma 1 mm error:
sigma = 1;% mm
[x1, y1, z1, O1, alpha1] = robotFrameCalibration(M1, M2, M3, alpha_deg, sigma, d);
disp('Test 2. Introducing sigma = 1mm error:');
fprintf('x: [%.2f, %.2f, %.2f]\n', x1);
fprintf('y: [%.2f, %.2f, %.2f]\n',y1);
fprintf('z: [%.2f, %.2f, %.2f]\n', z1);
fprintf('O: [%.2f, %.2f, %.2f]\n', O1);
fprintf('alpha (in degrees): %.2f\n\n', rad2deg(alpha1));

% Comparisons:
% Calculate the distance (magnitude) difference in each basis vector
% Calculate the vector differences
del_x = (x1 - x); % Difference in x
del_y = (y1 - y); % Difference in y
del_z = (z1 - z); % Difference in z

% Calculate the magnitude of the error for each coordinate
x_error = norm(del_x);
y_error = norm(del_y);
z_error = norm(del_z);
O_error = norm(O1 - O);

% calculate alpha error:
alpha_error = abs(alpha1 - alpha);

% Display the results
fprintf('Error in x: %.2f mm\n', (x_error));
fprintf('Error in y: %.2f mm\n', (y_error));
fprintf('Error in z: %.2f mm\n', (z_error));
fprintf('Error in O: %.2f mm\n', (O_error));
fprintf('Error in alpha: %.2f deg\n', rad2deg(alpha_error));

