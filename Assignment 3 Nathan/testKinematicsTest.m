% CMPE 330 Assignment 3
% KinematicsTest - Testing file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

% Testing worst case scenario Center of prostate as far away from robot
% as possible
targetCenter = [50, 0, 20*cosd(45)];
KinematicsTest(targetCenter);