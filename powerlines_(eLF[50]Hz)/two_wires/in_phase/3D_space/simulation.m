%% Two Wires IN PHASE - 3D Isosurface
close all; clc;

I = 100; mu0 = 4*pi*1e-7;
xs = [-5, 5];

x = linspace(-15, 15, 61);
y = linspace(-15, 15, 61);
z = linspace(-15, 15, 61);
[X, Y, Z] = meshgrid(x, y, z);

B_total = zeros(size(X));
for i = 1:2
    R = sqrt((X - xs(i)).^2 + Y.^2);
    R(R < 0.1) = 0.1;
    B_total = B_total + mu0 * I ./ (2 * pi * R);
end
B_uT = B_total * 1e6;

figure('Position', [100 100 900 700]);
p = patch(isosurface(x, y, z, B_uT, 10));
set(p, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
hold on;
for i = 1:2
    plot3([xs(i) xs(i)], [0 0], [-15 15], 'b-', 'LineWidth', 4);
end
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title('B = 10 \muT Isosurface - Two Wires IN PHASE');
camlight; lighting gouraud; axis equal; grid on; view(45, 25);

saveas(gcf, 'output.png');
