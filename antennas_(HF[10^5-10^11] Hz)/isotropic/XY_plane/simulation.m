%% Isotropic Antenna - Electric Field in XY Plane
%  Uniform radiation pattern -> circular isolines

close all; clc;

k = 4;  % sqrt(30*EIRP)
EIRP = k^2/30;
fprintf('EIRP = %.2f W\n', EIRP);

x = linspace(-20, 20, 161);
y = linspace(-20, 20, 161);
[X, Y] = meshgrid(x, y);

R = sqrt(X.^2 + Y.^2);
R(R < 0.1) = 0.1;

% Isotropic: E = k/r (no angular dependence)
E = k ./ R;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, E); shading interp;
hold on; plot(0, 0, 'wo', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('y [m]');
title('E-field [V/m] - Isotropic Antenna');
colormap('hot'); colorbar; caxis([0 10]);

subplot(1,2,2);
[C, h] = contour(X, Y, E, [6, 20], 'LineWidth', 2);
clabel(C, h, 'FontSize', 12);
hold on; plot(0, 0, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('y [m]');
title('CIRCULAR isolines (isotropic = spherical pattern)');
grid on; axis equal;
legend('E isolines', 'Antenna');

saveas(gcf, 'output.png');
