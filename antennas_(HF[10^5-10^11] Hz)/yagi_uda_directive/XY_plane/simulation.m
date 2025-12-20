%% Yagi-Uda Directive Antenna - XY Plane (theta=90°)
%  Pattern: F = |sin(theta)*sin(phi)| -> figure-8 in XY

close all; clc;

k = 4;
x = linspace(-20, 20, 161);
y = linspace(-20, 20, 161);
[X, Y] = meshgrid(x, y);

R = sqrt(X.^2 + Y.^2);
R(R < 0.1) = 0.1;
phi = atan2(Y, X);

% In XY plane (theta=90°): F = |sin(90°)*sin(phi)| = |sin(phi)|
F = abs(sin(phi));
E = k * F ./ R;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, E); shading interp;
hold on; plot(0, 0, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('y [m]');
title('E-field - Yagi-Uda (XY plane)');
colormap('hot'); colorbar; caxis([0 5]);

subplot(1,2,2);
[C, h] = contour(X, Y, E, [2, 4, 6], 'LineWidth', 2);
clabel(C, h);
hold on; 
plot(0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
quiver(0, 0, 0, 12, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.5);
quiver(0, 0, 0, -12, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.5);
xlabel('x [m]'); ylabel('y [m]');
title('FIGURE-8 pattern: max along ±Y, null along ±X');
grid on; axis equal;
legend('Isolines', 'Antenna', 'Main lobes');

saveas(gcf, 'output.png');
