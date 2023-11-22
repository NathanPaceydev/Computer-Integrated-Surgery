% CMPE 330 Assignment 2.
% Question 3. Testing File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% testMarkerReconstruction - Script to test the Marker Reconstruction

% Define ground truth points in CK frame

% 2. use the z unit vector as it should become (0,0,2)
P2_CK = [0; 0; 1];

% 3. use the y unit vector from A in CK to map to (0,0,0) in A
P3_CK = [-1/(2^0.5); 1/(2^0.5); 0];

% 4. use the y unit vector from B in CK to map to (0,0,0) in B
P4_CK = [1/(2^0.5); 1/(2^0.5); 0];

fprintf('----------------------------------------\nTest 1. z-unit vector Reconstruction Test\n');
% Project points onto A and B detectors and Reconstruct points and compute REM
[point_A2, point_B2] = xrayProjector(P2_CK);
[reconstructed_P2, REM_P2] = markerReconstruction(point_A2, point_B2);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', P2_CK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_P2);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_P2);

fprintf('----------------------------------------\nTest 2. Y-unit vector from A Reconstruction Test\n');
% Project points onto A and B detectors and Reconstruct points and compute REM
[point_A3, point_B3] = xrayProjector(P3_CK);
[reconstructed_P3, REM_P3] = markerReconstruction(point_A3, point_B3);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', P3_CK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_P3);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_P3);

fprintf('----------------------------------------\nTest 3. Y-unit vector from B Reconstruction Test\n');
% Project points onto A and B detectors and Reconstruct points and compute REM
[point_A4, point_B4] = xrayProjector(P4_CK);
[reconstructed_P4, REM_P4] = markerReconstruction(point_A4, point_B4);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', P4_CK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_P4);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_P4);


% -------------------------------------------------- 
% Can test the reconstruction with the given marker points to see if the
% X-ray can properly predict the original marker locations with small error
% trhis essentially determines wether the markers were placed in an
% appropriate location for the x-ray detectors

CCK = [0; 0; 0];
M1CK = [30; -30; 0];
M2CK = [-30; 0; 30];
M3CK = [0; -30; 60];

fprintf('----------------------------------------\nTest for Reconstructed CCK\n');
% Project points onto A and B detectors
[PA_CCK, PB_CCK] = xrayProjector(CCK);
% Reconstruct points and compute REM
[reconstructed_CCK, REM_CCK] = markerReconstruction(PA_CCK, PB_CCK);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', CCK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_CCK);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_CCK);

fprintf('----------------------------------------\nTest for Reconstructed M1CK\n');
% Project points onto A and B detectors
[PA_M1CK, PB_M1CK] = xrayProjector(M1CK);
% Reconstruct points and compute REM
[reconstructed_M1CK, REM_M1CK] = markerReconstruction(PA_M1CK, PB_M1CK);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', M1CK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_M1CK);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_M1CK);

fprintf('----------------------------------------\nTest for Reconstructed M2CK\n');
% Project points onto A and B detectors
[PA_M2CK, PB_M2CK] = xrayProjector(M2CK);
% Reconstruct points and compute REM
[reconstructed_M2CK, REM_M2CK] = markerReconstruction(PA_M2CK, PB_M2CK);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', M2CK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_M2CK);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_M2CK);

fprintf('----------------------------------------\nTest for Reconstructed M3CK\n');
% Project points onto A and B detectors
[PA_M3CK, PB_M3CK] = xrayProjector(M3CK);
% Reconstruct points and compute REM
[reconstructed_M3CK, REM_M3CK] = markerReconstruction(PA_M3CK, PB_M3CK);
% Display Results
fprintf('Original Point: [%.3f, %.3f, %.3f]\n', M3CK);
fprintf('Reconstructed Point: [%.3f, %.3f, %.3f]\n', reconstructed_M3CK);
fprintf('Residual Error Metric: [%.3f, %.3f, %.3f]\n\n', REM_M3CK);

