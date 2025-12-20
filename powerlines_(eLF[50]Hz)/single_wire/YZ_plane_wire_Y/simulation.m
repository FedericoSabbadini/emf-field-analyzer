%% Single Wire along Y-axis - Magnetic Field in YZ Plane
%  Wire lies IN the plane, field depends only on z-distance

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
zs = 0;

y = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[Y, Z] = meshgrid(y, z);

R = abs(Z - zs);
R(R < 0.1) = 0.1;
B_uT = mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, B_uT); shading interp;
hold on; plot([min(y) max(y)], [zs zs], 'w-', 'LineWidth', 3);
xlabel('y [m]'); ylabel('z [m]');
title('B-field - Wire along Y (in YZ plane)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(Y, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on; plot([min(y) max(y)], [zs zs], 'b-', 'LineWidth', 4);
xlabel('y [m]'); ylabel('z [m]');
title('Horizontal isolines (wire in plane)');
grid on;

saveas(gcf, 'output.png');
