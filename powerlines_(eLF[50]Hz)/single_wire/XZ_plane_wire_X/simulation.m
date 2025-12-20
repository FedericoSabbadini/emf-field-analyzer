%% Single Wire along X-axis - Magnetic Field in XZ Plane
%  Wire in the plane, field depends only on z-distance

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
zs = 0;

x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

R = abs(Z - zs);
R(R < 0.1) = 0.1;
B_uT = mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on; plot([min(x) max(x)], [zs zs], 'w-', 'LineWidth', 3);
xlabel('x [m]'); ylabel('z [m]');
title('B-field - Wire along X (in XZ plane)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on; plot([min(x) max(x)], [zs zs], 'b-', 'LineWidth', 4);
xlabel('x [m]'); ylabel('z [m]');
title('Horizontal isolines');
grid on;

saveas(gcf, 'output.png');
