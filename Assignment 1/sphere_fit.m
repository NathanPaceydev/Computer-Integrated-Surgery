% CMPE 330 Assignment 1
% Question 5 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

% solution Based on:
% Prem Rachakonda (2023). Sphere Fit
% (https://www.mathworks.com/matlabcentral/fileexchange/45910-sphere-fit), 
% MATLAB Central File Exchange.

% fitting function
function[C,R] = sphere_fit(points_in)
    % parse data into x,y,z
    x = points_in(:,1);
    y = points_in(:,2);
    z = points_in(:,3);
    
    % break the spherical equation into 2 deg polynomial
    A = [-2*x, -2*y, -2*z, ones(size(x))];
    B = [-(x.^2+y.^2+z.^2)];

    % use mldivide to solve the 2nd degree equation
    min = mldivide(A,B);
    % output of the equation is the roots with are the center of the
    % sphere and D ~ the non dependant term of the quadratic
    a = min(1);
    b = min(2);
    c = min(3);

    C = [a, b, c]; % let roots be center C

    % note min(4) = D = a^2+b^2+c^2+r^2
    % therefore r = (a^2+b^2+c^2 - D)^0.5
    R = sqrt(a^2+b^2+c^2-min(4));
end