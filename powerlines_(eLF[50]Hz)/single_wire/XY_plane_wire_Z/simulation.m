%% Single Wire along Z-axis - Magnetic Field in XY Plane
%  Cross-sectional view perpendicular to the wire

close all; clc;

% === PHYSICAL PARAMETERS ===
I = 100;                        % Current [A]
mu0 = 4*pi*1e-7;                % Permeability of free space [H/m]
xs = 0; ys = 0;                 % Wire position (passes through origin)

% === OBSERVATION GRID ===
x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

% === FIELD CALCULATION ===
% Distance from wire (in XY plane, wire is at origin along Z)
R = sqrt((X - xs).^2 + (Y - ys).^2);
R(R < 0.1) = 0.1;               % Avoid singularity

% Biot-Savart law: B = mu0*I / (2*pi*r)
B = mu0 * I ./ (2 * pi * R);
B_uT = B * 1e6;                 % Convert to microtesla

% === VISUALIZATION ===
figure('Position', [100 100 1200 500]);

% Left: 3D surface
subplot(1,2,1);
surf(X, Y, B_uT, 'EdgeColor', 'none');
xlabel('x [m]'); ylabel('y [m]'); zlabel('B [\muT]');
title('Magnetic Field Magnitude - Single Wire (Z-axis)');
colormap('hot'); colorbar; view(45, 30);
zlim([0 50]);

% Right: Contour with regulatory limits
subplot(1,2,2);
levels = [3, 10, 100];
[C, h] = contour(X, Y, B_uT, levels, 'LineWidth', 2);
clabel(C, h, 'FontSize', 12, 'FontWeight', 'bold');
hold on;
plot(xs, ys, 'ko', 'MarkerSize', 15, 'MarkerFaceColor', 'r', 'LineWidth', 2);
xlabel('x [m]'); ylabel('y [m]');
title('Isolevel Curves: 3, 10, 100 \muT (Italian Limits)');
axis equal; grid on;
legend('B-field isolines', 'Wire (Z-axis)', 'Location', 'northeast');

saveas(gcf, 'output.png');
fprintf('Generated: XY plane, wire along Z\n');
fprintf('Field at r=1m: %.2f uT\n', mu0*I/(2*pi*1)*1e6);
fprintf('Field at r=10m: %.2f uT\n', mu0*I/(2*pi*10)*1e6);
