function ReconstructSphere_Test

    function plotSphereWithPatches(numPatches)

    % Define spherical coordinates
    [theta, phi] = meshgrid(linspace(0, 2 * pi, numPatches), linspace(0, pi, numPatches));
    
    % Convert spherical coordinates to Cartesian coordinates
    x = sin(phi) .* cos(theta);
    y = sin(phi) .* sin(theta);
    z = cos(phi);
    
    % Create the sphere plot
    figure;
    surf(x, y, z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title(['Sphere with ', num2str(numPatches), ' Surface Patches']);
    end

% Example: Create a sphere with 20x20 surface patches
numPatches = 20;
plotSphereWithPatches(numPatches);

end