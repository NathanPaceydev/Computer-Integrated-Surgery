% CMPE 330 Assignment 1
% Question 5 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

% function to generate points along a sphere and plot them
function reconstruct_sphere(shift, radi, azimuth, elevation, n)
    figure(n);
    % taking example points
    % Convert spherical coordinates to Cartesian coordinates
    x = radi*sin(elevation) .* cos(azimuth) + shift(1);
    y = radi*sin(elevation) .* sin(azimuth) + shift(2);
    z = radi*cos(elevation) + shift(3);

    % Add noise to the points so that there is some deviation from the
    % sphere
    noise = 0.05 * randn(size(x));
    x = x + noise;
    y = y + noise;
    z = z + noise;

    sphere_data = [x' y' z']; % these are the points to be fitted
    
    % Call fitting function with generated points
    [C,r] = sphere_fit(sphere_data);
    fprintf('Predicted Center: ('+join(string(C),', ')+')\n');
    fprintf('Predicted Radius: '+ string(r)+'\n\n');

    % Generate points on a sphere with specified center and radius
    [xs, ys, zs] = sphere(20); % disp sphere with 20x20 patches
    xs = xs * r + C(1);  % Scale and translate the sphere
    ys = ys * r + C(2);
    zs = zs * r + C(3);

    % Create a 3D scatter plot with generated sphere to visualize the fit
    scatter3(x, y, z, 'filled');
    hold on;
    scatter3(C(1),C(2),C(3),'filled', 'red');
    
    surf(xs, ys, zs, 'FaceAlpha', 0.5);  % Plot the sphere with transparency
    text = "Sphere Fit with Predicted Center: ("+join(string(C),', ')+") and Radius: "+ string(r);
    subtext = "Actual Center: ("+join(string(shift),', ')+") and Radius: "+ string(radi);
    title(text,subtext);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    axis equal; % Equalize axis scaling to make it look like a sphere
    hold off;
    
end
