% CMPE 330 Assignment 1
% Question 10 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

function Assign1_Q10
    fprintf("Question 10 output:\n\n");
    % Define the ground-truth transformation parameters
    Ov = [0; 0; 0];  % Tracker in the canonical home
    angle_x_degrees = 0;  % No rotation about x-axis
    angle_z_degrees = 0;  % No rotation about z-axis
    
    % Rotation matrices for x-axis and z-axis rotations
    R_x = [1, 0, 0; 0, cosd(angle_x_degrees), -sind(angle_x_degrees); 0, sind(angle_x_degrees), cosd(angle_x_degrees)];
    R_z = [cosd(angle_z_degrees), -sind(angle_z_degrees), 0; sind(angle_z_degrees), cosd(angle_z_degrees), 0; 0, 0, 1];
    
    % Combine the rotations by multiplying the rotation matrices
    R_combined = R_x * R_z;
    
    % Define the position of the patient's head and markers
    head_radius = 100;  % Head radius (100 mm)
    head_center = [0; 0; -300];  % Head center position
    Pt_target = [0; 0; -400];  % Desired target position Pt at (0,0,-400)
    
    % Calculate the error-free ground-truth observation of Pt using the transformation
    T = FrameTransformationToHome(Ov, R_combined(:, 1), R_combined(:, 2), R_combined(:, 3));
    Pt_ground_truth = T * [Pt_target; 1];  % Apply the transformation to Pt_target
    
    % Display the ground-truth observation of Pt
    disp('Ground-Truth Observation of Pt at (0,0,-400):');
    disp(Pt_ground_truth(1:3));

    % Initialize parameters
    TREmax = 5.0;  % Maximum allowable TRE (5.0 mm)
    deltaFLE = 0.5;  % Increment of FLE magnitude (0.5 mm)
    FLE = 0;  % Initial FLE
    
    % Initialize variables to store TRE and FLE values
    TRE_values = [];
    FLE_values = [];
    disp("Average TRE values:")
    while true
        % Simulate random FLE vectors for markers A, B, and C
        FLE_A = FLE * rand(3, 1) / norm(rand(3, 1));
        FLE_B = FLE * rand(3, 1) / norm(rand(3, 1));
        FLE_C = FLE * rand(3, 1) / norm(rand(3, 1));
        
        % Compute the erroneous observation of Pt for N runs
        N = 1000;  % Number of runs (adjust as needed)
        TRE_sum = 0;
        for i = 1:N
            % Compute erroneous observations for markers A, B, and C
            Pt_A_err = MarkerObservation(Ov, R_combined(:, 1), R_combined(:, 2), R_combined(:, 3), FLE_A);
            Pt_B_err = MarkerObservation(Ov, R_combined(:, 1), R_combined(:, 2), R_combined(:, 3), FLE_B);
            Pt_C_err = MarkerObservation(Ov, R_combined(:, 1), R_combined(:, 2), R_combined(:, 3), FLE_C);
            
            % Compute TRE for this run
            TRE_run = norm(Pt_A_err - Pt_B_err) + norm(Pt_A_err - Pt_C_err) + norm(Pt_B_err - Pt_C_err);
            TRE_sum = TRE_sum + TRE_run;
        end
        
        % Calculate average TRE over N runs
        average_TRE = TRE_sum / N;
        disp(average_TRE);
        % Store TRE and FLE values
        TRE_values = [TRE_values, average_TRE];
        FLE_values = [FLE_values, FLE];
        
        % Check if TRE exceeds TREmax
        if average_TRE > TREmax
            break;  % Simulation stops if TRE exceeds TREmax
        end
        
        % Increment FLE magnitude
        FLE = FLE + deltaFLE;
    end
    
    % Plot TRE as a function of FLE
    figure;
    plot(FLE_values, TRE_values, 'b.-', 'LineWidth', 1.5);
    xlabel('Fiducial Localization Error (FLE, mm)');
    ylabel('Target Registration Error (TRE, mm)');
    title('TRE vs. FLE');
    grid on;
    
    

    function Pt_err = MarkerObservation(Ov, v1, v2, v3, FLE)
        % Simulate FLE by adding it to the actual marker positions
        Pt_actual_A = [100; 0; -300];  % Actual position of marker A
        Pt_actual_B = [-50; 86.6; -300];  % Actual position of marker B
        Pt_actual_C = [-50; -86.6; -300];  % Actual position of marker C
    
        % Add simulated FLE to marker positions
        Pt_err_A = Pt_actual_A + FLE;
        Pt_err_B = Pt_actual_B + FLE;
        Pt_err_C = Pt_actual_C + FLE;
    
        % Apply the transformation to obtain erroneous Pt position
        T = FrameTransformationToHome(Ov, v1, v2, v3);
        Pt_err = T * [Pt_err_A; 1];
    end

    function T = FrameTransformationToHome(Ov, v1, v2, v3)
        % Translation matrix 
        % Create the homogeneous transformation matrix
        T = eye(4);
        
        % Set the rotation and translation components
        % This matrix represents the Homogeneous Rotation Matrix times the inverse
        % Translation Matix
        T(1:3, 1) = v1;
        T(1:3, 2) = v2;
        T(1:3, 3) = v3;
        T(1:3, 4) = Ov;
    end
end