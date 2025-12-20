%% Two Wires OPPOSITE PHASE - XZ Plane
%  Currents opposite -> field DIFFERENCE (cancellation at center)

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
xs = [-5, 5];
signs = [1, -1];  % Opposite currents

x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

B_total = zeros(size(X));
for i = 1:2
    R = abs(X - xs(i));
    R(R < 0.1) = 0.1;
    B_total = B_total + signs(i) * mu0 * I ./ (2 * pi * R);
end
B_uT = abs(B_total) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on;
plot([xs(1) xs(1)], [-40 40], 'b-', 'LineWidth', 2);
plot([xs(2) xs(2)], [-40 40], 'r-', 'LineWidth', 2);
xlabel('x [m]'); ylabel('z [m]');
title('B-field - OPPOSITE currents (+I, -I)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [1, 3, 10], 'LineWidth', 2);
clabel(C, h);
hold on;
plot([xs(1) xs(1)], [-40 40], 'b-', 'LineWidth', 3);
plot([xs(2) xs(2)], [-40 40], 'r-', 'LineWidth', 3);
plot([0 0], [-40 40], 'g--', 'LineWidth', 2);
xlabel('x [m]'); ylabel('z [m]');
title('MINIMUM at x=0 (cancellation)');
grid on;

saveas(gcf, 'output.png');
