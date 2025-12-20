%% Isotropic Antenna - 3D Isosurface (Sphere)
close all; clc;

k = 4;
E_target = 6;  % Attention value [V/m]
r_sphere = k / E_target;
fprintf('Isosurface E = %d V/m is a sphere with r = %.2f m\n', E_target, r_sphere);

% Create sphere
[X, Y, Z] = sphere(50);
X = X * r_sphere;
Y = Y * r_sphere;
Z = Z * r_sphere;

figure('Position', [100 100 800 700]);
surf(X, Y, Z, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.7);
hold on;
plot3(0, 0, 0, 'ro', 'MarkerSize', 20, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title(sprintf('E = %d V/m Isosurface: SPHERE r = %.2f m (Isotropic)', E_target, r_sphere));
axis equal; grid on;
camlight; lighting gouraud;
legend('E = 6 V/m', 'Antenna');
view(45, 25);

saveas(gcf, 'output.png');
