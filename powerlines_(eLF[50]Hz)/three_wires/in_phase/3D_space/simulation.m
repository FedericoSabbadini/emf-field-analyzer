%% Three-Phase IN PHASE - 3D Isosurface
close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;
xs = [-5, 0, 5];

x = linspace(-20, 20, 81);
y = linspace(-20, 20, 81);
z = linspace(-20, 20, 81);
[X, Y, Z] = meshgrid(x, y, z);

B_tot = zeros(size(X));
for k = 1:3
    R = sqrt((X - xs(k)).^2 + Y.^2);
    R(R < 0.1) = 0.1;
    B_tot = B_tot + mu0 * I0 ./ (2 * pi * R);
end
B_uT = B_tot * 1e6;

figure('Position', [100 100 900 700]);
p = patch(isosurface(x, y, z, B_uT, 10));
set(p, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
hold on;
colors = {'b', 'r', 'g'};
for k = 1:3
    plot3([xs(k) xs(k)], [0 0], [-20 20], '-', 'Color', colors{k}, 'LineWidth', 4);
end
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title('B = 10 \muT - Three-Phase IN PHASE (large volume)');
camlight; lighting gouraud; axis equal; grid on; view(45, 25);

saveas(gcf, 'output.png');
