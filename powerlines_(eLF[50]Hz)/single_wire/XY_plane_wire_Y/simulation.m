%% Single Wire along Y-axis - Magnetic Field in XY Plane
%  Wire runs vertically in the plane, field depends only on x-distance

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
xs = 0;  % Wire at x=0, along y-axis

x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

R = abs(X - xs);
R(R < 0.1) = 0.1;
B_uT = mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, B_uT); shading interp;
hold on; plot([xs xs], [min(y) max(y)], 'w-', 'LineWidth', 3);
xlabel('x [m]'); ylabel('y [m]');
title('B-field [uT] - Wire along Y-axis');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Y, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on; plot([xs xs], [min(y) max(y)], 'b-', 'LineWidth', 4);
xlabel('x [m]'); ylabel('y [m]');
title('VERTICAL isolines (field constant along y)');
grid on; axis equal;

saveas(gcf, 'output.png');
