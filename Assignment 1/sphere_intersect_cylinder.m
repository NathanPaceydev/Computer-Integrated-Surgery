% CMPE 330 Assignment 1
% Question 4 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023


function[number_points] = sphere_intersect_cylinder(C, R, r, P, v)
    % need to find the distance between the sphere and cylinder
    % first find the normalized length from the center of the cylinder
    % to the center of the sphere
    h = norm(P-C);
    % next find the projection of this vector onto the direction of the
    % cylinder
    t = dot(v,(P-C));
    % finally use pythagorean theorem with these lengths to solve for
    % distance
    d = sqrt(h^2 - t^2);
    
    % if distance is exactly the two radi then one intersection point
    if d == r+R
        number_points = 1;
    % if the distance is smaller the ojects overlap causing inf points
    elseif d < r+R
        number_points = "Infinite";
    else
    % otherwise distance is greater than the two radi and they dont
    % intersect
        number_points = 0;
    end

end