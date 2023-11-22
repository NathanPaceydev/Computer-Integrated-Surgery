% CMPE 330 Assignment 3
% Robot Frame Calibration - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

% function goes through the calibration process for given markers, alpha
% and displacement of the robot and returns the basis vectors of the robot
% frame as viewed from the MRI frame

function [x, y, z, O, alpha] = robotFrameCalibration(M1, M2, M3, alpha_deg, sigma, d)

    % as per the assignment description, translation and rest position of markers:
    %  d = 50mm, M1=(50,0,-100), M2=(0,0,-100), M3=(0,0,-50), alpha=45 deg
    
    % convert alpha to rads
    alpha_rads = deg2rad(alpha_deg);
    
    % needle has full length 50mm
    L = 50; 
    
    % check wether error was given:
    if sigma == 0 % calibration with no error:
        
        % Step 1. Move the robot to the rest position 
        % let the needle be halfway out from full length
        M4 = [-0.5*L*sin(alpha_rads), 0, 0.5*L*cos(alpha_rads)];
        
        % Step 2. Find the origin by retracting the needle all the way
        M4 = M4 + [0.5*L*sin(alpha_rads), 0, -0.5*L*cos(alpha_rads)];
        O = M4;
        
        % Step 3. Find z vector by translating a distance d in z direction
        % note the needle is fully retracted so M4 is at origin
        % Move M4 and other markers d in +z
        translate_d = [0,0,d];
        M4_1 = M4 + translate_d;
        M3_1 = M3 + translate_d;
        M2_1 = M2 + translate_d;
        M1_1 = M1 + translate_d;
        
        % compute z by taking the normalized delta of markers
        delta = M4_1 - M4 + M3_1 - M3 + M2_1 - M2 + M1_1 - M1;
        distance_z = delta /4;
        z = distance_z./norm(distance_z);
        
        % Step 4. Measure alpha by extending the needle 
        % know the distance that the robot translated as measured
        translated_dist = norm(distance_z); % should be the exact same as d
        
        % move needle translated_dist
        M4_2 = M4 + [-translated_dist*sin(alpha_rads), 0, translated_dist*cos(alpha_rads)];

        % have triangle with two sides length translated_dist and one
        % length A, where A = | M4_2 - M4_1 | ^2
        A = norm(M4_2 - M4_1);
        % compute alpha using special trig function
        alpha = 2 * asin(A/(2*translated_dist));

        % note alpha is in rads can convert with rad2deg()
        %disp(rad2deg(alpha)); % should be 45 as in ground truth

        % Step 5. Find the x vector by placing M4_3 directly above M4_2 
        % retract the needle fully
        M4_3 = M4_2 + [translated_dist*sin(alpha_rads), 0, -translated_dist*cos(alpha_rads)];
        
        % use translated_dist to translate dcos(alpha)
        M4_3 = M4_3 + [0,0,translated_dist*cos(alpha)];

        % now can compute the x vector by taking the normalized delta of M4
        x = M4_3-M4_2;
        x = x./norm(x);

        % Step 6. Find y by taking cross prod of x and z vector
        y = cross(z,x);
        y = y./norm(y); % normalize cross prod

    elseif sigma > 0; % compute the basis now with a displacement error
         % Step 1. Move the robot to the rest position 
        % let the needle be halfway out from full length
        M4 = [-0.5*L*sin(alpha_rads), 0, 0.5*L*cos(alpha_rads)];
        
        % Step 2. Find the origin by retracting the needle all the way
        M4 = M4 + [0.5*L*sin(alpha_rads), 0, -0.5*L*cos(alpha_rads)];
        
        % calculate the 1mm randomly distributed error added to O
        % generate a 3D unit vector and scale it by random normailzed factor 0 to 1 
        O_sigma = generate_unit_vector(3,0)*randn(); 
        O = M4 + O_sigma; 
        
        % Step 3. Find z vector by translating a distance d in z direction
        % note the needle is fully retracted so M4 is at origin
        % Move M4 and other markers d in +z
        translate_d = [0,0,d];
        % observe markers with translation and observation error
        M4_1 = M4 + translate_d + generate_unit_vector(3,0)*randn();
        M3_1 = M3 + translate_d + generate_unit_vector(3,0)*randn();
        M2_1 = M2 + translate_d + generate_unit_vector(3,0)*randn();
        M1_1 = M1 + translate_d + generate_unit_vector(3,0)*randn();
        
        % compute z by taking the normalized delta of markers
        delta = M4_1 - M4 + M3_1 - M3 + M2_1 - M2 + M1_1 - M1;
        distance_z = delta /4;
        z = distance_z./norm(distance_z);
        
        % Step 4. Measure alpha by extending the needle 
        % know the distance that the robot translated as measured
        translated_dist = norm(distance_z); 
        
        % move needle translated_dist
        M4_2 = M4 + [-translated_dist*sin(alpha_rads), 0, translated_dist*cos(alpha_rads)];
        % add the observation error to M4_2
        M4_2 = M4_2 + generate_unit_vector(3,0)*randn();

        % have triangle with two sides length translated_dist and one
        % length A, where A = | M4_2 - M4_1 | ^2
        A = norm(M4_2 - M4_1);
        % compute alpha using special trig function
        alpha = 2 * asin(A/(2*translated_dist));

        % note alpha is in rads can convert with rad2deg()
        %disp(rad2deg(alpha)); % should be 45 as in ground truth

        % Step 5. Find the x vector by placing M4_3 directly above M4_2 
        % retract the needle fully
        M4_3 = M4_2 + [translated_dist*sin(alpha_rads), 0, -translated_dist*cos(alpha_rads)];

        % use translated_dist to translate dcos(alpha)
        M4_3 = M4_3 + [0,0,translated_dist*cos(alpha)];
        % add observation error to M4_3
        M4_3 = M4_3 + generate_unit_vector(3,0)*randn();

        % now can compute the x vector by taking the normalized delta of M4
        x = M4_3-M4_2;
        x = x./norm(x);

        % Step 6. Find y by taking cross prod of x and z vector
        y = cross(z,x);
        y = y./norm(y); % normalize cross prod
    else
        disp("Enter a sigma in mm that is greater than 0")
    end
end