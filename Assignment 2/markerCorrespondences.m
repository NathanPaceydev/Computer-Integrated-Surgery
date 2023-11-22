% CMPE 330 Assignment 2.
% Question 4. Functional Code
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% markerCorrespondences - module to resolve the correspondences in the reconstruction of 3 identical markers
%
% Input: 
% points_A: 3x3 matrix, where each row represents a point in A image frame
% points_B: 3x3 matrix, where each row represents a point in B image frame
% source_A: 1x3 vector representing the position of the source for detector A
% source_B: 1x3 vector representing the position of the source for detector B
%
% Output:
% correspondenceMatrix: 3x3 matrix, where each row represents the correspondence of a marker in A to B
%
function correspondenceMatrix = markerCorrespondences(points_A, points_B)
    % find out which points in the image frame are associated to
    % intersections (reconstructed points in CK) of the coorisponding lines
    % through A and B images to Sources

    % fist can take image points and convert them into CK coordinates

    % Sources in CK frame
    source_A = [-100/sqrt(2); 100/sqrt(2); 0]; 
    source_B =  [100/sqrt(2); 100/sqrt(2); 0];
    
    % transformation matricies for A and B frame
    T_CK_to_B = frameTransformation('B');
    T_CK_to_A = frameTransformation('A');

    T_A_to_CK = inv(T_CK_to_A);
    T_B_to_CK = inv(T_CK_to_B);
    
    % find the points in the A and B frames
    PA_CK = T_A_to_CK * [points_A,ones(size(points_A,1),1)]';
    PB_CK = T_B_to_CK * [points_B,ones(size(points_B,1),1)]';

    % reduce to x,y,z
    PA_CK = PA_CK(1:3,:);
    PB_CK = PB_CK(1:3,:);

    % get the size of matrix to determine loop iterations
    [numRowsA, numColsA] = size(PA_CK);
    [numRowsB, numColsB] = size(PB_CK);


    % Initialize the REM (Residual Error Metric) Matrix
    REM_Matrix = zeros(numRowsA, numColsA);
    
    correspondenceMatrix = zeros(3, 2);
    
    % Define a threshold for considering REM values as "near zero"
    threshold = 1e-3; % You can adjust this value as needed
    
    % then loop through all the points and find the distance between the
    % coorisponding lines (REM) where near zero represents an intersection
    % now loop through each combination of points and find the REM of 
    % their intersecting lines
    for i=1:numRowsA
        correspondenceMatrix(i,1) = i;

        % get PA at row i
        PA_i = PA_CK(:,i);

        % find the associated line from point A to source A
        line_A = createLine(PA_i, source_A);
        
        count =0;
       
        for j=1:numRowsB
            % get PB at index j
            PB_j = PB_CK(:,j);

            % find the associated line from point B to source B
            line_B = createLine(PA_i, source_B);
            
            % now can find error of the intersection of Line A and Line B
            [X, REM_val] = intersection_two_lines(PA_i, line_A.V, PB_j, line_B.V);

            % count the number of intersections per line pairing
            if REM_val <= threshold
                count = count +1; % make a note if there is more than one
            end
            REM_Matrix(i,j) = norm(REM_val);

        end
        % Find the correspondances based on the REM Matrix

        % if there is more than one intersection per pairing then the
        % points are ambiguous 
        if count > 1
            minIndex = -1;
        else
        % if only one intersection set minIndex to REM matrix min value
        [~, minIndex] = min(REM_Matrix(i, :));
        end

        %populate the correspondance matrix
        correspondenceMatrix(i,2) = minIndex;
       
    end
    REM_Matrix
     
end


% takes two 1x3 vectors
function line = createLine(point, source)
    % Create a line structure from a point and a source
    line.P = point;
    V = point - source;
    line.V = V./norm(V);
end 


