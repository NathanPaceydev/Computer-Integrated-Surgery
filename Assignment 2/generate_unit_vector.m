% CMPE 330 Assignment 1
% Question 6 - functional code file
% Author: Nathan Pacey      email: 18njp@queensu.ca     SN: 20153310
% Date: September 25th, 2023

function[random_unit_vector]=generate_unit_vector(dim, plot_bool)
    if dim == 2
        % Generate a random angle between 0 and 2*pi for 2D
        theta = rand() * 2 * pi;
        
        % Calculate the components of the unit vector
        random_unit_vector = [cos(theta), sin(theta)];
    elseif dim == 3
        % Generate two random angles, theta and phi, for 3D
        theta = rand() * 2 * pi;
        phi = rand() * pi;
        
        % Calculate the components of the unit vector
        random_unit_vector = [sin(phi) * cos(theta), sin(phi) * sin(theta), cos(phi)];
    else
        error('Invalid dimension. Use 2 or 3.');
    end
        
    % Plot the resulting vector on the canonical unit circle (2D) or unit sphere (3D)
    if plot_bool
        figure;
        if dim == 2
            plot(random_unit_vector(1), random_unit_vector(2),'bo');
            hold on;
            % Plot the unit circle for reference
            th = linspace(0, 2 * pi, 100);
            x = cos(th);
            y = sin(th);
            plot(x, y, 'r');
            axis equal;
            title('Random Unit Vector in 2D');
            legend('Random Unit Vector', 'Unit Circle');
        elseif dim == 3
            [X, Y, Z] = sphere;
            surf(X, Y, Z, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.5);
            hold on;
            scatter3(random_unit_vector(1), random_unit_vector(2), random_unit_vector(3),'filled', 'r');
            axis equal;
            title('Random Unit Vector in 3D');
            legend('Unit Sphere', 'Random Unit Vector');
        end
        hold off;
    end
end
