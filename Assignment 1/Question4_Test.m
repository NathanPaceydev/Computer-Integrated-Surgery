% CMPE 330 Assignment 1
% Question 4 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

fprintf("Question 4 output:\n\n");

% Test Case 1: Exactly 1 Intersection
[num_i1] = sphere_intersect_cylinder([0,0,0],5,10,[0,0,15],[0,1,0]);
fprintf("Sphere Centered at: (0,0,0) with radi 5 and \nCylinder Centered at: (0,0,15) with radi 10 in direction: (0,1,0)\n");
fprintf("Has "+string(num_i1)+" intestection(s)\n\n");


% Test Case 2: No Intersection
[num_i2] = sphere_intersect_cylinder([0,0,0],5,2,[0,0,15],[0,1,0]);
fprintf("Sphere Centered at: (0,0,0) with radi 2 and \nCylinder Centered at: (0,0,15) with radi 10 in direction: (0,1,0)\n");
fprintf("Has "+string(num_i2)+" intestection(s)\n\n");

% Test Case 3: Infite Intersections
[num_i3] = sphere_intersect_cylinder([0,0,0],5,20,[0,0,15],[0,1,0]);
fprintf("Sphere Centered at: (0,0,0) with radi 20 and \nCylinder Centered at: (0,0,15) with radi 10 in direction: (0,1,0)\n");
fprintf("Has "+string(num_i3)+" intestection(s)\n\n");