%% Three-Phase IN PHASE - XZ Plane
close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;
xs = [-5, 0, 5];

x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

B_tot = zeros(size(X));
for k = 1:3
    R = abs(X - xs(k));
    R(R < 0.1) = 0.1;
    B_tot = B_tot + mu0 * I0 ./ (2 * pi * R);
end
B_uT = B_tot * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on;
for k = 1:3, plot([xs(k) xs(k)], [-40 40], 'w-', 'LineWidth', 2); end
xlabel('x [m]'); ylabel('z [m]');
title('Three-Phase IN PHASE - XZ Plane');
colormap('hot'); colorbar; caxis([0 100]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on;
colors = {'b', 'r', 'g'};
for k = 1:3, plot([xs(k) xs(k)], [-40 40], '-', 'Color', colors{k}, 'LineWidth', 3); end
xlabel('x [m]'); ylabel('z [m]');
title('High field - no cancellation');
grid on;

saveas(gcf, 'output.png');
