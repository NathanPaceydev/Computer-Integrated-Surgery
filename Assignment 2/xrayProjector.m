% CMPE 330 Assignment 2.
% Question 2. Functional Code
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% xrayProjector - Projects a point from CK space onto the A and B detectors
%
% Syntax: [point_A, point_B] = xrayProjector(point_CK)
%
% Inputs:
%    point_CK - 3x1 vector representing a point in CK frame
%
% Outputs:
%    point_A - 3x1 vector representing the projected point in A detector frame
%    point_B - 3x1 vector representing the projected point in B detector frame
%
function [point_A, point_B] = xrayProjector(point_CK)
        % first define the line from the sources to the Dectors
        SA = [-100/(2^0.5);100/(2^0.5);0];
        SB = [100/(2^0.5);100/(2^0.5);0];
        
        % Line equantion L = P + tV where V is 3D slope
        % find Vs using known points
        VA = (point_CK - SA);
        VA = VA./norm(VA);
        VB = (point_CK - SB);
        VB = VB./norm(VB);

        % define detector centers
        CA = [100/(2^0.5);-100/(2^0.5);0];
        CB = [-100/(2^0.5);-100/(2^0.5);0];

        % next define the plane that represents the detector 
        % Need to find the Normal using points on the Detectors
        % can use basis points of detector frame in CK coordinates
        PA_Z = [100/(2^0.5);-100/(2^0.5);1];
        PA_X = [101/(2^0.5);-99/(2^0.5);0];

        PB_Z = [-100/(2^0.5);-100/(2^0.5);1];
        PB_X = [-99/(2^0.5);-101/(2^0.5);0];

        % take the cross product to find orthagonal vector
        cross_A = cross((PA_Z-CA),(PA_X-CA))';
        cross_B = cross((PB_Z-CB),(PB_X-CB))';
       
        % where the normal will be the normalized orthagonal vector
        N_A = cross_A./norm(cross_A);
        N_B = cross_B./norm(cross_B);

        % P is the arbitary point, N is the normal to the Plane and A is
        % the planes Center
        % in this case A = CA or CB
        % can use intersect line and plane to find the x-ray projection of
        % the point onto the detector image
        % intersect_line_and_plane(A, N, P, V)
        point_A_CK = intersect_line_and_plane(CA, N_A,point_CK,VA);
        point_B_CK = intersect_line_and_plane(CB, N_B,point_CK,VB);
        
        % Since the point from intersect line and plane is in the CK
        % coordinates we can transform it to the detectors frame using
        % frameTransform
        targetFrame = 'A';
        T_CK_to_A = frameTransformation(targetFrame);
        % add extra dimension to multiply transformation matrix
        point_A_CK = [point_A_CK; 1];        
        point_A = T_CK_to_A * point_A_CK;
        
        %truncate back to 3D
        point_A = point_A(1:3);

        targetFrame = 'B';
        T_CK_to_B = frameTransformation(targetFrame);
        % add extra dimension to multiply transformation matrix
        point_B_CK = [point_B_CK; 1];
        point_B = T_CK_to_B * point_B_CK;

        %truncate back to 3D
        point_B = point_B(1:3);
end