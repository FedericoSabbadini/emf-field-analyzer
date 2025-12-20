%% Three-Phase 120° SHIFT - XZ Plane
close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;
xs = [-5, 0, 5];
phases = [0, 2*pi/3, 4*pi/3];
I = I0 * exp(1i * phases);

x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

By_tot = zeros(size(X));
for k = 1:3
    R = abs(X - xs(k));
    R(R < 0.1) = 0.1;
    B = mu0 * I(k) ./ (2 * pi * R);
    By_tot = By_tot + B .* sign(X - xs(k));
end
B_uT = abs(By_tot) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on;
for k = 1:3, plot([xs(k) xs(k)], [-40 40], 'w-', 'LineWidth', 2); end
xlabel('x [m]'); ylabel('z [m]');
title('Three-Phase 120° - XZ Plane');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [3, 10, 30], 'LineWidth', 2);
clabel(C, h);
hold on;
colors = {'b', 'r', 'g'};
labels = {'R (0°)', 'S (120°)', 'T (240°)'};
for k = 1:3, plot([xs(k) xs(k)], [-40 40], '-', 'Color', colors{k}, 'LineWidth', 3); end
xlabel('x [m]'); ylabel('z [m]');
title('REDUCED field due to phase cancellation');
grid on;
legend('Isolines', labels{:});

saveas(gcf, 'output.png');
