%% Parabolic Dish - YZ Plane (also contains beam axis)
close all; clc;

k = 4;
y = linspace(-20, 20, 161);
z = linspace(-20, 20, 161);
[Y, Z] = meshgrid(y, z);

R = sqrt(Y.^2 + Z.^2);
R(R < 0.1) = 0.1;
theta = acos(Z ./ R);

F = cos(theta).^2;
F(Z < 0) = 0;

E = k * F ./ R;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(Y, Z, E); shading interp;
hold on; 
plot(0, 0, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
quiver(0, 0, 0, 15, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.3);
xlabel('y [m]'); ylabel('z [m]');
title('E-field - Parabolic Dish (YZ plane)');
colormap('hot'); colorbar; caxis([0 5]);

subplot(1,2,2);
[C, h] = contour(Y, Z, E, [2, 4, 6], 'LineWidth', 2);
clabel(C, h);
hold on; plot(0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('y [m]'); ylabel('z [m]');
title('Symmetric narrow beam');
grid on; axis equal;

saveas(gcf, 'output.png');
