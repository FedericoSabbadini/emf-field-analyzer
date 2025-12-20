%% Parabolic Dish - XY Plane (theta=90°, NO radiation!)
%  Pattern: F = cos^2(theta), max at theta=0 (z-axis)
%  In XY plane (theta=90°): F = cos^2(90°) = 0

close all; clc;

k = 4;
x = linspace(-20, 20, 161);
y = linspace(-20, 20, 161);
[X, Y] = meshgrid(x, y);

% In XY plane, theta = 90° -> F = 0
E = zeros(size(X));

figure('Position', [100 100 800 600]);
pcolor(X, Y, E); shading interp;
hold on; plot(0, 0, 'ro', 'MarkerSize', 20, 'MarkerFaceColor', 'r');
quiver(0, 0, 0, 0, 'b', 'LineWidth', 3);  % Pointing up (out of plane)
xlabel('x [m]'); ylabel('y [m]');
title('Parabolic Dish - XY Plane: NO RADIATION (beam points +Z)');
colormap('hot'); colorbar; caxis([0 1]);
text(0, 10, 'Antenna points OUT of this plane (toward +Z)', ...
     'FontSize', 12, 'Color', 'w', 'HorizontalAlignment', 'center');

saveas(gcf, 'output.png');
