% CMPE 330 Assignment 1
% Question 2 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 24th, 2023

function [intersec_point] = intersect_line_and_plane(A, N, P, V)
    % Print Given Equations:
    fprintf('Given Line:\nL = [%s]+ t*[%s]\n', join(string(P),','), join(string(V),','));
    fprintf('Given Plane:\n n = [%s], A = [%s]\n\n', join(string(N),','), join(string(A),','));

    % first need to normalize the given vectors
    N = N./norm(N);
    V = V./norm(V);

    % Now can find the out if the line is part of the plane

    if dot(N,V) == 0
        if dot(P-A, N) == 0
            intersec_point = "Infinte";
        else
            intersec_point = "None";
        end
    else
        t = (dot((A-P),N))/(dot(V,N));
        intersec_point = P+V.*t;
        intersec_point = round(intersec_point, 4);
    end
    fprintf('Intersection Point = [%s] \n\n', join(string(intersec_point),', '));

end