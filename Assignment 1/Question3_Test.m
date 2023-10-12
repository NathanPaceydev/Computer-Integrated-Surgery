% CMPE 330 Assignment 1
% Question 3 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 24th, 2023

fprintf("Question 3 output:\n\n");

% Test Case 1: One intersections
[intersec_points, number_points] = line_intersect_ellipse([0,0,5],[0,1,0],3,2,5);
fprintf("There is "+string(number_points)+" intersection point(s)\n"+"The intersection point(s) are: ");
disp(intersec_points);


% Test Case 2: Two intersections
[intersec_points, number_points] = line_intersect_ellipse([0,0,0],[1,0,0],3,2,5);
fprintf("There is "+string(number_points)+" intersection point(s)\n"+"The intersection point(s) are: ");
disp(intersec_points);

% Test Case 2: Two intersections
[intersec_points, number_points] = line_intersect_ellipse([0,0,0],[0,0,1],1,2,3);
fprintf("There is "+string(number_points)+" intersection point(s)\n"+"The intersection point(s) are: ");
disp(intersec_points);

% Test Case 3: No intersections
[intersec_points, number_points] = line_intersect_ellipse([0,0,10],[1,0,0],3,2,5);
fprintf("There is "+string(number_points)+" intersection point(s)\n"+"The intersection point(s) are: ");
disp(intersec_points);