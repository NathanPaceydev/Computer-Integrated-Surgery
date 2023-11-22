% CMPE 330 Assignment 2.
% Question 4. Testing Files
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% testMarkerCorrespondences - Script to test the marker correspondences

% Define marker points in CK frame
M1CK = [30, -30, 0];
M2CK = [-30, 0, 30];
M3CK = [0, -30, 60];

fprintf('----------------------------------------\n Test 1. Project the M1CK, M2CK, M3C onto two the X-ray detectors:\n\n');

% Project marker points onto A and B detectors
[point_AM1CK, point_BM1CK] = xrayProjector(M1CK');
[point_AM2CK, point_BM2CK] = xrayProjector(M2CK');
[point_AM3CK, point_BM3CK] = xrayProjector(M3CK');

% intersection_two_lines(point_AM2CK', (point_AM2CK'-source_A),point_BM2CK',(point_BM2CK'-source_B))

% Arrange points in matrices
points_A = [point_AM1CK'; point_AM2CK'; point_AM3CK'];
points_B = [point_BM1CK'; point_BM2CK'; point_BM3CK'];

% Test marker correspondences
correspondence_matrix = markerCorrespondences(points_A, points_B);

% Display results
fprintf('Correspondence Matrix:\n');
disp(correspondence_matrix);

fprintf('----------------------------------------\n Test 2. Swap M1 and M2 images\n\n');

% Arrange points in matrices
points_A = [point_AM2CK'; point_AM1CK'; point_AM3CK'];
points_B = [point_BM1CK'; point_BM2CK'; point_BM3CK'];

% Test marker correspondences
correspondence_matrix = markerCorrespondences(points_A, points_B);

% Display results
fprintf('Correspondence Matrix:\n');
disp(correspondence_matrix);


% Define marker points in CK frame
M1CK = [30, -30, 0];
M2CK = [-30, 0, 0];
M3CK = [0, -30, 60];

fprintf('----------------------------------------\n Test 3. New Markers\nM1CK = [30, -30, 0], M2CK = [-30, 0, 0], M3CK = [0, -30, 60].\n\n');

% Project marker points onto A and B detectors
[point_AM1CK, point_BM1CK] = xrayProjector(M1CK');
[point_AM2CK, point_BM2CK] = xrayProjector(M2CK');
[point_AM3CK, point_BM3CK] = xrayProjector(M3CK');

% intersection_two_lines(point_AM2CK', (point_AM2CK'-source_A),point_BM2CK',(point_BM2CK'-source_B))

% Arrange points in matrices
points_A = [point_AM1CK'; point_AM2CK'; point_AM3CK'];
points_B = [point_BM1CK'; point_BM2CK'; point_BM3CK'];

% Test marker correspondences
correspondence_matrix = markerCorrespondences(points_A, points_B);

% Display results
fprintf('Correspondence Matrix:\n');
disp(correspondence_matrix);
