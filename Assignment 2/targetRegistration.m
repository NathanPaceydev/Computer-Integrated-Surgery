% CMPE 330 Assignment 2.
% Question 5. Functional Code
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: October 30th, 2023

% targetRegistration - Transforms a target point from CT frame to CK frame
%
% Input:
% T_CT: 3x1 vector, representing the target point in CT frame
% M_CT1, M_CT2, M_CT3: 3x1 vectors, representing three non-collinear marker points in CT frame
% M_CK1, M_CK2, M_CK3: 3x1 vectors, representing the corresponding three non-collinear marker points in CK frame
%
% Output:
% target_CK: 3x1 vector, representing the transformed target point in CK frame
%
function  target_CK = targetRegistration(T_CT, M_CT1, M_CT2, M_CT3, M_CK1, M_CK2, M_CK3)
    % Compute the transformation matrix from CT to CK frame
    % can accomplish this by finding the bassis vectors and then using them
    % to generate a tranformation matrix
    
    T_CT_to_CK = TransformationMatrixCTtoCK(M_CT1, M_CT2, M_CT3, M_CK1, M_CK2, M_CK3);
    
    % Convert target point to homogeneous coordinates
    target_CT_homogeneous = [T_CT; 1];
    
    % Transform the target point from CT to CK frame
    target_CK_homogeneous = T_CT_to_CK * target_CT_homogeneous;
    
    % Convert back to non-homogeneous coordinates
    target_CK = target_CK_homogeneous(1:3) ./ target_CK_homogeneous(4);
end

% TransformationMatrixCTtoCK - Computes the transformation matrix from CT frame to CK frame
%
% Input:
% A_CK, B_CK, C_CK: 3x1 vectors, representing three non-collinear marker points in CK frame
% A_CT, B_CT, C_CT: 3x1 vectors, representing the corresponding three non-collinear marker points in CT frame
%
% Output:
% T_CT_to_CK: 4x4 matrix, representing the transformation matrix from CT frame to CK frame
%
function T_CT_to_CK = TransformationMatrixCTtoCK(A_CK, B_CK, C_CK, A_CT, B_CT, C_CT)
    % Generate orthogonal frames for CK and CT
    [Oe_CK, e1_CK, e2_CK, e3_CK] = generate_ortho_frame(A_CK, B_CK, C_CK);
    [Oe_CT, e1_CT, e2_CT, e3_CT] = generate_ortho_frame(A_CT, B_CT, C_CT);
    
    % Generate transformation matrices for CK and CT
    T_CK = FrameTransformationToHome(Oe_CK, e1_CK, e2_CK, e3_CK);
    T_CT = FrameTransformationToHome(Oe_CT, e1_CT, e2_CT, e3_CT);
    
    % Compute the transformation matrix from CT to CK
    T_CT_to_CK = T_CT * inv(T_CK);
end
