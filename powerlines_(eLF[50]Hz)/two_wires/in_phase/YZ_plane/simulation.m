%% Two Wires IN PHASE - YZ Plane (equidistant from both wires)
%  At x=0, both wires are at same distance from any point in YZ plane

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
d = 5;  % Wire at x=±5

y = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[Y, Z] = meshgrid(y, z);

% Both wires at distance sqrt(d^2 + y^2) from points in YZ plane
R = sqrt(d^2 + Y.^2);
R(R < 0.1) = 0.1;

% Two wires, same direction, same distance -> 2x field
B_uT = 2 * mu0 * I ./ (2 * pi * R) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, B_uT); shading interp;
xlabel('y [m]'); ylabel('z [m]');
title('B-field - Two Wires IN PHASE (YZ plane at x=0)');
colormap('hot'); colorbar; caxis([0 20]);

subplot(1,2,2);
[C, h] = contour(Y, Z, B_uT, [3, 10], 'LineWidth', 2);
clabel(C, h);
xlabel('y [m]'); ylabel('z [m]');
title('Equidistant from both wires - symmetric field');
grid on; axis equal;

saveas(gcf, 'output.png');
