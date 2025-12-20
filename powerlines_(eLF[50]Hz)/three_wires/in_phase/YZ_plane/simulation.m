%% Three-Phase IN PHASE - YZ Plane (at x=0, between wires)
close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;
xs = [-5, 0, 5];

y = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[Y, Z] = meshgrid(y, z);

B_tot = zeros(size(Y));
for k = 1:3
    R = sqrt(xs(k)^2 + Y.^2);
    R(R < 0.1) = 0.1;
    B_tot = B_tot + mu0 * I0 ./ (2 * pi * R);
end
B_uT = B_tot * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, B_uT); shading interp;
xlabel('y [m]'); ylabel('z [m]');
title('Three-Phase IN PHASE - YZ at x=0');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(Y, Z, B_uT, [3, 10, 30], 'LineWidth', 2);
clabel(C, h);
xlabel('y [m]'); ylabel('z [m]');
title('High field level');
grid on; axis equal;

saveas(gcf, 'output.png');
