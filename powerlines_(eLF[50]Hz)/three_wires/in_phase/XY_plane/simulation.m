%% Three-Phase IN PHASE (No shift) - XY Plane
%  Educational case: all currents in same direction -> MAX FIELD

close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;

% Wire positions
xs = [-5, 0, 5]; ys = [0, 0, 0];

x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

Bx_tot = zeros(size(X));
By_tot = zeros(size(Y));

for k = 1:3
    R = sqrt((X - xs(k)).^2 + (Y - ys(k)).^2);
    R(R < 0.1) = 0.1;
    B = mu0 * I0 ./ (2 * pi * R);
    Bx_tot = Bx_tot - B .* (Y - ys(k)) ./ R;
    By_tot = By_tot + B .* (X - xs(k)) ./ R;
end

B_uT = sqrt(Bx_tot.^2 + By_tot.^2) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, B_uT); shading interp;
hold on;
colors = {'b', 'r', 'g'};
for k = 1:3
    plot(xs(k), ys(k), 'o', 'MarkerSize', 12, 'MarkerFaceColor', colors{k});
end
xlabel('x [m]'); ylabel('y [m]');
title(sprintf('Three Wires IN PHASE - I = %d A each', I0));
colormap('hot'); colorbar; caxis([0 100]);

subplot(1,2,2);
[C, h] = contour(X, Y, B_uT, [3, 10, 100], 'LineWidth', 2);
clabel(C, h);
hold on;
for k = 1:3
    plot(xs(k), ys(k), 'o', 'MarkerSize', 15, 'MarkerFaceColor', colors{k});
end
xlabel('x [m]'); ylabel('y [m]');
title('MAXIMUM FIELD - No cancellation (educational)');
grid on; axis equal;
legend('Isolines', 'Phase R', 'Phase S', 'Phase T');

saveas(gcf, 'output.png');
