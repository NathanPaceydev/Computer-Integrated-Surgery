% CMPE 330 Assignment 3
% KinematicsTest - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: November 19th, 2023

function KinematicsTest(targetCenter)
    for i = 1:10
        fprintf("\n -- Test %d -- \n",i);
        % generate a random point within the prosate radi
        testPoint= targetCenter+generate_unit_vector(3,0)*rand()*30;
        fprintf("Generated Target Point: [%.2f,%.2f,%.2f] \n",testPoint)
        
        % compute the translations to get to target
        [theta, d, z] = inverseKinematics(testPoint);
        
        % find computed target from translations
        [TP_testx,TP_testy,TP_testz] = forwardKinematics(z, theta, d);
        TP_test = [TP_testx,TP_testy,TP_testz] ;
        fprintf('Measured TP: [%.2f, %.2f, %.2f] \n', TP_test);
        
        % copmpute error delta from reconstructed to generated target
        error = norm(testPoint-TP_test);
        fprintf("error difference: %.2f\n", error);
        disp('-------------------------------------------')
    end

end