% CMPE 330 Assignment 2.
% Question 6. Functional Code
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% targetRegistrationErrorSimulation - module to analyze the robustness of target registration against marker segmentation errors
%
% Inputs:
%    N - Number of random ground-truth target points
%    maxTRE - Maximum allowed target registration error (in mm)
%    Emax_increment - Increment of the marker segmentation error (in mm)
%    M_CK - 3x3 matrix where each row represents a marker point in CK frame
%    target_envelop_radius - Radius of the target envelop (in mm)
%
% Outputs:
%    max_allowable_error - Maximum allowable marker segmentation error that still guarantees clinically acceptable TRE
%
function max_allowable_error = targetRegistrationErrorSimulation(M1_CK, M2_CK, M3_CK, TP_CK, N, plot_bool)
    % this function takes markers and target in CK and generates N points
    % within the target envelope and then tests the accuracy of the X-ray
    % point reconstruction by applying small displacements in  the marker
    % coordinatees and then generates the associated 'displaced' target by
    % finding the new frame and target in that new frame
    % the simulation is finished when the displaced target is further than
    % the allowable error 1mm from the envelope target

    % declare simulation constants
    increment = 0.1;
    maxTRE = 1;
    R = 20;

    % Initialize matrix to store random points
    random_points_in_envelope_CK = zeros(N, 3);

    % Part 1. generate N ground truth points inside target envelope
    for i=1:N
        % use random unit vector for 3D unit vector -- surpress plots
        random_unit_vector = generate_unit_vector(3, 0);
    
        % multiply the unit vector from a random float from 0.0 to R
        scaled_vector = random_unit_vector * (R * rand());
    
        % take the scaled vector and place it inside the target envelope by
        % adding it to the target center
        random_points_in_envelope_CK(i, :) = TP_CK + scaled_vector';
    end

    % plot the randomly generated points if specified as a sanity check
    if plot_bool
        plotPoints(R,TP_CK,random_points_in_envelope_CK);
    end

    % Part 2. Project M_CK onto X-ray detectors (A & B)
    % Project marker points onto A and B detectors
    [point_AM1CK, point_BM1CK] = xrayProjector(M1_CK);
    [point_AM2CK, point_BM2CK] = xrayProjector(M2_CK);
    [point_AM3CK, point_BM3CK] = xrayProjector(M3_CK);

   % Print the given markers in CK frame
    fprintf('Given Markers in CK Frame:\n');
    fprintf('M1_CK: [%.3f, %.3f, %.3f]\n', M1_CK);
    fprintf('M2_CK: [%.3f, %.3f, %.3f]\n', M2_CK);
    fprintf('M3_CK: [%.3f, %.3f, %.3f]\n', M3_CK);
    
    % Print the Markers in the A frame
    fprintf('\nMarkers in A Frame:\n');
    fprintf('A_M1CK: [%.3f, %.3f, %.3f]\n', point_AM1CK);
    fprintf('A_M2CK: [%.3f, %.3f, %.3f]\n', point_AM2CK);
    fprintf('A_M3CK: [%.3f, %.3f, %.3f]\n', point_AM3CK);
    
    % Print the Markers in the B frame
    fprintf('\nMarkers in B Frame:\n');
    fprintf('B_M1CK: [%.3f, %.3f, %.3f]\n', point_BM1CK);
    fprintf('B_M2CK: [%.3f, %.3f, %.3f]\n', point_BM2CK);
    fprintf('B_M3CK: [%.3f, %.3f, %.3f]\n', point_BM3CK);

    
    % Part 3. Simulation cycle
    % Initialization
    Emax = 0;
    max_allowable_error = 0;
    TRE_values = [];
    Emax_values = [];
    max_TRE_values = [];

    while true
        % Spoil each marker image point by a segmentation error vector of random direction and of Emax magnitude, within the detector plane.
        [spoiled_AM1CK, spoiled_BM1CK] = spoilMarkerPoints(point_AM1CK, point_BM1CK, Emax);
        [spoiled_AM2CK, spoiled_BM2CK] = spoilMarkerPoints(point_AM2CK, point_BM2CK, Emax);
        [spoiled_AM3CK, spoiled_BM3CK] = spoilMarkerPoints(point_AM3CK, point_BM3CK, Emax);
        
        % Feed the error-spoilt image points to the marker reconstructor module to obtain three markers in CK frame.
        [M1_CK_reconstructed, REM1] = markerReconstruction(spoiled_AM1CK, spoiled_BM1CK);
        [M2_CK_reconstructed, REM2] = markerReconstruction(spoiled_AM2CK, spoiled_BM2CK);
        [M3_CK_reconstructed, REM3] = markerReconstruction(spoiled_AM3CK, spoiled_BM3CK);

        % For each ground-truth target point, register the target point and compute TRE
        TREs = zeros(N, 1);

        % for each generate N point in the envelope find the associated
        % 'displaced' target with the spoiled marker points 
        for i = 1:N
            % calculate new target using targetRegistration
            target_CK = targetRegistration(random_points_in_envelope_CK(i, :)', M1_CK, M2_CK, M3_CK, M1_CK_reconstructed, M2_CK_reconstructed, M3_CK_reconstructed);
            % populate the TRE array with the displacement from the generated envelope target
            TREs(i) = sqrt(sum(target_CK - random_points_in_envelope_CK(i, :)').^2);
        end
        
        % Calculate average TRE over N runs
        average_TRE = sum(TREs) / N;
        
        % Store TRE and Emax values
        max_TRE_values = [max_TRE_values, max(TREs)];
        TRE_values = [TRE_values, average_TRE];
        Emax_values = [Emax_values, Emax];

        if any(TREs > maxTRE)
            break;
        end

        % Update maximum allowable error
        max_allowable_error = Emax;
        % Increase the magnitude of the marker segmentation error (Emax)
        Emax = Emax + increment;
        
    end
    % Report the maximum allowable marker segmentation error
    fprintf('Maximum allowable marker segmentation error: %.3f mm\n', max_allowable_error);
    if plot_bool
        plotTRE(Emax_values, TRE_values, max_TRE_values);
    end
end

function plotTRE(Emax_values, TRE_values, max_TRE_values)
    % Plot average TRE agaisnt Emax_values:
    figure;
    plot(Emax_values, TRE_values, '-o');
    xlabel('Marker Segmentation Error (Emax) [mm]');
    ylabel('Average Target Registration Error (TRE) [mm]');
    title('Average TRE vs. Marker Segmentation Error');
    grid on;
    
    % Plot max TRE values agaisnt Emax_values:
    figure;
    plot(Emax_values, max_TRE_values, '-o', 'Color', 'r');
    xlabel('Marker Segmentation Error (Emax) [mm]');
    ylabel('Maximum Target Registration Error (TRE) [mm]');
    title('Maximum TRE vs. Marker Segmentation Error');
    grid on;
    hold off;
end


function [AM_spoilt, BM_spoilt] = spoilMarkerPoints(AM,BM, Emax)
    % Spoils each marker point by a segmentation error vector of random direction and Emax magnitude
    scaler_spoilt = Emax * randn(size(AM));
    AM_spoilt = AM + scaler_spoilt;
    BM_spoilt = BM + scaler_spoilt;
end


function plotPoints(R,TP_CK,random_points_in_envelope_CK)
    % plot the point inside the sphere with center TP_CK and radius R
    % Create a new figure
    figure;
    
    % Plot the sphere
    [X, Y, Z] = sphere(100);
    surf(R*X + TP_CK(1), R*Y + TP_CK(2), R*Z + TP_CK(3), 'FaceAlpha', 0.1, 'EdgeColor', 'none');
    hold on;
    
    % Plot the random points inside the envelope
    scatter3(random_points_in_envelope_CK(:, 1), random_points_in_envelope_CK(:, 2), random_points_in_envelope_CK(:, 3), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b');
    
    % Plot the target center
    scatter3(TP_CK(1), TP_CK(2), TP_CK(3), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
    
    % Set plot properties
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Point Inside Target Envelope');
    axis equal;
    grid on;
    hold off;
end
    