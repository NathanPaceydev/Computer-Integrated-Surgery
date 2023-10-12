% CMPE 330 Assignment 1
% Question 2 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 24th, 2023

fprintf("Question 2 output:\n\n");

% Use the plane of the x-y axis for simplicity
% Know that a line with diriction along y not in x will have No Intersection
point = intersect_line_and_plane([0,0,0],[0,0,1],[0,2,1],[0,-2,0]);

% Line in the x-y plane will have Infite Intersections
point = intersect_line_and_plane([0,0,0],[0,0,1],[0,0,0],[0,-2,0]);

% Line in the z axis will have exactly 1 intersection at the origin
point = intersect_line_and_plane([0,0,0],[0,0,1],[0,0,0],[0,0,1]);

% Any line not colinear or parallel will intersect
point = intersect_line_and_plane([0,0,0],[0,0,1],[1,-2,5],[-3,2,1]);
