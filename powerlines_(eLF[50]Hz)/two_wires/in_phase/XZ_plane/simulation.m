%% Two Wires IN PHASE - XZ Plane
%  Wires at x=-5 and x=+5, field depends on |x-xs|

close all; clc;

I = 100; mu0 = 4*pi*1e-7;
xs = [-5, 5];

x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

B_total = zeros(size(X));
for i = 1:2
    R = abs(X - xs(i));
    R(R < 0.1) = 0.1;
    B_total = B_total + mu0 * I ./ (2 * pi * R);
end
B_uT = B_total * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on;
for i = 1:2, plot([xs(i) xs(i)], [-40 40], 'w-', 'LineWidth', 2); end
xlabel('x [m]'); ylabel('z [m]');
title('B-field - Two Wires IN PHASE (XZ plane)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on;
for i = 1:2, plot([xs(i) xs(i)], [-40 40], 'b-', 'LineWidth', 3); end
xlabel('x [m]'); ylabel('z [m]');
title('Fields sum between wires');
grid on;

saveas(gcf, 'output.png');
