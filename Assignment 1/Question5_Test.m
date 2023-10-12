% CMPE 330 Assignment 1
% Question 5 - Test Case File
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023


fprintf("Question 5 output:\n\n");

% Test case 1: Simple points
% test trivial case of sphere at origin with radi 2
points = [0 0 2; 2 0 0; 0 2 0; 0 0 -2];
[C,r] = sphere_fit(points);
disp('Test case 1: Simple points, (0 0 2), (2 0 0), (0 2 0), (0 0 -2)')
fprintf('Predicted Center: ('+join(string(C),', ')+')\n');
fprintf('Predicted Radius: '+ string(r)+'\n\n');


% Test Case 2: 100 points around a random Sphere
% generate points on a sphere
% Define the number of points you want
numPoints = 100;
% generate random center from -10 to 10 in x,y,z
a= -10;
b=10;
shift = a + (b-a).*rand(3,1);
% generate random radius from 0 to 10
r = (b).*rand(1,1);
% Generate random spherical coordinates
azimuth = 2 * pi * rand(1, numPoints);
elevation = pi * rand(1, numPoints);

n=1; % figure number
disp('Test case 2: Points around a random Sphere');
reconstruct_sphere(shift,r, azimuth, elevation,n);


% Test Case 3: 100 points around a random Sphere limited range
% generate new random shift
shift = a + (b-a).*rand(3,1);
% generate random radius from 0 to 10
r = (b).*rand(1,1);
% Generate random spherical coordinates
azimuth = 0.5 * pi * rand(1, numPoints);
elevation = 0.5*pi * rand(1, numPoints);
n=2;
disp('Test case 3: Points around a random Sphere with limited range');
reconstruct_sphere(shift, r, azimuth, elevation, n);

