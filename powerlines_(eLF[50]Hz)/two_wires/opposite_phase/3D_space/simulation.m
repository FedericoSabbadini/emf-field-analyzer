%% Two Wires OPPOSITE PHASE - 3D
close all; clc;

I = 100; mu0 = 4*pi*1e-7;
xs = [-5, 5];

x = linspace(-15, 15, 61);
y = linspace(-15, 15, 61);
z = linspace(-15, 15, 61);
[X, Y, Z] = meshgrid(x, y, z);

% Compute vector field for opposite currents
R1 = sqrt((X - xs(1)).^2 + Y.^2); R1(R1 < 0.1) = 0.1;
R2 = sqrt((X - xs(2)).^2 + Y.^2); R2(R2 < 0.1) = 0.1;

B1 = mu0 * I ./ (2 * pi * R1);
B2 = mu0 * I ./ (2 * pi * R2);

% Opposite directions: approximate total as difference
B_uT = abs(B1 - B2) * 1e6;

figure('Position', [100 100 900 700]);
p = patch(isosurface(x, y, z, B_uT, 10));
set(p, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
hold on;
plot3([xs(1) xs(1)], [0 0], [-15 15], 'b-', 'LineWidth', 4);
plot3([xs(2) xs(2)], [0 0], [-15 15], 'r-', 'LineWidth', 4);
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title('B = 10 \muT - OPPOSITE currents (smaller volume!)');
camlight; lighting gouraud; axis equal; grid on; view(45, 25);

saveas(gcf, 'output.png');
