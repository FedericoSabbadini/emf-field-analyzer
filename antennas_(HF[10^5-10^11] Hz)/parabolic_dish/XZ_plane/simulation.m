%% Parabolic Dish - XZ Plane (contains the beam axis +Z)
%  Pattern: F = cos^2(theta), only for z > 0

close all; clc;

k = 4;
x = linspace(-20, 20, 161);
z = linspace(-20, 20, 161);
[X, Z] = meshgrid(x, z);

R = sqrt(X.^2 + Z.^2);
R(R < 0.1) = 0.1;
theta = acos(Z ./ R);

% Parabolic pattern: F = cos^2(theta), only forward hemisphere
F = cos(theta).^2;
F(Z < 0) = 0;  % No back radiation

E = k * F ./ R;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, E); shading interp;
hold on; 
plot(0, 0, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
quiver(0, 0, 0, 15, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.3);
xlabel('x [m]'); ylabel('z [m]');
title('E-field - Parabolic Dish (XZ plane)');
colormap('hot'); colorbar; caxis([0 5]);

subplot(1,2,2);
[C, h] = contour(X, Z, E, [2, 4, 6], 'LineWidth', 2);
clabel(C, h);
hold on; 
plot(0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
quiver(0, 0, 0, 10, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.3);
xlabel('x [m]'); ylabel('z [m]');
title('NARROW PENCIL BEAM along +Z');
grid on; axis equal;
legend('Isolines', 'Antenna', 'Pointing dir.');

saveas(gcf, 'output.png');
