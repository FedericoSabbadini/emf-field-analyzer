%% Two Parallel Wires (OPPOSITE PHASE) - Magnetic Field in XY Plane
%  Currents in OPPOSITE directions -> fields SUBTRACT (partial cancellation)

close all; clc;

I = 100; mu0 = 4*pi*1e-7;

xs1 = -5; ys1 = 0;
xs2 = +5; ys2 = 0;

x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

R1 = sqrt((X - xs1).^2 + (Y - ys1).^2);
R2 = sqrt((X - xs2).^2 + (Y - ys2).^2);
R1(R1 < 0.1) = 0.1; R2(R2 < 0.1) = 0.1;

B1 = mu0 * I ./ (2 * pi * R1);
B2 = mu0 * I ./ (2 * pi * R2);

% Vector components
B1x = -B1 .* (Y - ys1) ./ R1;
B1y =  B1 .* (X - xs1) ./ R1;
% OPPOSITE current for wire 2 -> negate components
B2x = +B2 .* (Y - ys2) ./ R2;  % Sign flipped!
B2y = -B2 .* (X - xs2) ./ R2;  % Sign flipped!

% Vector sum (partial cancellation)
Bx = B1x + B2x;
By = B1y + B2y;
B_total = sqrt(Bx.^2 + By.^2);
B_uT = B_total * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, B_uT); shading interp;
hold on;
plot(xs1, ys1, 'wo', 'MarkerSize', 12, 'MarkerFaceColor', 'b', 'LineWidth', 2);
plot(xs2, ys2, 'wo', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'LineWidth', 2);
xlabel('x [m]'); ylabel('y [m]');
title('B-field [uT] - Two Wires OPPOSITE (+I, -I)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Y, B_uT, [3, 10, 30], 'LineWidth', 2);
clabel(C, h);
hold on;
plot(xs1, ys1, 'bo', 'MarkerSize', 15, 'MarkerFaceColor', 'b');
plot(xs2, ys2, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
plot([0 0], [-40 40], 'g--', 'LineWidth', 2);
xlabel('x [m]'); ylabel('y [m]');
title('PARTIAL CANCELLATION - Reduced far-field (1/r^2 decay)');
grid on; axis equal;
legend('Isolines', 'Wire 1 (+I)', 'Wire 2 (-I)', 'Symmetry axis');

saveas(gcf, 'output.png');
