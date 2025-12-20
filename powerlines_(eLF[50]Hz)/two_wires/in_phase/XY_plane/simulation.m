%% Two Parallel Wires (IN PHASE) - Magnetic Field in XY Plane
%  Both wires carry current in SAME direction -> fields ADD

close all; clc;

I = 100; mu0 = 4*pi*1e-7;

% Wire positions (both along Z-axis)
xs1 = -5; ys1 = 0;  % Wire 1
xs2 = +5; ys2 = 0;  % Wire 2

x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

% Distances from each wire
R1 = sqrt((X - xs1).^2 + (Y - ys1).^2);
R2 = sqrt((X - xs2).^2 + (Y - ys2).^2);
R1(R1 < 0.1) = 0.1; R2(R2 < 0.1) = 0.1;

% Field magnitudes
B1 = mu0 * I ./ (2 * pi * R1);
B2 = mu0 * I ./ (2 * pi * R2);

% Vector components (tangential field)
B1x = -B1 .* (Y - ys1) ./ R1;
B1y =  B1 .* (X - xs1) ./ R1;
B2x = -B2 .* (Y - ys2) ./ R2;
B2y =  B2 .* (X - xs2) ./ R2;

% IN PHASE: currents same direction -> fields ADD
Bx = B1x + B2x;
By = B1y + B2y;
B_total = sqrt(Bx.^2 + By.^2);
B_uT = B_total * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, B_uT); shading interp;
hold on;
plot(xs1, ys1, 'wo', 'MarkerSize', 12, 'MarkerFaceColor', 'b', 'LineWidth', 2);
plot(xs2, ys2, 'wo', 'MarkerSize', 12, 'MarkerFaceColor', 'b', 'LineWidth', 2);
xlabel('x [m]'); ylabel('y [m]');
title('B-field [uT] - Two Wires IN PHASE (+I, +I)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Y, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on;
plot(xs1, ys1, 'bo', 'MarkerSize', 15, 'MarkerFaceColor', 'b');
plot(xs2, ys2, 'bo', 'MarkerSize', 15, 'MarkerFaceColor', 'b');
xlabel('x [m]'); ylabel('y [m]');
title('Fields ADD - Higher exposure between wires');
grid on; axis equal;
legend('Isolines', 'Wire 1 (+I)', 'Wire 2 (+I)');

saveas(gcf, 'output.png');
