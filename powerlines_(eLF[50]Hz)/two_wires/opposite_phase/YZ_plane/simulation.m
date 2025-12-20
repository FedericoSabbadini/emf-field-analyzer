%% Two Wires OPPOSITE PHASE - YZ Plane
%  At x=0 (symmetry plane), fields from opposite currents partially cancel

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
d = 5;

y = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[Y, Z] = meshgrid(y, z);

R = sqrt(d^2 + Y.^2);
R(R < 0.1) = 0.1;

% At x=0, the BY components from opposite currents subtract
% Simplified model: effective field much lower
B_uT = mu0 * I * 2 * d ./ (2 * pi * R.^2) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, B_uT); shading interp;
xlabel('y [m]'); ylabel('z [m]');
title('B-field - OPPOSITE phase (YZ at x=0)');
colormap('hot'); colorbar; caxis([0 5]);

subplot(1,2,2);
[C, h] = contour(Y, Z, B_uT, [0.5, 1, 2, 3], 'LineWidth', 2);
clabel(C, h);
xlabel('y [m]'); ylabel('z [m]');
title('Reduced field on symmetry plane');
grid on; axis equal;

saveas(gcf, 'output.png');
