% CMPE 330 Assignment 1
% Question 7 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

function[Oe, e1,e2,e3]=generate_ortho_frame(A, B, C)
    % Calculate the center of gravity (Oe)
    Oe = (A + B + C) / 3;
    
    % Compute the base vectors e1, e2, and e3
    e1 = (B - A);
    e3 = (cross(e1,(C-A)));
    e2 = cross(e3, e1);
    
    % Ensure that the base vectors are normalized
    e1 = e1./norm(e1);
    e2 = e2./norm(e2);
    e3 = e3./norm(e3);

     % Check if the base vectors are orthogonal (dot product close to zero)
    if any(isnan([dot(e1, e2), dot(e1, e3), dot(e2, e3)]))
        disp('Base vectors are not orthogonal.');
    end
    
end
