%% Isotropic Antenna - XZ Plane (identical to XY due to symmetry)
close all; clc;

k = 4;
x = linspace(-20, 20, 161);
z = linspace(-20, 20, 161);
[X, Z] = meshgrid(x, z);

R = sqrt(X.^2 + Z.^2);
R(R < 0.1) = 0.1;
E = k ./ R;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, E); shading interp;
hold on; plot(0, 0, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('z [m]');
title('E-field - Isotropic (XZ plane)');
colormap('hot'); colorbar; caxis([0 10]);

subplot(1,2,2);
[C, h] = contour(X, Z, E, [6, 20], 'LineWidth', 2);
clabel(C, h);
hold on; plot(0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('z [m]');
title('Circular contours (spherical symmetry)');
grid on; axis equal;

saveas(gcf, 'output.png');
