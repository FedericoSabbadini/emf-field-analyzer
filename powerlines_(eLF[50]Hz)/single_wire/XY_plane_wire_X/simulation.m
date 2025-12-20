%% Single Wire along X-axis - Magnetic Field in XY Plane
%  Wire runs horizontally, field depends only on y-distance

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
ys = 0;  % Wire at y=0, along x-axis

x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

% Distance from wire (perpendicular = |y|)
R = abs(Y - ys);
R(R < 0.1) = 0.1;
B_uT = mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, B_uT); shading interp;
hold on; plot([min(x) max(x)], [ys ys], 'w-', 'LineWidth', 3);
xlabel('x [m]'); ylabel('y [m]');
title('B-field [uT] - Wire along X-axis');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Y, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on; plot([min(x) max(x)], [ys ys], 'b-', 'LineWidth', 4);
xlabel('x [m]'); ylabel('y [m]');
title('HORIZONTAL isolines (field constant along x)');
grid on; axis equal;

saveas(gcf, 'output.png');
