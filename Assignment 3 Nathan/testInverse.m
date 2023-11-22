% CMPE 330 Assignment 3
% Inverse Kinematics - Testing  file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

% declare constants
alpha = 45;
d = 45;

% Test case 1. put the target 45 deg from the origin at distance d
% should output a theta of 0 deg and a d of 45 and a z of 0
disp("Test 1. Only Needle Insertion No Rotation or Translation")
TP = [d*cosd(alpha),0,d*sind(alpha)];
[theta, d1, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d1);
fprintf("z: %.2f\n\n",z);

% Test case 2. now rotate the target 30 deg about z
% should have a new theta of 30 deg and d while z remains 0
disp("Test 2. Needle Insertion and Axis Rotation")
TP = [45*cosd(45)*cosd(30),45*cosd(45)*sind(30),45*sind(45)];
[theta, d, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d);
fprintf("z: %.2f\n\n",z);

% Test 3. Finally displace the target by 10mm in z along with previous
% translations
disp("Test 3. All degrees of freedom Needle, Rotation and Translation")
TP = [45*cosd(45)*cosd(30),45*cosd(45)*sind(30),45*sind(45)+10];
[theta, d, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d);
fprintf("z: %.2f\n\n",z);

