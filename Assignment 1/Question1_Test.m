% CMPE 330 Assignment 1
% Question 1 - Test Case file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 24th, 2023

% Given problem: Compute the approximate (symbolic) intersection of two
% lines, with a suitable error metric
% Use P_n for fixed point and V_n for direction vector of each line as input
% Output: symbolic intersection point, along with standard error

fprintf("Question 1 output:\n\n");

%Intersection at origin
% use the equations of the axis z and x to get an intersection at the origin
[int_point, error] = intersection_two_lines([0,0,10],[0,0,5.2],[2,0,0],[10,0,0]);

% Intersection at 0,2,4
% use the equations of the axis z and x to get an intersection at the origin
[int_point, error] = intersection_two_lines([0,2,4],[1,-1,0],[0,2,4],[-1,-4,-5]);

% Intersection at non-origin point
% Should intersect at (7.45, -3.63, 14.71)
[int_point, error] = intersection_two_lines([-26.34,16.88,-23.72],[50.68, -30.76, 57.64],[-2,3,10.2],[28.34,-19.88,13.52]);

% Parrallel Lines No Intersections
[int_point, error] = intersection_two_lines([1,0,0],[0,-1,0],[0,0,0],[0,-1,0]);

% Same Line Infinite Intersections
[int_point, error] = intersection_two_lines([0,0,0],[0,-1,0],[0,0,0],[0,10,0]);