% CMPE 330 Assignment 1
% Question 3 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 24th, 2023

function[intersec_points, number_points] = line_intersect_ellipse(P, V, a, b, c)
    %first need to normalize the direction vedctor of the line
    V = V./norm(V);
   
    % know that the arrays of P and V are broken into [x,y,z]
    % can solve for A, B, C and find the roots of the quadratic
    % Use the equation of a Line and ellispoid to isolate terms of t
    % where At^2 + Bt + C = 0
    A = (V(1)^2)/(a^2) + (V(2)^2)/(b^2) + (V(3)^2)/(c^2);
    B = 2*((P(1)*V(1))/(a^2) + (P(2)*V(2))/(b^2)+ (P(3)*V(3))/(c^2));
    C = (P(1)^2)/(a^2) + (P(2)^2)/(b^2) + (P(3)^2)/(c^2) - 1;
    
    % characteristic equation determines how many roots in this case
    % how many intersection points
    D = B^2 - 4*A*C; %characteristic eqn
   
    % if D<0 no intersection points
    if D>=0 
        t=sym('t'); % declare the symbolic var to solve for
        quad_eqn = A*t^2 + B*t + C == 0;
        t_soln = solve(quad_eqn, t); % use the solve funtion to get roots

        if D == 0 % exactly one intersection point
            intersec_points = P + t_soln(1)*V; % sub the root back into the eqn
            number_points = 1;
        else
            % two intersection points plug each root back into the
            % equation
            intersec_points = [P + t_soln(1)*V; P + t_soln(2)*V];
            number_points = 2;
        end

    else % no real roots of the equation 
        intersec_points = 'None';
        number_points = 0;
    end

end
