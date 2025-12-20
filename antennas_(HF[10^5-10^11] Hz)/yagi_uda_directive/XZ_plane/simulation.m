%% Yagi-Uda - XZ Plane (phi=0, NULL plane)
%  At phi=0: F = |sin(theta)*sin(0)| = 0 -> ZERO field!

close all; clc;

k = 4;
x = linspace(-20, 20, 161);
z = linspace(-20, 20, 161);
[X, Z] = meshgrid(x, z);

R = sqrt(X.^2 + Z.^2);
R(R < 0.1) = 0.1;
theta = acos(Z ./ R);

% phi = 0 in XZ plane -> sin(0) = 0 -> F = 0
E = zeros(size(X));  % Null plane!

figure('Position', [100 100 800 600]);
pcolor(X, Z, E); shading interp;
hold on; plot(0, 0, 'ro', 'MarkerSize', 20, 'MarkerFaceColor', 'r');
xlabel('x [m]'); ylabel('z [m]');
title('Yagi-Uda XZ Plane: THIS IS THE NULL! (F = 0)');
colormap('hot'); colorbar; caxis([0 1]);
text(0, 10, 'Zero field in this plane!', 'FontSize', 14, 'Color', 'w', 'HorizontalAlignment', 'center');

saveas(gcf, 'output.png');
