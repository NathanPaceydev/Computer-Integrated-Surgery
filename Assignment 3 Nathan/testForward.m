% CMPE 330 Assignment 3
% Forward Kinematics - Testing  file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023


% Test 1. TP = [30,-20,-50]
TP = [30,-20,-50];
fprintf("Test 1. given TP: : [%.2f, %.2f, %.2f]\n",TP);
[theta, d, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d);
fprintf("z: %.2f\n\n",z);

[TP_testx,TP_testy,TP_testz] = forwardKinematics(z, theta, d);
TP_test = [TP_testx,TP_testy,TP_testz];
fprintf('Measured TP: [%.2f, %.2f, %.2f] \n', TP_test);
disp('----------------------------------------')


% Test 2. Only Needle Insertion No Rotation or Translation
disp("Test 2. Only Needle Insertion No Rotation or Translation")
TP = [45*cosd(45),0,45*sind(45)];
fprintf("Given TP: [%.2f, %.2f, %.2f]\n",TP);

[theta, d, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d);
fprintf("z: %.2f\n\n",z);

[TP_testx,TP_testy,TP_testz] = forwardKinematics(z, theta, d);
TP_test = [TP_testx,TP_testy,TP_testz];
fprintf('Measured TP: [%.2f, %.2f, %.2f] \n', TP_test);
disp('----------------------------------------')


% Test case 3. now rotate the target 30 deg about z
% should have a new theta of 30 deg and d while z remains 0
disp("Test 3. Needle Insertion and Axis Rotation")
TP = [45*cosd(45)*cosd(30),45*cosd(45)*sind(30),45*sind(45)];
fprintf("Given TP: [%.2f, %.2f, %.2f]\n",TP);

[theta, d, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d);
fprintf("z: %.2f\n\n",z);

[TP_testx,TP_testy,TP_testz] = forwardKinematics(z, theta, d);
TP_test = [TP_testx,TP_testy,TP_testz];
fprintf('Measured TP: [%.2f, %.2f, %.2f] \n', TP_test);
disp('----------------------------------------')


% Test 4. Finally displace the target by 10mm in z along with previous
% translations
disp("Test 4. All degrees of freedom Needle, Rotation and Translation")
TP = [45*cosd(45)*cosd(30),45*cosd(45)*sind(30),45*sind(45)+10];
fprintf("Given TP: [%.2f, %.2f, %.2f]\n",TP);
[theta, d, z] = inverseKinematics(TP);
fprintf("theta: %.2f\n",rad2deg(theta));
fprintf("d: %.2f\n",d);
fprintf("z: %.2f\n\n",z);

[TP_testx,TP_testy,TP_testz] = forwardKinematics(z, theta, d);
TP_test = [TP_testx,TP_testy,TP_testz];
fprintf('Measured TP: [%.2f, %.2f, %.2f] \n', TP_test);
