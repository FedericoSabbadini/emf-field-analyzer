%% Parabolic Dish - 3D Isosurface
%  Narrow pencil beam along +Z axis

close all; clc;

k = 4; E_val = 4;

x = linspace(-10, 10, 81);
y = linspace(-10, 10, 81);
z = linspace(-5, 15, 81);  % Asymmetric to show forward beam
[X, Y, Z] = meshgrid(x, y, z);

R = sqrt(X.^2 + Y.^2 + Z.^2);
R(R < 0.1) = 0.1;
theta = acos(Z ./ R);

F = cos(theta).^2;
F(Z < 0) = 0;

E = k * F ./ R;

figure('Position', [100 100 800 700]);
p = patch(isosurface(x, y, z, E, E_val));
set(p, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.7);
hold on;
plot3(0, 0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
quiver3(0, 0, 0, 0, 0, 8, 'b', 'LineWidth', 4, 'MaxHeadSize', 0.5);
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title(sprintf('Parabolic Dish: E = %d V/m (Narrow beam +Z)', E_val));
axis equal; grid on;
camlight; lighting gouraud;
legend('E isosurface', 'Antenna', 'Beam direction');
view(45, 25);

saveas(gcf, 'output.png');
