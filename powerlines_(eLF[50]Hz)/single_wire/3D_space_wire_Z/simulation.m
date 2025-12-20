%% Single Wire along Z-axis - 3D Isosurface
%  The B=10uT surface is a CYLINDER around the wire

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
B_target = 10e-6;  % 10 uT in Tesla

% Theoretical cylinder radius for B = 10 uT
r_cyl = mu0 * I / (2 * pi * B_target);
fprintf('Cylinder radius for B=10uT: r = %.3f m\n', r_cyl);

% Create cylindrical surface
theta = linspace(0, 2*pi, 50);
z = linspace(-20, 20, 50);
[THETA, Z] = meshgrid(theta, z);
X = r_cyl * cos(THETA);
Y = r_cyl * sin(THETA);

figure('Position', [100 100 800 700]);
surf(X, Y, Z, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.7);
hold on;
plot3([0 0], [0 0], [-20 20], 'r-', 'LineWidth', 4);
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title(sprintf('B = 10 \\muT Isosurface: Cylinder r = %.2f m', r_cyl));
axis equal; grid on;
camlight; lighting gouraud;
legend('B = 10 \muT surface', 'Wire (Z-axis)', 'Location', 'northeast');
view(45, 25);

saveas(gcf, 'output.png');
