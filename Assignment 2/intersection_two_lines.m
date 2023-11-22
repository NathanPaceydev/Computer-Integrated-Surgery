% CMPE 330 Assignment 1
% Question 1 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 24th, 2023

% Given problem: Compute the approximate (symbolic) intersection of two
% lines, with a suitable error metric
% Use P_n for fixed point and V_n for direction vector of each line as input
% Output: symbolic intersection point, along with standard error

function[intersec_point, error] = intersection_two_lines(P1, V1, P2, V2)
    % Display given Lines:
    %fprintf('Given Lines:\nL1 = [%s]+ t1*[%s]\n', join(string(P1),','), join(string(V1),','));
    %fprintf('L2 = [%s]+ t2*[%s]\n\n', join(string(P2),','), join(string(V2),','));


    % first find line L3 that is perpendicular to L2 and L3
    % L3 = P3 + t3*V3
    % need symbolic variables for t_n
    t1 = sym('t1');
    t2 = sym('t2');
    t3 = sym('t3');

    % need to normailze the direction vectors to find V3
    V1 = V1./norm(V1);
    V2 = V2./norm(V2);
    
    V3 = cross(V1, V2);
    V3 = V3./norm(V3);

    % now we can express the three line equations 
    % note in array indicies x, y, z = 1, 2, 3
    % first using P1_x - P2_y = -t1*v1_x + t2*v2_x +t3*v3_x
    one = -P1(1) + P2(1) - t1*V1(1) + t2*V2(1) + t3*V3(1);
    two = -P1(2) + P2(2) - t1*V1(2) + t2*V2(2) + t3*V3(2);
    three = -P1(3) + P2(3) - t1*V1(3) + t2*V2(3) + t3*V3(3);

    % these equations should all equal 0 and can be used as a system to
    % solve for t1, t2, t3
    % can use MatLab solve function with the equations as the parameters
    soln = solve([one, two, three], [t1, t2, t3]);
    t_1 = soln.t1;
    t_2 = soln.t2;
    t_3 = soln.t3;
    
    if isempty(t_1)
        %fprintf("No Signal Intersection Point\n");
        % need to check for colinear vs parallel
        eqn = -P2+P1+t1*V1;
        t_c = solve(eqn, t1);

        if isempty(t_c)
            if isequal(V1,V2)
                %fprintf('Lines are Parallel\n\n');
            else
                %fprintf('Lines are Skew\n\n');
            end
            
            intersec_point = "None";
            error = "";
        else
            %fprintf('Lines are Colinear\n\n');
            intersec_point = "inf";
            error = "";
        end

    else
        % now the intersection point is represented by the midpoint of the the
        % two line equations with the solved t values 
        L1 = P1 + t_1*V1;
        L2 = P2 + t_2*V2;
        
        % the error can be represented by half of the solved t3
        intersec_point = (L1+L2)/2;
        error = abs(L1-L2)/2;
        %printResults(intersec_point, error)
    end


    function printResults(points, error)
        digits(4);
        %disp("Intersection point: ");
        disp(vpa(points));
        %disp("Error in measurement: ");
        disp(vpa(error));
    end
    
end

   