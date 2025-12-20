%% Single Wire along X-axis - Magnetic Field in YZ Plane (Cross-section)
%  YZ plane is PERPENDICULAR to the wire -> circular isolines

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
ys = 0; zs = 0;  % Wire pierces YZ plane at origin

y = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[Y, Z] = meshgrid(y, z);

R = sqrt((Y - ys).^2 + (Z - zs).^2);
R(R < 0.1) = 0.1;
B_uT = mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, B_uT); shading interp;
hold on; plot(ys, zs, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'w');
xlabel('y [m]'); ylabel('z [m]');
title('B-field - Wire along X (cross-section in YZ)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(Y, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on; plot(ys, zs, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('y [m]'); ylabel('z [m]');
title('CIRCULAR isolines (perpendicular to wire)');
grid on; axis equal;

saveas(gcf, 'output.png');
