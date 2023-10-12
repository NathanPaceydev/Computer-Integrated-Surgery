% CMPE 330 Assignment 1
% Question 7 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

fprintf("Question 7 output:\n\n");
% Question 7: Generate Orthonormal Frame

% Test Case 1: Co-linear points
A = [0, 0, 0];
B = [1, 0, 0];
C = [2, 0, 0];
disp('Test Case 1: Co-linear points');
disp('A = (0, 0, 0), B = (1, 0, 0), C = (2, 0, 0)')
[Oe, e1, e2, e3] = generate_ortho_frame(A, B, C);
% Display the results
disp(['Oe: ', num2str(Oe)]);
disp(['e1: ', num2str(e1)]);
disp(['e2: ', num2str(e2)]);
disp(['e3: ', num2str(e3)]);
disp(' ');

%Test Case 2: Non Colinear Points
A = [0, 0, 0];
B = [1, 0, 0];
C = [0, 1, 0];
disp('Test Case 2: Non Colinear Points');
disp('A = (0, 0, 0), B = (1, 0, 0), C = (0, 1, 0)')
[Oe, e1, e2, e3] = generate_ortho_frame(A, B, C);
% Display the results
disp(['Oe: ', num2str(Oe)]);
disp(['e1: ', num2str(e1)]);
disp(['e2: ', num2str(e2)]);
disp(['e3: ', num2str(e3)]);
disp(' ');

% Test Case 3: Unit Basis Points along x, y, z
A = [1, 0, 0];
B = [0, 1, 0];
C = [0, 0, 1];
disp('Test Case 3: Basis Points along x, y, z');
disp('A = (1, 0, 0), B = (0, 1, 0), C = (0, 0, 1)')
[Oe,e1,e2,e3] = generate_ortho_frame(A,B,C);
% Display the results
disp(['Oe: ', num2str(Oe)]);
disp(['e1: ', num2str(e1)]);
disp(['e2: ', num2str(e2)]);
disp(['e3: ', num2str(e3)]);
disp(' ');