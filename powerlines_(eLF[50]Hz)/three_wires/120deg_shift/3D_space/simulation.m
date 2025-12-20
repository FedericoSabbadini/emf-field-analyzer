%% Three-Phase 120° SHIFT - 3D Isosurface
%  Compare with in-phase: the isosurface is SMALLER

close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;
xs = [-5, 0, 5];
phases = [0, 2*pi/3, 4*pi/3];
I = I0 * exp(1i * phases);

x = linspace(-20, 20, 81);
y = linspace(-20, 20, 81);
z = linspace(-20, 20, 81);
[X, Y, Z] = meshgrid(x, y, z);

Bx_tot = zeros(size(X));
By_tot = zeros(size(X));

for k = 1:3
    R = sqrt((X - xs(k)).^2 + Y.^2);
    R(R < 0.1) = 0.1;
    B = mu0 * I(k) ./ (2 * pi * R);
    Bx_tot = Bx_tot + B .* (X - xs(k)) ./ R;
    By_tot = By_tot + B .* Y ./ R;
end

B_uT = sqrt(abs(Bx_tot).^2 + abs(By_tot).^2) * 1e6;

figure('Position', [100 100 900 700]);
p = patch(isosurface(x, y, z, B_uT, 10));
set(p, 'FaceColor', [1 0.5 0], 'EdgeColor', 'none', 'FaceAlpha', 0.6);
hold on;
colors = {'b', 'r', 'g'};
labels = {'R (0°)', 'S (120°)', 'T (240°)'};
for k = 1:3
    plot3([xs(k) xs(k)], [0 0], [-20 20], '-', 'Color', colors{k}, 'LineWidth', 4);
end
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]');
title('B = 10 \muT - Three-Phase 120° (SMALLER volume than in-phase!)');
camlight; lighting gouraud; axis equal; grid on; view(45, 25);
legend([{''}, labels]);

saveas(gcf, 'output.png');
fprintf('\nComparison:\n');
fprintf('In-phase: large isosurface (fields add)\n');
fprintf('120° shift: smaller isosurface (fields partially cancel)\n');
