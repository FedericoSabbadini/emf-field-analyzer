%% Single Wire along Y-axis - Magnetic Field in XZ Plane (Cross-section)
%  XZ plane is PERPENDICULAR to the wire -> circular isolines

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
xs = 0; zs = 0;  % Wire pierces XZ plane at origin

x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

R = sqrt((X - xs).^2 + (Z - zs).^2);
R(R < 0.1) = 0.1;
B_uT = mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on; plot(xs, zs, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'w');
xlabel('x [m]'); ylabel('z [m]');
title('B-field - Wire along Y (cross-section in XZ)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on; plot(xs, zs, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('z [m]');
title('CIRCULAR isolines (cross-section view)');
grid on; axis equal;

saveas(gcf, 'output.png');
