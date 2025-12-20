%% Yagi-Uda - 3D Isosurface (View 1)
close all; clc;

k = 4; E_val = 4;

x = linspace(-10, 10, 81);
y = linspace(-10, 10, 81);
z = linspace(-10, 10, 81);
[X, Y, Z] = meshgrid(x, y, z);

R = sqrt(X.^2 + Y.^2 + Z.^2);
R(R < 0.1) = 0.1;
theta = acos(Z ./ R);
phi = atan2(Y, X);

F = abs(sin(theta) .* sin(phi));
E = k * F ./ R;

figure('Position', [100 100 800 700]);
p = patch(isosurface(x, y, z, E, E_val));
set(p, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.7);
hold on;
plot3(0, 0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title(sprintf('Yagi-Uda: E = %d V/m (Figure-8 lobes along Y)', E_val));
axis equal; grid on;
camlight; lighting gouraud;
view(45, 30);

saveas(gcf, 'output.png');
