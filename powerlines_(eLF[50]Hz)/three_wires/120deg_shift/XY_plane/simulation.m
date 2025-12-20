%% Three-Phase 120° SHIFT - XY Plane
%  REAL three-phase system: currents sum to zero -> REDUCED field

close all; clc;

I0 = 400; mu0 = 4*pi*1e-7;

% Wire positions
xs = [-5, 0, 5]; ys = [0, 0, 0];

% Phase angles (120° = 2*pi/3 radians)
phases = [0, 2*pi/3, 4*pi/3];

% Complex currents (phasors)
I = I0 * exp(1i * phases);

% Verify sum = 0
fprintf('Sum of currents: |I1+I2+I3| = %.2e A (should be ~0)\n', abs(sum(I)));

x = linspace(-40, 40, 161);
y = linspace(-40, 40, 161);
[X, Y] = meshgrid(x, y);

Bx_tot = zeros(size(X));
By_tot = zeros(size(Y));

for k = 1:3
    R = sqrt((X - xs(k)).^2 + (Y - ys(k)).^2);
    R(R < 0.1) = 0.1;
    
    % Complex field from complex current
    B = mu0 * I(k) ./ (2 * pi * R);
    Bx_tot = Bx_tot + B .* (X - xs(k)) ./ R;
    By_tot = By_tot + B .* (Y - ys(k)) ./ R;
end

% RMS field magnitude
B_uT = sqrt(abs(Bx_tot).^2 + abs(By_tot).^2) * 1e6;

figure('Position', [100 100 1200 500]);

subplot(1,2,1);
pcolor(X, Y, B_uT); shading interp;
hold on;
colors = {'b', 'r', 'g'};
for k = 1:3
    plot(xs(k), ys(k), 'o', 'MarkerSize', 12, 'MarkerFaceColor', colors{k});
end
xlabel('x [m]'); ylabel('y [m]');
title('THREE-PHASE with 120° shift');
colormap('hot'); colorbar; caxis([0 50]);

subplot(1,2,2);
[C, h] = contour(X, Y, B_uT, [3, 10, 30], 'LineWidth', 2);
clabel(C, h);
hold on;
labels = {'R (0°)', 'S (120°)', 'T (240°)'};
for k = 1:3
    plot(xs(k), ys(k), 'o', 'MarkerSize', 15, 'MarkerFaceColor', colors{k});
end
xlabel('x [m]'); ylabel('y [m]');
title('REDUCED FIELD - Phase cancellation! (1/r^2 decay)');
grid on; axis equal;
legend('Isolines', labels{:});

saveas(gcf, 'output.png');
