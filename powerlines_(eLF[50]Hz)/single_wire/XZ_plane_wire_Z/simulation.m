%% Single Wire along Z-axis - Magnetic Field in XZ Plane
%  Longitudinal view containing the wire

close all; clc;

% === PHYSICAL PARAMETERS ===
I = 100;                        % Current [A]
mu0 = 4*pi*1e-7;                % Permeability [H/m]
xs = 0;                         % Wire x-position

% === OBSERVATION GRID ===
x = linspace(-40, 40, 161);
z = linspace(-40, 40, 161);
[X, Z] = meshgrid(x, z);

% === FIELD CALCULATION ===
% Wire along Z at x=0, y=0. In XZ plane (y=0), distance = |x|
R = abs(X - xs);
R(R < 0.1) = 0.1;

B = mu0 * I ./ (2 * pi * R);
B_uT = B * 1e6;

% === VISUALIZATION ===
figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Z, B_uT); shading interp;
hold on;
plot([xs xs], [min(z) max(z)], 'w-', 'LineWidth', 3);
xlabel('x [m]'); ylabel('z [m]');
title('B-field [uT] - XZ Plane (wire along Z)');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Z, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h, 'FontSize', 11);
hold on;
plot([xs xs], [min(z) max(z)], 'b-', 'LineWidth', 4);
xlabel('x [m]'); ylabel('z [m]');
title('Isolevels are VERTICAL LINES (constant along z)');
grid on;
legend('B isolines', 'Wire', 'Location', 'northeast');

saveas(gcf, 'output.png');
